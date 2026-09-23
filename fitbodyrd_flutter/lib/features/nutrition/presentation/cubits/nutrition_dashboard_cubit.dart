import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/nutrition/domain/repositories/nutrition_repository.dart';
import 'package:fitbodyrd_flutter/features/nutrition/presentation/cubits/nutrition_dashboard_state.dart';
import 'package:fitbodyrd_flutter/src/core/services/dashboard_refresh_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record_result/record_result.dart';

class NutritionDashboardCubit extends Cubit<NutritionDashboardState> {
  NutritionDashboardCubit(
    this.repository,
    this.refreshService,
  ) : super(NutritionDashboardInitial());
  final NutritionRepository repository;
  final DashboardRefreshService refreshService;

  Future<void> loadDashboard() async {
    emit(NutritionDashboardLoading());
    final planResult = await repository.getActiveNutritionPlan();

    final today = DateTime.now();

    if (planResult.isFailure) {
      // Assuming error means no plan or failure.
      // We can check error code if needed.
      emit(NutritionDashboardEmpty());
      return;
    }

    final plan = planResult.success!;

    final logsResult = await repository.getFoodIntakeLogs(today);
    if (logsResult.isFailure) {
      emit(
        NutritionDashboardError(
          logsResult.failure?.message ?? 'Unknown error',
        ),
      );
      return;
    }

    final meals = _filterMealsForDate(plan, today);
    final logs = logsResult.success ?? [];
    final target = _calculateTargetMacros(meals);
    final consumed = _calculateConsumedMacros(logs);

    emit(
      NutritionDashboardLoaded(
        activePlan: plan,
        meals: meals,
        intakeLogs: logs,
        selectedDate: today,
        consumedCalories: consumed.calories,
        targetCalories: target.calories,
        consumedProtein: consumed.protein,
        targetProtein: target.protein,
        consumedCarbs: consumed.carbs,
        targetCarbs: target.carbs,
        consumedFat: consumed.fat,
        targetFat: target.fat,
      ),
    );
  }

  Future<void> selectDate(DateTime date) async {
    final currentState = state;
    if (currentState is! NutritionDashboardLoaded) return;

    // Don't emit loading state to avoid flickering
    // Keep showing current data while fetching new data
    final logsResult = await repository.getFoodIntakeLogs(date);
    if (logsResult.isFailure) {
      emit(
        NutritionDashboardError(
          logsResult.failure?.message ?? 'Unknown error',
        ),
      );
      return;
    }

    final meals = _filterMealsForDate(currentState.activePlan!, date);
    final logs = logsResult.success ?? [];
    final target = _calculateTargetMacros(meals);
    final consumed = _calculateConsumedMacros(logs);

    emit(
      NutritionDashboardLoaded(
        activePlan: currentState.activePlan,
        meals: meals,
        intakeLogs: logs,
        selectedDate: date,
        consumedCalories: consumed.calories,
        targetCalories: target.calories,
        consumedProtein: consumed.protein,
        targetProtein: target.protein,
        consumedCarbs: consumed.carbs,
        targetCarbs: target.carbs,
        consumedFat: consumed.fat,
        targetFat: target.fat,
      ),
    );
  }

  List<MealPlan> _filterMealsForDate(NutritionPlan plan, DateTime date) {
    return plan.mealPlans
            ?.where(
              (m) =>
                  m.date.year == date.year &&
                  m.date.month == date.month &&
                  m.date.day == date.day,
            )
            .toList() ??
        [];
  }

  // Calculate total target macros from meals
  // (static targets from original plan)
  ({double calories, double protein, double carbs, double fat})
      _calculateTargetMacros(List<MealPlan> meals) {
    double totalCalories = 0;
    double totalProtein = 0;
    double totalCarbs = 0;
    double totalFat = 0;

    for (final meal in meals) {
      totalCalories += meal.targetCalories;
      totalProtein += meal.targetProteins;
      totalCarbs += meal.targetCarbs;
      totalFat += meal.targetFats;
    }

    return (
      calories: totalCalories,
      protein: totalProtein,
      carbs: totalCarbs,
      fat: totalFat,
    );
  }

  // Calculate consumed macros from intake logs
  ({double calories, double protein, double carbs, double fat})
      _calculateConsumedMacros(List<FoodIntakeLog> logs) {
    double totalCalories = 0;
    double totalProtein = 0;
    double totalCarbs = 0;
    double totalFat = 0;

    for (final log in logs) {
      final food = log.food;
      if (food != null) {
        // Calculate based on quantity consumed
        final multiplier =
            log.quantityGrams / 100; // Assuming nutritional values are per 100g

        totalCalories += food.calories * multiplier;
        totalProtein += food.proteins * multiplier;
        totalCarbs += food.carbs * multiplier;
        totalFat += food.fats * multiplier;
      }
    }

    return (
      calories: totalCalories,
      protein: totalProtein,
      carbs: totalCarbs,
      fat: totalFat,
    );
  }

  Future<void> toggleFoodLog({
    required MealPlanFood food,
    required bool isEaten,
  }) async {
    final currentState = state;
    if (currentState is! NutritionDashboardLoaded) return;

    if (isEaten) {
      // Find meal type from meals
      // food.mealPlanId should match one of the meals
      final mealPlan = currentState.meals.firstWhere(
        (m) => m.id == food.mealPlanId,
        orElse: () => currentState.meals.first, // Fallback?
      );

      final dto = CreateFoodIntakeLog(
        mealPlanId: food.mealPlanId,
        foodId: food.foodId,
        date: currentState.selectedDate,
        mealType: mealPlan.mealType,
        servingSizeId: food.servingSizeId,
        servingQuantity: food.servingQuantity,
        quantityGrams: food.quantityGrams,
      );

      final result = await repository.logFoodIntake(dto);
      if (result.isSuccess) {
        final newLog = result.success!;
        final updatedLogs = [...currentState.intakeLogs, newLog];
        final consumed = _calculateConsumedMacros(updatedLogs);

        emit(
          currentState.copyWith(
            intakeLogs: updatedLogs,
            consumedCalories: consumed.calories,
            consumedProtein: consumed.protein,
            consumedCarbs: consumed.carbs,
            consumedFat: consumed.fat,
          ),
        );
        refreshService.refreshDashboard();
      }
    } else {
      final log = currentState.intakeLogs.firstWhere(
        (l) => l.mealPlanId == food.mealPlanId && l.foodId == food.foodId,
      );

      if (log.id != null) {
        final result = await repository.deleteFoodIntakeLog(log.id!);
        if (result.isSuccess) {
          final updatedLogs =
              currentState.intakeLogs.where((l) => l.id != log.id).toList();
          final consumed = _calculateConsumedMacros(updatedLogs);

          emit(
            currentState.copyWith(
              intakeLogs: updatedLogs,
              consumedCalories: consumed.calories,
              consumedProtein: consumed.protein,
              consumedCarbs: consumed.carbs,
              consumedFat: consumed.fat,
            ),
          );
          refreshService.refreshDashboard();
        }
      }
    }
  }

  Future<Map<String, double>?> updateMealPlanFood({
    required MealPlanFood food,
    required double servingQuantity,
    required int servingSizeId,
    required double quantityGrams,
  }) async {
    final currentState = state;
    if (currentState is! NutritionDashboardLoaded) return null;

    final result = await repository.updateMealPlanFood(
      mealPlanFoodId: food.id!,
      servingQuantity: servingQuantity,
      servingSizeId: servingSizeId,
      quantityGrams: quantityGrams,
    );

    if (result.isSuccess) {
      // Reload the entire nutrition plan to get fresh data
      final planResult = await repository.getActiveNutritionPlan();
      if (planResult.isSuccess) {
        final plan = planResult.success!;
        final meals = _filterMealsForDate(plan, currentState.selectedDate);

        // Also reload intake logs
        final logsResult =
            await repository.getFoodIntakeLogs(currentState.selectedDate);
        final logs = logsResult.success ?? [];

        final target = _calculateTargetMacros(meals);
        final consumed = _calculateConsumedMacros(logs);

        emit(
          NutritionDashboardLoaded(
            activePlan: plan,
            meals: meals,
            intakeLogs: logs,
            selectedDate: currentState.selectedDate,
            consumedCalories: consumed.calories,
            targetCalories: target.calories,
            consumedProtein: consumed.protein,
            targetProtein: target.protein,
            consumedCarbs: consumed.carbs,
            targetCarbs: target.carbs,
            consumedFat: consumed.fat,
            targetFat: target.fat,
          ),
        );
      }

      return {
        'servingQuantity': servingQuantity,
        'servingSizeId': servingSizeId.toDouble(),
        'quantityGrams': quantityGrams,
      };
    }

    return null;
  }

  Future<bool> deleteMealPlanFood({
    required MealPlanFood food,
  }) async {
    final currentState = state;
    if (currentState is! NutritionDashboardLoaded) return false;

    final result = await repository.deleteMealPlanFood(
      mealPlanFoodId: food.id!,
    );

    if (result.isSuccess) {
      // Reload the entire nutrition plan to get fresh data
      final planResult = await repository.getActiveNutritionPlan();
      if (planResult.isSuccess) {
        final plan = planResult.success!;
        final meals = _filterMealsForDate(plan, currentState.selectedDate);

        // Also reload intake logs
        final logsResult =
            await repository.getFoodIntakeLogs(currentState.selectedDate);
        final logs = logsResult.success ?? [];

        final target = _calculateTargetMacros(meals);
        final consumed = _calculateConsumedMacros(logs);

        emit(
          NutritionDashboardLoaded(
            activePlan: plan,
            meals: meals,
            intakeLogs: logs,
            selectedDate: currentState.selectedDate,
            consumedCalories: consumed.calories,
            targetCalories: target.calories,
            consumedProtein: consumed.protein,
            targetProtein: target.protein,
            consumedCarbs: consumed.carbs,
            targetCarbs: target.carbs,
            consumedFat: consumed.fat,
            targetFat: target.fat,
          ),
        );
      }

      return true;
    }

    return false;
  }

  Future<bool> addFoodToMeal({
    required int mealPlanId,
    required Food food,
    required double servingQuantity,
    required int servingSizeId,
    required double quantityGrams,
  }) async {
    final currentState = state;
    if (currentState is! NutritionDashboardLoaded) return false;

    final result = await repository.addMealPlanFood(
      mealPlanId: mealPlanId,
      foodId: food.id!,
      servingSizeId: servingSizeId,
      servingQuantity: servingQuantity,
      quantityGrams: quantityGrams,
    );

    if (result.isSuccess) {
      // Reload the entire nutrition plan to get fresh data
      final planResult = await repository.getActiveNutritionPlan();
      if (planResult.isSuccess) {
        final plan = planResult.success!;
        final meals = _filterMealsForDate(plan, currentState.selectedDate);

        // Also reload intake logs
        final logsResult =
            await repository.getFoodIntakeLogs(currentState.selectedDate);
        final logs = logsResult.success ?? [];

        final target = _calculateTargetMacros(meals);
        final consumed = _calculateConsumedMacros(logs);

        emit(
          NutritionDashboardLoaded(
            activePlan: plan,
            meals: meals,
            intakeLogs: logs,
            selectedDate: currentState.selectedDate,
            consumedCalories: consumed.calories,
            targetCalories: target.calories,
            consumedProtein: consumed.protein,
            targetProtein: target.protein,
            consumedCarbs: consumed.carbs,
            targetCarbs: target.carbs,
            consumedFat: consumed.fat,
            targetFat: target.fat,
          ),
        );
      }

      return true;
    }

    return false;
  }
}
