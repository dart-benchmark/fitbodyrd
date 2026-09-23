import 'package:fitbodyrd_server/src/generated/protocol.dart';

abstract class WorkoutExceptions {
  static const String _module = 'workout';

  static AppException activeWorkoutPlanExists() {
    return AppException(
      module: _module,
      message: 'Active workout plan already exists.',
      errorCode: 7000,
      httpStatus: 400,
    );
  }

  static AppException noActiveWorkoutPlan() {
    return AppException(
      module: _module,
      message: 'No active workout plan found.',
      errorCode: 7001,
      httpStatus: 404,
    );
  }

  static AppException errorCreatingWorkoutPlan() {
    return AppException(
      module: _module,
      message: 'Error creating workout plan.',
      errorCode: 7002,
      httpStatus: 500,
    );
  }

  static AppException exerciseLogNotFound() {
    return AppException(
      module: _module,
      message: 'Exercise log not found or does not belong to the user.',
      errorCode: 7003,
      httpStatus: 404,
    );
  }
}
