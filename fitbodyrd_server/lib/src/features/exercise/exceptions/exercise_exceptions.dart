import 'package:fitbodyrd_server/src/generated/protocol.dart';

abstract class ExerciseExceptions {
  static const String _module = 'exercise';

  static AppException equipmentMissing() {
    return AppException(
      module: _module,
      message: 'Required equipment is missing for the exercise.',
      errorCode: 2000,
      httpStatus: 400,
    );
  }

  static AppException imageNotFound() {
    return AppException(
      module: _module,
      message: 'Exercise image not found.',
      errorCode: 2001,
      httpStatus: 404,
    );
  }

  static AppException invalidImageOrder() {
    return AppException(
      module: _module,
      message: 'Invalid image order provided.',
      errorCode: 2002,
      httpStatus: 400,
    );
  }

  static AppException nameAlreadyExists() {
    return AppException(
      module: _module,
      message: 'An exercise with the same name already exists.',
      errorCode: 2003,
      httpStatus: 400,
    );
  }

  static AppException exerciseNotFound() {
    return AppException(
      module: _module,
      message: 'Exercise not found.',
      errorCode: 2004,
      httpStatus: 404,
    );
  }
}
