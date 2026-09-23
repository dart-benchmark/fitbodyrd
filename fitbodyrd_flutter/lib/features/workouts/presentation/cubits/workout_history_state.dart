part of 'workout_history_cubit.dart';

sealed class WorkoutHistoryState extends Equatable {
  const WorkoutHistoryState();

  @override
  List<Object?> get props => [];
}

final class WorkoutHistoryInitial extends WorkoutHistoryState {
  const WorkoutHistoryInitial();
}

final class WorkoutHistoryLoading extends WorkoutHistoryState {
  const WorkoutHistoryLoading();
}

final class WorkoutHistoryLoaded extends WorkoutHistoryState {
  const WorkoutHistoryLoaded({
    required this.sessionsByDate,
    required this.progressMetrics,
    required this.selectedPeriod,
    required this.viewMode,
  });

  final List<WorkoutSessionsByDateDto> sessionsByDate;
  final WorkoutProgressMetricsDto progressMetrics;
  final TimePeriod selectedPeriod;
  final WorkoutHistoryViewMode viewMode;

  @override
  List<Object?> get props => [
        sessionsByDate,
        progressMetrics,
        selectedPeriod,
        viewMode,
      ];

  WorkoutHistoryLoaded copyWith({
    List<WorkoutSessionsByDateDto>? sessionsByDate,
    WorkoutProgressMetricsDto? progressMetrics,
    TimePeriod? selectedPeriod,
    WorkoutHistoryViewMode? viewMode,
  }) {
    return WorkoutHistoryLoaded(
      sessionsByDate: sessionsByDate ?? this.sessionsByDate,
      progressMetrics: progressMetrics ?? this.progressMetrics,
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
      viewMode: viewMode ?? this.viewMode,
    );
  }
}

final class WorkoutHistoryError extends WorkoutHistoryState {
  const WorkoutHistoryError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

enum WorkoutHistoryViewMode {
  list,
  calendar,
}
