import 'package:fitbodyrd_server/src/generated/protocol.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';
import 'package:test/test.dart';

// Import the generated file, it contains everything you need.
import '../../../../integration/test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given FoodIntakeLog endpoint', (sessionBuilder, endpoints) {
    const userId = 1;
    final authenticatedSessionBuilder = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        userId.toString(),
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

    group('create', () {
      test('should create food log successfully', () async {
        // Arrange
        final session = authenticatedSessionBuilder.build();
        final userProfile = createTestUserProfile();
        await UserProfile.db.insertRow(session, userProfile);
        final insertedProfile = await UserProfile.db.findFirstRow(
          session,
          where: (t) => t.userInfoId.equals(userId),
        );
        final userProfileId = insertedProfile!.id!;

        // Create FoodCategory and Food
        final foodCategory = FoodCategory(
          name: 'Test Category',
          slug: 'test-category',
          iconName: 'test-icon',
          colorHex: '#000000',
          displayOrder: 0,
        );
        await FoodCategory.db.insertRow(session, foodCategory);
        final insertedCategory = await FoodCategory.db.findFirstRow(
          session,
          where: (t) => t.name.equals('Test Category'),
        );
        final categoryId = insertedCategory!.id!;

        final food = Food(
          name: 'Chicken Breast',
          categoryId: categoryId,
          calories: 165.0,
          proteins: 31.0,
          carbs: 0.0,
          fats: 3.6,
          fiber: 0.0,
        );
        await Food.db.insertRow(session, food);
        final insertedFood = await Food.db.findFirstRow(
          session,
          where: (t) => t.name.equals('Chicken Breast'),
        );
        final foodId = insertedFood!.id!;

        final dto = CreateFoodIntakeLog(
          mealPlanId: null,
          foodId: foodId,
          date: DateTime(2024, 6, 15),
          mealType: MealPlanType.breakfast,
          servingSizeId: null,
          servingQuantity: 1.0,
          quantityGrams: 100.0,
        );

        // Act
        final result = await endpoints.foodIntakeLog.create(
          authenticatedSessionBuilder,
          dto,
        );

        // Assert
        expect(result, isNotNull);
        expect(result.userId, equals(userProfileId));
        expect(result.foodId, equals(foodId));
        expect(result.mealType, equals(MealPlanType.breakfast));
        expect(result.quantityGrams, equals(100.0));
        expect(result.food, isNotNull);
        expect(result.food!.name, equals('Chicken Breast'));
      });

      test('should throw exception when user profile not found', () async {
        // Arrange - no user profile created
        final dto = CreateFoodIntakeLog(
          mealPlanId: null,
          foodId: 1,
          date: DateTime(2024, 6, 15),
          mealType: MealPlanType.breakfast,
          servingSizeId: null,
          servingQuantity: 1.0,
          quantityGrams: 100.0,
        );

        // Act & Assert
        await expectLater(
          endpoints.foodIntakeLog.create(authenticatedSessionBuilder, dto),
          throwsException,
        );
      });

      test('should include food relation in response', () async {
        // Arrange
        final session = authenticatedSessionBuilder.build();
        final userProfile = createTestUserProfile();
        await UserProfile.db.insertRow(session, userProfile);

        // Create FoodCategory and Food
        final foodCategory = FoodCategory(
          name: 'Test Category',
          slug: 'test-category',
          iconName: 'test-icon',
          colorHex: '#000000',
          displayOrder: 0,
        );
        await FoodCategory.db.insertRow(session, foodCategory);
        final insertedCategory = await FoodCategory.db.findFirstRow(
          session,
          where: (t) => t.name.equals('Test Category'),
        );
        final categoryId = insertedCategory!.id!;

        final food = Food(
          name: 'Brown Rice',
          categoryId: categoryId,
          calories: 111.0,
          proteins: 2.6,
          carbs: 23.0,
          fats: 0.9,
          fiber: 1.8,
        );
        await Food.db.insertRow(session, food);
        final insertedFood = await Food.db.findFirstRow(
          session,
          where: (t) => t.name.equals('Brown Rice'),
        );
        final foodId = insertedFood!.id!;

        final dto = CreateFoodIntakeLog(
          mealPlanId: null,
          foodId: foodId,
          date: DateTime(2024, 6, 15),
          mealType: MealPlanType.lunch,
          servingSizeId: null,
          servingQuantity: 1.5,
          quantityGrams: 150.0,
        );

        // Act
        final result = await endpoints.foodIntakeLog.create(
          authenticatedSessionBuilder,
          dto,
        );

        // Assert
        expect(result.food, isNotNull);
        expect(result.food!.id, equals(foodId));
        expect(result.food!.name, equals('Brown Rice'));
        expect(result.food!.calories, equals(111.0));
      });
    });

    group('delete', () {
      test('should delete food log successfully', () async {
        // Arrange
        final session = authenticatedSessionBuilder.build();
        final userProfile = createTestUserProfile();
        await UserProfile.db.insertRow(session, userProfile);
        final insertedProfile = await UserProfile.db.findFirstRow(
          session,
          where: (t) => t.userInfoId.equals(userId),
        );
        final userProfileId = insertedProfile!.id!;

        // Create FoodCategory and Food
        final foodCategory = FoodCategory(
          name: 'Test Category',
          slug: 'test-category',
          iconName: 'test-icon',
          colorHex: '#000000',
          displayOrder: 0,
        );
        await FoodCategory.db.insertRow(session, foodCategory);
        final insertedCategory = await FoodCategory.db.findFirstRow(
          session,
          where: (t) => t.name.equals('Test Category'),
        );
        final categoryId = insertedCategory!.id!;

        final food = Food(
          name: 'Test Food',
          categoryId: categoryId,
          calories: 100.0,
          proteins: 10.0,
          carbs: 20.0,
          fats: 5.0,
          fiber: 2.0,
        );
        await Food.db.insertRow(session, food);
        final insertedFood = await Food.db.findFirstRow(
          session,
          where: (t) => t.name.equals('Test Food'),
        );
        final foodId = insertedFood!.id!;

        final log = FoodIntakeLog(
          userId: userProfileId,
          foodId: foodId,
          date: DateTime(2024, 6, 15),
          mealType: MealPlanType.breakfast,
          servingQuantity: 1.0,
          quantityGrams: 100.0,
        );
        await FoodIntakeLog.db.insertRow(session, log);
        final insertedLog = await FoodIntakeLog.db.findFirstRow(
          session,
          where: (t) => t.userId.equals(userProfileId),
        );
        final logId = insertedLog!.id!;

        // Act
        await endpoints.foodIntakeLog.delete(
          authenticatedSessionBuilder,
          logId,
        );

        // Assert - verify log is deleted
        final deletedLog = await FoodIntakeLog.db.findById(session, logId);
        expect(deletedLog, isNull);
      });

      test(
        'should throw exception when unauthorized (different user)',
        () async {
          // Arrange
          final session = authenticatedSessionBuilder.build();
          final userProfile = createTestUserProfile();
          await UserProfile.db.insertRow(session, userProfile);

          // Create second user
          const userId2 = 2;
          await UserInfo.db.insertRow(
            session,
            UserInfo(
              id: userId2,
              userIdentifier: 'test_user_$userId2',
              created: DateTime(2024, 1, 1),
              scopeNames: ['user'],
              blocked: false,
            ),
          );
          final userProfile2 = createTestUserProfile(
            userInfoId: userId2,
            email: 'user2@example.com',
          );
          await UserProfile.db.insertRow(session, userProfile2);
          final insertedProfile2 = await UserProfile.db.findFirstRow(
            session,
            where: (t) => t.userInfoId.equals(userId2),
          );
          final userProfileId2 = insertedProfile2!.id!;

          // Create FoodCategory and Food
          final foodCategory = FoodCategory(
            name: 'Test Category',
            slug: 'test-category',
            iconName: 'test-icon',
            colorHex: '#000000',
            displayOrder: 0,
          );
          await FoodCategory.db.insertRow(session, foodCategory);
          final insertedCategory = await FoodCategory.db.findFirstRow(
            session,
            where: (t) => t.name.equals('Test Category'),
          );
          final categoryId = insertedCategory!.id!;

          final food = Food(
            name: 'Test Food',
            categoryId: categoryId,
            calories: 100.0,
            proteins: 10.0,
            carbs: 20.0,
            fats: 5.0,
            fiber: 2.0,
          );
          await Food.db.insertRow(session, food);
          final insertedFood = await Food.db.findFirstRow(
            session,
            where: (t) => t.name.equals('Test Food'),
          );
          final foodId = insertedFood!.id!;

          // Create log for user 2
          final log = FoodIntakeLog(
            userId: userProfileId2,
            foodId: foodId,
            date: DateTime(2024, 6, 15),
            mealType: MealPlanType.breakfast,
            servingQuantity: 1.0,
            quantityGrams: 100.0,
          );
          await FoodIntakeLog.db.insertRow(session, log);
          final insertedLog = await FoodIntakeLog.db.findFirstRow(
            session,
            where: (t) => t.userId.equals(userProfileId2),
          );
          final logId = insertedLog!.id!;

          // Act & Assert - user 1 trying to delete user 2's log
          await expectLater(
            endpoints.foodIntakeLog.delete(authenticatedSessionBuilder, logId),
            throwsException,
          );
        },
      );

      test('should not throw when log not found', () async {
        // Arrange
        final session = authenticatedSessionBuilder.build();
        final userProfile = createTestUserProfile();
        await UserProfile.db.insertRow(session, userProfile);

        // Act & Assert - deleting non-existent log should not throw
        await endpoints.foodIntakeLog.delete(
          authenticatedSessionBuilder,
          99999, // Non-existent ID
        );
        // Should complete without exception
      });
    });

    group('getByDate', () {
      test('should retrieve logs for specific date', () async {
        // Arrange
        final session = authenticatedSessionBuilder.build();
        final userProfile = createTestUserProfile();
        await UserProfile.db.insertRow(session, userProfile);
        final insertedProfile = await UserProfile.db.findFirstRow(
          session,
          where: (t) => t.userInfoId.equals(userId),
        );
        final userProfileId = insertedProfile!.id!;

        // Create FoodCategory and Food
        final foodCategory = FoodCategory(
          name: 'Test Category',
          slug: 'test-category',
          iconName: 'test-icon',
          colorHex: '#000000',
          displayOrder: 0,
        );
        await FoodCategory.db.insertRow(session, foodCategory);
        final insertedCategory = await FoodCategory.db.findFirstRow(
          session,
          where: (t) => t.name.equals('Test Category'),
        );
        final categoryId = insertedCategory!.id!;

        final food = Food(
          name: 'Test Food',
          categoryId: categoryId,
          calories: 100.0,
          proteins: 10.0,
          carbs: 20.0,
          fats: 5.0,
          fiber: 2.0,
        );
        await Food.db.insertRow(session, food);
        final insertedFood = await Food.db.findFirstRow(
          session,
          where: (t) => t.name.equals('Test Food'),
        );
        final foodId = insertedFood!.id!;

        final targetDate = DateTime(2024, 6, 15);
        final log1 = FoodIntakeLog(
          userId: userProfileId,
          foodId: foodId,
          date: targetDate,
          mealType: MealPlanType.breakfast,
          servingQuantity: 1.0,
          quantityGrams: 100.0,
        );
        final log2 = FoodIntakeLog(
          userId: userProfileId,
          foodId: foodId,
          date: targetDate,
          mealType: MealPlanType.lunch,
          servingQuantity: 1.5,
          quantityGrams: 150.0,
        );
        await FoodIntakeLog.db.insertRow(session, log1);
        await FoodIntakeLog.db.insertRow(session, log2);

        // Act
        final result = await endpoints.foodIntakeLog.getByDate(
          authenticatedSessionBuilder,
          targetDate,
        );

        // Assert
        expect(result, isNotNull);
        expect(result.length, equals(2));
        expect(result.every((log) => log.userId == userProfileId), isTrue);
        expect(
          result.every(
            (log) =>
                log.date.year == targetDate.year &&
                log.date.month == targetDate.month &&
                log.date.day == targetDate.day,
          ),
          isTrue,
        );
      });

      test('should return empty list when no logs exist', () async {
        // Arrange
        final session = authenticatedSessionBuilder.build();
        final userProfile = createTestUserProfile();
        await UserProfile.db.insertRow(session, userProfile);

        final targetDate = DateTime(2024, 6, 15);

        // Act
        final result = await endpoints.foodIntakeLog.getByDate(
          authenticatedSessionBuilder,
          targetDate,
        );

        // Assert
        expect(result, isEmpty);
      });

      test(
        'should filter by date range correctly (start of day to end of day)',
        () async {
          // Arrange
          final session = authenticatedSessionBuilder.build();
          final userProfile = createTestUserProfile();
          await UserProfile.db.insertRow(session, userProfile);
          final insertedProfile = await UserProfile.db.findFirstRow(
            session,
            where: (t) => t.userInfoId.equals(userId),
          );
          final userProfileId = insertedProfile!.id!;

          // Create FoodCategory and Food
          final foodCategory = FoodCategory(
            name: 'Test Category',
            slug: 'test-category',
            iconName: 'test-icon',
            colorHex: '#000000',
            displayOrder: 0,
          );
          await FoodCategory.db.insertRow(session, foodCategory);
          final insertedCategory = await FoodCategory.db.findFirstRow(
            session,
            where: (t) => t.name.equals('Test Category'),
          );
          final categoryId = insertedCategory!.id!;

          final food = Food(
            name: 'Test Food',
            categoryId: categoryId,
            calories: 100.0,
            proteins: 10.0,
            carbs: 20.0,
            fats: 5.0,
            fiber: 2.0,
          );
          await Food.db.insertRow(session, food);
          final insertedFood = await Food.db.findFirstRow(
            session,
            where: (t) => t.name.equals('Test Food'),
          );
          final foodId = insertedFood!.id!;

          final targetDate = DateTime(2024, 6, 15);
          // Log on target date
          final logOnDate = FoodIntakeLog(
            userId: userProfileId,
            foodId: foodId,
            date: targetDate,
            mealType: MealPlanType.breakfast,
            servingQuantity: 1.0,
            quantityGrams: 100.0,
          );
          // Log on previous day (should not be included)
          final logBeforeDate = FoodIntakeLog(
            userId: userProfileId,
            foodId: foodId,
            date: targetDate.subtract(const Duration(days: 1)),
            mealType: MealPlanType.lunch,
            servingQuantity: 1.0,
            quantityGrams: 100.0,
          );
          // Log on next day (should not be included)
          final logAfterDate = FoodIntakeLog(
            userId: userProfileId,
            foodId: foodId,
            date: targetDate.add(const Duration(days: 1)),
            mealType: MealPlanType.dinner,
            servingQuantity: 1.0,
            quantityGrams: 100.0,
          );
          await FoodIntakeLog.db.insertRow(session, logOnDate);
          await FoodIntakeLog.db.insertRow(session, logBeforeDate);
          await FoodIntakeLog.db.insertRow(session, logAfterDate);

          // Act
          final result = await endpoints.foodIntakeLog.getByDate(
            authenticatedSessionBuilder,
            targetDate,
          );

          // Assert
          expect(result.length, equals(1));
          expect(result.first.date.year, equals(targetDate.year));
          expect(result.first.date.month, equals(targetDate.month));
          expect(result.first.date.day, equals(targetDate.day));
        },
      );

      test('should include food relation in response', () async {
        // Arrange
        final session = authenticatedSessionBuilder.build();
        final userProfile = createTestUserProfile();
        await UserProfile.db.insertRow(session, userProfile);
        final insertedProfile = await UserProfile.db.findFirstRow(
          session,
          where: (t) => t.userInfoId.equals(userId),
        );
        final userProfileId = insertedProfile!.id!;

        // Create FoodCategory and Food
        final foodCategory = FoodCategory(
          name: 'Test Category',
          slug: 'test-category',
          iconName: 'test-icon',
          colorHex: '#000000',
          displayOrder: 0,
        );
        await FoodCategory.db.insertRow(session, foodCategory);
        final insertedCategory = await FoodCategory.db.findFirstRow(
          session,
          where: (t) => t.name.equals('Test Category'),
        );
        final categoryId = insertedCategory!.id!;

        final food = Food(
          name: 'Broccoli',
          categoryId: categoryId,
          calories: 34.0,
          proteins: 2.8,
          carbs: 7.0,
          fats: 0.4,
          fiber: 2.6,
        );
        await Food.db.insertRow(session, food);
        final insertedFood = await Food.db.findFirstRow(
          session,
          where: (t) => t.name.equals('Broccoli'),
        );
        final foodId = insertedFood!.id!;

        final targetDate = DateTime(2024, 6, 15);
        final log = FoodIntakeLog(
          userId: userProfileId,
          foodId: foodId,
          date: targetDate,
          mealType: MealPlanType.dinner,
          servingQuantity: 2.0,
          quantityGrams: 200.0,
        );
        await FoodIntakeLog.db.insertRow(session, log);

        // Act
        final result = await endpoints.foodIntakeLog.getByDate(
          authenticatedSessionBuilder,
          targetDate,
        );

        // Assert
        expect(result.length, equals(1));
        expect(result.first.food, isNotNull);
        expect(result.first.food!.id, equals(foodId));
        expect(result.first.food!.name, equals('Broccoli'));
        expect(result.first.food!.calories, equals(34.0));
      });
    });
  });
}
