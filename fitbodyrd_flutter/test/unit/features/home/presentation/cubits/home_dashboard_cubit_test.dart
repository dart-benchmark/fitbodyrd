import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/home/domain/repositories/dashboard_repository.dart';
import 'package:fitbodyrd_flutter/features/home/presentation/cubits/home_dashboard_cubit.dart';
import 'package:fitbodyrd_flutter/features/home/presentation/cubits/home_dashboard_state.dart';
import 'package:fitbodyrd_flutter/features/nutrition/domain/repositories/nutrition_repository.dart';
import 'package:fitbodyrd_flutter/features/workouts/domain/repositories/workout_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:record_result/record_result.dart';

// Mock classes
class MockDashboardRepository extends Mock implements DashboardRepository {}

class MockNutritionRepository extends Mock implements NutritionRepository {}

class MockWorkoutRepository extends Mock implements WorkoutRepository {}

// Helper functions
WeeklySummaryDto createMockWeeklySummary() {
  final now = DateTime(2024, 6, 15);
  final monday = now.subtract(Duration(days: now.weekday - 1));
  return WeeklySummaryDto(
    workoutsCompleted: 3,
    workoutsScheduled: 5,
    nutritionDaysLogged: 4,
    totalExercisesLogged: 10,
    totalMealsLogged: 12,
    weekStartDate: monday,
    weekEndDate: monday.add(const Duration(days: 6)),
  );
}

NutritionPlan createMockNutritionPlan({DateTime? date}) {
  final targetDate = date ?? DateTime.now();
  return NutritionPlan(
    id: 1,
    userProfileId: 1,
    startDate: targetDate.subtract(const Duration(days: 7)),
    endDate: targetDate.add(const Duration(days: 7)),
    dailyCalories: 2000.0,
    dailyProteins: 150.0,
    dailyCarbs: 200.0,
    dailyFats: 65.0,
    status: Status.active,
    mealPlans: [
      MealPlan(
        id: 1,
        nutritionPlanId: 1,
        date: targetDate,
        dayNumber: 1,
        mealType: MealPlanType.breakfast,
        targetCalories: 500.0,
        targetProteins: 30.0,
        targetCarbs: 50.0,
        targetFats: 15.0,
      ),
      MealPlan(
        id: 2,
        nutritionPlanId: 1,
        date: targetDate,
        dayNumber: 1,
        mealType: MealPlanType.lunch,
        targetCalories: 700.0,
        targetProteins: 50.0,
        targetCarbs: 70.0,
        targetFats: 25.0,
      ),
      MealPlan(
        id: 3,
        nutritionPlanId: 1,
        date: targetDate,
        dayNumber: 1,
        mealType: MealPlanType.dinner,
        targetCalories: 600.0,
        targetProteins: 40.0,
        targetCarbs: 60.0,
        targetFats: 20.0,
      ),
    ],
  );
}

FoodIntakeLog createMockFoodLog({
  required int foodId,
  required double calories,
  required double quantityGrams,
}) {
  return FoodIntakeLog(
    id: foodId,
    userId: 1,
    foodId: foodId,
    date: DateTime.now(),
    mealType: MealPlanType.breakfast,
    servingQuantity: 1.0,
    quantityGrams: quantityGrams,
    food: Food(
      id: foodId,
      name: 'Test Food $foodId',
      categoryId: 1,
      calories: calories,
      proteins: 10.0,
      carbs: 20.0,
      fats: 5.0,
      fiber: 2.0,
    ),
  );
}

WorkoutPlan createMockWorkoutPlan({
  DateTime? date,
  bool sessionComplete = false,
}) {
  final targetDate = date ?? DateTime.now();
  return WorkoutPlan(
    id: 1,
    userId: 1,
    name: 'Test Plan',
    startDate: targetDate.subtract(const Duration(days: 7)),
    endDate: targetDate.add(const Duration(days: 7)),
    difficultyLevel: ExerciseDifficulty.beginner,
    sessionsCount: 5,
    status: Status.active,
    sessions: [
      WorkoutSession(
        id: 1,
        workoutPlanId: 1,
        date: targetDate,
        dayName: 'Saturday',
        focus: 'Full Body',
        sessionComplete: sessionComplete,
      ),
    ],
  );
}

void main() {
  group('HomeDashboardCubit', () {
    late HomeDashboardCubit cubit;
    late MockDashboardRepository mockDashboardRepository;
    late MockNutritionRepository mockNutritionRepository;
    late MockWorkoutRepository mockWorkoutRepository;

    setUp(() {
      mockDashboardRepository = MockDashboardRepository();
      mockNutritionRepository = MockNutritionRepository();
      mockWorkoutRepository = MockWorkoutRepository();

      registerFallbackValue(Object());

      cubit = HomeDashboardCubit(
        mockDashboardRepository,
        mockNutritionRepository,
        mockWorkoutRepository,
      );
    });

    tearDown(() async {
      await cubit.close();
    });

    test('initial state is HomeDashboardInitial', () {
      expect(cubit.state, isA<HomeDashboardInitial>());
    });

    test(
        'loadDashboard should emit HomeDashboardLoading '
        'when showLoading is true', () async {
      // Arrange
      final summary = createMockWeeklySummary();
      when(() => mockDashboardRepository.getWeeklySummary())
          .thenAnswer((_) async => right(summary));
      when(() => mockNutritionRepository.getActiveNutritionPlan()).thenAnswer(
        (_) async => left(
          ServerFailure(
            statusCode: 5001,
            message: 'No active plan',
          ),
        ),
      );
      when(() => mockWorkoutRepository.getActiveWorkoutPlan()).thenAnswer(
        (_) async => left(
          ServerFailure(
            statusCode: 7001,
            message: 'No active plan',
          ),
        ),
      );

      // Act
      final states = <HomeDashboardState>[];
      cubit.stream.listen(states.add);
      await cubit.loadDashboard();

      // Assert
      expect(states.first, isA<HomeDashboardLoading>());
    });

    test(
        'loadDashboard should emit HomeDashboardError '
        'when weekly summary fails', () async {
      // Arrange
      when(() => mockDashboardRepository.getWeeklySummary()).thenAnswer(
        (_) async => left(
          ServerFailure(
            statusCode: 500,
            message: 'Failed to load summary',
          ),
        ),
      );

      // Act
      final states = <HomeDashboardState>[];
      final subscription = cubit.stream.listen(states.add);
      await cubit.loadDashboard();
      await Future<void>.delayed(const Duration(milliseconds: 10));
      await subscription.cancel();

      // Assert
      expect(states.length, greaterThanOrEqualTo(1));
      expect(states.last, isA<HomeDashboardError>());
      final errorState = states[1] as HomeDashboardError;
      expect(errorState.message, equals('Failed to load summary'));
      verify(() => mockDashboardRepository.getWeeklySummary()).called(1);
      verifyNever(() => mockNutritionRepository.getActiveNutritionPlan());
      verifyNever(() => mockWorkoutRepository.getActiveWorkoutPlan());
    });

    test(
        'loadDashboard should emit HomeDashboardLoaded '
        'with all data on success', () async {
      // Arrange
      final summary = createMockWeeklySummary();
      final nutritionPlan = createMockNutritionPlan();
      final workoutPlan = createMockWorkoutPlan();
      final foodLogs = [
        createMockFoodLog(foodId: 1, calories: 100.0, quantityGrams: 200.0),
        createMockFoodLog(foodId: 2, calories: 150.0, quantityGrams: 150.0),
      ];

      when(() => mockDashboardRepository.getWeeklySummary())
          .thenAnswer((_) async => right(summary));
      when(() => mockNutritionRepository.getActiveNutritionPlan())
          .thenAnswer((_) async => right(nutritionPlan));
      when(() => mockNutritionRepository.getFoodIntakeLogs(any()))
          .thenAnswer((_) async => right(foodLogs));
      when(() => mockWorkoutRepository.getActiveWorkoutPlan())
          .thenAnswer((_) async => right(workoutPlan));

      // Act
      await cubit.loadDashboard();
      await Future<void>.delayed(const Duration(milliseconds: 10));

      // Assert

      final state = cubit.state as HomeDashboardLoaded;
      expect(state.summary, isNotNull);
      expect(state.nutritionPlan, isNotNull);
      expect(state.workoutPlan, isNotNull);
      expect(state.targetCalories, equals(1800.0)); // 500 + 700 + 600
      // Calories: (100 * 200/100) + (150 * 150/100) = 200 + 225 = 425
      expect(state.todayCalories, equals(425.0));
      expect(state.hasWorkoutToday, isTrue);
      expect(state.isWorkoutCompleted, isFalse);

      verify(() => mockDashboardRepository.getWeeklySummary()).called(1);
      verify(() => mockNutritionRepository.getActiveNutritionPlan()).called(1);
      verify(() => mockWorkoutRepository.getActiveWorkoutPlan()).called(1);
    });

    test('loadDashboard should calculate today calories correctly', () async {
      // Arrange
      final summary = createMockWeeklySummary();
      final nutritionPlan = createMockNutritionPlan();
      final foodLogs = [
        createMockFoodLog(
          foodId: 1,
          calories: 200.0,
          quantityGrams: 100.0,
        ), // 200 * 1 = 200
        createMockFoodLog(
          foodId: 2,
          calories: 300.0,
          quantityGrams: 150.0,
        ), // 300 * 1.5 = 450
        createMockFoodLog(
          foodId: 3,
          calories: 100.0,
          quantityGrams: 50.0,
        ), // 100 * 0.5 = 50
      ];

      when(() => mockDashboardRepository.getWeeklySummary())
          .thenAnswer((_) async => right(summary));
      when(() => mockNutritionRepository.getActiveNutritionPlan())
          .thenAnswer((_) async => right(nutritionPlan));
      when(() => mockNutritionRepository.getFoodIntakeLogs(any()))
          .thenAnswer((_) async => right(foodLogs));
      when(() => mockWorkoutRepository.getActiveWorkoutPlan())
          .thenAnswer((_) async => right(createMockWorkoutPlan()));

      // Act
      await cubit.loadDashboard();

      // Assert
      final state = cubit.state as HomeDashboardLoaded;
      // Total: 200 + 450 + 50 = 700
      expect(state.todayCalories, equals(700.0));
    });

    test('loadDashboard should handle no nutrition plan gracefully', () async {
      // Arrange
      final summary = createMockWeeklySummary();
      when(() => mockDashboardRepository.getWeeklySummary())
          .thenAnswer((_) async => right(summary));
      when(() => mockNutritionRepository.getActiveNutritionPlan()).thenAnswer(
        (_) async => left(
          ServerFailure(
            statusCode: 5001,
            message: 'No active plan',
          ),
        ),
      );
      when(() => mockWorkoutRepository.getActiveWorkoutPlan())
          .thenAnswer((_) async => right(createMockWorkoutPlan()));

      // Act
      await cubit.loadDashboard();

      // Assert
      final state = cubit.state as HomeDashboardLoaded;
      expect(state.nutritionPlan, isNull);
      expect(state.targetCalories, equals(0.0));
      expect(state.todayCalories, equals(0.0));
    });

    test('loadDashboard should handle no workout plan gracefully', () async {
      // Arrange
      final summary = createMockWeeklySummary();
      final nutritionPlan = createMockNutritionPlan();
      when(() => mockDashboardRepository.getWeeklySummary())
          .thenAnswer((_) async => right(summary));
      when(() => mockNutritionRepository.getActiveNutritionPlan())
          .thenAnswer((_) async => right(nutritionPlan));
      when(() => mockNutritionRepository.getFoodIntakeLogs(any()))
          .thenAnswer((_) async => right([]));
      when(() => mockWorkoutRepository.getActiveWorkoutPlan()).thenAnswer(
        (_) async => left(
          ServerFailure(
            statusCode: 7001,
            message: 'No active plan',
          ),
        ),
      );

      // Act
      await cubit.loadDashboard();

      // Assert
      final state = cubit.state as HomeDashboardLoaded;
      expect(state.workoutPlan, isNull);
      expect(state.hasWorkoutToday, isFalse);
      expect(state.isWorkoutCompleted, isFalse);
    });

    test('loadDashboard should detect workout today correctly', () async {
      // Arrange
      final summary = createMockWeeklySummary();
      final nutritionPlan = createMockNutritionPlan();
      final today = DateTime.now();
      final workoutPlan = createMockWorkoutPlan(date: today);

      when(() => mockDashboardRepository.getWeeklySummary())
          .thenAnswer((_) async => right(summary));
      when(() => mockNutritionRepository.getActiveNutritionPlan())
          .thenAnswer((_) async => right(nutritionPlan));
      when(() => mockNutritionRepository.getFoodIntakeLogs(any()))
          .thenAnswer((_) async => right([]));
      when(() => mockWorkoutRepository.getActiveWorkoutPlan())
          .thenAnswer((_) async => right(workoutPlan));

      // Act
      await cubit.loadDashboard();

      // Assert
      final state = cubit.state as HomeDashboardLoaded;
      expect(state.hasWorkoutToday, isTrue);
    });

    test('loadDashboard should detect completed workout correctly', () async {
      // Arrange
      final summary = createMockWeeklySummary();
      final nutritionPlan = createMockNutritionPlan();
      final today = DateTime.now();
      final workoutPlan = createMockWorkoutPlan(
        date: today,
        sessionComplete: true,
      );

      when(() => mockDashboardRepository.getWeeklySummary())
          .thenAnswer((_) async => right(summary));
      when(() => mockNutritionRepository.getActiveNutritionPlan())
          .thenAnswer((_) async => right(nutritionPlan));
      when(() => mockNutritionRepository.getFoodIntakeLogs(any()))
          .thenAnswer((_) async => right([]));
      when(() => mockWorkoutRepository.getActiveWorkoutPlan())
          .thenAnswer((_) async => right(workoutPlan));

      // Act
      await cubit.loadDashboard();

      // Assert
      final state = cubit.state as HomeDashboardLoaded;
      expect(state.hasWorkoutToday, isTrue);
      expect(state.isWorkoutCompleted, isTrue);
    });

    test('loadDashboard should not emit loading when showLoading is false',
        () async {
      // Arrange
      final summary = createMockWeeklySummary();
      when(() => mockDashboardRepository.getWeeklySummary())
          .thenAnswer((_) async => right(summary));
      when(() => mockNutritionRepository.getActiveNutritionPlan()).thenAnswer(
        (_) async => left(
          ServerFailure(
            statusCode: 5001,
            message: 'No active plan',
          ),
        ),
      );
      when(() => mockWorkoutRepository.getActiveWorkoutPlan()).thenAnswer(
        (_) async => left(
          ServerFailure(
            statusCode: 7001,
            message: 'No active plan',
          ),
        ),
      );

      // Act
      await cubit.loadDashboard(showLoading: false);
      await Future<void>.delayed(const Duration(milliseconds: 10));

      // Assert
      expect(cubit.state, isA<HomeDashboardLoaded>());
    });
  });
}
