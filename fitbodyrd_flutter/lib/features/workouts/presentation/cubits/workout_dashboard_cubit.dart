import 'package:equatable/equatable.dart';
import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/workouts/domain/repositories/workout_repository.dart';
import 'package:fitbodyrd_flutter/src/core/services/dashboard_refresh_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record_result/record_result.dart';

part 'workout_dashboard_state.dart';

class WorkoutDashboardCubit extends Cubit<WorkoutDashboardState> {
  WorkoutDashboardCubit(
    this._repository,
    this._refreshService,
  ) : super(const WorkoutDashboardInitial());

  final WorkoutRepository _repository;
  final DashboardRefreshService _refreshService;

  Future<void> loadDashboard() async {
    emit(const WorkoutDashboardLoading());

    final result = await _repository.getActiveWorkoutPlan();

    if (!result.isSuccess) {
      // Check if error is "no active plan" (7001)
      if (result.failure?.statusCode == 7001) {
        emit(const WorkoutDashboardEmpty());
      } else {
        emit(
          WorkoutDashboardError(
            result.failure?.message ?? 'Error loading workout plan',
          ),
        );
      }
      return;
    }

    final plan = result.success!;
    final today = DateTime.now();
    final session = _findSessionForDate(plan, today);

    // Collect all distinct exercise IDs from the plan
    final exerciseIds = <int>{
      if (plan.sessions != null)
        for (final s in plan.sessions!)
          if (s.exercises != null)
            for (final e in s.exercises!) e.exerciseId,
    }.toList();

    // If there are no exercises, we can skip loading logs
    if (exerciseIds.isEmpty) {
      emit(
        WorkoutDashboardLoaded(
          plan: plan,
          selectedDate: today,
          currentSession: session,
          logsByDateAndExercise: const {},
        ),
      );
      return;
    }

    final logsResult = await _repository.getExerciseLogs(
      startDate: plan.startDate,
      endDate: plan.endDate,
      exerciseIds: exerciseIds,
    );

    if (!logsResult.isSuccess) {
      emit(
        WorkoutDashboardError(
          logsResult.failure?.message ?? 'Error loading exercise logs',
        ),
      );
      return;
    }

    final logs = logsResult.success!;

    final logsByDateAndExercise = <DateTime, Map<int, ExerciseLog>>{};

    for (final log in logs) {
      final dateKey = DateTime(log.date.year, log.date.month, log.date.day);
      final exerciseMap =
          logsByDateAndExercise[dateKey] ?? <int, ExerciseLog>{};
      exerciseMap[log.exerciseId] = log;
      logsByDateAndExercise[dateKey] = exerciseMap;
    }

    emit(
      WorkoutDashboardLoaded(
        plan: plan,
        selectedDate: today,
        currentSession: session,
        logsByDateAndExercise: logsByDateAndExercise,
      ),
    );
  }

  Future<void> selectDate(DateTime date) async {
    final currentState = state;
    if (currentState is! WorkoutDashboardLoaded) return;

    final session = _findSessionForDate(currentState.plan, date);

    emit(
      currentState.copyWith(
        selectedDate: date,
        currentSession: session,
        sessionJustCompleted: false,
      ),
    );
  }

  void clearSessionCompletedFlag() {
    final currentState = state;
    if (currentState is! WorkoutDashboardLoaded) return;

    emit(
      currentState.copyWith(
        sessionJustCompleted: false,
      ),
    );
  }

  Future<void> applyOrUpdateLog(ExerciseLog log) async {
    final currentState = state;
    if (currentState is! WorkoutDashboardLoaded) return;

    final dateKey = DateTime(log.date.year, log.date.month, log.date.day);

    // Check if session was already completed before this update
    final wasCompletedBefore = currentState.currentSession != null &&
        _isSessionFullyCompleted(
          currentState.currentSession!,
          currentState.selectedDate,
          currentState.logsByDateAndExercise,
        );

    final updatedLogsByDate = Map<DateTime, Map<int, ExerciseLog>>.from(
      currentState.logsByDateAndExercise,
    );

    final logsForDate = Map<int, ExerciseLog>.from(
      updatedLogsByDate[dateKey] ?? {},
    )..[log.exerciseId] = log;

    updatedLogsByDate[dateKey] = logsForDate;

    // Check if session is now fully completed
    final isCompletedNow = currentState.currentSession != null &&
        _isSessionFullyCompleted(
          currentState.currentSession!,
          currentState.selectedDate,
          updatedLogsByDate,
        );

    // Only mark as just completed if it wasn't completed before but is now
    final sessionJustCompleted = !wasCompletedBefore && isCompletedNow;

    emit(
      currentState.copyWith(
        logsByDateAndExercise: updatedLogsByDate,
        sessionJustCompleted: sessionJustCompleted,
      ),
    );
    _refreshService.refreshDashboard();
  }

  Future<void> deleteLogForExercise(ExerciseLog log) async {
    final currentState = state;
    if (currentState is! WorkoutDashboardLoaded) return;

    final dateKey = DateTime(log.date.year, log.date.month, log.date.day);

    final updatedLogsByDate = Map<DateTime, Map<int, ExerciseLog>>.from(
      currentState.logsByDateAndExercise,
    );

    final logsForDate = Map<int, ExerciseLog>.from(
      updatedLogsByDate[dateKey] ?? {},
    )..remove(log.exerciseId);

    if (logsForDate.isEmpty) {
      updatedLogsByDate.remove(dateKey);
    } else {
      updatedLogsByDate[dateKey] = logsForDate;
    }

    emit(
      currentState.copyWith(
        logsByDateAndExercise: updatedLogsByDate,
      ),
    );

    // Fire-and-forget delete; UI is already updated optimistically.
    // In case of failure, the server will surface an AppException that
    // can be handled globally (e.g., via a snackbar interceptor).
    await _repository.deleteExerciseLog(log.id!);
    _refreshService.refreshDashboard();
  }

  bool _isSessionFullyCompleted(
    WorkoutSession session,
    DateTime selectedDate,
    Map<DateTime, Map<int, ExerciseLog>> logsByDateAndExercise,
  ) {
    // For real-time UI updates, check local logs state
    // (database field updates asynchronously)
    if (session.exercises == null || session.exercises!.isEmpty) {
      return false;
    }

    final dateKey = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
    );

    final logsForDate = logsByDateAndExercise[dateKey] ?? {};

    // Check if all exercises in the session have a log for this date
    for (final exercise in session.exercises!) {
      if (!logsForDate.containsKey(exercise.exerciseId)) {
        return false;
      }
    }

    return true;
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
