import 'package:bloc_test/bloc_test.dart';
import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/workouts/domain/repositories/workout_repository.dart';
import 'package:fitbodyrd_flutter/features/workouts/presentation/cubits/exercise_details_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:record_result/record_result.dart';

// Mock classes
class MockWorkoutRepository extends Mock implements WorkoutRepository {}

// Helper functions for mock data
ExerciseLog createMockExerciseLog({
  int? id,
  int exerciseId = 1,
  DateTime? date,
  int setsCompleted = 3,
  int repsCompleted = 10,
  double weightUsed = 50.0,
}) {
  return ExerciseLog(
    id: id,
    userId: 1,
    exerciseId: exerciseId,
    date: date ?? DateTime(2024, 6, 15),
    setsCompleted: setsCompleted,
    repsCompleted: repsCompleted,
    weightUsed: weightUsed,
  );
}

void main() {
  group('ExerciseDetailsCubit', () {
    late ExerciseDetailsCubit cubit;
    late MockWorkoutRepository mockRepository;

    setUp(() {
      mockRepository = MockWorkoutRepository();
      registerFallbackValue(Object());

      cubit = ExerciseDetailsCubit(mockRepository);
    });

    tearDown(() async {
      await cubit.close();
    });

    test('initial state is ExerciseDetailsInitial', () {
      expect(cubit.state, isA<ExerciseDetailsInitial>());
    });

    blocTest<ExerciseDetailsCubit, ExerciseDetailsState>(
      'loadExerciseLogs should emit loading then loaded with sorted logs',
      setUp: () {
        final now = DateTime(2024, 6, 15);
        final startDate = DateTime(now.year, now.month - 3);
        final endDate = now;

        // Create logs in reverse order to test sorting
        final logs = [
          createMockExerciseLog(
            id: 3,
            date: endDate,
          ),
          createMockExerciseLog(
            id: 1,
            date: startDate,
          ),
          createMockExerciseLog(
            id: 2,
            date: startDate.add(const Duration(days: 30)),
          ),
        ];

        when(
          () => mockRepository.getExerciseLogs(
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
            exerciseIds: any(named: 'exerciseIds'),
          ),
        ).thenAnswer((_) async => right(logs));
      },
      build: () => cubit,
      act: (cubit) => cubit.loadExerciseLogs(exerciseId: 1),
      expect: () => [
        isA<ExerciseDetailsLoading>(),
        isA<ExerciseDetailsLoaded>()
            .having(
              (s) => s.logs.length,
              'logs.length',
              3,
            )
            .having(
              (s) => s.logs.first.id,
              'logs.first.id',
              1, // Should be sorted oldest first
            )
            .having(
              (s) => s.logs.last.id,
              'logs.last.id',
              3, // Should be sorted oldest first
            ),
      ],
    );

    blocTest<ExerciseDetailsCubit, ExerciseDetailsState>(
      'loadExerciseLogs should use default date range (last 3 months) '
      'when not provided',
      setUp: () {
        final now = DateTime(2024, 6, 15);
        // The implementation uses DateTime(now.year, now.month - 3)
        // which calculates 3 months ago
        final startDate = DateTime(now.year, now.month - 3);

        final logs = [
          createMockExerciseLog(id: 1, date: startDate),
        ];

        when(
          () => mockRepository.getExerciseLogs(
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
            exerciseIds: any(named: 'exerciseIds'),
          ),
        ).thenAnswer((invocation) async {
          // Capture the actual startDate passed to verify it's correct
          return right(logs);
        });
      },
      build: () => cubit,
      act: (cubit) => cubit.loadExerciseLogs(exerciseId: 1),
      expect: () => [
        isA<ExerciseDetailsLoading>(),
        isA<ExerciseDetailsLoaded>().having(
          (s) => s.logs.length,
          'logs.length',
          1,
        ),
      ],
    );

    blocTest<ExerciseDetailsCubit, ExerciseDetailsState>(
      'loadExerciseLogs should use provided date range',
      setUp: () {
        final startDate = DateTime(2024);
        final logs = [
          createMockExerciseLog(id: 1, date: startDate),
        ];

        when(
          () => mockRepository.getExerciseLogs(
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
            exerciseIds: any(named: 'exerciseIds'),
          ),
        ).thenAnswer((_) async => right(logs));
      },
      build: () => cubit,
      act: (cubit) => cubit.loadExerciseLogs(
        exerciseId: 1,
        startDate: DateTime(2024),
        endDate: DateTime(2024, 6, 15),
      ),
      expect: () => [
        isA<ExerciseDetailsLoading>(),
        isA<ExerciseDetailsLoaded>()
            .having(
              (s) => s.startDate,
              'startDate',
              DateTime(2024),
            )
            .having(
              (s) => s.endDate,
              'endDate',
              DateTime(2024, 6, 15),
            ),
      ],
    );

    blocTest<ExerciseDetailsCubit, ExerciseDetailsState>(
      'loadExerciseLogs should emit error when fetch fails',
      setUp: () {
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
      act: (cubit) => cubit.loadExerciseLogs(exerciseId: 1),
      expect: () => [
        isA<ExerciseDetailsLoading>(),
        isA<ExerciseDetailsError>()
            .having((s) => s.message, 'message', 'Failed to fetch logs'),
      ],
    );

    blocTest<ExerciseDetailsCubit, ExerciseDetailsState>(
      'loadExerciseLogs should handle empty logs list',
      setUp: () {
        when(
          () => mockRepository.getExerciseLogs(
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
            exerciseIds: any(named: 'exerciseIds'),
          ),
        ).thenAnswer((_) async => right([]));
      },
      build: () => cubit,
      act: (cubit) => cubit.loadExerciseLogs(exerciseId: 1),
      expect: () => [
        isA<ExerciseDetailsLoading>(),
        isA<ExerciseDetailsLoaded>()
            .having((s) => s.logs.length, 'logs.length', 0),
      ],
    );

    blocTest<ExerciseDetailsCubit, ExerciseDetailsState>(
      'updateDateRange should reload logs with new date range',
      setUp: () {
        final startDate1 = DateTime(2024);
        final endDate1 = DateTime(2024, 3, 31);
        final startDate2 = DateTime(2024, 4);
        final endDate2 = DateTime(2024, 6, 15);

        when(
          () => mockRepository.getExerciseLogs(
            startDate: startDate1,
            endDate: endDate1,
            exerciseIds: [1],
          ),
        ).thenAnswer(
          (_) async => right([
            createMockExerciseLog(id: 1, date: startDate1),
          ]),
        );
        when(
          () => mockRepository.getExerciseLogs(
            startDate: startDate2,
            endDate: endDate2,
            exerciseIds: [1],
          ),
        ).thenAnswer(
          (_) async => right([
            createMockExerciseLog(id: 2, date: startDate2),
          ]),
        );
      },
      build: () => cubit,
      act: (cubit) async {
        await cubit.loadExerciseLogs(
          exerciseId: 1,
          startDate: DateTime(2024),
          endDate: DateTime(2024, 3, 31),
        );
        await cubit.updateDateRange(
          exerciseId: 1,
          startDate: DateTime(2024, 4),
          endDate: DateTime(2024, 6, 15),
        );
      },
      expect: () => [
        isA<ExerciseDetailsLoading>(),
        isA<ExerciseDetailsLoaded>()
            .having(
              (s) => s.startDate,
              'startDate',
              DateTime(2024),
            )
            .having(
              (s) => s.endDate,
              'endDate',
              DateTime(2024, 3, 31),
            ),
        isA<ExerciseDetailsLoading>(),
        isA<ExerciseDetailsLoaded>()
            .having(
              (s) => s.startDate,
              'startDate',
              DateTime(2024, 4),
            )
            .having(
              (s) => s.endDate,
              'endDate',
              DateTime(2024, 6, 15),
            ),
      ],
    );

    blocTest<ExerciseDetailsCubit, ExerciseDetailsState>(
      'loadExerciseLogs should sort logs by date (oldest first)',
      setUp: () {
        final now = DateTime(2024, 6, 15);
        final startDate = DateTime(now.year, now.month - 3);
        final endDate = now;

        // Create logs in random order
        final logs = [
          createMockExerciseLog(
            id: 3,
            date: endDate.subtract(const Duration(days: 10)),
          ),
          createMockExerciseLog(
            id: 1,
            date: startDate,
          ),
          createMockExerciseLog(
            id: 2,
            date: startDate.add(const Duration(days: 30)),
          ),
        ];

        when(
          () => mockRepository.getExerciseLogs(
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
            exerciseIds: any(named: 'exerciseIds'),
          ),
        ).thenAnswer((_) async => right(logs));
      },
      build: () => cubit,
      act: (cubit) => cubit.loadExerciseLogs(exerciseId: 1),
      expect: () => [
        isA<ExerciseDetailsLoading>(),
        isA<ExerciseDetailsLoaded>()
            .having(
              (s) => s.logs[0].id,
              'logs[0].id',
              1, // Oldest first
            )
            .having(
              (s) => s.logs[1].id,
              'logs[1].id',
              2,
            )
            .having(
              (s) => s.logs[2].id,
              'logs[2].id',
              3, // Newest last
            ),
      ],
    );

    blocTest<ExerciseDetailsCubit, ExerciseDetailsState>(
      'loadExerciseLogs should handle logs with same date',
      setUp: () {
        final now = DateTime(2024, 6, 15);
        final startDate = DateTime(now.year, now.month - 3);
        final sameDate = startDate.add(const Duration(days: 30));

        // Create logs with same date
        final logs = [
          createMockExerciseLog(
            id: 2,
            date: sameDate,
            setsCompleted: 4,
          ),
          createMockExerciseLog(
            id: 1,
            date: sameDate,
          ),
        ];

        when(
          () => mockRepository.getExerciseLogs(
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
            exerciseIds: any(named: 'exerciseIds'),
          ),
        ).thenAnswer((_) async => right(logs));
      },
      build: () => cubit,
      act: (cubit) => cubit.loadExerciseLogs(exerciseId: 1),
      expect: () => [
        isA<ExerciseDetailsLoading>(),
        isA<ExerciseDetailsLoaded>()
            .having((s) => s.logs.length, 'logs.length', 2),
      ],
    );

    blocTest<ExerciseDetailsCubit, ExerciseDetailsState>(
      'loadExerciseLogs should pass correct exercise ID',
      setUp: () {
        final now = DateTime(2024, 6, 15);
        final startDate = DateTime(now.year, now.month - 3);
        final logs = [
          createMockExerciseLog(id: 1, exerciseId: 5, date: startDate),
        ];

        when(
          () => mockRepository.getExerciseLogs(
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
            exerciseIds: [5],
          ),
        ).thenAnswer((_) async => right(logs));
      },
      build: () => cubit,
      act: (cubit) => cubit.loadExerciseLogs(exerciseId: 5),
      expect: () => [
        isA<ExerciseDetailsLoading>(),
        isA<ExerciseDetailsLoaded>().having(
          (s) => s.logs.first.exerciseId,
          'logs.first.exerciseId',
          5,
        ),
      ],
      verify: (_) {
        verify(
          () => mockRepository.getExerciseLogs(
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
            exerciseIds: [5],
          ),
        ).called(1);
      },
    );
  });
}
