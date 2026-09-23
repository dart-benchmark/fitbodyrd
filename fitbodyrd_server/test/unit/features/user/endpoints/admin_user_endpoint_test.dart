import 'package:fitbodyrd_server/src/generated/protocol.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';
import 'package:test/test.dart';

// Import the generated file, it contains everything you need.
import '../../../../integration/test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given AdminUser endpoint', (sessionBuilder, endpoints) {
    const userId1 = 1;
    const userId2 = 2;

    final authenticatedSessionBuilder = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        userId1.toString(),
        {},
      ),
    );

    // Helper function to create a test UserProfile
    UserProfile createTestUserProfile({
      int? id,
      int? userInfoId,
      String fullName = 'Test User',
      String email = 'test@example.com',
    }) {
      return UserProfile(
        id: id,
        userInfoId: userInfoId ?? userId1,
        fullName: fullName,
        email: email,
        birthDate: DateTime(1990, 1, 1),
        sex: Sex.male,
        weightKgs: 75.0,
        heightMs: 1.75,
        bodyGoal: BodyGoal.loseWeight,
        activityLevel: ActivityLevel.sedentary,
        daysPerWeekExercise: 3,
        timePerExerciseSessionMinutes: 30,
        experienceLevel: ExerciseDifficulty.beginner,
      );
    }

    group('findUserProfile', () {
      test('should return user profile when user exists', () async {
        // Arrange
        final session = authenticatedSessionBuilder.build();
        // Create UserInfo first (required for foreign key constraint)
        await UserInfo.db.insertRow(
          session,
          UserInfo(
            id: userId1,
            userIdentifier: 'test_user_$userId1',
            created: DateTime.now(),
            scopeNames: ['user'],
            blocked: false,
          ),
        );
        final testProfile = createTestUserProfile();
        await UserProfile.db.insertRow(session, testProfile);

        // Act
        final result = await endpoints.adminUser.findUserProfile(
          authenticatedSessionBuilder,
          userId1,
        );

        // Assert
        expect(result, isNotNull);
        expect(result.userInfoId, equals(userId1));
        expect(result.fullName, equals('Test User'));
        expect(result.email, equals('test@example.com'));
        // Verify completeProfile was called (should have age and BMI)
        expect(result.age, isNotNull);
        expect(result.bmi, isNotNull);
        expect(result.weightCategory, isNotNull);
      });

      test(
        'should throw UserExceptions.userNotFound when user does not exist',
        () async {
          // Arrange - no user profile in database
          // Act & Assert
          await expectLater(
            endpoints.adminUser.findUserProfile(
              authenticatedSessionBuilder,
              999, // Non-existent user ID
            ),
            throwsA(
              isA<AppException>()
                  .having((e) => e.module, 'module', 'user')
                  .having((e) => e.message, 'message', 'User not found.')
                  .having((e) => e.errorCode, 'errorCode', 6000)
                  .having((e) => e.httpStatus, 'httpStatus', 404),
            ),
          );
        },
      );

      test('should find user profile for different user ID', () async {
        // Arrange
        final session = authenticatedSessionBuilder.build();
        // Create UserInfo for second user
        await UserInfo.db.insertRow(
          session,
          UserInfo(
            id: userId2,
            userIdentifier: 'test_user_$userId2',
            created: DateTime.now(),
            scopeNames: ['user'],
            blocked: false,
          ),
        );
        final testProfile = createTestUserProfile(
          userInfoId: userId2,
          fullName: 'Second User',
          email: 'second@example.com',
        );
        await UserProfile.db.insertRow(session, testProfile);

        // Act
        final result = await endpoints.adminUser.findUserProfile(
          authenticatedSessionBuilder,
          userId2,
        );

        // Assert
        expect(result, isNotNull);
        expect(result.userInfoId, equals(userId2));
        expect(result.fullName, equals('Second User'));
        expect(result.email, equals('second@example.com'));
      });
    });

    group('admin-specific operations', () {
      test('should get user food preferences', () async {
        // Arrange
        final session = authenticatedSessionBuilder.build();
        // Create UserInfo and UserProfile
        await UserInfo.db.insertRow(
          session,
          UserInfo(
            id: userId1,
            userIdentifier: 'test_user_$userId1',
            created: DateTime.now(),
            scopeNames: ['user'],
            blocked: false,
          ),
        );
        final testProfile = createTestUserProfile();
        await UserProfile.db.insertRow(session, testProfile);

        // Act
        final result = await endpoints.adminUser.getUserFoodPreferences(
          authenticatedSessionBuilder,
          userId1,
        );

        // Assert
        expect(result, isNotNull);
        expect(result.preferences, isA<List<UserFoodPreference>>());
        expect(result.excludedFoodIds, isA<List<int>>());
        expect(result.favoriteFoodIds, isA<List<int>>());
        expect(result.allergyFoodIds, isA<List<int>>());
        expect(result.intoleranceFoodIds, isA<List<int>>());
      });
    });

    group('authorization checks', () {
      test(
        'should allow access without requireLogin (admin endpoint)',
        () async {
          // Arrange
          final unauthenticatedSessionBuilder = sessionBuilder.copyWith(
            authentication: AuthenticationOverride.unauthenticated(),
          );
          final session = unauthenticatedSessionBuilder.build();
          // Create UserInfo and UserProfile
          await UserInfo.db.insertRow(
            session,
            UserInfo(
              id: userId1,
              userIdentifier: 'test_user_$userId1',
              created: DateTime.now(),
              scopeNames: ['user'],
              blocked: false,
            ),
          );
          final testProfile = createTestUserProfile();
          await UserProfile.db.insertRow(session, testProfile);

          // Act & Assert
          // AdminUserEndpoint doesn't have requireLogin, so it should work
          // even without authentication (though in production this might be
          // protected by other means)
          final result = await endpoints.adminUser.findUserProfile(
            unauthenticatedSessionBuilder,
            userId1,
          );

          expect(result, isNotNull);
          expect(result.userInfoId, equals(userId1));
        },
      );
    });
  });
}
