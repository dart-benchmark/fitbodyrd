import 'package:fitbodyrd_server/src/generated/protocol.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';
import 'package:test/test.dart';

// Import the generated file, it contains everything you need.
import '../../../../integration/test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given User endpoint', (sessionBuilder, endpoints) {
    const userId = 1;
    final authenticatedSessionBuilder = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        userId.toString(),
        {},
      ),
    );

    final unauthenticatedSessionBuilder = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.unauthenticated(),
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
        userInfoId: userInfoId ?? userId,
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

    group('getCurrentUserProfile', () {
      test('should return user profile when user exists', () async {
        // Arrange
        final session = authenticatedSessionBuilder.build();
        // Create UserInfo first (required for foreign key constraint)
        await UserInfo.db.insertRow(
          session,
          UserInfo(
            id: userId,
            userIdentifier: 'test_user_$userId',
            created: DateTime.now(),
            scopeNames: ['user'],
            blocked: false,
          ),
        );
        final testProfile = createTestUserProfile();
        await UserProfile.db.insertRow(session, testProfile);

        // Act
        final result = await endpoints.user.getCurrentUserProfile(
          authenticatedSessionBuilder,
        );

        // Assert
        expect(result, isNotNull);
        expect(result.userInfoId, equals(userId));
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
            endpoints.user.getCurrentUserProfile(authenticatedSessionBuilder),
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

      test('should require authentication (requireLogin)', () async {
        // Act & Assert
        // When requireLogin is true and user is not authenticated,
        // Serverpod throws an exception before the endpoint method is called
        await expectLater(
          endpoints.user.getCurrentUserProfile(unauthenticatedSessionBuilder),
          throwsException,
        );
      });
    });

    group('createUserProfile', () {
      test('should create user profile successfully', () async {
        // Arrange
        final session = authenticatedSessionBuilder.build();
        // Create UserInfo first (required for foreign key constraint)
        await UserInfo.db.insertRow(
          session,
          UserInfo(
            id: userId,
            userIdentifier: 'test_user_$userId',
            created: DateTime.now(),
            scopeNames: ['user'],
            blocked: false,
          ),
        );
        final newProfile = createTestUserProfile(
          fullName: 'New User',
          email: 'newuser@example.com',
        );

        // Act
        final result = await endpoints.user.createUserProfile(
          authenticatedSessionBuilder,
          newProfile,
        );

        // Assert
        expect(result, isNotNull);
        expect(result.userInfoId, equals(userId));
        expect(result.fullName, equals('New User'));
        expect(result.email, equals('newuser@example.com'));
        // Verify profile was created by trying to fetch it
        final fetchedProfile = await endpoints.user.getCurrentUserProfile(
          authenticatedSessionBuilder,
        );
        expect(fetchedProfile.fullName, equals('New User'));
      });

      test(
        'should throw UserExceptions.userProfileAlreadyExists when profile already exists',
        () async {
          // Arrange
          final session = authenticatedSessionBuilder.build();
          // Create UserInfo first (required for foreign key constraint)
          await UserInfo.db.insertRow(
            session,
            UserInfo(
              id: userId,
              userIdentifier: 'test_user_$userId',
              created: DateTime.now(),
              scopeNames: ['user'],
              blocked: false,
            ),
          );
          final existingProfile = createTestUserProfile();
          await UserProfile.db.insertRow(session, existingProfile);

          final duplicateProfile = createTestUserProfile(
            fullName: 'Duplicate User',
            email: 'duplicate@example.com',
          );

          // Act & Assert
          await expectLater(
            endpoints.user.createUserProfile(
              authenticatedSessionBuilder,
              duplicateProfile,
            ),
            throwsA(
              isA<AppException>()
                  .having((e) => e.module, 'module', 'user')
                  .having(
                    (e) => e.message,
                    'message',
                    'User profile already exists.',
                  )
                  .having((e) => e.errorCode, 'errorCode', 6002)
                  .having((e) => e.httpStatus, 'httpStatus', 409),
            ),
          );
        },
      );

      test('should require authentication (requireLogin)', () async {
        // Arrange
        final newProfile = createTestUserProfile();

        // Act & Assert
        // When requireLogin is true and user is not authenticated,
        // Serverpod throws an exception before the endpoint method is called
        await expectLater(
          endpoints.user.createUserProfile(
            unauthenticatedSessionBuilder,
            newProfile,
          ),
          throwsException,
        );
      });
    });

    group('requireLogin property', () {
      test('should have requireLogin set to true', () async {
        // This is tested implicitly by the authentication requirement tests above
        // but we can verify the endpoint requires login by checking it throws
        // an exception for unauthenticated requests
        await expectLater(
          endpoints.user.getCurrentUserProfile(unauthenticatedSessionBuilder),
          throwsException,
        );
      });
    });
  });
}
