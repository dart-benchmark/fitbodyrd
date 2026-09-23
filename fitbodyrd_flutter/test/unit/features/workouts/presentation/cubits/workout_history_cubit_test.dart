import 'package:bloc_test/bloc_test.dart';
import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/workouts/domain/repositories/workout_repository.dart';
import 'package:fitbodyrd_flutter/features/workouts/presentation/cubits/workout_history_cubit.dart';
import 'package:fitbodyrd_flutter/features/workouts/presentation/widgets/exercise_stats_time_selector.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:record_result/record_result.dart';

// Mock classes
class MockWorkoutRepository extends Mock implements WorkoutRepository {}

// Helper functions for mock data
WorkoutSessionsByDateDto createMockWorkoutSessionsByDate({
  DateTime? date,
  List<WorkoutSession>? sessions,
  int totalExercisesCompleted = 0,
}) {
  return WorkoutSessionsByDateDto(
    date: date ?? DateTime(2024, 6, 15),
    sessions: sessions ?? [],
    totalExercisesCompleted: totalExercisesCompleted,
  );
}

WorkoutSession createMockWorkoutSession({
  int id = 1,
  DateTime? date,
  bool completed = false,
}) {
  return WorkoutSession(
    id: id,
    workoutPlanId: 1,
    date: date ?? DateTime(2024, 6, 15),
    dayName: 'Monday',
    focus: 'Upper Body',
    sessionComplete: completed,
    exercises: [],
  );
}

WorkoutProgressMetricsDto createMockWorkoutProgressMetrics({
  int totalWorkoutsCompleted = 10,
  int currentStreak = 5,
  int longestStreak = 10,
  double averageWorkoutsPerWeek = 3.0,
  int totalExercisesLogged = 50,
  int workoutsThisWeek = 3,
  int workoutsThisMonth = 12,
}) {
  return WorkoutProgressMetricsDto(
    totalWorkoutsCompleted: totalWorkoutsCompleted,
    currentStreak: currentStreak,
    longestStreak: longestStreak,
    averageWorkoutsPerWeek: averageWorkoutsPerWeek,
    totalExercisesLogged: totalExercisesLogged,
    workoutsThisWeek: workoutsThisWeek,
    workoutsThisMonth: workoutsThisMonth,
  );
}

void main() {
  group('WorkoutHistoryCubit', () {
    late WorkoutHistoryCubit cubit;
    late MockWorkoutRepository mockRepository;

    setUp(() {
      mockRepository = MockWorkoutRepository();
      registerFallbackValue(Object());

      cubit = WorkoutHistoryCubit(mockRepository);
    });

    tearDown(() async {
      await cubit.close();
    });

    test('initial state is WorkoutHistoryInitial', () {
      expect(cubit.state, isA<WorkoutHistoryInitial>());
    });

    blocTest<WorkoutHistoryCubit, WorkoutHistoryState>(
      'loadWorkoutHistory should emit loading then loaded with data',
      setUp: () {
        final startDate = ExerciseStatsTimeSelector.getStartDate(
          TimePeriod.last3Months,
        );
        final endDate = DateTime.now();
        final sessionsByDate = [
          createMockWorkoutSessionsByDate(
            date: startDate,
            sessions: [
              createMockWorkoutSession(date: startDate),
            ],
          ),
          createMockWorkoutSessionsByDate(
            date: endDate,
            sessions: [
              createMockWorkoutSession(id: 2, date: endDate),
            ],
          ),
        ];
        final metrics = createMockWorkoutProgressMetrics();

        when(
          () => mockRepository.getWorkoutSessionsByDateRange(
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
          ),
        ).thenAnswer((_) async => right(sessionsByDate));
        when(
          () => mockRepository.getWorkoutProgressMetrics(
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
          ),
        ).thenAnswer((_) async => right(metrics));
      },
      build: () => cubit,
      act: (cubit) => cubit.loadWorkoutHistory(),
      expect: () => [
        isA<WorkoutHistoryLoading>(),
        isA<WorkoutHistoryLoaded>()
            .having(
              (s) => s.sessionsByDate.length,
              'sessionsByDate.length',
              2,
            )
            .having(
              (s) => s.progressMetrics.totalWorkoutsCompleted,
              'progressMetrics.totalWorkoutsCompleted',
              10,
            )
            .having(
              (s) => s.selectedPeriod,
              'selectedPeriod',
              TimePeriod.last3Months,
            )
            .having(
              (s) => s.viewMode,
              'viewMode',
              WorkoutHistoryViewMode.list,
            ),
      ],
    );

    blocTest<WorkoutHistoryCubit, WorkoutHistoryState>(
      'loadWorkoutHistory should emit error when history fetch fails',
      setUp: () {
        when(
          () => mockRepository.getWorkoutSessionsByDateRange(
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
          ),
        ).thenAnswer(
          (_) async => left(
            ServerFailure(statusCode: 500, message: 'Failed to fetch history'),
          ),
        );
        // Also need to mock getWorkoutProgressMetrics since both are called
        when(
          () => mockRepository.getWorkoutProgressMetrics(
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
          ),
        ).thenAnswer(
          (_) async => left(
            ServerFailure(statusCode: 500, message: 'Failed to fetch metrics'),
          ),
        );
      },
      build: () => cubit,
      act: (cubit) => cubit.loadWorkoutHistory(),
      expect: () => [
        isA<WorkoutHistoryLoading>(),
        isA<WorkoutHistoryError>()
            .having((s) => s.message, 'message', 'Failed to fetch history'),
      ],
    );

    blocTest<WorkoutHistoryCubit, WorkoutHistoryState>(
      'loadWorkoutHistory should emit error when metrics fetch fails',
      setUp: () {
        final startDate = ExerciseStatsTimeSelector.getStartDate(
          TimePeriod.last3Months,
        );
        final sessionsByDate = [
          createMockWorkoutSessionsByDate(date: startDate),
        ];

        when(
          () => mockRepository.getWorkoutSessionsByDateRange(
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
          ),
        ).thenAnswer((_) async => right(sessionsByDate));
        when(
          () => mockRepository.getWorkoutProgressMetrics(
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
          ),
        ).thenAnswer(
          (_) async => left(
            ServerFailure(statusCode: 500, message: 'Failed to fetch metrics'),
          ),
        );
      },
      build: () => cubit,
      act: (cubit) => cubit.loadWorkoutHistory(),
      expect: () => [
        isA<WorkoutHistoryLoading>(),
        isA<WorkoutHistoryError>()
            .having((s) => s.message, 'message', 'Failed to fetch metrics'),
      ],
    );

    blocTest<WorkoutHistoryCubit, WorkoutHistoryState>(
      'loadWorkoutHistory should use custom period and view mode',
      setUp: () {
        final startDate = ExerciseStatsTimeSelector.getStartDate(
          TimePeriod.last30Days,
        );
        final sessionsByDate = [
          createMockWorkoutSessionsByDate(date: startDate),
        ];
        final metrics = createMockWorkoutProgressMetrics();

        when(
          () => mockRepository.getWorkoutSessionsByDateRange(
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
          ),
        ).thenAnswer((_) async => right(sessionsByDate));
        when(
          () => mockRepository.getWorkoutProgressMetrics(
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
          ),
        ).thenAnswer((_) async => right(metrics));
      },
      build: () => cubit,
      act: (cubit) => cubit.loadWorkoutHistory(
        period: TimePeriod.last30Days,
        viewMode: WorkoutHistoryViewMode.calendar,
      ),
      expect: () => [
        isA<WorkoutHistoryLoading>(),
        isA<WorkoutHistoryLoaded>()
            .having(
              (s) => s.selectedPeriod,
              'selectedPeriod',
              TimePeriod.last30Days,
            )
            .having(
              (s) => s.viewMode,
              'viewMode',
              WorkoutHistoryViewMode.calendar,
            ),
      ],
    );

    blocTest<WorkoutHistoryCubit, WorkoutHistoryState>(
      'updatePeriod should reload history with new period',
      setUp: () {
        final startDate3Months = ExerciseStatsTimeSelector.getStartDate(
          TimePeriod.last3Months,
        );
        final startDate30Days = ExerciseStatsTimeSelector.getStartDate(
          TimePeriod.last30Days,
        );
        final endDate = DateTime.now();

        when(
          () => mockRepository.getWorkoutSessionsByDateRange(
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
          ),
        ).thenAnswer(
          (_) async => right(
            [
              createMockWorkoutSessionsByDate(date: startDate3Months),
            ],
          ),
        );
        when(
          () => mockRepository.getWorkoutProgressMetrics(
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
          ),
        ).thenAnswer((_) async => right(createMockWorkoutProgressMetrics()));

        // Second call with different period
        when(
          () => mockRepository.getWorkoutSessionsByDateRange(
            startDate: startDate30Days,
            endDate: endDate,
          ),
        ).thenAnswer(
          (_) async => right(
            [
              createMockWorkoutSessionsByDate(date: startDate30Days),
            ],
          ),
        );
        when(
          () => mockRepository.getWorkoutProgressMetrics(
            startDate: startDate30Days,
            endDate: endDate,
          ),
        ).thenAnswer((_) async => right(createMockWorkoutProgressMetrics()));
      },
      build: () => cubit,
      act: (cubit) async {
        await cubit.loadWorkoutHistory();
        await cubit.updatePeriod(TimePeriod.last30Days);
      },
      expect: () => [
        isA<WorkoutHistoryLoading>(),
        isA<WorkoutHistoryLoaded>().having(
          (s) => s.selectedPeriod,
          'selectedPeriod',
          TimePeriod.last3Months,
        ),
        isA<WorkoutHistoryLoading>(),
        isA<WorkoutHistoryLoaded>().having(
          (s) => s.selectedPeriod,
          'selectedPeriod',
          TimePeriod.last30Days,
        ),
      ],
    );

    blocTest<WorkoutHistoryCubit, WorkoutHistoryState>(
      'updatePeriod should do nothing if state is not WorkoutHistoryLoaded',
      build: () => cubit,
      act: (cubit) => cubit.updatePeriod(TimePeriod.last30Days),
      expect: () => <WorkoutHistoryState>[],
    );

    blocTest<WorkoutHistoryCubit, WorkoutHistoryState>(
      'toggleViewMode should switch between list and calendar',
      setUp: () {
        final startDate = ExerciseStatsTimeSelector.getStartDate(
          TimePeriod.last3Months,
        );
        final sessionsByDate = [
          createMockWorkoutSessionsByDate(date: startDate),
        ];
        final metrics = createMockWorkoutProgressMetrics();

        when(
          () => mockRepository.getWorkoutSessionsByDateRange(
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
          ),
        ).thenAnswer((_) async => right(sessionsByDate));
        when(
          () => mockRepository.getWorkoutProgressMetrics(
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
          ),
        ).thenAnswer((_) async => right(metrics));
      },
      build: () => cubit,
      act: (cubit) async {
        await cubit.loadWorkoutHistory();
        cubit.toggleViewMode();
      },
      expect: () => [
        isA<WorkoutHistoryLoading>(),
        isA<WorkoutHistoryLoaded>().having(
          (s) => s.viewMode,
          'viewMode',
          WorkoutHistoryViewMode.list,
        ),
        isA<WorkoutHistoryLoaded>().having(
          (s) => s.viewMode,
          'viewMode',
          WorkoutHistoryViewMode.calendar,
        ),
      ],
    );

    blocTest<WorkoutHistoryCubit, WorkoutHistoryState>(
      'toggleViewMode should switch from calendar to list',
      setUp: () {
        final startDate = ExerciseStatsTimeSelector.getStartDate(
          TimePeriod.last3Months,
        );
        final sessionsByDate = [
          createMockWorkoutSessionsByDate(date: startDate),
        ];
        final metrics = createMockWorkoutProgressMetrics();

        when(
          () => mockRepository.getWorkoutSessionsByDateRange(
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
          ),
        ).thenAnswer((_) async => right(sessionsByDate));
        when(
          () => mockRepository.getWorkoutProgressMetrics(
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
          ),
        ).thenAnswer((_) async => right(metrics));
      },
      build: () => cubit,
      act: (cubit) async {
        await cubit.loadWorkoutHistory(
          viewMode: WorkoutHistoryViewMode.calendar,
        );
        cubit.toggleViewMode();
      },
      expect: () => [
        isA<WorkoutHistoryLoading>(),
        isA<WorkoutHistoryLoaded>().having(
          (s) => s.viewMode,
          'viewMode',
          WorkoutHistoryViewMode.calendar,
        ),
        isA<WorkoutHistoryLoaded>().having(
          (s) => s.viewMode,
          'viewMode',
          WorkoutHistoryViewMode.list,
        ),
      ],
    );

    blocTest<WorkoutHistoryCubit, WorkoutHistoryState>(
      'toggleViewMode should do nothing if state is not WorkoutHistoryLoaded',
      build: () => cubit,
      act: (cubit) => cubit.toggleViewMode(),
      expect: () => <WorkoutHistoryState>[],
    );

    blocTest<WorkoutHistoryCubit, WorkoutHistoryState>(
      'loadWorkoutHistory should handle all time periods',
      setUp: () {
        // Use any() matchers since we're calling with different dates
        when(
          () => mockRepository.getWorkoutSessionsByDateRange(
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
          ),
        ).thenAnswer((_) async {
          final startDate = DateTime.now().subtract(const Duration(days: 30));
          return right([createMockWorkoutSessionsByDate(date: startDate)]);
        });
        when(
          () => mockRepository.getWorkoutProgressMetrics(
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
          ),
        ).thenAnswer((_) async => right(createMockWorkoutProgressMetrics()));
      },
      build: () => cubit,
      act: (cubit) async {
        for (final period in TimePeriod.values) {
          await cubit.loadWorkoutHistory(period: period);
        }
      },
      expect: () => [
        for (final period in TimePeriod.values) ...[
          isA<WorkoutHistoryLoading>(),
          isA<WorkoutHistoryLoaded>().having(
            (s) => s.selectedPeriod,
            'selectedPeriod',
            period,
          ),
        ],
      ],
    );
  });
}
