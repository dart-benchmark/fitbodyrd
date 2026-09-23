import 'package:fitbodyrd_server/src/generated/protocol.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';
import 'package:test/test.dart';

// Import the generated file, it contains everything you need.
import '../../../../integration/test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given NutritionPlan endpoint', (sessionBuilder, endpoints) {
    const userId = 1;
    final authenticatedSessionBuilder = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        userId.toString(),
        {},
      ),
    );

    // Helper function to create a test UserProfile
    Future<UserProfile> createTestUserProfile({
      int? id,
      int? userInfoId,
    }) async {
      // final session = authenticatedSessionBuilder.build();
      final userProfile = UserProfile(
        id: id,
        userInfoId: userInfoId ?? userId,
        fullName: 'Test User',
        email: 'test@example.com',
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
      final user = await endpoints.user.createUserProfile(
        authenticatedSessionBuilder,
        userProfile,
      );
      return user;
      // await UserProfile.db.insertRow(session, userProfile);
      // final inserted = await UserProfile.db.findFirstRow(
      //   session,
      //   where: (t) => t.userInfoId.equals(userInfoId ?? userId),
      // );
      // return inserted!;
    }

    // Helper function to create test FoodCategory
    Future<FoodCategory> createTestFoodCategory() async {
      final session = authenticatedSessionBuilder.build();
      final category = FoodCategory(
        name: 'Test Category',
        slug: 'test-category',
        iconName: 'test-icon',
        colorHex: '#000000',
        displayOrder: 0,
      );
      await FoodCategory.db.insertRow(session, category);
      final inserted = await FoodCategory.db.findFirstRow(
        session,
        where: (t) => t.name.equals('Test Category'),
      );
      return inserted!;
    }

    // Helper function to create test Food
    Future<Food> createTestFood({int? categoryId}) async {
      final session = authenticatedSessionBuilder.build();
      final catId = categoryId ?? (await createTestFoodCategory()).id!;
      final food = Food(
        name: 'Test Food',
        categoryId: catId,
        calories: 100.0,
        proteins: 10.0,
        carbs: 20.0,
        fats: 5.0,
        fiber: 2.0,
      );
      final inserted = await Food.db.insertRow(session, food);

      return inserted;
    }

    // Helper function to create test FoodServingSize
    Future<FoodServingSize> createTestServingSize({
      required int foodId,
      String name = '1 serving',
      double grams = 100.0,
    }) async {
      final session = authenticatedSessionBuilder.build();
      final servingSize = FoodServingSize(
        foodId: foodId,
        name: name,
        grams: grams,
        isDefault: true,
      );
      final inserted = await FoodServingSize.db.insertRow(session, servingSize);

      return inserted;
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

    group('createNutritionPlan', () {
      test(
        'should create nutrition plan successfully with valid inputs',
        () async {
          // Arrange
          final userProfile = await createTestUserProfile();
          final startDate = DateTime(2024, 1, 1);
          final endDate = DateTime(2024, 1, 7);

          // Act
          final result = await endpoints.nutritionPlan.createNutritionPlan(
            authenticatedSessionBuilder,
            userId: userProfile.id!,
            startDate: startDate,
            endDate: endDate,
            dailyCalories: 2000.0,
            dailyProteins: 120.0,
            dailyCarbs: 250.0,
            dailyFats: 70.0,
          );

          // Assert
          expect(result, isNotNull);
          expect(result.userProfileId, equals(userProfile.id!));
          expect(result.dailyCalories, equals(2000.0));
          expect(result.dailyProteins, equals(120.0));
          expect(result.dailyCarbs, equals(250.0));
          expect(result.dailyFats, equals(70.0));
          expect(result.status, equals(Status.active));
        },
      );

      test('should throw exception when calories are zero', () async {
        // Arrange
        await createTestUserProfile();

        // Act & Assert
        await expectLater(
          endpoints.nutritionPlan.createNutritionPlan(
            authenticatedSessionBuilder,
            userId: userId,
            startDate: DateTime(2024, 1, 1),
            endDate: DateTime(2024, 1, 7),
            dailyCalories: 0.0,
            dailyProteins: 120.0,
            dailyCarbs: 250.0,
            dailyFats: 70.0,
          ),
          throwsA(isA<AppException>()),
        );
      });

      test('should throw exception when proteins are zero', () async {
        // Arrange
        await createTestUserProfile();

        // Act & Assert
        await expectLater(
          endpoints.nutritionPlan.createNutritionPlan(
            authenticatedSessionBuilder,
            userId: userId,
            startDate: DateTime(2024, 1, 1),
            endDate: DateTime(2024, 1, 7),
            dailyCalories: 2000.0,
            dailyProteins: 0.0,
            dailyCarbs: 250.0,
            dailyFats: 70.0,
          ),
          throwsA(isA<AppException>()),
        );
      });

      test('should throw exception when carbs are zero', () async {
        // Arrange
        await createTestUserProfile();

        // Act & Assert
        await expectLater(
          endpoints.nutritionPlan.createNutritionPlan(
            authenticatedSessionBuilder,
            userId: userId,
            startDate: DateTime(2024, 1, 1),
            endDate: DateTime(2024, 1, 7),
            dailyCalories: 2000.0,
            dailyProteins: 120.0,
            dailyCarbs: 0.0,
            dailyFats: 70.0,
          ),
          throwsA(isA<AppException>()),
        );
      });

      test('should throw exception when fats are zero', () async {
        // Arrange
        await createTestUserProfile();

        // Act & Assert
        await expectLater(
          endpoints.nutritionPlan.createNutritionPlan(
            authenticatedSessionBuilder,
            userId: userId,
            startDate: DateTime(2024, 1, 1),
            endDate: DateTime(2024, 1, 7),
            dailyCalories: 2000.0,
            dailyProteins: 120.0,
            dailyCarbs: 250.0,
            dailyFats: 0.0,
          ),
          throwsA(isA<AppException>()),
        );
      });

      test(
        'should throw exception when daily calories are below 1200',
        () async {
          // Arrange
          await createTestUserProfile();

          // Act & Assert
          await expectLater(
            endpoints.nutritionPlan.createNutritionPlan(
              authenticatedSessionBuilder,
              userId: userId,
              startDate: DateTime(2024, 1, 1),
              endDate: DateTime(2024, 1, 7),
              dailyCalories: 1199.0,
              dailyProteins: 120.0,
              dailyCarbs: 250.0,
              dailyFats: 70.0,
            ),
            throwsA(isA<AppException>()),
          );
        },
      );

      test(
        'should throw exception when daily calories are above 5000',
        () async {
          // Arrange
          await createTestUserProfile();

          // Act & Assert
          await expectLater(
            endpoints.nutritionPlan.createNutritionPlan(
              authenticatedSessionBuilder,
              userId: userId,
              startDate: DateTime(2024, 1, 1),
              endDate: DateTime(2024, 1, 7),
              dailyCalories: 5001.0,
              dailyProteins: 120.0,
              dailyCarbs: 250.0,
              dailyFats: 70.0,
            ),
            throwsA(isA<AppException>()),
          );
        },
      );

      test(
        'should throw exception when end date is before start date',
        () async {
          // Arrange
          await createTestUserProfile();

          // Act & Assert
          await expectLater(
            endpoints.nutritionPlan.createNutritionPlan(
              authenticatedSessionBuilder,
              userId: userId,
              startDate: DateTime(2024, 1, 7),
              endDate: DateTime(2024, 1, 1),
              dailyCalories: 2000.0,
              dailyProteins: 120.0,
              dailyCarbs: 250.0,
              dailyFats: 70.0,
            ),
            throwsA(isA<AppException>()),
          );
        },
      );

      test('should throw exception when active plan already exists', () async {
        // Arrange
        await createTestUserProfile();
        await endpoints.nutritionPlan.createNutritionPlan(
          authenticatedSessionBuilder,
          userId: userId,
          startDate: DateTime(2024, 1, 1),
          endDate: DateTime(2024, 1, 7),
          dailyCalories: 2000.0,
          dailyProteins: 120.0,
          dailyCarbs: 250.0,
          dailyFats: 70.0,
        );

        // Act & Assert
        await expectLater(
          endpoints.nutritionPlan.createNutritionPlan(
            authenticatedSessionBuilder,
            userId: userId,
            startDate: DateTime(2024, 2, 1),
            endDate: DateTime(2024, 2, 7),
            dailyCalories: 2000.0,
            dailyProteins: 120.0,
            dailyCarbs: 250.0,
            dailyFats: 70.0,
          ),
          throwsA(isA<AppException>()),
        );
      });

      test('should throw exception when user not found', () async {
        // Arrange - no user profile created

        // Act & Assert
        await expectLater(
          endpoints.nutritionPlan.createNutritionPlan(
            authenticatedSessionBuilder,
            userId: userId,
            startDate: DateTime(2024, 1, 1),
            endDate: DateTime(2024, 1, 7),
            dailyCalories: 2000.0,
            dailyProteins: 120.0,
            dailyCarbs: 250.0,
            dailyFats: 70.0,
          ),
          throwsA(isA<AppException>()),
        );
      });
    });

    group('getNutritionPlanById', () {
      test(
        'should retrieve nutrition plan with includes successfully',
        () async {
          // Arrange
          await createTestUserProfile();
          final createdPlan = await endpoints.nutritionPlan.createNutritionPlan(
            authenticatedSessionBuilder,
            userId: userId,
            startDate: DateTime(2024, 1, 1),
            endDate: DateTime(2024, 1, 7),
            dailyCalories: 2000.0,
            dailyProteins: 120.0,
            dailyCarbs: 250.0,
            dailyFats: 70.0,
          );

          // Act
          final result = await endpoints.nutritionPlan.getNutritionPlanById(
            authenticatedSessionBuilder,
            createdPlan.id!,
          );

          // Assert
          expect(result, isNotNull);
          expect(result.id, equals(createdPlan.id));
          expect(result.mealPlans, isNotNull);
        },
      );

      test('should throw exception when nutrition plan not found', () async {
        // Arrange
        await createTestUserProfile();

        // Act & Assert
        await expectLater(
          endpoints.nutritionPlan.getNutritionPlanById(
            authenticatedSessionBuilder,
            99999,
          ),
          throwsA(isA<AppException>()),
        );
      });
    });

    group('createMealPlan', () {
      test(
        'should create meal plan successfully with multiple meals and foods',
        () async {
          // Arrange
          await createTestUserProfile();
          final nutritionPlan = await endpoints.nutritionPlan
              .createNutritionPlan(
                authenticatedSessionBuilder,
                userId: userId,
                startDate: DateTime(2024, 1, 1),
                endDate: DateTime(2024, 1, 7),
                dailyCalories: 2000.0,
                dailyProteins: 120.0,
                dailyCarbs: 250.0,
                dailyFats: 70.0,
              );

          final food = await createTestFood();
          final servingSize = await createTestServingSize(foodId: food.id!);

          final mealPlanDto = CreateMealPlanDto(
            nutritionPlanId: nutritionPlan.id!,
            date: DateTime(2024, 1, 1),
            dayNumber: 1,
            meals: [
              CreateMealPlanDetailDto(
                mealType: MealPlanType.breakfast,
                targetCalories: 500.0,
                targetProteins: 30.0,
                targetCarbs: 60.0,
                targetFats: 15.0,
                foods: [
                  CreateMealPlanFoodDto(
                    foodId: food.id!,
                    servingSizeId: servingSize.id!,
                    servingQuantity: 1.0,
                    quantityGrams: 100.0,
                    calories: 100.0,
                    proteins: 10.0,
                    carbs: 20.0,
                    fats: 5.0,
                  ),
                ],
              ),
            ],
          );

          // Act
          final result = await endpoints.nutritionPlan.createMealPlan(
            authenticatedSessionBuilder,
            mealPlanDto,
          );

          // Assert
          expect(result, isNotNull);
          expect(result.dayNumber, equals(1));
          expect(result.mealsCreated, equals(1));
          expect(result.totalFoodsAdded, equals(1));
          expect(result.actualTotals, isNotNull);
          expect(result.variance, isNotNull);
          expect(result.mealPlanIds, isNotEmpty);
        },
      );

      test('should calculate variance correctly', () async {
        // Arrange
        await createTestUserProfile();
        final nutritionPlan = await endpoints.nutritionPlan.createNutritionPlan(
          authenticatedSessionBuilder,
          userId: userId,
          startDate: DateTime(2024, 1, 1),
          endDate: DateTime(2024, 1, 7),
          dailyCalories: 2000.0,
          dailyProteins: 120.0,
          dailyCarbs: 250.0,
          dailyFats: 70.0,
        );

        final food = await createTestFood();
        final servingSize = await createTestServingSize(foodId: food.id!);

        final mealPlanDto = CreateMealPlanDto(
          nutritionPlanId: nutritionPlan.id!,
          date: DateTime(2024, 1, 1),
          dayNumber: 1,
          meals: [
            CreateMealPlanDetailDto(
              mealType: MealPlanType.breakfast,
              targetCalories: 500.0,
              targetProteins: 30.0,
              targetCarbs: 60.0,
              targetFats: 15.0,
              foods: [
                CreateMealPlanFoodDto(
                  foodId: food.id!,
                  servingSizeId: servingSize.id!,
                  servingQuantity: 1.0,
                  quantityGrams: 100.0,
                  calories: 100.0,
                  proteins: 10.0,
                  carbs: 20.0,
                  fats: 5.0,
                ),
              ],
            ),
          ],
        );

        // Act
        final result = await endpoints.nutritionPlan.createMealPlan(
          authenticatedSessionBuilder,
          mealPlanDto,
        );

        // Assert
        expect(result.variance, isNotNull);
        // Variance should be actual - target
        expect(result.variance.calories, equals(100.0 - 2000.0));
      });
    });

    group('updateNutritionPlanProgress', () {
      test('should update progress and post message to channel', () async {
        // Arrange
        await createTestUserProfile();
        final nutritionPlan = await endpoints.nutritionPlan.createNutritionPlan(
          authenticatedSessionBuilder,
          userId: userId,
          startDate: DateTime(2024, 1, 1),
          endDate: DateTime(2024, 1, 7),
          dailyCalories: 2000.0,
          dailyProteins: 120.0,
          dailyCarbs: 250.0,
          dailyFats: 70.0,
        );

        // Act
        final result = await endpoints.nutritionPlan
            .updateNutritionPlanProgress(
              authenticatedSessionBuilder,
              userId: userId,
              nutritionPlanId: nutritionPlan.id!,
              currentDay: 3,
              totalDays: 7,
              status: StreamStatus.waiting,
              message: 'Test progress update',
            );

        // Assert
        expect(result, isNotNull);
        expect(result.success, isTrue);
        expect(result.currentDay, equals(3));
        expect(result.totalDays, equals(7));
        expect(result.status, equals(StreamStatus.waiting));
        expect(result.message, equals('Test progress update'));
        expect(result.progressPercentage, closeTo(42.857, 0.001)); // 3/7 * 100
      });

      test(
        'should calculate progress percentage correctly for different statuses',
        () async {
          // Arrange
          await createTestUserProfile();
          final nutritionPlan = await endpoints.nutritionPlan
              .createNutritionPlan(
                authenticatedSessionBuilder,
                userId: userId,
                startDate: DateTime(2024, 1, 1),
                endDate: DateTime(2024, 1, 7),
                dailyCalories: 2000.0,
                dailyProteins: 120.0,
                dailyCarbs: 250.0,
                dailyFats: 70.0,
              );

          // Test completed status
          final completedResult = await endpoints.nutritionPlan
              .updateNutritionPlanProgress(
                authenticatedSessionBuilder,
                userId: userId,
                nutritionPlanId: nutritionPlan.id!,
                currentDay: 7,
                totalDays: 7,
                status: StreamStatus.completed,
                message: 'Completed',
              );

          expect(completedResult.status, equals(StreamStatus.completed));
          expect(completedResult.progressPercentage, equals(100.0));

          // Test error status
          final errorResult = await endpoints.nutritionPlan
              .updateNutritionPlanProgress(
                authenticatedSessionBuilder,
                userId: userId,
                nutritionPlanId: nutritionPlan.id!,
                currentDay: 0,
                totalDays: 7,
                status: StreamStatus.error,
                message: 'Error occurred',
              );

          expect(errorResult.status, equals(StreamStatus.error));
          expect(errorResult.progressPercentage, equals(0.0));
        },
      );
    });

    group('notifyErrorCreatingNutritionPlan', () {
      test('should post error message to channel', () async {
        // Arrange
        await createTestUserProfile();

        // Act - should not throw
        await endpoints.nutritionPlan.notifyErrorCreatingNutritionPlan(
          authenticatedSessionBuilder,
          userId,
        );

        // Assert - if no exception is thrown, the message was posted
        expect(true, isTrue);
      });
    });

    group('getActiveNutritionPlan', () {
      test(
        'should retrieve active nutrition plan with includes successfully',
        () async {
          // Arrange
          await createTestUserProfile();
          await endpoints.nutritionPlan.createNutritionPlan(
            authenticatedSessionBuilder,
            userId: userId,
            startDate: DateTime(2024, 1, 1),
            endDate: DateTime(2024, 1, 7),
            dailyCalories: 2000.0,
            dailyProteins: 120.0,
            dailyCarbs: 250.0,
            dailyFats: 70.0,
          );

          // Act
          final result = await endpoints.nutritionPlan.getActiveNutritionPlan(
            authenticatedSessionBuilder,
            userId,
          );

          // Assert
          expect(result, isNotNull);
          expect(result.userProfileId, equals(userId));
          expect(result.status, equals(Status.active));
          expect(result.mealPlans, isNotNull);
        },
      );

      test('should throw exception when no active plan found', () async {
        // Arrange
        await createTestUserProfile();

        // Act & Assert
        await expectLater(
          endpoints.nutritionPlan.getActiveNutritionPlan(
            authenticatedSessionBuilder,
            userId,
          ),
          throwsA(isA<AppException>()),
        );
      });
    });

    group('updateMealPlanFood', () {
      test(
        'should update meal plan food successfully with intake log updates',
        () async {
          // Arrange
          await createTestUserProfile();
          final nutritionPlan = await endpoints.nutritionPlan
              .createNutritionPlan(
                authenticatedSessionBuilder,
                userId: userId,
                startDate: DateTime(2024, 1, 1),
                endDate: DateTime(2024, 1, 7),
                dailyCalories: 2000.0,
                dailyProteins: 120.0,
                dailyCarbs: 250.0,
                dailyFats: 70.0,
              );

          final food = await createTestFood();
          final servingSize1 = await createTestServingSize(
            foodId: food.id!,
            name: '1 serving',
            grams: 100.0,
          );
          final servingSize2 = await createTestServingSize(
            foodId: food.id!,
            name: '2 servings',
            grams: 200.0,
          );

          final mealPlan = MealPlan(
            nutritionPlanId: nutritionPlan.id!,
            date: DateTime(2024, 1, 1),
            dayNumber: 1,
            mealType: MealPlanType.breakfast,
            targetCalories: 500.0,
            targetProteins: 30.0,
            targetCarbs: 60.0,
            targetFats: 15.0,
          );
          final session = authenticatedSessionBuilder.build();
          final createdMealPlan = await MealPlan.db.insertRow(
            session,
            mealPlan,
          );

          final mealPlanFood = MealPlanFood(
            mealPlanId: createdMealPlan.id!,
            foodId: food.id!,
            servingSizeId: servingSize1.id!,
            servingQuantity: 1.0,
            quantityGrams: 100.0,
          );
          final createdMealPlanFood = await MealPlanFood.db.insertRow(
            session,
            mealPlanFood,
          );

          // Create a food intake log for this meal plan food
          final intakeLog = FoodIntakeLog(
            userId: userId,
            mealPlanId: createdMealPlan.id!,
            foodId: food.id!,
            date: DateTime(2024, 1, 1),
            mealType: MealPlanType.breakfast,
            servingQuantity: 1.0,
            servingSizeId: servingSize1.id!,
            quantityGrams: 100.0,
          );
          await FoodIntakeLog.db.insertRow(session, intakeLog);

          final updateDto = UpdateMealPlanFoodDto(
            servingSizeId: servingSize2.id!,
            servingQuantity: 2.0,
            quantityGrams: 200.0,
          );

          // Act
          final result = await endpoints.nutritionPlan.updateMealPlanFood(
            authenticatedSessionBuilder,
            mealPlanFoodId: createdMealPlanFood.id!,
            updateDto: updateDto,
          );

          // Assert
          expect(result, isNotNull);
          expect(result.servingQuantity, equals(2.0));
          expect(result.quantityGrams, equals(200.0));
          expect(result.servingSizeId, equals(servingSize2.id));
          expect(result.isUserModified, isTrue);

          // Verify intake log was updated
          final updatedLogs = await FoodIntakeLog.db.find(
            session,
            where: (t) =>
                t.mealPlanId.equals(createdMealPlan.id!) &
                t.foodId.equals(food.id!),
          );
          expect(updatedLogs, isNotEmpty);
          expect(updatedLogs.first.servingQuantity, equals(2.0));
          expect(updatedLogs.first.quantityGrams, equals(200.0));
        },
      );

      test('should throw exception when quantity is invalid', () async {
        // Arrange
        final updateDto = UpdateMealPlanFoodDto(
          servingSizeId: 1,
          servingQuantity: 0.0,
          quantityGrams: 100.0,
        );

        // Act & Assert
        await expectLater(
          endpoints.nutritionPlan.updateMealPlanFood(
            authenticatedSessionBuilder,
            mealPlanFoodId: 1,
            updateDto: updateDto,
          ),
          throwsA(isA<AppException>()),
        );
      });

      test('should throw exception when meal plan food not found', () async {
        // Arrange
        final updateDto = UpdateMealPlanFoodDto(
          servingSizeId: 1,
          servingQuantity: 1.0,
          quantityGrams: 100.0,
        );

        // Act & Assert
        await expectLater(
          endpoints.nutritionPlan.updateMealPlanFood(
            authenticatedSessionBuilder,
            mealPlanFoodId: 99999,
            updateDto: updateDto,
          ),
          throwsA(isA<AppException>()),
        );
      });

      test('should throw exception when serving size not found', () async {
        // Arrange
        await createTestUserProfile();
        final nutritionPlan = await endpoints.nutritionPlan.createNutritionPlan(
          authenticatedSessionBuilder,
          userId: userId,
          startDate: DateTime(2024, 1, 1),
          endDate: DateTime(2024, 1, 7),
          dailyCalories: 2000.0,
          dailyProteins: 120.0,
          dailyCarbs: 250.0,
          dailyFats: 70.0,
        );

        final food = await createTestFood();
        final servingSize = await createTestServingSize(foodId: food.id!);

        final mealPlan = MealPlan(
          nutritionPlanId: nutritionPlan.id!,
          date: DateTime(2024, 1, 1),
          dayNumber: 1,
          mealType: MealPlanType.breakfast,
          targetCalories: 500.0,
          targetProteins: 30.0,
          targetCarbs: 60.0,
          targetFats: 15.0,
        );
        final session = authenticatedSessionBuilder.build();
        final createdMealPlan = await MealPlan.db.insertRow(session, mealPlan);

        final mealPlanFood = MealPlanFood(
          mealPlanId: createdMealPlan.id!,
          foodId: food.id!,
          servingSizeId: servingSize.id!,
          servingQuantity: 1.0,
          quantityGrams: 100.0,
        );
        final createdMealPlanFood = await MealPlanFood.db.insertRow(
          session,
          mealPlanFood,
        );

        final updateDto = UpdateMealPlanFoodDto(
          servingSizeId: 99999, // Non-existent serving size
          servingQuantity: 2.0,
          quantityGrams: 200.0,
        );

        // Act & Assert
        await expectLater(
          endpoints.nutritionPlan.updateMealPlanFood(
            authenticatedSessionBuilder,
            mealPlanFoodId: createdMealPlanFood.id!,
            updateDto: updateDto,
          ),
          throwsA(isA<AppException>()),
        );
      });

      test('should throw exception when serving size mismatch', () async {
        // Arrange
        final userProfile = await createTestUserProfile();
        final nutritionPlan = await endpoints.nutritionPlan.createNutritionPlan(
          authenticatedSessionBuilder,
          userId: userProfile.id!,
          startDate: DateTime(2024, 1, 1),
          endDate: DateTime(2024, 1, 7),
          dailyCalories: 2000.0,
          dailyProteins: 120.0,
          dailyCarbs: 250.0,
          dailyFats: 70.0,
        );

        final food1 = await createTestFood();
        final food2 = await createTestFood();
        final servingSize1 = await createTestServingSize(foodId: food1.id!);
        final servingSize2 = await createTestServingSize(foodId: food2.id!);

        final mealPlan = MealPlan(
          nutritionPlanId: nutritionPlan.id!,
          date: DateTime(2024, 1, 1),
          dayNumber: 1,
          mealType: MealPlanType.breakfast,
          targetCalories: 500.0,
          targetProteins: 30.0,
          targetCarbs: 60.0,
          targetFats: 15.0,
        );
        final session = authenticatedSessionBuilder.build();
        final createdMealPlan = await MealPlan.db.insertRow(session, mealPlan);

        final mealPlanFood = MealPlanFood(
          mealPlanId: createdMealPlan.id!,
          foodId: food1.id!,
          servingSizeId: servingSize1.id!,
          servingQuantity: 1.0,
          quantityGrams: 100.0,
        );
        final createdMealPlanFood = await MealPlanFood.db.insertRow(
          session,
          mealPlanFood,
        );

        final updateDto = UpdateMealPlanFoodDto(
          servingSizeId: servingSize2.id!, // Different food's serving size
          servingQuantity: 2.0,
          quantityGrams: 200.0,
        );

        // Act & Assert
        await expectLater(
          endpoints.nutritionPlan.updateMealPlanFood(
            authenticatedSessionBuilder,
            mealPlanFoodId: createdMealPlanFood.id!,
            updateDto: updateDto,
          ),
          throwsA(isA<AppException>()),
        );
      });
    });

    group('deleteMealPlanFood', () {
      test(
        'should soft delete meal plan food and delete intake logs successfully',
        () async {
          // Arrange
          await createTestUserProfile();
          final nutritionPlan = await endpoints.nutritionPlan
              .createNutritionPlan(
                authenticatedSessionBuilder,
                userId: userId,
                startDate: DateTime(2024, 1, 1),
                endDate: DateTime(2024, 1, 7),
                dailyCalories: 2000.0,
                dailyProteins: 120.0,
                dailyCarbs: 250.0,
                dailyFats: 70.0,
              );

          final food = await createTestFood();
          final servingSize = await createTestServingSize(foodId: food.id!);

          final mealPlan = MealPlan(
            nutritionPlanId: nutritionPlan.id!,
            date: DateTime(2024, 1, 1),
            dayNumber: 1,
            mealType: MealPlanType.breakfast,
            targetCalories: 500.0,
            targetProteins: 30.0,
            targetCarbs: 60.0,
            targetFats: 15.0,
          );
          final session = authenticatedSessionBuilder.build();
          final createdMealPlan = await MealPlan.db.insertRow(
            session,
            mealPlan,
          );

          final mealPlanFood = MealPlanFood(
            mealPlanId: createdMealPlan.id!,
            foodId: food.id!,
            servingSizeId: servingSize.id!,
            servingQuantity: 1.0,
            quantityGrams: 100.0,
          );
          final createdMealPlanFood = await MealPlanFood.db.insertRow(
            session,
            mealPlanFood,
          );

          // Create a food intake log for this meal plan food
          final intakeLog = FoodIntakeLog(
            userId: userId,
            mealPlanId: createdMealPlan.id!,
            foodId: food.id!,
            date: DateTime(2024, 1, 1),
            mealType: MealPlanType.breakfast,
            servingQuantity: 1.0,
            servingSizeId: servingSize.id!,
            quantityGrams: 100.0,
          );
          await FoodIntakeLog.db.insertRow(session, intakeLog);

          // Act
          final result = await endpoints.nutritionPlan.deleteMealPlanFood(
            authenticatedSessionBuilder,
            mealPlanFoodId: createdMealPlanFood.id!,
            userId: userId,
          );

          // Assert
          expect(result, isTrue);

          // Verify meal plan food was soft deleted
          final deletedFood = await MealPlanFood.db.findById(
            session,
            createdMealPlanFood.id!,
          );
          expect(deletedFood, isNotNull);
          expect(deletedFood!.wasUserDeleted, isTrue);
          expect(deletedFood.deletedAt, isNotNull);
          expect(deletedFood.deletedById, equals(userId));

          // Verify intake logs were deleted
          final remainingLogs = await FoodIntakeLog.db.find(
            session,
            where: (t) =>
                t.mealPlanId.equals(createdMealPlan.id!) &
                t.foodId.equals(food.id!),
          );
          expect(remainingLogs, isEmpty);
        },
      );

      test('should throw exception when meal plan food not found', () async {
        // Act & Assert
        await expectLater(
          endpoints.nutritionPlan.deleteMealPlanFood(
            authenticatedSessionBuilder,
            mealPlanFoodId: 99999,
            userId: userId,
          ),
          throwsA(isA<AppException>()),
        );
      });
    });

    group('addMealPlanFood', () {
      test('should add meal plan food successfully', () async {
        // Arrange
        await createTestUserProfile();
        final nutritionPlan = await endpoints.nutritionPlan.createNutritionPlan(
          authenticatedSessionBuilder,
          userId: userId,
          startDate: DateTime(2024, 1, 1),
          endDate: DateTime(2024, 1, 7),
          dailyCalories: 2000.0,
          dailyProteins: 120.0,
          dailyCarbs: 250.0,
          dailyFats: 70.0,
        );

        final food = await createTestFood();
        final servingSize = await createTestServingSize(foodId: food.id!);

        final mealPlan = MealPlan(
          nutritionPlanId: nutritionPlan.id!,
          date: DateTime(2024, 1, 1),
          dayNumber: 1,
          mealType: MealPlanType.breakfast,
          targetCalories: 500.0,
          targetProteins: 30.0,
          targetCarbs: 60.0,
          targetFats: 15.0,
        );
        final session = authenticatedSessionBuilder.build();
        final createdMealPlan = await MealPlan.db.insertRow(session, mealPlan);

        // Act
        final result = await endpoints.nutritionPlan.addMealPlanFood(
          authenticatedSessionBuilder,
          mealPlanId: createdMealPlan.id!,
          foodId: food.id!,
          servingSizeId: servingSize.id!,
          servingQuantity: 1.0,
          quantityGrams: 100.0,
        );

        // Assert
        expect(result, isNotNull);
        expect(result.mealPlanId, equals(createdMealPlan.id));
        expect(result.foodId, equals(food.id));
        expect(result.servingSizeId, equals(servingSize.id));
        expect(result.servingQuantity, equals(1.0));
        expect(result.quantityGrams, equals(100.0));
        expect(result.isUserModified, isTrue);
        expect(result.food, isNotNull);
        expect(result.servingSize, isNotNull);
      });

      test('should throw exception when quantity is invalid', () async {
        // Act & Assert
        await expectLater(
          endpoints.nutritionPlan.addMealPlanFood(
            authenticatedSessionBuilder,
            mealPlanId: 1,
            foodId: 1,
            servingSizeId: 1,
            servingQuantity: 0.0,
            quantityGrams: 100.0,
          ),
          throwsA(isA<AppException>()),
        );
      });

      test('should throw exception when meal plan not found', () async {
        // Arrange
        final food = await createTestFood();
        final servingSize = await createTestServingSize(foodId: food.id!);

        // Act & Assert
        await expectLater(
          endpoints.nutritionPlan.addMealPlanFood(
            authenticatedSessionBuilder,
            mealPlanId: 99999,
            foodId: food.id!,
            servingSizeId: servingSize.id!,
            servingQuantity: 1.0,
            quantityGrams: 100.0,
          ),
          throwsA(isA<AppException>()),
        );
      });

      test('should throw exception when food not found', () async {
        // Arrange
        await createTestUserProfile();
        final nutritionPlan = await endpoints.nutritionPlan.createNutritionPlan(
          authenticatedSessionBuilder,
          userId: userId,
          startDate: DateTime(2024, 1, 1),
          endDate: DateTime(2024, 1, 7),
          dailyCalories: 2000.0,
          dailyProteins: 120.0,
          dailyCarbs: 250.0,
          dailyFats: 70.0,
        );

        final mealPlan = MealPlan(
          nutritionPlanId: nutritionPlan.id!,
          date: DateTime(2024, 1, 1),
          dayNumber: 1,
          mealType: MealPlanType.breakfast,
          targetCalories: 500.0,
          targetProteins: 30.0,
          targetCarbs: 60.0,
          targetFats: 15.0,
        );
        final session = authenticatedSessionBuilder.build();
        final createdMealPlan = await MealPlan.db.insertRow(session, mealPlan);

        // Act & Assert
        await expectLater(
          endpoints.nutritionPlan.addMealPlanFood(
            authenticatedSessionBuilder,
            mealPlanId: createdMealPlan.id!,
            foodId: 99999,
            servingSizeId: 1,
            servingQuantity: 1.0,
            quantityGrams: 100.0,
          ),
          throwsA(isA<AppException>()),
        );
      });

      test('should throw exception when serving size not found', () async {
        // Arrange
        await createTestUserProfile();
        final nutritionPlan = await endpoints.nutritionPlan.createNutritionPlan(
          authenticatedSessionBuilder,
          userId: userId,
          startDate: DateTime(2024, 1, 1),
          endDate: DateTime(2024, 1, 7),
          dailyCalories: 2000.0,
          dailyProteins: 120.0,
          dailyCarbs: 250.0,
          dailyFats: 70.0,
        );

        final food = await createTestFood();

        final mealPlan = MealPlan(
          nutritionPlanId: nutritionPlan.id!,
          date: DateTime(2024, 1, 1),
          dayNumber: 1,
          mealType: MealPlanType.breakfast,
          targetCalories: 500.0,
          targetProteins: 30.0,
          targetCarbs: 60.0,
          targetFats: 15.0,
        );
        final session = authenticatedSessionBuilder.build();
        final createdMealPlan = await MealPlan.db.insertRow(session, mealPlan);

        // Act & Assert
        await expectLater(
          endpoints.nutritionPlan.addMealPlanFood(
            authenticatedSessionBuilder,
            mealPlanId: createdMealPlan.id!,
            foodId: food.id!,
            servingSizeId: 99999,
            servingQuantity: 1.0,
            quantityGrams: 100.0,
          ),
          throwsA(isA<AppException>()),
        );
      });

      test('should throw exception when serving size mismatch', () async {
        // Arrange
        await createTestUserProfile();
        final nutritionPlan = await endpoints.nutritionPlan.createNutritionPlan(
          authenticatedSessionBuilder,
          userId: userId,
          startDate: DateTime(2024, 1, 1),
          endDate: DateTime(2024, 1, 7),
          dailyCalories: 2000.0,
          dailyProteins: 120.0,
          dailyCarbs: 250.0,
          dailyFats: 70.0,
        );

        final food1 = await createTestFood();
        final food2 = await createTestFood();
        final servingSize2 = await createTestServingSize(foodId: food2.id!);

        final mealPlan = MealPlan(
          nutritionPlanId: nutritionPlan.id!,
          date: DateTime(2024, 1, 1),
          dayNumber: 1,
          mealType: MealPlanType.breakfast,
          targetCalories: 500.0,
          targetProteins: 30.0,
          targetCarbs: 60.0,
          targetFats: 15.0,
        );
        final session = authenticatedSessionBuilder.build();
        final createdMealPlan = await MealPlan.db.insertRow(session, mealPlan);

        // Act & Assert
        await expectLater(
          endpoints.nutritionPlan.addMealPlanFood(
            authenticatedSessionBuilder,
            mealPlanId: createdMealPlan.id!,
            foodId: food1.id!,
            servingSizeId: servingSize2.id!, // Serving size from different food
            servingQuantity: 1.0,
            quantityGrams: 100.0,
          ),
          throwsA(isA<AppException>()),
        );
      });

      test('should throw exception when food already in meal plan', () async {
        // Arrange
        await createTestUserProfile();
        final nutritionPlan = await endpoints.nutritionPlan.createNutritionPlan(
          authenticatedSessionBuilder,
          userId: userId,
          startDate: DateTime(2024, 1, 1),
          endDate: DateTime(2024, 1, 7),
          dailyCalories: 2000.0,
          dailyProteins: 120.0,
          dailyCarbs: 250.0,
          dailyFats: 70.0,
        );

        final food = await createTestFood();
        final servingSize = await createTestServingSize(foodId: food.id!);

        final mealPlan = MealPlan(
          nutritionPlanId: nutritionPlan.id!,
          date: DateTime(2024, 1, 1),
          dayNumber: 1,
          mealType: MealPlanType.breakfast,
          targetCalories: 500.0,
          targetProteins: 30.0,
          targetCarbs: 60.0,
          targetFats: 15.0,
        );
        final session = authenticatedSessionBuilder.build();
        final createdMealPlan = await MealPlan.db.insertRow(session, mealPlan);

        // Add food first time
        await endpoints.nutritionPlan.addMealPlanFood(
          authenticatedSessionBuilder,
          mealPlanId: createdMealPlan.id!,
          foodId: food.id!,
          servingSizeId: servingSize.id!,
          servingQuantity: 1.0,
          quantityGrams: 100.0,
        );

        // Act & Assert - try to add same food again
        await expectLater(
          endpoints.nutritionPlan.addMealPlanFood(
            authenticatedSessionBuilder,
            mealPlanId: createdMealPlan.id!,
            foodId: food.id!,
            servingSizeId: servingSize.id!,
            servingQuantity: 2.0,
            quantityGrams: 200.0,
          ),
          throwsA(isA<AppException>()),
        );
      });
    });
  });
}
