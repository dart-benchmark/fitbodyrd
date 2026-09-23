import 'package:equatable/equatable.dart';
import 'package:fitbodyrd_client/fitbodyrd_client.dart';

abstract class HomeDashboardState extends Equatable {
  const HomeDashboardState();

  @override
  List<Object?> get props => [];
}

class HomeDashboardInitial extends HomeDashboardState {
  const HomeDashboardInitial();
}

class HomeDashboardLoading extends HomeDashboardState {
  const HomeDashboardLoading();
}

class HomeDashboardLoaded extends HomeDashboardState {
  const HomeDashboardLoaded({
    required this.summary,
    this.nutritionPlan,
    this.workoutPlan,
    this.todayCalories = 0.0,
    this.targetCalories = 0.0,
    this.hasWorkoutToday = false,
    this.isWorkoutCompleted = false,
  });

  final WeeklySummaryDto summary;
  final NutritionPlan? nutritionPlan;
  final WorkoutPlan? workoutPlan;
  final double todayCalories;
  final double targetCalories;
  final bool hasWorkoutToday;
  final bool isWorkoutCompleted;

  @override
  List<Object?> get props => [
        summary,
        nutritionPlan,
        workoutPlan,
        todayCalories,
        targetCalories,
        hasWorkoutToday,
        isWorkoutCompleted,
      ];
}

class HomeDashboardError extends HomeDashboardState {
  const HomeDashboardError({
    required this.message,
  });

  final String message;

  @override
  List<Object?> get props => [message];
}
