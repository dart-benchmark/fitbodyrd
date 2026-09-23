import 'package:fitbodyrd_client/fitbodyrd_client.dart';

abstract class NutritionDashboardState {}

class NutritionDashboardInitial extends NutritionDashboardState {}

class NutritionDashboardEmpty extends NutritionDashboardState {}

class NutritionDashboardLoading extends NutritionDashboardState {}

class NutritionDashboardLoaded extends NutritionDashboardState {
  NutritionDashboardLoaded({
    required this.meals,
    required this.intakeLogs,
    required this.selectedDate,
    required this.consumedCalories,
    required this.targetCalories,
    required this.consumedProtein,
    required this.targetProtein,
    required this.consumedCarbs,
    required this.targetCarbs,
    required this.consumedFat,
    required this.targetFat,
    this.activePlan,
  });
  final NutritionPlan? activePlan;
  final List<MealPlan> meals;
  final List<FoodIntakeLog> intakeLogs;
  final DateTime selectedDate;
  final double consumedCalories;
  final double targetCalories;
  final double consumedProtein;
  final double targetProtein;
  final double consumedCarbs;
  final double targetCarbs;
  final double consumedFat;
  final double targetFat;

  NutritionDashboardLoaded copyWith({
    NutritionPlan? activePlan,
    List<MealPlan>? meals,
    List<FoodIntakeLog>? intakeLogs,
    DateTime? selectedDate,
    double? consumedCalories,
    double? targetCalories,
    double? consumedProtein,
    double? targetProtein,
    double? consumedCarbs,
    double? targetCarbs,
    double? consumedFat,
    double? targetFat,
  }) {
    return NutritionDashboardLoaded(
      activePlan: activePlan ?? this.activePlan,
      meals: meals ?? this.meals,
      intakeLogs: intakeLogs ?? this.intakeLogs,
      selectedDate: selectedDate ?? this.selectedDate,
      consumedCalories: consumedCalories ?? this.consumedCalories,
      targetCalories: targetCalories ?? this.targetCalories,
      consumedProtein: consumedProtein ?? this.consumedProtein,
      targetProtein: targetProtein ?? this.targetProtein,
      consumedCarbs: consumedCarbs ?? this.consumedCarbs,
      targetCarbs: targetCarbs ?? this.targetCarbs,
      consumedFat: consumedFat ?? this.consumedFat,
      targetFat: targetFat ?? this.targetFat,
    );
  }
}

class NutritionDashboardError extends NutritionDashboardState {
  NutritionDashboardError(this.message);
  final String message;
}
