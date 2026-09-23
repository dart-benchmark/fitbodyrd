import 'package:fitbodyrd_server/src/common/utils/endpoint_utils.dart';
import 'package:fitbodyrd_server/src/errors/exceptions/generic_exceptions.dart';
import 'package:fitbodyrd_server/src/features/user/exceptions/user_exceptions.dart';
import 'package:fitbodyrd_server/src/features/user/utils/user_utils.dart';
import 'package:fitbodyrd_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

part 'package:fitbodyrd_server/src/features/user/utils/user_endpoint_queries.dart';

class UserEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<UserProfile> getCurrentUserProfile(Session session) async {
    final userId = await EndpointUtils.getUserIdFromSession(session);

    final userProfile = await UserProfile.db.findFirstRow(
      session,
      where: (t) => t.userInfoId.equals(
        userId,
      ),
    );
    if (userProfile == null) {
      throw UserExceptions.userNotFound();
    }
    return userProfile.completeProfile();
  }

  Future<UserProfile> createUserProfile(
    Session session,
    UserProfile userProfile,
  ) async {
    try {
      final userId = await EndpointUtils.getUserIdFromSession(session);

      final existingProfile = await UserProfile.db.findFirstRow(
        session,
        where: (t) => t.userInfoId.equals(
          userId,
        ),
      );
      if (existingProfile != null) {
        throw UserExceptions.userProfileAlreadyExists();
      }

      userProfile.userInfoId = userId;
      // await UserProfile.db.insertRow(session, userProfile);

      await session.db.unsafeExecute(
        _insertUserQuery,
        parameters: QueryParameters.named(
          {
            'id': userProfile.userInfoId,
            'userInfoId': userProfile.userInfoId,
            'fullName': userProfile.fullName,
            'email': userProfile.email,
            'birthDate': userProfile.birthDate,
            'sex': userProfile.sex.name,
            'weightKgs': userProfile.weightKgs,
            'heightMs': userProfile.heightMs,
            'bodyGoal': userProfile.bodyGoal.name,
            'activityLevel': userProfile.activityLevel.name,
            'daysPerWeekExercise': userProfile.daysPerWeekExercise,
            'timePerExerciseSessionMinutes':
                userProfile.timePerExerciseSessionMinutes,
            'experienceLevel': userProfile.experienceLevel.name,
            'authMethod': userProfile.authMethod?.name,
            'hasEquipment': userProfile.hasEquipment,
            'dietaryRestrictions': userProfile.dietaryRestrictions.name,
            'deletedAt': userProfile.deletedAt,
            'createdAt': userProfile.createdAt,
            'updatedAt': userProfile.updatedAt,
          },
        ),
      );

      return getCurrentUserProfile(session);
    } on AppException catch (_) {
      rethrow;
    } catch (e) {
      throw GenericExceptions.internalServerError();
    }
  }

  Future<void> setAuthMethod(
    Session session,
    AuthMethod authMethod,
  ) async {
    final userId = await EndpointUtils.getUserIdFromSession(session);

    var userProfile = await UserProfile.db.findFirstRow(
      session,
      where: (t) => t.userInfoId.equals(
        userId,
      ),
    );
    if (userProfile == null) {
      throw UserExceptions.userNotFound();
    }

    userProfile = userProfile.copyWith(authMethod: authMethod);

    await UserProfile.db.updateRow(session, userProfile);
  }
}
