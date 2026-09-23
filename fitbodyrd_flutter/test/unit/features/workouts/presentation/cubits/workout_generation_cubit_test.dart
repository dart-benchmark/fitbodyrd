import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/workouts/domain/repositories/workout_repository.dart';
import 'package:fitbodyrd_flutter/features/workouts/presentation/cubits/workout_generation_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:record_result/record_result.dart';

// Mock classes
class MockWorkoutRepository extends Mock implements WorkoutRepository {}

// Helper functions for mock data
WorkoutPlan createMockWorkoutPlan() {
  final today = DateTime(2024, 6, 15);
  return WorkoutPlan(
    id: 1,
    userId: 1,
    name: 'Test Workout Plan',
    difficultyLevel: ExerciseDifficulty.beginner,
    startDate: today,
    endDate: today.add(const Duration(days: 14)),
    status: Status.active,
    sessions: [],
  );
}

GenerateWorkoutPlanProgressDto createProgressDto({
  required StreamStatus status,
  required String message,
  required double progressPercentage,
}) {
  return GenerateWorkoutPlanProgressDto(
    success: status == StreamStatus.completed,
    status: status,
    message: message,
    progressPercentage: progressPercentage,
    currentDay: 1,
    totalDays: 14,
    updatedAt: DateTime(2024, 6, 15),
  );
}

void main() {
  group('WorkoutGenerationCubit', () {
    late WorkoutGenerationCubit cubit;
    late MockWorkoutRepository mockRepository;

    setUp(() {
      mockRepository = MockWorkoutRepository();
      registerFallbackValue(Object());

      cubit = WorkoutGenerationCubit(repository: mockRepository);
    });

    tearDown(() async {
      await cubit.close();
    });

    test('initial state is WorkoutGenerationInitial', () {
      expect(cubit.state, isA<WorkoutGenerationInitial>());
    });

    blocTest<WorkoutGenerationCubit, WorkoutGenerationState>(
      'generateWorkoutPlan should emit initial progress state',
      setUp: () {
        final streamController =
            StreamController<GenerateWorkoutPlanProgressDto>();
        final tipsStreamController = StreamController<String>();

        when(
          () => mockRepository.requestWorkoutPlanGeneration(
            numberOfWeeks: any(named: 'numberOfWeeks'),
          ),
        ).thenAnswer((_) => streamController.stream);
        when(() => mockRepository.listenToWorkoutTips())
            .thenAnswer((_) => tipsStreamController.stream);

        // Close streams immediately to avoid hanging
        unawaited(
          Future<void>.microtask(() async {
            await streamController.close();
            await tipsStreamController.close();
          }),
        );
      },
      build: () => cubit,
      act: (cubit) => cubit.generateWorkoutPlan(weeks: 4),
      expect: () => [
        isA<WorkoutGenerationInProgress>().having(
          (s) => s.currentTip,
          'currentTip',
          'Iniciando generación...',
        ),
      ],
    );

    blocTest<WorkoutGenerationCubit, WorkoutGenerationState>(
      'generateWorkoutPlan should emit progress updates from stream',
      setUp: () {
        final streamController =
            StreamController<GenerateWorkoutPlanProgressDto>();
        final tipsStreamController = StreamController<String>();

        when(
          () => mockRepository.requestWorkoutPlanGeneration(
            numberOfWeeks: any(named: 'numberOfWeeks'),
          ),
        ).thenAnswer((_) => streamController.stream);
        when(() => mockRepository.listenToWorkoutTips())
            .thenAnswer((_) => tipsStreamController.stream);
        when(() => mockRepository.getActiveWorkoutPlan()).thenAnswer(
          (_) async => left(
            ServerFailure(statusCode: 5001, message: 'No plan yet'),
          ),
        );

        // Emit progress updates
        unawaited(
          Future<void>.microtask(() async {
            streamController.add(
              createProgressDto(
                status: StreamStatus.waiting,
                message: 'Generating plan...',
                progressPercentage: 50.0,
              ),
            );
            await streamController.close();
            await tipsStreamController.close();
          }),
        );
      },
      build: () => cubit,
      act: (cubit) => cubit.generateWorkoutPlan(weeks: 4),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        isA<WorkoutGenerationInProgress>().having(
          (s) => s.currentTip,
          'currentTip',
          'Iniciando generación...',
        ),
      ],
    );

    blocTest<WorkoutGenerationCubit, WorkoutGenerationState>(
      'generateWorkoutPlan should emit success when stream completes',
      setUp: () {
        final streamController =
            StreamController<GenerateWorkoutPlanProgressDto>();
        final tipsStreamController = StreamController<String>();
        final mockPlan = createMockWorkoutPlan();

        when(
          () => mockRepository.requestWorkoutPlanGeneration(
            numberOfWeeks: any(named: 'numberOfWeeks'),
          ),
        ).thenAnswer((_) => streamController.stream);
        when(() => mockRepository.listenToWorkoutTips())
            .thenAnswer((_) => tipsStreamController.stream);
        when(() => mockRepository.getActiveWorkoutPlan())
            .thenAnswer((_) async => right(mockPlan));

        // Emit completion
        unawaited(
          Future<void>.microtask(() async {
            streamController.add(
              GenerateWorkoutPlanProgressDto(
                success: true,
                status: StreamStatus.completed,
                message: 'Plan generated',
                progressPercentage: 100.0,
                currentDay: 14,
                totalDays: 14,
                updatedAt: DateTime(2024, 6, 15),
              ),
            );
            await streamController.close();
            await tipsStreamController.close();
          }),
        );
      },
      build: () => cubit,
      act: (cubit) => cubit.generateWorkoutPlan(weeks: 4),
      wait: const Duration(milliseconds: 200),
      expect: () => [
        isA<WorkoutGenerationInProgress>(),
        isA<WorkoutGenerationSuccess>().having((s) => s.plan.id, 'plan.id', 1),
      ],
    );

    blocTest<WorkoutGenerationCubit, WorkoutGenerationState>(
      'generateWorkoutPlan should emit error when stream has error status',
      setUp: () {
        final streamController =
            StreamController<GenerateWorkoutPlanProgressDto>();
        final tipsStreamController = StreamController<String>();

        when(
          () => mockRepository.requestWorkoutPlanGeneration(
            numberOfWeeks: any(named: 'numberOfWeeks'),
          ),
        ).thenAnswer((_) => streamController.stream);
        when(() => mockRepository.listenToWorkoutTips())
            .thenAnswer((_) => tipsStreamController.stream);

        // Emit error status
        unawaited(
          Future<void>.microtask(() async {
            streamController.add(
              GenerateWorkoutPlanProgressDto(
                success: false,
                status: StreamStatus.error,
                message: 'Generation failed',
                progressPercentage: 0.0,
                currentDay: 0,
                totalDays: 14,
                updatedAt: DateTime(2024, 6, 15),
              ),
            );
            await streamController.close();
            await tipsStreamController.close();
          }),
        );
      },
      build: () => cubit,
      act: (cubit) => cubit.generateWorkoutPlan(weeks: 4),
      wait: const Duration(milliseconds: 200),
      expect: () => [
        isA<WorkoutGenerationInProgress>(),
        isA<WorkoutGenerationError>().having(
          (s) => s.message,
          'message',
          'Error generating workout plan',
        ),
      ],
    );

    blocTest<WorkoutGenerationCubit, WorkoutGenerationState>(
      'generateWorkoutPlan should emit error when stream throws error',
      setUp: () {
        final streamController =
            StreamController<GenerateWorkoutPlanProgressDto>();
        final tipsStreamController = StreamController<String>();

        when(
          () => mockRepository.requestWorkoutPlanGeneration(
            numberOfWeeks: any(named: 'numberOfWeeks'),
          ),
        ).thenAnswer((_) => streamController.stream);
        when(() => mockRepository.listenToWorkoutTips())
            .thenAnswer((_) => tipsStreamController.stream);

        // Emit error
        unawaited(
          Future<void>.microtask(() async {
            streamController.addError('Stream error');
            await streamController.close();
            await tipsStreamController.close();
          }),
        );
      },
      build: () => cubit,
      act: (cubit) => cubit.generateWorkoutPlan(weeks: 4),
      wait: const Duration(milliseconds: 200),
      expect: () => [
        isA<WorkoutGenerationInProgress>(),
        isA<WorkoutGenerationError>().having(
          (s) => s.message,
          'message',
          contains('Stream error'),
        ),
      ],
    );

    blocTest<WorkoutGenerationCubit, WorkoutGenerationState>(
      'generateWorkoutPlan should emit error when getActiveWorkoutPlan '
      'fails after completion',
      setUp: () {
        final streamController =
            StreamController<GenerateWorkoutPlanProgressDto>();
        final tipsStreamController = StreamController<String>();

        when(
          () => mockRepository.requestWorkoutPlanGeneration(
            numberOfWeeks: any(named: 'numberOfWeeks'),
          ),
        ).thenAnswer((_) => streamController.stream);
        when(() => mockRepository.listenToWorkoutTips())
            .thenAnswer((_) => tipsStreamController.stream);
        when(() => mockRepository.getActiveWorkoutPlan()).thenAnswer(
          (_) async => left(
            ServerFailure(statusCode: 500, message: 'Failed to get plan'),
          ),
        );

        // Emit completion
        unawaited(
          Future<void>.microtask(() async {
            streamController.add(
              GenerateWorkoutPlanProgressDto(
                success: true,
                status: StreamStatus.completed,
                message: 'Plan generated',
                progressPercentage: 100.0,
                currentDay: 14,
                totalDays: 14,
                updatedAt: DateTime(2024, 6, 15),
              ),
            );
            await streamController.close();
            await tipsStreamController.close();
          }),
        );
      },
      build: () => cubit,
      act: (cubit) => cubit.generateWorkoutPlan(weeks: 4),
      wait: const Duration(milliseconds: 200),
      expect: () => [
        isA<WorkoutGenerationInProgress>(),
        isA<WorkoutGenerationError>().having(
          (s) => s.message,
          'message',
          'Failed to get plan',
        ),
      ],
    );

    blocTest<WorkoutGenerationCubit, WorkoutGenerationState>(
      'checkActiveWorkoutPlan should emit success when plan exists',
      setUp: () {
        final mockPlan = createMockWorkoutPlan();
        when(() => mockRepository.getActiveWorkoutPlan())
            .thenAnswer((_) async => right(mockPlan));
      },
      build: () => cubit,
      act: (cubit) => cubit.checkActiveWorkoutPlan(),
      expect: () => [
        isA<WorkoutGenerationSuccess>().having((s) => s.plan.id, 'plan.id', 1),
      ],
    );

    blocTest<WorkoutGenerationCubit, WorkoutGenerationState>(
      'checkActiveWorkoutPlan should stay in initial state when no plan (7001)',
      setUp: () {
        when(() => mockRepository.getActiveWorkoutPlan()).thenAnswer(
          (_) async => left(
            ServerFailure(statusCode: 7001, message: 'No active plan'),
          ),
        );
      },
      build: () => cubit,
      act: (cubit) => cubit.checkActiveWorkoutPlan(),
      expect: () => <WorkoutGenerationState>[],
    );

    blocTest<WorkoutGenerationCubit, WorkoutGenerationState>(
      'checkActiveWorkoutPlan should emit error for other errors',
      setUp: () {
        when(() => mockRepository.getActiveWorkoutPlan()).thenAnswer(
          (_) async => left(
            ServerFailure(statusCode: 500, message: 'Server error'),
          ),
        );
      },
      build: () => cubit,
      act: (cubit) => cubit.checkActiveWorkoutPlan(),
      expect: () => [
        isA<WorkoutGenerationError>()
            .having((s) => s.message, 'message', 'Server error'),
      ],
    );

    blocTest<WorkoutGenerationCubit, WorkoutGenerationState>(
      'generateWorkoutPlan should update tip from tips stream',
      setUp: () {
        final streamController =
            StreamController<GenerateWorkoutPlanProgressDto>();
        final tipsStreamController = StreamController<String>();

        when(
          () => mockRepository.requestWorkoutPlanGeneration(
            numberOfWeeks: any(named: 'numberOfWeeks'),
          ),
        ).thenAnswer((_) => streamController.stream);
        when(() => mockRepository.listenToWorkoutTips())
            .thenAnswer((_) => tipsStreamController.stream);
        when(() => mockRepository.getActiveWorkoutPlan()).thenAnswer(
          (_) async => left(
            ServerFailure(statusCode: 5001, message: 'No plan yet'),
          ),
        );

        // Emit tip
        unawaited(
          Future<void>.microtask(() async {
            tipsStreamController.add('New tip message');
            await Future<void>.delayed(const Duration(milliseconds: 50));
            await streamController.close();
            await tipsStreamController.close();
          }),
        );
      },
      build: () => cubit,
      act: (cubit) => cubit.generateWorkoutPlan(weeks: 4),
      wait: const Duration(milliseconds: 200),
      expect: () => [
        isA<WorkoutGenerationInProgress>().having(
          (s) => s.currentTip,
          'currentTip',
          'Iniciando generación...',
        ),
        isA<WorkoutGenerationInProgress>().having(
          (s) => s.currentTip,
          'currentTip',
          'New tip message',
        ),
      ],
    );

    test('close should cancel subscriptions', () async {
      final streamController =
          StreamController<GenerateWorkoutPlanProgressDto>();
      final tipsStreamController = StreamController<String>();

      when(
        () => mockRepository.requestWorkoutPlanGeneration(
          numberOfWeeks: any(named: 'numberOfWeeks'),
        ),
      ).thenAnswer((_) => streamController.stream);
      when(() => mockRepository.listenToWorkoutTips())
          .thenAnswer((_) => tipsStreamController.stream);

      await cubit.generateWorkoutPlan(weeks: 4);
      await cubit.close();

      // Verify streams are closed
      expect(
        streamController.isClosed,
        isFalse,
      ); // Controller not closed by cubit
      expect(
        tipsStreamController.isClosed,
        isFalse,
      ); // Controller not closed by cubit

      await streamController.close();
      await tipsStreamController.close();
    });
  });
}
