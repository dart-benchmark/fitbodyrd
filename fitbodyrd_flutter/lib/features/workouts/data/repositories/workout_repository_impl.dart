import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/workouts/domain/repositories/workout_repository.dart';
import 'package:record_result/record_result.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

class WorkoutRepositoryImpl implements WorkoutRepository {
  WorkoutRepositoryImpl({
    required this.client,
    required this.sessionManager,
  });
  final Client client;
  final SessionManager sessionManager;

  int get _userId {
    final user = sessionManager.signedInUser;
    if (user == null || user.id == null) {
      throw Exception('User not signed in');
    }
    return user.id!;
  }

  @override
  Stream<GenerateWorkoutPlanProgressDto> requestWorkoutPlanGeneration({
    required int numberOfWeeks,
  }) {
    return client.workout.requestWorkoutPlanGeneration(_userId, numberOfWeeks);
  }

  @override
  Stream<String> listenToWorkoutTips() {
    return client.workout.listenToWorkoutTips();
  }

  @override
  FutureResult<WorkoutPlan> getActiveWorkoutPlan() async {
    try {
      final plan = await client.workout.getActiveWorkoutPlan(_userId);
      return right(plan);
    } on AppException catch (e) {
      return left(ServerFailure(statusCode: e.errorCode, message: e.message));
    }
  }

  @override
  FutureResult<ExerciseLog> logWorkoutExercise(ExerciseLog log) async {
    try {
      final result = await client.workout.logWorkoutExercise(log);
      return right(result);
    } on AppException catch (e) {
      return left(ServerFailure(statusCode: e.errorCode, message: e.message));
    }
  }

  @override
  FutureResult<List<ExerciseLog>> getExerciseLogs({
    required DateTime startDate,
    required DateTime endDate,
    required List<int> exerciseIds,
  }) async {
    try {
      final logs = await client.workout.getExerciseLogs(
        startDate,
        endDate,
        exerciseIds,
      );
      return right(logs);
    } on AppException catch (e) {
      return left(ServerFailure(statusCode: e.errorCode, message: e.message));
    }
  }

  @override
  FutureResult<void> deleteExerciseLog(int logId) async {
    try {
      await client.workout.deleteExerciseLog(logId);
      return right(null);
    } on AppException catch (e) {
      return left(ServerFailure(statusCode: e.errorCode, message: e.message));
    }
  }

  @override
  FutureResult<List<WorkoutSession>> getWorkoutHistory({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final sessions = await client.workout.getWorkoutHistory(
        startDate,
        endDate,
      );
      return right(sessions);
    } on AppException catch (e) {
      return left(ServerFailure(statusCode: e.errorCode, message: e.message));
    }
  }

  @override
  FutureResult<WorkoutProgressMetricsDto> getWorkoutProgressMetrics({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final metrics = await client.workout.getWorkoutProgressMetrics(
        startDate,
        endDate,
      );
      return right(metrics);
    } on AppException catch (e) {
      return left(ServerFailure(statusCode: e.errorCode, message: e.message));
    }
  }

  @override
  FutureResult<List<WorkoutSessionsByDateDto>> getWorkoutSessionsByDateRange({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final sessions = await client.workout.getWorkoutSessionsByDateRange(
        startDate,
        endDate,
      );
      return right(sessions);
    } on AppException catch (e) {
      return left(ServerFailure(statusCode: e.errorCode, message: e.message));
    }
  }
}
