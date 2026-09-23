import 'package:fitbodyrd_server/src/features/user/exceptions/user_exceptions.dart';
import 'package:fitbodyrd_server/src/features/user/utils/user_utils.dart';
import 'package:fitbodyrd_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class AdminUserEndpoint extends Endpoint {
  Future<UserProfile> findUserProfile(Session session, int userId) async {
    var user = await UserProfile.db
        .findFirstRow(session, where: (t) => t.userInfoId.equals(userId));
    if (user == null) {
      throw UserExceptions.userNotFound();
    }
    return user.completeProfile();
  }

  Future<UserFoodPreferencesResponseDto> getUserFoodPreferences(
    Session session,
    int userId,
  ) async {
    final preferences = await UserFoodPreference.db.find(
      session,
      where: (t) => t.userProfileId.equals(userId),
      include: UserFoodPreference.include(
        food: Food.include(),
      ),
    );

    final excludedFoodIds = preferences
        .where((pref) => pref.preferenceType == UserFoodPreferenceType.exclude)
        .map((pref) => pref.foodId)
        .toList();

    final favoriteFoodIds = preferences
        .where((pref) => pref.preferenceType == UserFoodPreferenceType.favorite)
        .map((pref) => pref.foodId)
        .toList();

    final allergyFoodIds = preferences
        .where((pref) => pref.preferenceType == UserFoodPreferenceType.allergic)
        .map((pref) => pref.foodId)
        .toList();

    final intoleranceFoodIds = preferences
        .where(
            (pref) => pref.preferenceType == UserFoodPreferenceType.intolerant)
        .map((pref) => pref.foodId)
        .toList();

    return UserFoodPreferencesResponseDto(
      preferences: preferences,
      excludedFoodIds: excludedFoodIds,
      favoriteFoodIds: favoriteFoodIds,
      allergyFoodIds: allergyFoodIds,
      intoleranceFoodIds: intoleranceFoodIds,
    );
  }
}
