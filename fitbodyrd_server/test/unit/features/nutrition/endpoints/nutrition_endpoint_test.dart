import 'package:fitbodyrd_server/src/features/user/utils/user_utils.dart';
import 'package:fitbodyrd_server/src/generated/protocol.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';
import 'package:test/test.dart';

// Import the generated file, it contains everything you need.
import '../../../../integration/test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Nutrition endpoint', (sessionBuilder, endpoints) {
    const userId = 1;
    final authenticatedSessionBuilder = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        userId.toString(),
        {},
      ),
    );

    // Helper function to create a test UserProfile with age calculated
    Future<UserProfile> createTestUserProfile({
      int? id,
      int? userInfoId,
      Sex sex = Sex.male,
      double weightKgs = 75.0,
      double heightMs = 1.75,
      int age = 30,
      ActivityLevel activityLevel = ActivityLevel.sedentary,
      BodyGoal bodyGoal = BodyGoal.maintainWeight,
    }) async {
      final session = authenticatedSessionBuilder.build();
      final birthDate = DateTime.now().subtract(Duration(days: age * 365));
      final userProfile = UserProfile(
        id: id,
        userInfoId: userInfoId ?? userId,
        fullName: 'Test User',
        email: 'test@example.com',
        birthDate: birthDate,
        sex: sex,
        weightKgs: weightKgs,
        heightMs: heightMs,
        bodyGoal: bodyGoal,
        activityLevel: activityLevel,
        daysPerWeekExercise: 3,
        timePerExerciseSessionMinutes: 30,
        experienceLevel: ExerciseDifficulty.beginner,
      );
      await UserProfile.db.insertRow(session, userProfile);
      // Fetch to get complete profile with age
      final inserted = await UserProfile.db.findFirstRow(
        session,
        where: (t) => t.userInfoId.equals(userId),
      );
      return inserted!.completeProfile();
    }

    setUp(() async {
      final session = authenticatedSessionBuilder.build();
      // Create UserInfo for foreign key constraint
      await UserInfo.db.insertRow(
        session,
        UserInfo(
          id: userId,
          userIdentifier: 'test_user_$userId',
          created: DateTime(2024, 1, 1),
          scopeNames: ['user'],
          blocked: false,
        ),
      );
    });

    group('calculateMacros', () {
      test('should calculate BMR correctly for male', () async {
        // Arrange
        final profile = await createTestUserProfile(
          sex: Sex.male,
          weightKgs: 80.0,
          heightMs: 1.80,
          age: 25,
        );

        // Act
        final result = await endpoints.nutrition.calculateMacros(
          authenticatedSessionBuilder,
          userId,
          [MealPlanType.breakfast, MealPlanType.lunch],
        );

        // Assert
        // BMR = (10 * weight) + (6.25 * heightCm) - (5 * age) + 5
        final expectedBmr =
            (10 * 80.0) + (6.25 * 180.0) - (5 * profile.age!) + 5;
        expect(result.bmr, closeTo(expectedBmr, 0.1));
      });

      test('should calculate BMR correctly for female', () async {
        // Arrange
        final profile = await createTestUserProfile(
          sex: Sex.female,
          weightKgs: 65.0,
          heightMs: 1.65,
          age: 28,
        );

        // Act
        final result = await endpoints.nutrition.calculateMacros(
          authenticatedSessionBuilder,
          userId,
          [MealPlanType.breakfast, MealPlanType.lunch],
        );

        // Assert
        // BMR = (10 * weight) + (6.25 * heightCm) - (5 * age) - 161
        final expectedBmr =
            (10 * 65.0) + (6.25 * 165.0) - (5 * profile.age!) - 161;
        expect(result.bmr, closeTo(expectedBmr, 0.1));
      });

      test(
        'should calculate TDEE correctly for sedentary activity level',
        () async {
          // Arrange
          await createTestUserProfile(
            activityLevel: ActivityLevel.sedentary,
            weightKgs: 75.0,
            heightMs: 1.75,
            age: 30,
          );

          // Act
          final result = await endpoints.nutrition.calculateMacros(
            authenticatedSessionBuilder,
            userId,
            [MealPlanType.breakfast, MealPlanType.lunch],
          );

          // Assert
          // TDEE = BMR * 1.2
          expect(result.tdee, closeTo(result.bmr * 1.2, 0.1));
        },
      );

      test(
        'should calculate TDEE correctly for lightly active activity level',
        () async {
          // Arrange
          await createTestUserProfile(
            activityLevel: ActivityLevel.lightlyActive,
            weightKgs: 75.0,
            heightMs: 1.75,
            age: 30,
          );

          // Act
          final result = await endpoints.nutrition.calculateMacros(
            authenticatedSessionBuilder,
            userId,
            [MealPlanType.breakfast, MealPlanType.lunch],
          );

          // Assert
          // TDEE = BMR * 1.375
          expect(result.tdee, closeTo(result.bmr * 1.375, 0.1));
        },
      );

      test(
        'should calculate TDEE correctly for moderately active activity level',
        () async {
          // Arrange
          await createTestUserProfile(
            activityLevel: ActivityLevel.moderatelyActive,
            weightKgs: 75.0,
            heightMs: 1.75,
            age: 30,
          );

          // Act
          final result = await endpoints.nutrition.calculateMacros(
            authenticatedSessionBuilder,
            userId,
            [MealPlanType.breakfast, MealPlanType.lunch],
          );

          // Assert
          // TDEE = BMR * 1.55
          expect(result.tdee, closeTo(result.bmr * 1.55, 0.1));
        },
      );

      test(
        'should calculate TDEE correctly for active activity level',
        () async {
          // Arrange
          await createTestUserProfile(
            activityLevel: ActivityLevel.active,
            weightKgs: 75.0,
            heightMs: 1.75,
            age: 30,
          );

          // Act
          final result = await endpoints.nutrition.calculateMacros(
            authenticatedSessionBuilder,
            userId,
            [MealPlanType.breakfast, MealPlanType.lunch],
          );

          // Assert
          // TDEE = BMR * 1.725
          expect(result.tdee, closeTo(result.bmr * 1.725, 0.1));
        },
      );

      test(
        'should calculate TDEE correctly for very active activity level',
        () async {
          // Arrange
          await createTestUserProfile(
            activityLevel: ActivityLevel.veryActive,
            weightKgs: 75.0,
            heightMs: 1.75,
            age: 30,
          );

          // Act
          final result = await endpoints.nutrition.calculateMacros(
            authenticatedSessionBuilder,
            userId,
            [MealPlanType.breakfast, MealPlanType.lunch],
          );

          // Assert
          // TDEE = BMR * 1.9
          expect(result.tdee, closeTo(result.bmr * 1.9, 0.1));
        },
      );

      test(
        'should apply caloric adjustment for loseWeight body goal',
        () async {
          // Arrange
          await createTestUserProfile(
            bodyGoal: BodyGoal.loseWeight,
            weightKgs: 75.0,
            heightMs: 1.75,
            age: 30,
          );

          // Act
          final result = await endpoints.nutrition.calculateMacros(
            authenticatedSessionBuilder,
            userId,
            [MealPlanType.breakfast, MealPlanType.lunch],
          );

          // Assert
          // loseWeight: -500 calories
          expect(result.caloricAdjustment, equals(-500.0));
          expect(
            result.targetCalories,
            closeTo(result.tdee + result.caloricAdjustment, 0.1),
          );
        },
      );

      test(
        'should apply caloric adjustment for maintainWeight body goal',
        () async {
          // Arrange
          await createTestUserProfile(
            bodyGoal: BodyGoal.maintainWeight,
            weightKgs: 75.0,
            heightMs: 1.75,
            age: 30,
          );

          // Act
          final result = await endpoints.nutrition.calculateMacros(
            authenticatedSessionBuilder,
            userId,
            [MealPlanType.breakfast, MealPlanType.lunch],
          );

          // Assert
          // maintainWeight: 0 calories adjustment
          expect(result.caloricAdjustment, equals(0.0));
          expect(
            result.targetCalories,
            closeTo(result.tdee + result.caloricAdjustment, 0.1),
          );
        },
      );

      test(
        'should apply caloric adjustment for gainMuscleMass body goal',
        () async {
          // Arrange
          await createTestUserProfile(
            bodyGoal: BodyGoal.gainMuscleMass,
            weightKgs: 75.0,
            heightMs: 1.75,
            age: 30,
          );

          // Act
          final result = await endpoints.nutrition.calculateMacros(
            authenticatedSessionBuilder,
            userId,
            [MealPlanType.breakfast, MealPlanType.lunch],
          );

          // Assert
          // gainMuscleMass: +300 calories
          expect(result.caloricAdjustment, equals(300.0));
          expect(
            result.targetCalories,
            closeTo(result.tdee + result.caloricAdjustment, 0.1),
          );
        },
      );

      test('should validate meal type count (2-5 types required)', () async {
        // Arrange
        await createTestUserProfile();

        // Act & Assert - Less than 2 types
        await expectLater(
          endpoints.nutrition.calculateMacros(
            authenticatedSessionBuilder,
            userId,
            [MealPlanType.breakfast],
          ),
          throwsA(
            isA<AppException>()
                .having((e) => e.module, 'module', 'nutrition')
                .having((e) => e.errorCode, 'errorCode', 4000)
                .having((e) => e.httpStatus, 'httpStatus', 400)
                .having((e) => e.message, 'message', contains('1')),
          ),
        );

        // Act & Assert - More than 5 types (all 5 unique types, but we can't have 6 unique)
        // Since there are only 5 meal types total, we test with exactly 5 (which is valid)
        // The > 5 case would require 6 unique types which doesn't exist
        // So we test that 5 types is valid (boundary case)
        final result5Types = await endpoints.nutrition
            .calculateMacros(authenticatedSessionBuilder, userId, [
              MealPlanType.breakfast,
              MealPlanType.brunch,
              MealPlanType.lunch,
              MealPlanType.snack,
              MealPlanType.dinner,
            ]);
        expect(result5Types, isNotNull);
      });

      test('should handle duplicate meal types (deduplicate)', () async {
        // Arrange
        await createTestUserProfile();

        // Act
        final result = await endpoints.nutrition.calculateMacros(
          authenticatedSessionBuilder,
          userId,
          [
            MealPlanType.breakfast,
            MealPlanType.lunch,
            MealPlanType.breakfast, // Duplicate
            MealPlanType.lunch, // Duplicate
          ],
        );

        // Assert - Should succeed with only 2 unique types
        expect(result, isNotNull);
        expect(result.bmr, greaterThan(0));
        expect(result.tdee, greaterThan(0));
        // Verify meal distribution only includes breakfast and lunch
        expect(result.mealDistribution.breakfast, isNotNull);
        expect(result.mealDistribution.lunch, isNotNull);
        expect(result.mealDistribution.brunch, isNull);
        expect(result.mealDistribution.snack, isNull);
        expect(result.mealDistribution.dinner, isNull);
      });

      test(
        'should calculate macro distribution for loseWeight body goal',
        () async {
          // Arrange
          await createTestUserProfile(
            bodyGoal: BodyGoal.loseWeight,
            weightKgs: 75.0,
          );

          // Act
          final result = await endpoints.nutrition.calculateMacros(
            authenticatedSessionBuilder,
            userId,
            [MealPlanType.breakfast, MealPlanType.lunch],
          );

          // Assert
          // loseWeight: protein 30%, carbs 40%, fats 30%
          expect(result.proteinPercentage, equals(30.0));
          expect(result.carbsPercentage, equals(40.0));
          expect(result.fatsPercentage, equals(30.0));
          // Percentages should sum to 100
          expect(
            result.proteinPercentage +
                result.carbsPercentage +
                result.fatsPercentage,
            equals(100.0),
          );
        },
      );

      test(
        'should calculate macro distribution for maintainWeight body goal',
        () async {
          // Arrange
          await createTestUserProfile(
            bodyGoal: BodyGoal.maintainWeight,
            weightKgs: 75.0,
          );

          // Act
          final result = await endpoints.nutrition.calculateMacros(
            authenticatedSessionBuilder,
            userId,
            [MealPlanType.breakfast, MealPlanType.lunch],
          );

          // Assert
          // maintainWeight: protein 25%, carbs 45%, fats 30%
          expect(result.proteinPercentage, equals(25.0));
          expect(result.carbsPercentage, equals(45.0));
          expect(result.fatsPercentage, equals(30.0));
          // Percentages should sum to 100
          expect(
            result.proteinPercentage +
                result.carbsPercentage +
                result.fatsPercentage,
            equals(100.0),
          );
        },
      );

      test(
        'should calculate macro distribution for gainMuscleMass body goal',
        () async {
          // Arrange
          await createTestUserProfile(
            bodyGoal: BodyGoal.gainMuscleMass,
            weightKgs: 75.0,
          );

          // Act
          final result = await endpoints.nutrition.calculateMacros(
            authenticatedSessionBuilder,
            userId,
            [MealPlanType.breakfast, MealPlanType.lunch],
          );

          // Assert
          // gainMuscleMass: protein 30%, carbs 45%, fats 25%
          expect(result.proteinPercentage, equals(30.0));
          expect(result.carbsPercentage, equals(45.0));
          expect(result.fatsPercentage, equals(25.0));
          // Percentages should sum to 100
          expect(
            result.proteinPercentage +
                result.carbsPercentage +
                result.fatsPercentage,
            equals(100.0),
          );
        },
      );

      test('should calculate meal distribution correctly', () async {
        // Arrange
        await createTestUserProfile(weightKgs: 75.0);

        // Act
        final result = await endpoints.nutrition.calculateMacros(
          authenticatedSessionBuilder,
          userId,
          [MealPlanType.breakfast, MealPlanType.lunch],
        );

        // Assert
        // Meal weights: breakfast = 3.0, lunch = 4.5, total = 7.5
        // breakfast percentage = (3.0 / 7.5) * 100 = 40%
        // lunch percentage = (4.5 / 7.5) * 100 = 60%
        expect(result.mealDistribution.breakfast, isNotNull);
        expect(result.mealDistribution.lunch, isNotNull);
        expect(
          result.mealDistribution.breakfast!.percentage,
          closeTo(40.0, 0.1),
        );
        expect(result.mealDistribution.lunch!.percentage, closeTo(60.0, 0.1));
        // Percentages should sum to 100
        final totalPercentage =
            (result.mealDistribution.breakfast?.percentage ?? 0) +
            (result.mealDistribution.lunch?.percentage ?? 0);
        expect(totalPercentage, closeTo(100.0, 0.1));
      });

      test('should calculate meal distribution with all meal types', () async {
        // Arrange
        await createTestUserProfile(weightKgs: 75.0);

        // Act
        final result = await endpoints.nutrition
            .calculateMacros(authenticatedSessionBuilder, userId, [
              MealPlanType.breakfast,
              MealPlanType.brunch,
              MealPlanType.lunch,
              MealPlanType.snack,
              MealPlanType.dinner,
            ]);

        // Assert
        // Meal weights: breakfast=3.0, brunch=4.0, lunch=4.5, snack=1.0, dinner=3.5
        // Total = 16.0
        expect(result.mealDistribution.breakfast, isNotNull);
        expect(result.mealDistribution.brunch, isNotNull);
        expect(result.mealDistribution.lunch, isNotNull);
        expect(result.mealDistribution.snack, isNotNull);
        expect(result.mealDistribution.dinner, isNotNull);

        // Verify percentages sum to 100
        final totalPercentage =
            (result.mealDistribution.breakfast?.percentage ?? 0) +
            (result.mealDistribution.brunch?.percentage ?? 0) +
            (result.mealDistribution.lunch?.percentage ?? 0) +
            (result.mealDistribution.snack?.percentage ?? 0) +
            (result.mealDistribution.dinner?.percentage ?? 0);
        expect(totalPercentage, closeTo(100.0, 0.1));
      });

      test('should calculate daily macros in grams correctly', () async {
        // Arrange
        await createTestUserProfile(
          bodyGoal: BodyGoal.maintainWeight,
          weightKgs: 75.0,
        );

        // Act
        final result = await endpoints.nutrition.calculateMacros(
          authenticatedSessionBuilder,
          userId,
          [MealPlanType.breakfast, MealPlanType.lunch],
        );

        // Assert
        // maintainWeight: protein 25%, carbs 45%, fats 30%
        // dailyProteins = (targetCalories * 0.25) / 4
        // dailyCarbs = (targetCalories * 0.45) / 4
        // dailyFats = (targetCalories * 0.30) / 9
        expect(
          result.dailyProteins,
          closeTo((result.targetCalories * 0.25) / 4, 0.1),
        );
        expect(
          result.dailyCarbs,
          closeTo((result.targetCalories * 0.45) / 4, 0.1),
        );
        expect(
          result.dailyFats,
          closeTo((result.targetCalories * 0.30) / 9, 0.1),
        );
      });

      test('should calculate proteinGramsPerKg correctly', () async {
        // Arrange
        final profile = await createTestUserProfile(
          bodyGoal: BodyGoal.maintainWeight,
          weightKgs: 75.0,
        );

        // Act
        final result = await endpoints.nutrition.calculateMacros(
          authenticatedSessionBuilder,
          userId,
          [MealPlanType.breakfast, MealPlanType.lunch],
        );

        // Assert
        // proteinGramsPerKg = dailyProteins / weightKgs
        expect(
          result.proteinGramsPerKg,
          closeTo(result.dailyProteins / profile.weightKgs, 0.1),
        );
      });
    });
  });
}
