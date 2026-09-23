import 'package:equatable/equatable.dart';
import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/workouts/domain/repositories/workout_repository.dart';
import 'package:fitbodyrd_flutter/features/workouts/presentation/widgets/exercise_stats_time_selector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record_result/record_result.dart';

part 'workout_history_state.dart';

class WorkoutHistoryCubit extends Cubit<WorkoutHistoryState> {
  WorkoutHistoryCubit(this._repository) : super(const WorkoutHistoryInitial());

  final WorkoutRepository _repository;

  Future<void> loadWorkoutHistory({
    TimePeriod period = TimePeriod.last3Months,
    WorkoutHistoryViewMode viewMode = WorkoutHistoryViewMode.list,
  }) async {
    emit(const WorkoutHistoryLoading());

    final startDate = ExerciseStatsTimeSelector.getStartDate(period);
    final endDate = DateTime.now();

    final historyResult = await _repository.getWorkoutSessionsByDateRange(
      startDate: startDate,
      endDate: endDate,
    );

    final metricsResult = await _repository.getWorkoutProgressMetrics(
      startDate: startDate,
      endDate: endDate,
    );

    if (!historyResult.isSuccess || !metricsResult.isSuccess) {
      emit(
        WorkoutHistoryError(
          historyResult.failure?.message ??
              metricsResult.failure?.message ??
              'Error loading workout history',
        ),
      );
      return;
    }

    emit(
      WorkoutHistoryLoaded(
        sessionsByDate: historyResult.success!,
        progressMetrics: metricsResult.success!,
        selectedPeriod: period,
        viewMode: viewMode,
      ),
    );
  }

  Future<void> updatePeriod(TimePeriod period) async {
    final currentState = state;
    if (currentState is! WorkoutHistoryLoaded) return;

    await loadWorkoutHistory(
      period: period,
      viewMode: currentState.viewMode,
    );
  }

  void toggleViewMode() {
    final currentState = state;
    if (currentState is! WorkoutHistoryLoaded) return;

    final newMode = currentState.viewMode == WorkoutHistoryViewMode.list
        ? WorkoutHistoryViewMode.calendar
        : WorkoutHistoryViewMode.list;

    emit(
      currentState.copyWith(viewMode: newMode),
    );
  }
}
