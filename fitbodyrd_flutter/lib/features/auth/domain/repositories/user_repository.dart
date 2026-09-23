import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:record_result/record_result.dart';

/// This is the interface for the user repository
abstract interface class UserRepository {
  /// This method will get the user from the cache
  /// if the user is not in the cache, it will fetch the user
  FutureResult<UserProfile> getCachedUser();

  /// This method will refresh the user
  /// This will fetch the user from the server
  FutureResultVoid refreshUser();

  /// This method will update the user image
  // FutureResultVoid updateUserImage(XFile image);

  /// This method will update the username
  // FutureResultVoid updateUsername(String username);

  // FutureResultVoid updateUserToken({required String deviceToken});

  // FutureResultVoid deleteUserToken();

  /// This method will create a user profile
  FutureResult<UserProfile> createUserProfile(UserProfile userProfile);

  /// This method will clear the user from the cache
  void clearUser();
}
