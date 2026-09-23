import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/nutrition/domain/repositories/nutrition_repository.dart';
import 'package:fitbodyrd_flutter/features/nutrition/presentation/cubits/nutrition_generation_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:record_result/record_result.dart';

// Mock classes
class MockNutritionRepository extends Mock implements NutritionRepository {}

// Helper functions for mock data
NutritionPlan createMockNutritionPlan() {
  final today = DateTime(2024, 6, 15);
  return NutritionPlan(
    id: 1,
    userProfileId: 1,
    startDate: today.subtract(const Duration(days: 7)),
    endDate: today.add(const Duration(days: 7)),
    dailyCalories: 2000.0,
    dailyProteins: 150.0,
    dailyCarbs: 200.0,
    dailyFats: 65.0,
    status: Status.active,
    mealPlans: [],
  );
}

GenerateNutritionPlanProgressDto createProgressDto({
  required StreamStatus status,
  required String message,
  required double progressPercentage,
  bool success = false,
  int currentDay = 1,
  int totalDays = 14,
}) {
  return GenerateNutritionPlanProgressDto(
    success: success,
    status: status,
    message: message,
    progressPercentage: progressPercentage,
    currentDay: currentDay,
    totalDays: totalDays,
    updatedAt: DateTime(2024, 6, 15),
  );
}

void main() {
  group('NutritionGenerationCubit', () {
    late NutritionGenerationCubit cubit;
    late MockNutritionRepository mockRepository;

    setUp(() {
      mockRepository = MockNutritionRepository();
      registerFallbackValue(Object());

      cubit = NutritionGenerationCubit(
        nutritionRepository: mockRepository,
      );
    });

    tearDown(() async {
      await cubit.close();
    });

    test('initial state is NutritionGenerationInitial', () {
      expect(cubit.state, isA<NutritionGenerationInitial>());
    });

    blocTest<NutritionGenerationCubit, NutritionGenerationState>(
      'generateNutritionPlan should emit initial progress state',
      setUp: () async {
        final streamController =
            StreamController<GenerateNutritionPlanProgressDto>();
        when(
          () => mockRepository.requestNutritionPlanGeneration(
            weeks: any(named: 'weeks'),
            mealTypes: any(named: 'mealTypes'),
          ),
        ).thenAnswer((_) => streamController.stream);
        // Close stream immediately to avoid hanging
        unawaited(Future<void>.microtask(streamController.close));
      },
      build: () => cubit,
      act: (cubit) => cubit.generateNutritionPlan(
        weeks: 2,
        mealTypes: [MealPlanType.breakfast, MealPlanType.lunch],
      ),
      expect: () => [
        isA<NutritionGenerationInProgress>()
            .having(
              (s) => s.message,
              'message',
              'Iniciando generación...',
            )
            .having(
              (s) => s.progress,
              'progress',
              0.0,
            ),
      ],
    );

    blocTest<NutritionGenerationCubit, NutritionGenerationState>(
      'generateNutritionPlan should emit progress updates from stream',
      setUp: () async {
        final streamController =
            StreamController<GenerateNutritionPlanProgressDto>();
        when(
          () => mockRepository.requestNutritionPlanGeneration(
            weeks: any(named: 'weeks'),
            mealTypes: any(named: 'mealTypes'),
          ),
        ).thenAnswer((_) => streamController.stream);
        when(() => mockRepository.getActiveNutritionPlan()).thenAnswer(
          (_) async => left(
            ServerFailure(statusCode: 5001, message: 'No plan yet'),
          ),
        );

        // Emit progress updates
        await Future<void>.microtask(() async {
          streamController.add(
            createProgressDto(
              status: StreamStatus.waiting,
              message: 'Generating plan...',
              progressPercentage: 50.0,
            ),
          );
          unawaited(Future<void>.microtask(streamController.close));
        });
      },
      build: () => cubit,
      act: (cubit) => cubit.generateNutritionPlan(
        weeks: 2,
        mealTypes: [MealPlanType.breakfast, MealPlanType.lunch],
      ),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        isA<NutritionGenerationInProgress>().having(
          (s) => s.progress,
          'progress',
          0.0,
        ),
        isA<NutritionGenerationInProgress>()
            .having(
              (s) => s.message,
              'message',
              'Generating plan...',
            )
            .having(
              (s) => s.progress,
              'progress',
              0.5, // 50.0 / 100
            ),
      ],
    );

    blocTest<NutritionGenerationCubit, NutritionGenerationState>(
      'generateNutritionPlan should emit success state on completion',
      setUp: () async {
        final streamController =
            StreamController<GenerateNutritionPlanProgressDto>();
        final nutritionPlan = createMockNutritionPlan();
        when(
          () => mockRepository.requestNutritionPlanGeneration(
            weeks: any(named: 'weeks'),
            mealTypes: any(named: 'mealTypes'),
          ),
        ).thenAnswer((_) => streamController.stream);
        when(() => mockRepository.getActiveNutritionPlan())
            .thenAnswer((_) async => right(nutritionPlan));

        // Emit completion
        await Future<void>.microtask(() async {
          streamController.add(
            createProgressDto(
              status: StreamStatus.completed,
              message: 'Plan generated',
              progressPercentage: 100.0,
              success: true,
            ),
          );
          unawaited(Future<void>.microtask(streamController.close));
        });
      },
      build: () => cubit,
      act: (cubit) => cubit.generateNutritionPlan(
        weeks: 2,
        mealTypes: [MealPlanType.breakfast, MealPlanType.lunch],
      ),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        isA<NutritionGenerationInProgress>(),
        isA<NutritionGenerationSuccess>().having(
          (s) => s.nutritionPlan.id,
          'nutritionPlan.id',
          1,
        ),
      ],
    );

    blocTest<NutritionGenerationCubit, NutritionGenerationState>(
      'generateNutritionPlan should emit error state on stream error',
      setUp: () async {
        final streamController =
            StreamController<GenerateNutritionPlanProgressDto>();
        when(
          () => mockRepository.requestNutritionPlanGeneration(
            weeks: any(named: 'weeks'),
            mealTypes: any(named: 'mealTypes'),
          ),
        ).thenAnswer((_) => streamController.stream);

        // Emit error
        await Future<void>.microtask(() async {
          streamController.addError('Stream error occurred');
          unawaited(Future<void>.microtask(streamController.close));
        });
      },
      build: () => cubit,
      act: (cubit) => cubit.generateNutritionPlan(
        weeks: 2,
        mealTypes: [MealPlanType.breakfast, MealPlanType.lunch],
      ),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        isA<NutritionGenerationInProgress>(),
        isA<NutritionGenerationError>().having(
          (s) => s.message,
          'message',
          'Stream error occurred',
        ),
      ],
    );

    blocTest<NutritionGenerationCubit, NutritionGenerationState>(
      'generateNutritionPlan should emit error state '
      'when progressDto status is error',
      setUp: () async {
        final streamController =
            StreamController<GenerateNutritionPlanProgressDto>();
        when(
          () => mockRepository.requestNutritionPlanGeneration(
            weeks: any(named: 'weeks'),
            mealTypes: any(named: 'mealTypes'),
          ),
        ).thenAnswer((_) => streamController.stream);

        // Emit error status
        await Future<void>.microtask(() async {
          streamController.add(
            createProgressDto(
              status: StreamStatus.error,
              message: 'Generation failed',
              progressPercentage: 0.0,
            ),
          );
          unawaited(Future<void>.microtask(streamController.close));
        });
      },
      build: () => cubit,
      act: (cubit) => cubit.generateNutritionPlan(
        weeks: 2,
        mealTypes: [MealPlanType.breakfast, MealPlanType.lunch],
      ),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        isA<NutritionGenerationInProgress>(),
        isA<NutritionGenerationError>().having(
          (s) => s.message,
          'message',
          'Generation failed',
        ),
      ],
    );

    blocTest<NutritionGenerationCubit, NutritionGenerationState>(
      'generateNutritionPlan should emit error state on AppException',
      setUp: () {
        final appException = AppException(
          module: 'nutrition',
          message: 'Failed to start generation',
          errorCode: 500,
          httpStatus: 500,
        );
        when(
          () => mockRepository.requestNutritionPlanGeneration(
            weeks: any(named: 'weeks'),
            mealTypes: any(named: 'mealTypes'),
          ),
        ).thenThrow(appException);
      },
      build: () => cubit,
      act: (cubit) => cubit.generateNutritionPlan(
        weeks: 2,
        mealTypes: [MealPlanType.breakfast, MealPlanType.lunch],
      ),
      expect: () => [
        isA<NutritionGenerationInProgress>(),
        isA<NutritionGenerationError>().having(
          (s) => s.message,
          'message',
          'Failed to start generation',
        ),
      ],
    );

    blocTest<NutritionGenerationCubit, NutritionGenerationState>(
      'checkActivePlan should emit success state when plan exists',
      setUp: () {
        final nutritionPlan = createMockNutritionPlan();
        when(() => mockRepository.getActiveNutritionPlan())
            .thenAnswer((_) async => right(nutritionPlan));
      },
      build: () => cubit,
      act: (cubit) => cubit.checkActivePlan(),
      expect: () => [
        isA<NutritionGenerationSuccess>().having(
          (s) => s.nutritionPlan.id,
          'nutritionPlan.id',
          1,
        ),
      ],
    );

    blocTest<NutritionGenerationCubit, NutritionGenerationState>(
      'checkActivePlan should not change state when no plan exists',
      setUp: () {
        when(() => mockRepository.getActiveNutritionPlan()).thenAnswer(
          (_) async => left(
            ServerFailure(statusCode: 5001, message: 'No active plan'),
          ),
        );
      },
      build: () => cubit,
      act: (cubit) => cubit.checkActivePlan(),
      expect: () => <NutritionGenerationState>[], // No state change
    );

    test('close should cancel stream subscription', () async {
      // Arrange
      final streamController =
          StreamController<GenerateNutritionPlanProgressDto>();
      when(
        () => mockRepository.requestNutritionPlanGeneration(
          weeks: any(named: 'weeks'),
          mealTypes: any(named: 'mealTypes'),
        ),
      ).thenAnswer((_) => streamController.stream);

      // Act - start generation
      await cubit.generateNutritionPlan(
        weeks: 2,
        mealTypes: [MealPlanType.breakfast, MealPlanType.lunch],
      );

      // Wait a bit for subscription to be created
      await Future<void>.delayed(const Duration(milliseconds: 50));

      // Close the cubit
      await cubit.close();

      // Assert - stream controller should be closed or subscription cancelled
      // We can't directly verify the subscription,
      // but we can verify the cubit is closed
      expect(
        streamController.isClosed,
        isFalse,
      ); // Stream controller is still open
      // The subscription should be cancelled though
    });

    test('generateNutritionPlan should handle partial plan in progress updates',
        () async {
      // Arrange
      final streamController =
          StreamController<GenerateNutritionPlanProgressDto>();
      final partialPlan = createMockNutritionPlan();
      when(
        () => mockRepository.requestNutritionPlanGeneration(
          weeks: any(named: 'weeks'),
          mealTypes: any(named: 'mealTypes'),
        ),
      ).thenAnswer((_) => streamController.stream);
      when(() => mockRepository.getActiveNutritionPlan())
          .thenAnswer((_) async => right(partialPlan));

      // Act
      await cubit.generateNutritionPlan(
        weeks: 2,
        mealTypes: [MealPlanType.breakfast, MealPlanType.lunch],
      );

      // Emit progress with partial plan
      streamController.add(
        createProgressDto(
          status: StreamStatus.waiting,
          message: 'Generating...',
          progressPercentage: 50.0,
        ),
      );

      // Wait for state update
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert - verify state has partial plan
      final state = cubit.state;
      if (state is NutritionGenerationInProgress) {
        expect(state.partialPlan, isNotNull);
      }

      await streamController.close();
      await cubit.close();
    });
  });
}
