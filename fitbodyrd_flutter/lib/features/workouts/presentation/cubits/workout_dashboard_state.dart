part of 'workout_dashboard_cubit.dart';

sealed class WorkoutDashboardState extends Equatable {
  const WorkoutDashboardState();

  @override
  List<Object?> get props => [];
}

final class WorkoutDashboardInitial extends WorkoutDashboardState {
  const WorkoutDashboardInitial();
}

final class WorkoutDashboardLoading extends WorkoutDashboardState {
  const WorkoutDashboardLoading();
}

final class WorkoutDashboardLoaded extends WorkoutDashboardState {
  const WorkoutDashboardLoaded({
    required this.plan,
    required this.selectedDate,
    required this.logsByDateAndExercise,
    this.currentSession,
    this.sessionJustCompleted = false,
  });
  final WorkoutPlan plan;
  final DateTime selectedDate;
  final WorkoutSession? currentSession;
  final Map<DateTime, Map<int, ExerciseLog>> logsByDateAndExercise;
  final bool sessionJustCompleted;

  @override
  List<Object?> get props => [
        plan,
        selectedDate,
        currentSession,
        logsByDateAndExercise,
        sessionJustCompleted,
      ];

  WorkoutDashboardLoaded copyWith({
    WorkoutPlan? plan,
    DateTime? selectedDate,
    Object? currentSession = _undefined,
    Map<DateTime, Map<int, ExerciseLog>>? logsByDateAndExercise,
    bool? sessionJustCompleted,
  }) {
    return WorkoutDashboardLoaded(
      plan: plan ?? this.plan,
      selectedDate: selectedDate ?? this.selectedDate,
      currentSession: currentSession == _undefined
          ? this.currentSession
          : currentSession as WorkoutSession?,
      logsByDateAndExercise:
          logsByDateAndExercise ?? this.logsByDateAndExercise,
      sessionJustCompleted: sessionJustCompleted ?? this.sessionJustCompleted,
    );
  }
}

const _undefined = Object();

final class WorkoutDashboardEmpty extends WorkoutDashboardState {
  const WorkoutDashboardEmpty();
}

final class WorkoutDashboardError extends WorkoutDashboardState {
  const WorkoutDashboardError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
