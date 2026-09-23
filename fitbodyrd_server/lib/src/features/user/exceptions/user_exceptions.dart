import 'package:fitbodyrd_server/src/generated/protocol.dart';

abstract class UserExceptions {
  static const String _module = 'user';

  static AppException userNotFound() {
    return AppException(
      module: _module,
      message: 'User not found.',
      errorCode: 6000,
      httpStatus: 404,
    );
  }

  static AppException userNotAuthenticated() {
    return AppException(
      module: _module,
      message: 'User is not authenticated.',
      errorCode: 6001,
      httpStatus: 401,
    );
  }

  static AppException userProfileAlreadyExists() {
    return AppException(
      module: _module,
      message: 'User profile already exists.',
      errorCode: 6002,
      httpStatus: 409,
    );
  }
}
