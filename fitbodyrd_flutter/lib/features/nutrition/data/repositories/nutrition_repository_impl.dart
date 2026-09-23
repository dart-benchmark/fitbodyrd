import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/nutrition/domain/repositories/nutrition_repository.dart';
import 'package:record_result/record_result.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

class NutritionRepositoryImpl implements NutritionRepository {
  NutritionRepositoryImpl({
    required this.client,
    required this.sessionManager,
  });
  final Client client;
  final SessionManager sessionManager;

  int get _userId {
    final user = sessionManager.signedInUser;
    if (user == null || user.id == null) {
      throw Exception('User not signed in');
    }
    return user.id!;
  }

  @override
  FutureResult<NutritionPlan> getActiveNutritionPlan() async {
    try {
      final result = await client.nutritionPlan.getActiveNutritionPlan(_userId);
      return right(result);
    } on AppException catch (e) {
      return left(ServerFailure(statusCode: e.errorCode, message: e.message));
    }
  }

  @override
  Stream<GenerateNutritionPlanProgressDto> requestNutritionPlanGeneration({
    required int weeks,
    required List<MealPlanType> mealTypes,
  }) {
    return client.nutritionPlan.requestNutritionPlanGeneration(
      _userId,
      weeks,
      mealTypes,
    );
  }

  @override
  FutureResult<List<FoodIntakeLog>> getFoodIntakeLogs(DateTime date) async {
    try {
      final result = await client.foodIntakeLog.getByDate(date);
      return right(result);
    } on AppException catch (e) {
      return left(ServerFailure(statusCode: e.errorCode, message: e.message));
    } on Exception catch (e) {
      return left(ServerFailure(statusCode: 500, message: e.toString()));
    }
  }

  @override
  FutureResult<FoodIntakeLog> logFoodIntake(CreateFoodIntakeLog dto) async {
    try {
      final result = await client.foodIntakeLog.create(dto);
      return right(result);
    } on AppException catch (e) {
      return left(ServerFailure(statusCode: e.errorCode, message: e.message));
    } on Exception catch (e) {
      return left(ServerFailure(statusCode: 500, message: e.toString()));
    }
  }

  @override
  FutureResult<void> deleteFoodIntakeLog(int id) async {
    try {
      await client.foodIntakeLog.delete(id);
      return right(null);
    } on AppException catch (e) {
      return left(ServerFailure(statusCode: e.errorCode, message: e.message));
    } on Exception catch (e) {
      return left(ServerFailure(statusCode: 500, message: e.toString()));
    }
  }

  @override
  FutureResult<MealPlanFood> updateMealPlanFood({
    required int mealPlanFoodId,
    required double servingQuantity,
    required int servingSizeId,
    required double quantityGrams,
  }) async {
    try {
      final updateDto = UpdateMealPlanFoodDto(
        servingQuantity: servingQuantity,
        servingSizeId: servingSizeId,
        quantityGrams: quantityGrams,
      );
      final result = await client.nutritionPlan.updateMealPlanFood(
        mealPlanFoodId: mealPlanFoodId,
        updateDto: updateDto,
      );
      return right(result);
    } on AppException catch (e) {
      return left(ServerFailure(statusCode: e.errorCode, message: e.message));
    } on Exception catch (e) {
      return left(ServerFailure(statusCode: 500, message: e.toString()));
    }
  }

  @override
  FutureResult<bool> deleteMealPlanFood({
    required int mealPlanFoodId,
  }) async {
    try {
      final result = await client.nutritionPlan.deleteMealPlanFood(
        mealPlanFoodId: mealPlanFoodId,
        userId: _userId,
      );
      return right(result);
    } on AppException catch (e) {
      return left(ServerFailure(statusCode: e.errorCode, message: e.message));
    } on Exception catch (e) {
      return left(ServerFailure(statusCode: 500, message: e.toString()));
    }
  }

  @override
  FutureResult<List<Food>> searchFoods({
    required String query,
    int? categoryId,
    int? limit,
  }) async {
    try {
      final result = await client.food.searchFoodsV2(
        query: query,
        categoryId: categoryId,
        limit: limit,
      );
      return right(result.foods);
    } on AppException catch (e) {
      return left(ServerFailure(statusCode: e.errorCode, message: e.message));
    } on Exception catch (e) {
      return left(ServerFailure(statusCode: 500, message: e.toString()));
    }
  }

  @override
  FutureResult<MealPlanFood> addMealPlanFood({
    required int mealPlanId,
    required int foodId,
    required int servingSizeId,
    required double servingQuantity,
    required double quantityGrams,
  }) async {
    try {
      final result = await client.nutritionPlan.addMealPlanFood(
        mealPlanId: mealPlanId,
        foodId: foodId,
        servingSizeId: servingSizeId,
        servingQuantity: servingQuantity,
        quantityGrams: quantityGrams,
      );
      return right(result);
    } on AppException catch (e) {
      return left(ServerFailure(statusCode: e.errorCode, message: e.message));
    } on Exception catch (e) {
      return left(ServerFailure(statusCode: 500, message: e.toString()));
    }
  }
}
