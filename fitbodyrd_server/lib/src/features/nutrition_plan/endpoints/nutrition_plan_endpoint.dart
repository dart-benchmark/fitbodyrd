import 'dart:async';
import 'dart:convert';

import 'package:fitbodyrd_server/src/core/agent_client/agent_client.dart';
import 'package:fitbodyrd_server/src/core/injections/injection_container.dart';
import 'package:fitbodyrd_server/src/features/food/exceptions/food_exceptions.dart';
import 'package:fitbodyrd_server/src/features/nutrition_plan/exceptions/nutrition_plan_exceptions.dart';
import 'package:fitbodyrd_server/src/features/nutrition_plan/utils/nutrition_plan_utils.dart';
import 'package:fitbodyrd_server/src/features/user/endpoints/admin_user_endpoint.dart';
import 'package:fitbodyrd_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class NutritionPlanEndpoint extends Endpoint {
  String getCreateNutritionPlanChannelName(int userId) {
    return 'create_nutrition_plan_$userId';
  }

  Future<NutritionPlan> createNutritionPlan(
    Session session, {
    required int userId,
    required DateTime startDate,
    required DateTime endDate,
    required double dailyCalories,
    required double dailyProteins,
    required double dailyCarbs,
    required double dailyFats,
  }) async {
    if (dailyCalories <= 0 ||
        dailyProteins <= 0 ||
        dailyCarbs <= 0 ||
        dailyFats <= 0) {
      throw NutritionPlanExceptions.invalidNutritionValues();
    }

    if (dailyCalories < 1200 || dailyCalories > 5000) {
      throw NutritionPlanExceptions.invalidDailyCalories(dailyCalories);
    }

    if (endDate.isBefore(startDate)) {
      throw NutritionPlanExceptions.invalidDateRange(startDate, endDate);
    }

    await AdminUserEndpoint().findUserProfile(session, userId);

    final existingPlansCount = await NutritionPlan.db.count(
      session,
      where: (t) =>
          t.userProfileId.equals(userId) & t.status.equals(Status.active),
    );

    if (existingPlansCount > 0) {
      throw NutritionPlanExceptions.activePlanAlreadyExists(userId);
    }

    final nutritionPlan = NutritionPlan(
      userProfileId: userId,
      startDate: startDate,
      endDate: endDate,
      dailyCalories: dailyCalories,
      dailyProteins: dailyProteins,
      dailyCarbs: dailyCarbs,
      dailyFats: dailyFats,
      status: Status.active,
    );

    final createdPlan =
        await NutritionPlan.db.insertRow(session, nutritionPlan);

    return createdPlan;
  }

  Future<NutritionPlan> getNutritionPlanById(
    Session session,
    int planId,
  ) async {
    final nutritionPlan = await NutritionPlan.db.findById(
      session,
      planId,
      include: NutritionPlan.include(
        mealPlans: MealPlan.includeList(
          include: MealPlan.include(
            mealPlanFoods: MealPlanFood.includeList(
              where: (t) => t.wasUserDeleted.equals(false),
              orderBy: (t) => t.id,
              include: MealPlanFood.include(
                food: Food.include(),
                servingSize: FoodServingSize.include(),
              ),
            ),
          ),
        ),
      ),
    );

    if (nutritionPlan == null) {
      throw NutritionPlanExceptions.nutritionPlanNotFound(planId);
    }

    return nutritionPlan;
  }

  Future<CreatedMealPlanDto> createMealPlan(
    Session session,
    CreateMealPlanDto mealPlanDto,
  ) async {
    final nutritionPlan = await getNutritionPlanById(
      session,
      mealPlanDto.nutritionPlanId,
    );

    session.log(
      'Creating meal plan for nutrition plan ID ${nutritionPlan.id} for'
      ' day ${mealPlanDto.dayNumber} on date ${mealPlanDto.date}, mealTypes:'
      ' ${mealPlanDto.meals.map((meal) => meal.mealType).join(', ')}',
      level: LogLevel.info,
    );

    final totalDays =
        nutritionPlan.endDate.difference(nutritionPlan.startDate).inDays + 1;

    int mealsCreated = 0;
    int totalFoodsAdded = 0;
    CreatedMealPlanTotalsDto actualTotals = CreatedMealPlanTotalsDto(
      calories: 0,
      proteins: 0,
      carbs: 0,
      fats: 0,
    );
    List<CreatedMealPlanIdDto> mealPlanIds = [];

    try {
      await session.db.transaction(
        (transaction) async {
          for (var mealDetailDto in mealPlanDto.meals) {
            final mealPlan = MealPlan(
              nutritionPlanId: nutritionPlan.id!,
              date: mealPlanDto.date,
              dayNumber: mealPlanDto.dayNumber,
              mealType: mealDetailDto.mealType,
              targetCalories: mealDetailDto.targetCalories,
              targetProteins: mealDetailDto.targetProteins,
              targetCarbs: mealDetailDto.targetCarbs,
              targetFats: mealDetailDto.targetFats,
            );

            final createdMealPlan = await MealPlan.db.insertRow(
              session,
              mealPlan,
              transaction: transaction,
            );

            mealsCreated++;

            final mealPlanFoods = <MealPlanFood>[];

            for (var foodDto in mealDetailDto.foods) {
              final mealPlanFood = MealPlanFood(
                mealPlanId: createdMealPlan.id!,
                foodId: foodDto.foodId,
                servingSizeId: foodDto.servingSizeId,
                servingQuantity: foodDto.servingQuantity,
                quantityGrams: foodDto.quantityGrams,
              );

              totalFoodsAdded++;

              actualTotals.calories += foodDto.calories;
              actualTotals.proteins += foodDto.proteins;
              actualTotals.carbs += foodDto.carbs;
              actualTotals.fats += foodDto.fats;
              mealPlanFoods.add(mealPlanFood);
            }

            await MealPlanFood.db.insert(
              session,
              mealPlanFoods,
              transaction: transaction,
            );

            mealPlanIds.add(
              CreatedMealPlanIdDto(
                mealType: mealDetailDto.mealType,
                id: createdMealPlan.id!,
              ),
            );
          }
        },
      );
    } on DatabaseQueryException catch (e) {
      session.log(
        'Database error creating meal plan for nutrition plan ID ${nutritionPlan.id}: $e',
        level: LogLevel.error,
      );
      throw NutritionPlanExceptions.databaseException(e);
    }

    final variance = NutritionPlanUtils.calculateVariance(
      actual: actualTotals,
      target: nutritionPlan,
    );

    unawaited(
      updateNutritionPlanProgress(
        session,
        userId: nutritionPlan.userProfileId,
        nutritionPlanId: nutritionPlan.id!,
        currentDay: mealPlanDto.dayNumber,
        totalDays: totalDays,
        status: StreamStatus.waiting,
        message: 'Meal plan created for day ${mealPlanDto.dayNumber}',
      ),
    );

    final createdMealPlanDto = CreatedMealPlanDto(
      dayNumber: mealPlanDto.dayNumber,
      date: mealPlanDto.date,
      mealsCreated: mealsCreated,
      totalFoodsAdded: totalFoodsAdded,
      actualTotals: actualTotals,
      variance: variance,
      mealPlanIds: mealPlanIds,
    );

    session.log(
      'Created meal plan for nutrition plan ID ${nutritionPlan.id}: ${jsonEncode(createdMealPlanDto.toJson())}',
      level: LogLevel.info,
    );

    return createdMealPlanDto;
  }

  Future<GenerateNutritionPlanProgressDto> updateNutritionPlanProgress(
    Session session, {
    required int userId,
    required int nutritionPlanId,
    required int currentDay,
    required int totalDays,
    required StreamStatus status,
    required String message,
  }) async {
    session.log(
      'Updating nutrition plan progress for user ID $userId: Day $currentDay of $totalDays, Status: $status, Message: $message',
      level: LogLevel.info,
    );

    final progressPercentage = NutritionPlanUtils.calculateProgressPercentage(
      daysCompleted: currentDay,
      totalDays: totalDays,
    );
    final progress = GenerateNutritionPlanProgressDto(
      success: true,
      progressPercentage: progressPercentage,
      currentDay: currentDay,
      totalDays: totalDays,
      status: status,
      message: message,
      updatedAt: DateTime.now(),
    );

    await session.messages.postMessage(
      getCreateNutritionPlanChannelName(userId),
      progress,
    );

    return progress;
  }

  Stream<GenerateNutritionPlanProgressDto> requestNutritionPlanGeneration(
    Session session,
    int userId,
    int weeks,
    List<MealPlanType> mealTypes,
  ) async* {
    yield GenerateNutritionPlanProgressDto(
      success: true,
      progressPercentage: 0,
      currentDay: 0,
      totalDays: 0,
      status: StreamStatus.waiting,
      message: 'Requesting nutrition plan generation...',
      updatedAt: DateTime.now(),
    );

    final activeNutritionPlan = await NutritionPlan.db.findFirstRow(
      session,
      where: (t) =>
          t.userProfileId.equals(userId) & t.status.equals(Status.active),
    );
    if (activeNutritionPlan != null) {
      await NutritionPlan.db.updateRow(
          session,
          activeNutritionPlan.copyWith(
            status: Status.cancelled,
          ));

      // throw NutritionPlanExceptions.activePlanAlreadyExists(userId);
    }

    try {
      await sl<AgentClient>().sendCreateNutritionPlanRequest(
        userId: userId,
        weeks: weeks,
        mealTypes: mealTypes,
      );
    } catch (e) {
      session.log('Error requesting nutrition plan generation: $e',
          level: LogLevel.error);
      yield GenerateNutritionPlanProgressDto(
        success: false,
        progressPercentage: 0,
        currentDay: 0,
        totalDays: 0,
        status: StreamStatus.error,
        message: 'Error requesting nutrition plan generation.',
        updatedAt: DateTime.now(),
      );
    }

    final channelName = getCreateNutritionPlanChannelName(userId);
    final stream = session.messages
        .createStream<GenerateNutritionPlanProgressDto>(channelName);

    await for (final progress in stream) {
      yield progress;
      if (progress.status == StreamStatus.completed ||
          progress.status == StreamStatus.error) {
        return;
      }
    }
  }

  Future<void> notifyErrorCreatingNutritionPlan(
    Session session,
    int userId,
  ) async {
    await session.messages.postMessage(
      getCreateNutritionPlanChannelName(userId),
      GenerateNutritionPlanProgressDto(
        success: false,
        progressPercentage: 0,
        currentDay: 0,
        totalDays: 0,
        status: StreamStatus.error,
        message: 'Error creating nutrition plan.',
        updatedAt: DateTime.now(),
      ),
    );
  }

  Future<NutritionPlan> getActiveNutritionPlan(
    Session session,
    int userId,
  ) async {
    final nutritionPlan = await NutritionPlan.db.findFirstRow(
      session,
      where: (t) =>
          t.userProfileId.equals(userId) & t.status.equals(Status.active),
      include: NutritionPlan.include(
        mealPlans: MealPlan.includeList(
          include: MealPlan.include(
            mealPlanFoods: MealPlanFood.includeList(
              where: (t) => t.wasUserDeleted.equals(false),
              orderBy: (t) => t.id,
              include: MealPlanFood.include(
                food: Food.include(
                  servingSizes: FoodServingSize.includeList(),
                ),
                servingSize: FoodServingSize.include(),
              ),
            ),
          ),
        ),
      ),
    );

    if (nutritionPlan == null) {
      throw NutritionPlanExceptions.noActiveNutritionPlan(userId);
    }

    return nutritionPlan;
  }

  Future<MealPlanFood> updateMealPlanFood(
    Session session, {
    required int mealPlanFoodId,
    required UpdateMealPlanFoodDto updateDto,
  }) async {
    // Validate input
    if (updateDto.servingQuantity <= 0 || updateDto.quantityGrams <= 0) {
      throw NutritionPlanExceptions.invalidQuantity();
    }

    // Find the existing meal plan food
    final existingFood = await MealPlanFood.db.findById(
      session,
      mealPlanFoodId,
      include: MealPlanFood.include(
        food: Food.include(),
        servingSize: FoodServingSize.include(),
        mealPlan: MealPlan.include(),
      ),
    );

    if (existingFood == null) {
      throw NutritionPlanExceptions.mealPlanFoodNotFound(mealPlanFoodId);
    }

    // Check if the serving size exists and belongs to the same food
    final servingSize = await FoodServingSize.db.findById(
      session,
      updateDto.servingSizeId,
    );

    if (servingSize == null) {
      throw NutritionPlanExceptions.servingSizeNotFound(
          updateDto.servingSizeId);
    }

    if (servingSize.foodId != existingFood.foodId) {
      throw NutritionPlanExceptions.servingSizeMismatch(
        servingSize.foodId,
        existingFood.foodId,
      );
    }

    // Update the meal plan food and related intake logs in a transaction
    return await session.db.transaction((transaction) async {
      // Update the meal plan food
      existingFood.servingQuantity = updateDto.servingQuantity;
      existingFood.servingSizeId = updateDto.servingSizeId;
      existingFood.quantityGrams = updateDto.quantityGrams;
      existingFood.isUserModified = true;
      existingFood.updatedAt = DateTime.now();

      await MealPlanFood.db
          .updateRow(session, existingFood, transaction: transaction);

      // Also update any food intake logs for this meal plan food
      // so that consumed macros reflect the new quantities
      final intakeLogs = await FoodIntakeLog.db.find(
        session,
        where: (t) =>
            t.mealPlanId.equals(existingFood.mealPlanId) &
            t.foodId.equals(existingFood.foodId),
        transaction: transaction,
      );

      for (final log in intakeLogs) {
        log.servingQuantity = updateDto.servingQuantity;
        log.servingSizeId = updateDto.servingSizeId;
        log.quantityGrams = updateDto.quantityGrams;
        await FoodIntakeLog.db
            .updateRow(session, log, transaction: transaction);
      }

      // Reload with relations
      return await MealPlanFood.db.findById(
            session,
            mealPlanFoodId,
            include: MealPlanFood.include(
              food: Food.include(),
              servingSize: FoodServingSize.include(),
            ),
            transaction: transaction,
          ) ??
          existingFood;
    });
  }

  Future<bool> deleteMealPlanFood(
    Session session, {
    required int mealPlanFoodId,
    required int userId,
  }) async {
    // Find the existing meal plan food
    final existingFood = await MealPlanFood.db.findById(
      session,
      mealPlanFoodId,
    );

    if (existingFood == null) {
      throw NutritionPlanExceptions.mealPlanFoodNotFound(mealPlanFoodId);
    }

    // Soft delete the meal plan food and delete related intake logs in a transaction
    return await session.db.transaction((transaction) async {
      // Soft delete by setting wasUserDeleted flag
      existingFood.wasUserDeleted = true;
      existingFood.deletedAt = DateTime.now();
      existingFood.deletedById = userId;

      await MealPlanFood.db.updateRow(
        session,
        existingFood,
        transaction: transaction,
      );

      // Also delete any food intake logs for this meal plan food
      // so that consumed macros reflect the deletion
      final intakeLogs = await FoodIntakeLog.db.find(
        session,
        where: (t) =>
            t.mealPlanId.equals(existingFood.mealPlanId) &
            t.foodId.equals(existingFood.foodId),
        transaction: transaction,
      );

      for (final log in intakeLogs) {
        await FoodIntakeLog.db
            .deleteRow(session, log, transaction: transaction);
      }

      return true;
    });
  }

  Future<MealPlanFood> addMealPlanFood(
    Session session, {
    required int mealPlanId,
    required int foodId,
    required int servingSizeId,
    required double servingQuantity,
    required double quantityGrams,
  }) async {
    // Validate input
    if (servingQuantity <= 0 || quantityGrams <= 0) {
      throw NutritionPlanExceptions.invalidQuantity();
    }

    // Verify meal plan exists
    final mealPlan = await MealPlan.db.findById(session, mealPlanId);
    if (mealPlan == null) {
      throw NutritionPlanExceptions.mealPlanNotFound(mealPlanId);
    }

    // Verify food exists
    final food = await Food.db.findById(session, foodId);
    if (food == null) {
      throw FoodExceptions.foodNotFound(foodId);
    }

    // Verify serving size exists and belongs to food
    final servingSize =
        await FoodServingSize.db.findById(session, servingSizeId);
    if (servingSize == null) {
      throw FoodExceptions.servingSizeNotFound(servingSizeId);
    }
    if (servingSize.foodId != foodId) {
      throw NutritionPlanExceptions.servingSizeMismatch(
          servingSize.foodId, foodId);
    }

    // Check if food already exists in this meal plan
    final existingFood = await MealPlanFood.db.findFirstRow(
      session,
      where: (t) =>
          t.mealPlanId.equals(mealPlanId) &
          t.foodId.equals(foodId) &
          t.wasUserDeleted.equals(false),
    );

    if (existingFood != null) {
      throw NutritionPlanExceptions.foodAlreadyInMealPlan(
        foodId,
        mealPlanId,
      );
    }

    return await session.db.transaction((transaction) async {
      final newMealPlanFood = MealPlanFood(
        mealPlanId: mealPlanId,
        foodId: foodId,
        servingSizeId: servingSizeId,
        servingQuantity: servingQuantity,
        quantityGrams: quantityGrams,
        isUserModified: true,
      );

      final insertedFood = await MealPlanFood.db.insertRow(
        session,
        newMealPlanFood,
        transaction: transaction,
      );

      // Reload with relations
      return await MealPlanFood.db.findById(
        session,
        insertedFood.id!,
        include: MealPlanFood.include(
          food: Food.include(),
          servingSize: FoodServingSize.include(),
        ),
        transaction: transaction,
      ) as MealPlanFood;
    });
  }
}
