import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:record_result/record_result.dart';

abstract class WorkoutRepository {
  Stream<GenerateWorkoutPlanProgressDto> requestWorkoutPlanGeneration({
    required int numberOfWeeks,
  });

  Stream<String> listenToWorkoutTips();

  FutureResult<WorkoutPlan> getActiveWorkoutPlan();

  FutureResult<ExerciseLog> logWorkoutExercise(ExerciseLog log);

  FutureResult<List<ExerciseLog>> getExerciseLogs({
    required DateTime startDate,
    required DateTime endDate,
    required List<int> exerciseIds,
  });

  FutureResult<void> deleteExerciseLog(int logId);

  FutureResult<List<WorkoutSession>> getWorkoutHistory({
    DateTime? startDate,
    DateTime? endDate,
  });

  FutureResult<WorkoutProgressMetricsDto> getWorkoutProgressMetrics({
    DateTime? startDate,
    DateTime? endDate,
  });

  FutureResult<List<WorkoutSessionsByDateDto>> getWorkoutSessionsByDateRange({
    required DateTime startDate,
    required DateTime endDate,
  });
}
