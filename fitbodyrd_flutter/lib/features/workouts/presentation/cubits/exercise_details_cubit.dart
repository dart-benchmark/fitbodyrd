import 'package:equatable/equatable.dart';
import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/workouts/domain/repositories/workout_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record_result/record_result.dart';

part 'exercise_details_state.dart';

class ExerciseDetailsCubit extends Cubit<ExerciseDetailsState> {
  ExerciseDetailsCubit(this._repository)
      : super(const ExerciseDetailsInitial());

  final WorkoutRepository _repository;

  Future<void> loadExerciseLogs({
    required int exerciseId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    emit(const ExerciseDetailsLoading());

    // Default to last 3 months if no dates provided
    final now = DateTime.now();
    final defaultStartDate = startDate ?? DateTime(now.year, now.month - 3);
    final defaultEndDate = endDate ?? now;

    final result = await _repository.getExerciseLogs(
      startDate: defaultStartDate,
      endDate: defaultEndDate,
      exerciseIds: [exerciseId],
    );

    if (!result.isSuccess) {
      emit(
        ExerciseDetailsError(
          result.failure?.message ?? 'Error loading exercise logs',
        ),
      );
      return;
    }

    final logs = result.success!
      // Sort logs by date (oldest first)
      ..sort((a, b) => a.date.compareTo(b.date));

    emit(
      ExerciseDetailsLoaded(
        logs: logs,
        startDate: defaultStartDate,
        endDate: defaultEndDate,
      ),
    );
  }

  Future<void> updateDateRange({
    required int exerciseId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    await loadExerciseLogs(
      exerciseId: exerciseId,
      startDate: startDate,
      endDate: endDate,
    );
  }
}
