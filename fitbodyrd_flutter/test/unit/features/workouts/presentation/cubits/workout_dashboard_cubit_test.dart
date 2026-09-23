import 'package:bloc_test/bloc_test.dart';
import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/workouts/domain/repositories/workout_repository.dart';
import 'package:fitbodyrd_flutter/features/workouts/presentation/cubits/workout_dashboard_cubit.dart';
import 'package:fitbodyrd_flutter/src/core/services/dashboard_refresh_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:record_result/record_result.dart';

// Mock classes
class MockWorkoutRepository extends Mock implements WorkoutRepository {}

class MockDashboardRefreshService extends Mock
    implements DashboardRefreshService {}

// Helper functions for mock data
WorkoutPlan createMockWorkoutPlan({
  DateTime? date,
  List<WorkoutSession>? sessions,
}) {
  final targetDate = date ?? DateTime(2024, 6, 15);
  return WorkoutPlan(
    id: 1,
    userId: 1,
    name: 'Test Workout Plan',
    difficultyLevel: ExerciseDifficulty.beginner,
    startDate: targetDate.subtract(const Duration(days: 7)),
    endDate: targetDate.add(const Duration(days: 7)),
    status: Status.active,
    sessions: sessions ?? [],
  );
}

WorkoutSession createMockWorkoutSession({
  int id = 1,
  DateTime? date,
  List<WorkoutExercise>? exercises,
  bool completed = false,
}) {
  final targetDate = date ?? DateTime(2024, 6, 15);
  return WorkoutSession(
    id: id,
    workoutPlanId: 1,
    date: targetDate,
    dayName: 'Monday',
    focus: 'Upper Body',
    sessionComplete: completed,
    exercises: exercises ?? [],
  );
}

WorkoutExercise createMockWorkoutExercise({
  int id = 1,
  int exerciseId = 1,
}) {
  return WorkoutExercise(
    id: id,
    workoutSessionId: 1,
    exerciseId: exerciseId,
    order: 1,
    sets: 3,
    reps: 10,
    restSeconds: 60,
  );
}

ExerciseLog createMockExerciseLog({
  int? id,
  int exerciseId = 1,
  DateTime? date,
}) {
  return ExerciseLog(
    id: id,
    userId: 1,
    exerciseId: exerciseId,
    date: date ?? DateTime(2024, 6, 15),
    setsCompleted: 3,
    repsCompleted: 10,
    weightUsed: 50.0,
  );
}

void main() {
  group('WorkoutDashboardCubit', () {
    late WorkoutDashboardCubit cubit;
    late MockWorkoutRepository mockRepository;
    late MockDashboardRefreshService mockRefreshService;

    setUp(() {
      mockRepository = MockWorkoutRepository();
      mockRefreshService = MockDashboardRefreshService();
      registerFallbackValue(Object());

      cubit = WorkoutDashboardCubit(
        mockRepository,
        mockRefreshService,
      );
    });

    tearDown(() async {
      await cubit.close();
    });

    test('initial state is WorkoutDashboardInitial', () {
      expect(cubit.state, isA<WorkoutDashboardInitial>());
    });

    blocTest<WorkoutDashboardCubit, WorkoutDashboardState>(
      'loadDashboard should emit WorkoutDashboardLoading '
      'then WorkoutDashboardLoaded with data',
      setUp: () {
        final today = DateTime(2024, 6, 15);
        final session = createMockWorkoutSession(
          date: today,
          exercises: [
            createMockWorkoutExercise(),
            createMockWorkoutExercise(id: 2, exerciseId: 2),
          ],
        );
        final plan = createMockWorkoutPlan(
          date: today,
          sessions: [session],
        );
        final exerciseLogs = [
          createMockExerciseLog(id: 1, date: today),
          createMockExerciseLog(id: 2, exerciseId: 2, date: today),
        ];

        when(() => mockRepository.getActiveWorkoutPlan())
            .thenAnswer((_) async => right(plan));
        when(
          () => mockRepository.getExerciseLogs(
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
            exerciseIds: any(named: 'exerciseIds'),
          ),
        ).thenAnswer((_) async => right(exerciseLogs));
      },
      build: () => cubit,
      act: (cubit) => cubit.loadDashboard(),
      expect: () => [
        isA<WorkoutDashboardLoading>(),
        isA<WorkoutDashboardLoaded>()
            .having((s) => s.plan.id, 'plan.id', 1)
            .having(
              (s) => s.logsByDateAndExercise.length,
              'logsByDateAndExercise.length',
              greaterThan(0),
            ),
      ],
    );

    blocTest<WorkoutDashboardCubit, WorkoutDashboardState>(
      'loadDashboard should emit WorkoutDashboardEmpty '
      'when no active plan (7001)',
      setUp: () {
        when(() => mockRepository.getActiveWorkoutPlan()).thenAnswer(
          (_) async => left(
            ServerFailure(statusCode: 7001, message: 'No active plan'),
          ),
        );
      },
      build: () => cubit,
      act: (cubit) => cubit.loadDashboard(),
      expect: () => [
        isA<WorkoutDashboardLoading>(),
        isA<WorkoutDashboardEmpty>(),
      ],
    );

    blocTest<WorkoutDashboardCubit, WorkoutDashboardState>(
      'loadDashboard should emit WorkoutDashboardError on other errors',
      setUp: () {
        when(() => mockRepository.getActiveWorkoutPlan()).thenAnswer(
          (_) async => left(
            ServerFailure(statusCode: 500, message: 'Server error'),
          ),
        );
      },
      build: () => cubit,
      act: (cubit) => cubit.loadDashboard(),
      expect: () => [
        isA<WorkoutDashboardLoading>(),
        isA<WorkoutDashboardError>()
            .having((s) => s.message, 'message', 'Server error'),
      ],
    );

    blocTest<WorkoutDashboardCubit, WorkoutDashboardState>(
      'loadDashboard should handle plan with no exercises',
      setUp: () {
        final today = DateTime(2024, 6, 15);
        final plan = createMockWorkoutPlan(
          date: today,
          sessions: [
            createMockWorkoutSession(date: today, exercises: []),
          ],
        );

        when(() => mockRepository.getActiveWorkoutPlan())
            .thenAnswer((_) async => right(plan));
      },
      build: () => cubit,
      act: (cubit) => cubit.loadDashboard(),
      expect: () => [
        isA<WorkoutDashboardLoading>(),
        isA<WorkoutDashboardLoaded>().having(
          (s) => s.logsByDateAndExercise.length,
          'logsByDateAndExercise.length',
          0,
        ),
      ],
    );

    blocTest<WorkoutDashboardCubit, WorkoutDashboardState>(
      'loadDashboard should emit error when exercise logs fetch fails',
      setUp: () {
        final today = DateTime(2024, 6, 15);
        final session = createMockWorkoutSession(
          date: today,
          exercises: [createMockWorkoutExercise()],
        );
        final plan = createMockWorkoutPlan(
          date: today,
          sessions: [session],
        );

        when(() => mockRepository.getActiveWorkoutPlan())
            .thenAnswer((_) async => right(plan));
        when(
          () => mockRepository.getExerciseLogs(
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
            exerciseIds: any(named: 'exerciseIds'),
          ),
        ).thenAnswer(
          (_) async => left(
            ServerFailure(statusCode: 500, message: 'Failed to fetch logs'),
          ),
        );
      },
      build: () => cubit,
      act: (cubit) => cubit.loadDashboard(),
      expect: () => [
        isA<WorkoutDashboardLoading>(),
        isA<WorkoutDashboardError>()
            .having((s) => s.message, 'message', 'Failed to fetch logs'),
      ],
    );

    blocTest<WorkoutDashboardCubit, WorkoutDashboardState>(
      'selectDate should update selectedDate and currentSession',
      setUp: () {
        final today = DateTime(2024, 6, 15);
        final tomorrow = today.add(const Duration(days: 1));
        final session1 = createMockWorkoutSession(date: today);
        final session2 = createMockWorkoutSession(id: 2, date: tomorrow);
        final plan = createMockWorkoutPlan(
          date: today,
          sessions: [session1, session2],
        );

        when(() => mockRepository.getActiveWorkoutPlan())
            .thenAnswer((_) async => right(plan));
        when(
          () => mockRepository.getExerciseLogs(
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
            exerciseIds: any(named: 'exerciseIds'),
          ),
        ).thenAnswer((_) async => right([]));
      },
      build: () => cubit,
      act: (cubit) async {
        await cubit.loadDashboard();
        final today = DateTime(2024, 6, 15);
        final tomorrow = today.add(const Duration(days: 1));
        await cubit.selectDate(tomorrow);
      },
      expect: () => [
        isA<WorkoutDashboardLoading>(),
        isA<WorkoutDashboardLoaded>(),
        isA<WorkoutDashboardLoaded>()
            .having(
              (s) => s.selectedDate.day,
              'selectedDate.day',
              16,
            )
            .having((s) => s.currentSession?.id, 'currentSession.id', 2),
      ],
    );

    blocTest<WorkoutDashboardCubit, WorkoutDashboardState>(
      'selectDate should do nothing if state is not WorkoutDashboardLoaded',
      build: () => cubit,
      act: (cubit) => cubit.selectDate(DateTime(2024, 6, 15)),
      expect: () => <WorkoutDashboardState>[],
    );

    blocTest<WorkoutDashboardCubit, WorkoutDashboardState>(
      'clearSessionCompletedFlag should clear the flag',
      setUp: () {
        final today = DateTime(2024, 6, 15);
        final plan = createMockWorkoutPlan(
          date: today,
          sessions: [createMockWorkoutSession(date: today)],
        );

        when(() => mockRepository.getActiveWorkoutPlan())
            .thenAnswer((_) async => right(plan));
        when(
          () => mockRepository.getExerciseLogs(
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
            exerciseIds: any(named: 'exerciseIds'),
          ),
        ).thenAnswer((_) async => right([]));
      },
      build: () => cubit,
      act: (cubit) async {
        await cubit.loadDashboard();
        // clearSessionCompletedFlag should be callable without error
        cubit.clearSessionCompletedFlag();
      },
      expect: () => [
        isA<WorkoutDashboardLoading>(),
        isA<WorkoutDashboardLoaded>().having(
          (s) => s.sessionJustCompleted,
          'sessionJustCompleted',
          false,
        ),
      ],
    );

    blocTest<WorkoutDashboardCubit, WorkoutDashboardState>(
      'applyOrUpdateLog should update logs and mark session as completed',
      setUp: () {
        final today = DateTime(2024, 6, 15);
        final session = createMockWorkoutSession(
          date: today,
          exercises: [createMockWorkoutExercise()],
        );
        final plan = createMockWorkoutPlan(
          date: today,
          sessions: [session],
        );

        when(() => mockRepository.getActiveWorkoutPlan())
            .thenAnswer((_) async => right(plan));
        when(
          () => mockRepository.getExerciseLogs(
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
            exerciseIds: any(named: 'exerciseIds'),
          ),
        ).thenAnswer((_) async => right([]));
        when(() => mockRefreshService.refreshDashboard()).thenReturn(null);
      },
      build: () => cubit,
      act: (cubit) async {
        await cubit.loadDashboard();
        final today = DateTime(2024, 6, 15);
        final log = createMockExerciseLog(id: 1, date: today);
        await cubit.applyOrUpdateLog(log);
      },
      expect: () => [
        isA<WorkoutDashboardLoading>(),
        isA<WorkoutDashboardLoaded>(),
        isA<WorkoutDashboardLoaded>().having(
          (s) => s.logsByDateAndExercise.length,
          'logsByDateAndExercise.length',
          greaterThan(0),
        ),
      ],
      verify: (_) {
        verify(() => mockRefreshService.refreshDashboard()).called(1);
      },
    );

    blocTest<WorkoutDashboardCubit, WorkoutDashboardState>(
      'applyOrUpdateLog should not mark session as completed '
      'if already completed',
      setUp: () {
        final today = DateTime(2024, 6, 15);
        final session = createMockWorkoutSession(
          date: today,
          exercises: [createMockWorkoutExercise()],
        );
        final plan = createMockWorkoutPlan(
          date: today,
          sessions: [session],
        );
        final existingLog = createMockExerciseLog(
          id: 1,
          date: today,
        );

        when(() => mockRepository.getActiveWorkoutPlan())
            .thenAnswer((_) async => right(plan));
        when(
          () => mockRepository.getExerciseLogs(
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
            exerciseIds: any(named: 'exerciseIds'),
          ),
        ).thenAnswer((_) async => right([existingLog]));
        when(() => mockRefreshService.refreshDashboard()).thenReturn(null);
      },
      build: () => cubit,
      act: (cubit) async {
        await cubit.loadDashboard();
        final today = DateTime(2024, 6, 15);
        final updatedLog = createMockExerciseLog(
          id: 1,
          date: today,
        );
        await cubit.applyOrUpdateLog(updatedLog);
      },
      expect: () => [
        isA<WorkoutDashboardLoading>(),
        isA<WorkoutDashboardLoaded>(),
        isA<WorkoutDashboardLoaded>().having(
          (s) => s.sessionJustCompleted,
          'sessionJustCompleted',
          false,
        ),
      ],
    );

    blocTest<WorkoutDashboardCubit, WorkoutDashboardState>(
      'deleteLogForExercise should remove log from state',
      setUp: () {
        final today = DateTime(2024, 6, 15);
        final session = createMockWorkoutSession(
          date: today,
          exercises: [createMockWorkoutExercise()],
        );
        final plan = createMockWorkoutPlan(
          date: today,
          sessions: [session],
        );
        final existingLog = createMockExerciseLog(
          id: 1,
          date: today,
        );

        when(() => mockRepository.getActiveWorkoutPlan())
            .thenAnswer((_) async => right(plan));
        when(
          () => mockRepository.getExerciseLogs(
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
            exerciseIds: any(named: 'exerciseIds'),
          ),
        ).thenAnswer((_) async => right([existingLog]));
        when(() => mockRepository.deleteExerciseLog(any()))
            .thenAnswer((_) async => right(null));
        when(() => mockRefreshService.refreshDashboard()).thenReturn(null);
      },
      build: () => cubit,
      act: (cubit) async {
        await cubit.loadDashboard();
        final today = DateTime(2024, 6, 15);
        final log = createMockExerciseLog(id: 1, date: today);
        await cubit.deleteLogForExercise(log);
      },
      expect: () => [
        isA<WorkoutDashboardLoading>(),
        isA<WorkoutDashboardLoaded>(),
        isA<WorkoutDashboardLoaded>().having(
          (s) => s.logsByDateAndExercise.length,
          'logsByDateAndExercise.length',
          0,
        ),
      ],
      verify: (_) {
        verify(() => mockRepository.deleteExerciseLog(1)).called(1);
        verify(() => mockRefreshService.refreshDashboard()).called(1);
      },
    );

    blocTest<WorkoutDashboardCubit, WorkoutDashboardState>(
      'deleteLogForExercise should do nothing if state '
      'is not WorkoutDashboardLoaded',
      build: () => cubit,
      act: (cubit) async {
        final log = createMockExerciseLog();
        await cubit.deleteLogForExercise(log);
      },
      expect: () => <WorkoutDashboardState>[],
    );
  });
}
