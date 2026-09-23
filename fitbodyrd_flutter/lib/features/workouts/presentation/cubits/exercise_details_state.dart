part of 'exercise_details_cubit.dart';

sealed class ExerciseDetailsState extends Equatable {
  const ExerciseDetailsState();

  @override
  List<Object?> get props => [];
}

final class ExerciseDetailsInitial extends ExerciseDetailsState {
  const ExerciseDetailsInitial();
}

final class ExerciseDetailsLoading extends ExerciseDetailsState {
  const ExerciseDetailsLoading();
}

final class ExerciseDetailsLoaded extends ExerciseDetailsState {
  const ExerciseDetailsLoaded({
    required this.logs,
    required this.startDate,
    required this.endDate,
  });

  final List<ExerciseLog> logs;
  final DateTime startDate;
  final DateTime endDate;

  @override
  List<Object?> get props => [logs, startDate, endDate];

  ExerciseDetailsLoaded copyWith({
    List<ExerciseLog>? logs,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return ExerciseDetailsLoaded(
      logs: logs ?? this.logs,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}

final class ExerciseDetailsError extends ExerciseDetailsState {
  const ExerciseDetailsError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
