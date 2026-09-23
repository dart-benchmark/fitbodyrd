import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/auth/domain/repositories/user_repository.dart';
import 'package:record_result/record_result.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({
    required Client client,
    // required DeviceIdService deviceIdService,
  }) : _client = client;
  //_deviceIdService = deviceIdService;

  final Client _client;

  // final DeviceIdService _deviceIdService;

  UserProfile? _user;

  @override
  FutureResult<UserProfile> getCachedUser() async {
    try {
      if (_user != null) {
        return right(_user!);
      }

      final user = await _client.user.getCurrentUserProfile();
      _user = user;
      return right(user);
    } on AppException catch (e) {
      final failure = ServerFailure(
        statusCode: e.errorCode,
        message: e.message,
      );

      return left(failure);
    }
  }

  @override
  FutureResultVoid refreshUser() async {
    try {
      final user = await _client.user.getCurrentUserProfile();
      _user = user;
      return voidSuccess;
    } on AppException catch (e) {
      final failure = ServerFailure(
        statusCode: e.errorCode,
        message: e.message,
      );

      return left(failure);
    }
  }

  @override
  FutureResult<UserProfile> createUserProfile(UserProfile userProfile) async {
    try {
      final user = await _client.user.createUserProfile(userProfile);
      _user = user;
      return right(user);
    } on AppException catch (e) {
      final failure = ServerFailure(
        statusCode: e.errorCode,
        message: e.message,
      );

      return left(failure);
    }
  }

  @override
  void clearUser() {
    _user = null;
  }
}
