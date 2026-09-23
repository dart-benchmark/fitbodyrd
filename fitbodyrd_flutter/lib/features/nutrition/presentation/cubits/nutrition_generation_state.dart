part of 'nutrition_generation_cubit.dart';

sealed class NutritionGenerationState extends Equatable {
  const NutritionGenerationState();

  @override
  List<Object> get props => [];
}

final class NutritionGenerationInitial extends NutritionGenerationState {
  const NutritionGenerationInitial();
}

final class NutritionGenerationInProgress extends NutritionGenerationState {
  const NutritionGenerationInProgress({
    required this.message,
    required this.progress,
    this.partialPlan,
  });

  final String message;
  final double progress;
  final NutritionPlan? partialPlan;

  @override
  List<Object> get props => [message, progress, ?partialPlan];
}

final class NutritionGenerationSuccess extends NutritionGenerationState {
  const NutritionGenerationSuccess(this.nutritionPlan);

  final NutritionPlan nutritionPlan;

  @override
  List<Object> get props => [nutritionPlan];
}

final class NutritionGenerationError extends NutritionGenerationState {
  const NutritionGenerationError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
