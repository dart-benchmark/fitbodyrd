import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/home/domain/repositories/dashboard_repository.dart';
import 'package:fitbodyrd_flutter/features/home/presentation/cubits/home_dashboard_state.dart';
import 'package:fitbodyrd_flutter/features/nutrition/domain/repositories/nutrition_repository.dart';
import 'package:fitbodyrd_flutter/features/workouts/domain/repositories/workout_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record_result/record_result.dart';

class HomeDashboardCubit extends Cubit<HomeDashboardState> {
  HomeDashboardCubit(
    this.repository,
    this.nutritionRepository,
    this.workoutRepository,
  ) : super(const HomeDashboardInitial());

  final DashboardRepository repository;
  final NutritionRepository nutritionRepository;
  final WorkoutRepository workoutRepository;

  Future<void> loadDashboard({
    bool showLoading = true,
  }) async {
    if (showLoading) {
      emit(const HomeDashboardLoading());
    }

    final weeklyResult = await repository.getWeeklySummary();

    if (weeklyResult.isFailure) {
      emit(
        HomeDashboardError(
          message: weeklyResult.failure?.message ?? 'Error loading dashboard',
        ),
      );
      return;
    }

    final today = DateTime.now();
    NutritionPlan? nutritionPlan;
    WorkoutPlan? workoutPlan;
    var todayCalories = 0.0;
    var targetCalories = 0.0;
    var hasWorkoutToday = false;
    var isWorkoutCompleted = false;

    // Load nutrition data
    final nutritionPlanResult =
        await nutritionRepository.getActiveNutritionPlan();
    if (nutritionPlanResult.isSuccess) {
      final plan = nutritionPlanResult.success;
      if (plan != null) {
        nutritionPlan = plan;
        final meals = _filterMealsForDate(plan, today);
        targetCalories = _calculateTargetCalories(meals);

        final logsResult = await nutritionRepository.getFoodIntakeLogs(today);
        if (logsResult.isSuccess) {
          todayCalories = _calculateConsumedCalories(logsResult.success ?? []);
        }
      }
    }

    // Load workout data
    final workoutPlanResult = await workoutRepository.getActiveWorkoutPlan();
    if (workoutPlanResult.isSuccess) {
      final plan = workoutPlanResult.success;
      if (plan != null) {
        workoutPlan = plan;
        final session = _findSessionForDate(plan, today);
        hasWorkoutToday = session != null;

        if (session != null) {
          // Use sessionComplete field from database
          isWorkoutCompleted = session.sessionComplete;
        }
      }
    }

    emit(
      HomeDashboardLoaded(
        summary: weeklyResult.success!,
        nutritionPlan: nutritionPlan,
        workoutPlan: workoutPlan,
        todayCalories: todayCalories,
        targetCalories: targetCalories,
        hasWorkoutToday: hasWorkoutToday,
        isWorkoutCompleted: isWorkoutCompleted,
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

  double _calculateTargetCalories(List<MealPlan> meals) {
    return meals.fold(0.0, (sum, meal) => sum + meal.targetCalories);
  }

  double _calculateConsumedCalories(List<FoodIntakeLog> logs) {
    return logs.fold(
      0.0,
      (sum, log) =>
          sum + (log.food?.calories ?? 0.0) * (log.quantityGrams / 100),
    );
  }

  WorkoutSession? _findSessionForDate(WorkoutPlan plan, DateTime date) {
    if (plan.sessions == null) return null;

    try {
      return plan.sessions!.firstWhere(
        (session) =>
            session.date.year == date.year &&
            session.date.month == date.month &&
            session.date.day == date.day,
      );
      // The error here sends a StateError
      // which is not caught by the catch clause
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return null;
    }
  }
}
