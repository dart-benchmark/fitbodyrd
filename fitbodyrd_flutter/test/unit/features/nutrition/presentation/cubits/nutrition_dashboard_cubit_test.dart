import 'package:bloc_test/bloc_test.dart';
import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/nutrition/domain/repositories/nutrition_repository.dart';
import 'package:fitbodyrd_flutter/features/nutrition/presentation/cubits/nutrition_dashboard_cubit.dart';
import 'package:fitbodyrd_flutter/features/nutrition/presentation/cubits/nutrition_dashboard_state.dart';
import 'package:fitbodyrd_flutter/src/core/services/dashboard_refresh_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:record_result/record_result.dart';

// Mock classes
class MockNutritionRepository extends Mock implements NutritionRepository {}

class MockDashboardRefreshService extends Mock
    implements DashboardRefreshService {}

// Helper functions for mock data
NutritionPlan createMockNutritionPlan({DateTime? date}) {
  final targetDate = date ?? DateTime(2024, 6, 15);
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
        dayNumber: targetDate.weekday,
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
        dayNumber: targetDate.weekday,
        mealType: MealPlanType.lunch,
        targetCalories: 700.0,
        targetProteins: 50.0,
        targetCarbs: 70.0,
        targetFats: 25.0,
      ),
      MealPlan(
        id: 3,
        nutritionPlanId: 1,
        date: targetDate.subtract(const Duration(days: 1)), // Yesterday
        dayNumber: targetDate.subtract(const Duration(days: 1)).weekday,
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
  int id = 1,
  int foodId = 1,
  int? mealPlanId,
  double calories = 100.0,
  double quantityGrams = 100.0,
  DateTime? date,
}) {
  return FoodIntakeLog(
    id: id,
    userId: 1,
    mealPlanId: mealPlanId,
    foodId: foodId,
    date: date ?? DateTime(2024, 6, 15),
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

MealPlanFood createMockMealPlanFood({
  int id = 1,
  int mealPlanId = 1,
  int foodId = 1,
}) {
  return MealPlanFood(
    id: id,
    mealPlanId: mealPlanId,
    foodId: foodId,
    servingSizeId: 1,
    servingQuantity: 1.0,
    quantityGrams: 100.0,
    food: Food(
      id: foodId,
      name: 'Test Food $foodId',
      categoryId: 1,
      calories: 100.0,
      proteins: 10.0,
      carbs: 20.0,
      fats: 5.0,
      fiber: 2.0,
    ),
  );
}

Food createMockFood({int id = 1, String name = 'Test Food'}) {
  return Food(
    id: id,
    name: name,
    categoryId: 1,
    calories: 100.0,
    proteins: 10.0,
    carbs: 20.0,
    fats: 5.0,
    fiber: 2.0,
  );
}

void main() {
  group('NutritionDashboardCubit', () {
    late NutritionDashboardCubit cubit;
    late MockNutritionRepository mockRepository;
    late MockDashboardRefreshService mockRefreshService;

    setUp(() {
      mockRepository = MockNutritionRepository();
      mockRefreshService = MockDashboardRefreshService();
      registerFallbackValue(Object());
      registerFallbackValue(
        CreateFoodIntakeLog(
          foodId: 1,
          date: DateTime(2024, 6, 15),
          mealType: MealPlanType.breakfast,
          servingQuantity: 1.0,
          quantityGrams: 100.0,
        ),
      );

      cubit = NutritionDashboardCubit(
        mockRepository,
        mockRefreshService,
      );
    });

    tearDown(() async {
      await cubit.close();
    });

    test('initial state is NutritionDashboardInitial', () {
      expect(cubit.state, isA<NutritionDashboardInitial>());
    });

    blocTest<NutritionDashboardCubit, NutritionDashboardState>(
      'loadDashboard should emit NutritionDashboardLoading '
      'then NutritionDashboardLoaded with data',
      setUp: () {
        final today = DateTime.now();
        final nutritionPlan = createMockNutritionPlan(date: today);
        final foodLogs = [
          createMockFoodLog(
            calories: 200.0,
            date: today,
          ),
          createMockFoodLog(
            id: 2,
            foodId: 2,
            calories: 300.0,
            quantityGrams: 150.0,
            date: today,
          ),
        ];

        when(() => mockRepository.getActiveNutritionPlan())
            .thenAnswer((_) async => right(nutritionPlan));
        when(() => mockRepository.getFoodIntakeLogs(any()))
            .thenAnswer((_) async => right(foodLogs));
      },
      build: () => cubit,
      act: (cubit) => cubit.loadDashboard(),
      expect: () => [
        isA<NutritionDashboardLoading>(),
        isA<NutritionDashboardLoaded>()
            .having(
              (s) => s.activePlan,
              'activePlan',
              isNotNull,
            )
            .having(
              (s) => s.meals.length,
              'meals.length',
              2, // breakfast and lunch for today
            )
            .having(
              (s) => s.intakeLogs.length,
              'intakeLogs.length',
              2,
            )
            .having(
              (s) => s.consumedCalories,
              'consumedCalories',
              650.0, // (200 * 1.0) + (300 * 1.5) = 200 + 450 = 650
            ),
      ],
      verify: (_) {
        verify(() => mockRepository.getActiveNutritionPlan()).called(1);
        verify(() => mockRepository.getFoodIntakeLogs(any())).called(1);
      },
    );

    blocTest<NutritionDashboardCubit, NutritionDashboardState>(
      'loadDashboard should emit NutritionDashboardEmpty when no plan exists',
      setUp: () {
        when(() => mockRepository.getActiveNutritionPlan()).thenAnswer(
          (_) async => left(
            ServerFailure(statusCode: 5001, message: 'No active plan'),
          ),
        );
      },
      build: () => cubit,
      act: (cubit) => cubit.loadDashboard(),
      expect: () => [
        isA<NutritionDashboardLoading>(),
        isA<NutritionDashboardEmpty>(),
      ],
      verify: (_) {
        verify(() => mockRepository.getActiveNutritionPlan()).called(1);
        verifyNever(() => mockRepository.getFoodIntakeLogs(any()));
      },
    );

    blocTest<NutritionDashboardCubit, NutritionDashboardState>(
      'loadDashboard should emit NutritionDashboardError when logs fail',
      setUp: () {
        final today = DateTime(2024, 6, 15);
        final nutritionPlan = createMockNutritionPlan(date: today);
        when(() => mockRepository.getActiveNutritionPlan())
            .thenAnswer((_) async => right(nutritionPlan));
        when(() => mockRepository.getFoodIntakeLogs(any())).thenAnswer(
          (_) async => left(
            ServerFailure(statusCode: 500, message: 'Failed to fetch logs'),
          ),
        );
      },
      build: () => cubit,
      act: (cubit) => cubit.loadDashboard(),
      expect: () => [
        isA<NutritionDashboardLoading>(),
        isA<NutritionDashboardError>().having(
          (e) => e.message,
          'message',
          'Failed to fetch logs',
        ),
      ],
      verify: (_) {
        verify(() => mockRepository.getActiveNutritionPlan()).called(1);
        verify(() => mockRepository.getFoodIntakeLogs(any())).called(1);
      },
    );

    blocTest<NutritionDashboardCubit, NutritionDashboardState>(
      'selectDate should update state with new date data',
      setUp: () {
        final today = DateTime.now();
        final newDate = today.add(const Duration(days: 1));
        final nutritionPlan = createMockNutritionPlan(date: today);
        final todayLogs = [
          createMockFoodLog(date: today),
        ];
        final newDateLogs = [
          createMockFoodLog(id: 2, date: newDate),
        ];

        // First load dashboard
        when(() => mockRepository.getActiveNutritionPlan())
            .thenAnswer((_) async => right(nutritionPlan));
        when(() => mockRepository.getFoodIntakeLogs(any()))
            .thenAnswer((invocation) async {
          final dateArg = invocation.positionalArguments[0] as DateTime;
          if (dateArg.year == today.year &&
              dateArg.month == today.month &&
              dateArg.day == today.day) {
            return right(todayLogs);
          } else {
            return right(newDateLogs);
          }
        });
      },
      build: () => cubit,
      act: (cubit) async {
        await cubit.loadDashboard();
        await cubit.selectDate(DateTime.now().add(const Duration(days: 1)));
      },
      expect: () => [
        isA<NutritionDashboardLoading>(),
        isA<NutritionDashboardLoaded>(),
        isA<NutritionDashboardLoaded>().having(
          (s) => s.intakeLogs.length,
          'intakeLogs.length',
          1,
        ),
      ],
    );

    blocTest<NutritionDashboardCubit, NutritionDashboardState>(
      'selectDate should emit error when logs fail',
      setUp: () {
        final today = DateTime.now();
        final nutritionPlan = createMockNutritionPlan(date: today);
        final todayLogs = [createMockFoodLog(date: today)];

        when(() => mockRepository.getActiveNutritionPlan())
            .thenAnswer((_) async => right(nutritionPlan));
        when(() => mockRepository.getFoodIntakeLogs(any()))
            .thenAnswer((invocation) async {
          final dateArg = invocation.positionalArguments[0] as DateTime;
          if (dateArg.year == today.year &&
              dateArg.month == today.month &&
              dateArg.day == today.day) {
            return right(todayLogs);
          } else {
            return left(ServerFailure(statusCode: 500, message: 'Failed'));
          }
        });
      },
      build: () => cubit,
      act: (cubit) async {
        await cubit.loadDashboard();
        await cubit.selectDate(DateTime.now().add(const Duration(days: 1)));
      },
      expect: () => [
        isA<NutritionDashboardLoading>(),
        isA<NutritionDashboardLoaded>(),
        isA<NutritionDashboardError>(),
      ],
    );

    blocTest<NutritionDashboardCubit, NutritionDashboardState>(
      'selectDate should not update state if current state is not loaded',
      setUp: () {
        // Don't set up any mocks - state will be initial
      },
      build: () => cubit,
      act: (cubit) => cubit.selectDate(DateTime(2024, 6, 16)),
      expect: () => <NutritionDashboardState>[],
      verify: (_) {
        verifyNever(() => mockRepository.getFoodIntakeLogs(any()));
      },
    );

    blocTest<NutritionDashboardCubit, NutritionDashboardState>(
      'toggleFoodLog should add food log when isEaten is true',
      setUp: () {
        final today = DateTime.now();
        final nutritionPlan = createMockNutritionPlan(date: today);
        final todayLogs = <FoodIntakeLog>[];
        final newLog = createMockFoodLog(date: today);

        when(() => mockRepository.getActiveNutritionPlan())
            .thenAnswer((_) async => right(nutritionPlan));
        when(() => mockRepository.getFoodIntakeLogs(any()))
            .thenAnswer((_) async => right(todayLogs));
        when(() => mockRepository.logFoodIntake(any()))
            .thenAnswer((_) async => right(newLog));
      },
      build: () => cubit,
      act: (cubit) async {
        await cubit.loadDashboard();
        await cubit.toggleFoodLog(
          food: createMockMealPlanFood(),
          isEaten: true,
        );
      },
      expect: () => [
        isA<NutritionDashboardLoading>(),
        isA<NutritionDashboardLoaded>(),
        isA<NutritionDashboardLoaded>().having(
          (s) => s.intakeLogs.length,
          'intakeLogs.length',
          1,
        ),
      ],
      verify: (_) {
        verify(() => mockRepository.logFoodIntake(any())).called(1);
        verify(() => mockRefreshService.refreshDashboard()).called(1);
      },
    );

    blocTest<NutritionDashboardCubit, NutritionDashboardState>(
      'toggleFoodLog should remove food log when isEaten is false',
      setUp: () {
        final today = DateTime.now();
        final nutritionPlan = createMockNutritionPlan(date: today);
        final existingLog = createMockFoodLog(
          mealPlanId: 1,
          date: today,
        );
        final todayLogs = [existingLog];

        when(() => mockRepository.getActiveNutritionPlan())
            .thenAnswer((_) async => right(nutritionPlan));
        when(() => mockRepository.getFoodIntakeLogs(any()))
            .thenAnswer((_) async => right(todayLogs));
        when(() => mockRepository.deleteFoodIntakeLog(any()))
            .thenAnswer((_) async => right(null));
      },
      build: () => cubit,
      act: (cubit) async {
        await cubit.loadDashboard();
        await cubit.toggleFoodLog(
          food: createMockMealPlanFood(),
          isEaten: false,
        );
      },
      expect: () => [
        isA<NutritionDashboardLoading>(),
        isA<NutritionDashboardLoaded>(),
        isA<NutritionDashboardLoaded>().having(
          (s) => s.intakeLogs.length,
          'intakeLogs.length',
          0,
        ),
      ],
      verify: (_) {
        verify(() => mockRepository.deleteFoodIntakeLog(1)).called(1);
        verify(() => mockRefreshService.refreshDashboard()).called(1);
      },
    );

    blocTest<NutritionDashboardCubit, NutritionDashboardState>(
      'updateMealPlanFood should successfully update and reload data',
      setUp: () {
        final today = DateTime.now();
        final nutritionPlan = createMockNutritionPlan(date: today);
        final todayLogs = <FoodIntakeLog>[];
        final updatedMealPlanFood = createMockMealPlanFood();

        when(() => mockRepository.getActiveNutritionPlan())
            .thenAnswer((_) async => right(nutritionPlan));
        when(() => mockRepository.getFoodIntakeLogs(any()))
            .thenAnswer((_) async => right(todayLogs));
        when(
          () => mockRepository.updateMealPlanFood(
            mealPlanFoodId: any(named: 'mealPlanFoodId'),
            servingQuantity: any(named: 'servingQuantity'),
            servingSizeId: any(named: 'servingSizeId'),
            quantityGrams: any(named: 'quantityGrams'),
          ),
        ).thenAnswer((_) async => right(updatedMealPlanFood));
      },
      build: () => cubit,
      act: (cubit) async {
        await cubit.loadDashboard();
        await cubit.updateMealPlanFood(
          food: createMockMealPlanFood(),
          servingQuantity: 1.5,
          servingSizeId: 2,
          quantityGrams: 150.0,
        );
      },
      expect: () => [
        isA<NutritionDashboardLoading>(),
        isA<NutritionDashboardLoaded>(),
        isA<NutritionDashboardLoaded>(), // Reloaded state
      ],
      verify: (_) {
        verify(
          () => mockRepository.updateMealPlanFood(
            mealPlanFoodId: any(named: 'mealPlanFoodId'),
            servingQuantity: 1.5,
            servingSizeId: 2,
            quantityGrams: 150.0,
          ),
        ).called(1);
        verify(() => mockRepository.getActiveNutritionPlan())
            .called(2); // Once for load, once for reload
      },
    );

    blocTest<NutritionDashboardCubit, NutritionDashboardState>(
      'updateMealPlanFood should return null when not in loaded state',
      setUp: () {
        // Don't set up any mocks - state will be initial
      },
      build: () => cubit,
      act: (cubit) async {
        final result = await cubit.updateMealPlanFood(
          food: createMockMealPlanFood(),
          servingQuantity: 1.5,
          servingSizeId: 2,
          quantityGrams: 150.0,
        );
        expect(result, isNull);
      },
      expect: () => <NutritionDashboardState>[],
      verify: (_) {
        verifyNever(
          () => mockRepository.updateMealPlanFood(
            mealPlanFoodId: any(named: 'mealPlanFoodId'),
            servingQuantity: any(named: 'servingQuantity'),
            servingSizeId: any(named: 'servingSizeId'),
            quantityGrams: any(named: 'quantityGrams'),
          ),
        );
      },
    );

    blocTest<NutritionDashboardCubit, NutritionDashboardState>(
      'deleteMealPlanFood should successfully delete and reload data',
      setUp: () {
        final today = DateTime.now();
        final nutritionPlan = createMockNutritionPlan(date: today);
        final todayLogs = <FoodIntakeLog>[];

        when(() => mockRepository.getActiveNutritionPlan())
            .thenAnswer((_) async => right(nutritionPlan));
        when(() => mockRepository.getFoodIntakeLogs(any()))
            .thenAnswer((_) async => right(todayLogs));
        when(
          () => mockRepository.deleteMealPlanFood(
            mealPlanFoodId: any(named: 'mealPlanFoodId'),
          ),
        ).thenAnswer((_) async => right(true));
      },
      build: () => cubit,
      act: (cubit) async {
        await cubit.loadDashboard();
        await cubit.deleteMealPlanFood(
          food: createMockMealPlanFood(),
        );
      },
      expect: () => [
        isA<NutritionDashboardLoading>(),
        isA<NutritionDashboardLoaded>(),
        isA<NutritionDashboardLoaded>(), // Reloaded state
      ],
      verify: (_) {
        verify(
          () => mockRepository.deleteMealPlanFood(
            mealPlanFoodId: any(named: 'mealPlanFoodId'),
          ),
        ).called(1);
        verify(() => mockRepository.getActiveNutritionPlan()).called(2);
      },
    );

    blocTest<NutritionDashboardCubit, NutritionDashboardState>(
      'deleteMealPlanFood should return false when not in loaded state',
      setUp: () {
        // Don't set up any mocks - state will be initial
      },
      build: () => cubit,
      act: (cubit) async {
        final result = await cubit.deleteMealPlanFood(
          food: createMockMealPlanFood(),
        );
        expect(result, isFalse);
      },
      expect: () => <NutritionDashboardState>[],
    );

    blocTest<NutritionDashboardCubit, NutritionDashboardState>(
      'addFoodToMeal should successfully add food and reload data',
      setUp: () {
        final today = DateTime.now();
        final nutritionPlan = createMockNutritionPlan(date: today);
        final todayLogs = <FoodIntakeLog>[];
        final newMealPlanFood = createMockMealPlanFood();

        when(() => mockRepository.getActiveNutritionPlan())
            .thenAnswer((_) async => right(nutritionPlan));
        when(() => mockRepository.getFoodIntakeLogs(any()))
            .thenAnswer((_) async => right(todayLogs));
        when(
          () => mockRepository.addMealPlanFood(
            mealPlanId: any(named: 'mealPlanId'),
            foodId: any(named: 'foodId'),
            servingSizeId: any(named: 'servingSizeId'),
            servingQuantity: any(named: 'servingQuantity'),
            quantityGrams: any(named: 'quantityGrams'),
          ),
        ).thenAnswer((_) async => right(newMealPlanFood));
      },
      build: () => cubit,
      act: (cubit) async {
        await cubit.loadDashboard();
        await cubit.addFoodToMeal(
          mealPlanId: 1,
          food: createMockFood(),
          servingQuantity: 1.0,
          servingSizeId: 1,
          quantityGrams: 100.0,
        );
      },
      expect: () => [
        isA<NutritionDashboardLoading>(),
        isA<NutritionDashboardLoaded>(),
        isA<NutritionDashboardLoaded>(), // Reloaded state
      ],
      verify: (_) {
        verify(
          () => mockRepository.addMealPlanFood(
            mealPlanId: 1,
            foodId: 1,
            servingSizeId: 1,
            servingQuantity: 1.0,
            quantityGrams: 100.0,
          ),
        ).called(1);
        verify(() => mockRepository.getActiveNutritionPlan()).called(2);
      },
    );

    blocTest<NutritionDashboardCubit, NutritionDashboardState>(
      'addFoodToMeal should return false when not in loaded state',
      setUp: () {
        // Don't set up any mocks - state will be initial
      },
      build: () => cubit,
      act: (cubit) async {
        final result = await cubit.addFoodToMeal(
          mealPlanId: 1,
          food: createMockFood(),
          servingQuantity: 1.0,
          servingSizeId: 1,
          quantityGrams: 100.0,
        );
        expect(result, isFalse);
      },
      expect: () => <NutritionDashboardState>[],
    );

    blocTest<NutritionDashboardCubit, NutritionDashboardState>(
      '_filterMealsForDate should filter meals correctly',
      setUp: () {
        final today = DateTime.now();
        final nutritionPlan = createMockNutritionPlan(date: today);
        final todayLogs = <FoodIntakeLog>[];

        when(() => mockRepository.getActiveNutritionPlan())
            .thenAnswer((_) async => right(nutritionPlan));
        when(() => mockRepository.getFoodIntakeLogs(any()))
            .thenAnswer((_) async => right(todayLogs));
      },
      build: () => cubit,
      act: (cubit) => cubit.loadDashboard(),
      expect: () => [
        isA<NutritionDashboardLoading>(),
        isA<NutritionDashboardLoaded>().having(
          (s) => s.meals.length,
          'meals.length',
          2, // Only breakfast and lunch for today, not dinner (yesterday)
        ),
      ],
    );

    blocTest<NutritionDashboardCubit, NutritionDashboardState>(
      '_calculateTargetMacros should calculate correctly',
      setUp: () {
        final today = DateTime.now();
        final nutritionPlan = createMockNutritionPlan(date: today);
        final todayLogs = <FoodIntakeLog>[];

        when(() => mockRepository.getActiveNutritionPlan())
            .thenAnswer((_) async => right(nutritionPlan));
        when(() => mockRepository.getFoodIntakeLogs(any()))
            .thenAnswer((_) async => right(todayLogs));
      },
      build: () => cubit,
      act: (cubit) => cubit.loadDashboard(),
      expect: () => [
        isA<NutritionDashboardLoading>(),
        isA<NutritionDashboardLoaded>()
            .having(
              (s) => s.targetCalories,
              'targetCalories',
              1200.0, // 500 + 700
            )
            .having(
              (s) => s.targetProtein,
              'targetProtein',
              80.0, // 30 + 50
            )
            .having(
              (s) => s.targetCarbs,
              'targetCarbs',
              120.0, // 50 + 70
            )
            .having(
              (s) => s.targetFat,
              'targetFat',
              40.0, // 15 + 25
            ),
      ],
    );

    blocTest<NutritionDashboardCubit, NutritionDashboardState>(
      '_calculateConsumedMacros should calculate correctly',
      setUp: () {
        final today = DateTime.now();
        final nutritionPlan = createMockNutritionPlan(date: today);
        final foodLogs = [
          createMockFoodLog(
            calories: 200.0,
            date: today,
          ), // 200 * (100/100) = 200
          createMockFoodLog(
            id: 2,
            foodId: 2,
            calories: 300.0,
            quantityGrams: 150.0,
            date: today,
          ), // 300 * (150/100) = 450
        ];

        when(() => mockRepository.getActiveNutritionPlan())
            .thenAnswer((_) async => right(nutritionPlan));
        when(() => mockRepository.getFoodIntakeLogs(any()))
            .thenAnswer((_) async => right(foodLogs));
      },
      build: () => cubit,
      act: (cubit) => cubit.loadDashboard(),
      expect: () => [
        isA<NutritionDashboardLoading>(),
        isA<NutritionDashboardLoaded>().having(
          (s) => s.consumedCalories,
          'consumedCalories',
          650.0, // 200 + 450
        ),
      ],
    );
  });
}
