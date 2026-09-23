import 'package:fitbodyrd_server/src/generated/protocol.dart';

abstract class GenericExceptions {
  static const String _module = 'generic';

  static AppException internalServerError() {
    return AppException(
      module: _module,
      message: 'Internal server error.',
      errorCode: 1000,
      httpStatus: 500,
    );
  }

  static AppException userNotAuthenticated() {
    return AppException(
      module: _module,
      message: 'User not authenticated.',
      errorCode: 1001,
      httpStatus: 401,
    );
  }
}
