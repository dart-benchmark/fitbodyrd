part of 'workout_generation_cubit.dart';

sealed class WorkoutGenerationState extends Equatable {
  const WorkoutGenerationState();

  @override
  List<Object?> get props => [];
}

class WorkoutGenerationInitial extends WorkoutGenerationState {
  const WorkoutGenerationInitial();
}

class WorkoutGenerationInProgress extends WorkoutGenerationState {
  const WorkoutGenerationInProgress({required this.currentTip});
  final String currentTip;

  @override
  List<Object?> get props => [currentTip];
}

class WorkoutGenerationSuccess extends WorkoutGenerationState {
  const WorkoutGenerationSuccess(this.plan);
  final WorkoutPlan plan;

  @override
  List<Object?> get props => [plan];
}

class WorkoutGenerationError extends WorkoutGenerationState {
  const WorkoutGenerationError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
