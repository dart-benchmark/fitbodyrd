import 'dart:async';

import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/nutrition/data/repositories/nutrition_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:record_result/record_result.dart';
import 'package:serverpod_auth_client/serverpod_auth_client.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

// Mock classes
class MockClient extends Mock implements Client {}

class MockSessionManager extends Mock implements SessionManager {}

class MockEndpointNutritionPlan extends Mock implements EndpointNutritionPlan {}

class MockEndpointFoodIntakeLog extends Mock implements EndpointFoodIntakeLog {}

class MockEndpointFood extends Mock implements EndpointFood {}

// Mock UserInfo for SessionManager

// Helper functions for mock data
NutritionPlan createMockNutritionPlan() {
  final today = DateTime(2024, 6, 15);
  return NutritionPlan(
    id: 1,
    userProfileId: 1,
    startDate: today.subtract(const Duration(days: 7)),
    endDate: today.add(const Duration(days: 7)),
    dailyCalories: 2000,
    dailyProteins: 150,
    dailyCarbs: 200,
    dailyFats: 60,
    status: Status.active,
    mealPlans: [],
  );
}

FoodIntakeLog createMockFoodLog({
  int id = 1,
  int foodId = 1,
  DateTime? date,
}) {
  return FoodIntakeLog(
    id: id,
    userId: 1,
    foodId: foodId,
    date: date ?? DateTime(2024, 6, 15),
    mealType: MealPlanType.breakfast,
    servingQuantity: 1.0,
    quantityGrams: 100.0,
    food: Food(
      id: foodId,
      name: 'Test Food',
      categoryId: 1,
      calories: 100.0,
      proteins: 10.0,
      carbs: 20.0,
      fats: 5.0,
      fiber: 2.0,
    ),
  );
}

MealPlanFood createMockMealPlanFood({
  int id = 1,
  int foodId = 1,
}) {
  return MealPlanFood(
    id: id,
    mealPlanId: 1,
    foodId: foodId,
    servingSizeId: 1,
    servingQuantity: 1.0,
    quantityGrams: 100.0,
    food: Food(
      id: foodId,
      name: 'Test Food',
      categoryId: 1,
      calories: 100.0,
      proteins: 10.0,
      carbs: 20.0,
      fats: 5.0,
      fiber: 2.0,
    ),
  );
}

Food createMockFood({int id = 1, String name = 'Test Food'}) {
  return Food(
    id: id,
    name: name,
    categoryId: 1,
    calories: 100.0,
    proteins: 10.0,
    carbs: 20.0,
    fats: 5.0,
    fiber: 2.0,
  );
}

void main() {
  group('NutritionRepositoryImpl', () {
    late NutritionRepositoryImpl repository;
    late MockClient mockClient;
    late MockSessionManager mockSessionManager;
    late MockEndpointNutritionPlan mockEndpointNutritionPlan;
    late MockEndpointFoodIntakeLog mockEndpointFoodIntakeLog;
    late MockEndpointFood mockEndpointFood;

    setUp(() {
      mockClient = MockClient();
      mockSessionManager = MockSessionManager();
      mockEndpointNutritionPlan = MockEndpointNutritionPlan();
      mockEndpointFoodIntakeLog = MockEndpointFoodIntakeLog();
      mockEndpointFood = MockEndpointFood();

      when(() => mockClient.nutritionPlan)
          .thenReturn(mockEndpointNutritionPlan);
      when(() => mockClient.foodIntakeLog)
          .thenReturn(mockEndpointFoodIntakeLog);
      when(() => mockClient.food).thenReturn(mockEndpointFood);

      // Mock signed in user - signedInUser returns a
      // UserInfo from serverpod_auth_shared_flutter
      when(() => mockSessionManager.signedInUser).thenReturn(
        UserInfo(
          id: 1,
          userIdentifier: 'test_user_1',
          userName: 'test_user',
          email: 'test@example.com',
          created: DateTime(2024),
          scopeNames: ['user'],
          blocked: false,
        ),
      );

      registerFallbackValue(Object());

      registerFallbackValue(
        CreateFoodIntakeLog(
          foodId: 1,
          date: DateTime(2024),
          mealType: MealPlanType.breakfast,
          servingQuantity: 1.0,
          quantityGrams: 100.0,
        ),
      );

      registerFallbackValue(
        UpdateMealPlanFoodDto(
          servingQuantity: 1.0,
          servingSizeId: 1,
          quantityGrams: 100.0,
        ),
      );

      repository = NutritionRepositoryImpl(
        client: mockClient,
        sessionManager: mockSessionManager,
      );
    });

    group('getActiveNutritionPlan', () {
      test('should return NutritionPlan on success', () async {
        // Arrange
        final mockPlan = createMockNutritionPlan();
        when(() => mockEndpointNutritionPlan.getActiveNutritionPlan(any()))
            .thenAnswer((_) async => mockPlan);

        // Act
        final result = await repository.getActiveNutritionPlan();

        // Assert
        result.fold(
          (plan) {
            expect(plan, equals(mockPlan));
            expect(plan?.id, equals(1));
          },
          (failure) =>
              fail('Expected success, but got failure: ${failure.message}'),
        );
        verify(() => mockEndpointNutritionPlan.getActiveNutritionPlan(1))
            .called(1);
      });

      test('should return ServerFailure when AppException is thrown', () async {
        // Arrange
        final appException = AppException(
          module: 'nutrition',
          message: 'No active plan found',
          errorCode: 5001,
          httpStatus: 404,
        );
        when(() => mockEndpointNutritionPlan.getActiveNutritionPlan(any()))
            .thenThrow(appException);

        // Act
        final result = await repository.getActiveNutritionPlan();

        // Assert
        result.fold(
          (plan) => fail('Expected failure, but got success: $plan'),
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.statusCode, equals(5001));
            expect(failure.message, equals('No active plan found'));
          },
        );
      });
    });

    group('getFoodIntakeLogs', () {
      test('should return list of FoodIntakeLog on success', () async {
        // Arrange
        final targetDate = DateTime(2024, 6, 15);
        final mockLogs = [
          createMockFoodLog(date: targetDate),
          createMockFoodLog(id: 2, date: targetDate),
        ];
        when(() => mockEndpointFoodIntakeLog.getByDate(any()))
            .thenAnswer((_) async => mockLogs);

        // Act
        final result = await repository.getFoodIntakeLogs(targetDate);

        // Assert
        result.fold(
          (logs) {
            expect(logs?.length, equals(2));
            expect(logs?.first.id, equals(1));
            expect(logs?.last.id, equals(2));
          },
          (failure) =>
              fail('Expected success, but got failure: ${failure.message}'),
        );
        verify(() => mockEndpointFoodIntakeLog.getByDate(targetDate)).called(1);
      });

      test('should return ServerFailure when AppException is thrown', () async {
        // Arrange
        final targetDate = DateTime(2024, 6, 15);
        final appException = AppException(
          module: 'nutrition',
          message: 'Failed to fetch logs',
          errorCode: 500,
          httpStatus: 500,
        );
        when(() => mockEndpointFoodIntakeLog.getByDate(any()))
            .thenThrow(appException);

        // Act
        final result = await repository.getFoodIntakeLogs(targetDate);

        // Assert
        result.fold(
          (logs) => fail('Expected failure, but got success: $logs'),
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.statusCode, equals(500));
          },
        );
      });

      test('should return ServerFailure when generic Exception is thrown',
          () async {
        // Arrange
        final targetDate = DateTime(2024, 6, 15);
        final genericException = Exception('Network error');
        when(() => mockEndpointFoodIntakeLog.getByDate(any()))
            .thenThrow(genericException);

        // Act
        final result = await repository.getFoodIntakeLogs(targetDate);

        // Assert
        result.fold(
          (logs) => fail('Expected failure, but got success: $logs'),
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.statusCode, equals(500));
            expect(failure.message, contains('Network error'));
          },
        );
      });
    });

    group('logFoodIntake', () {
      test('should return FoodIntakeLog on success', () async {
        // Arrange
        final dto = CreateFoodIntakeLog(
          foodId: 1,
          date: DateTime(2024, 6, 15),
          mealType: MealPlanType.breakfast,
          servingQuantity: 1.0,
          quantityGrams: 100.0,
        );
        final mockLog = createMockFoodLog();
        when(() => mockEndpointFoodIntakeLog.create(any()))
            .thenAnswer((_) async => mockLog);

        // Act
        final result = await repository.logFoodIntake(dto);

        // Assert
        result.fold(
          (log) {
            expect(log, equals(mockLog));
            expect(log?.id, equals(1));
          },
          (failure) =>
              fail('Expected success, but got failure: ${failure.message}'),
        );
        verify(() => mockEndpointFoodIntakeLog.create(dto)).called(1);
      });

      test('should return ServerFailure when AppException is thrown', () async {
        // Arrange
        final dto = CreateFoodIntakeLog(
          foodId: 1,
          date: DateTime(2024, 6, 15),
          mealType: MealPlanType.breakfast,
          servingQuantity: 1.0,
          quantityGrams: 100.0,
        );
        final appException = AppException(
          module: 'nutrition',
          message: 'Failed to log food',
          errorCode: 500,
          httpStatus: 500,
        );
        when(() => mockEndpointFoodIntakeLog.create(any()))
            .thenThrow(appException);

        // Act
        final result = await repository.logFoodIntake(dto);

        // Assert
        result.fold(
          (log) => fail('Expected failure, but got success: $log'),
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.statusCode, equals(500));
          },
        );
      });
    });

    group('deleteFoodIntakeLog', () {
      test('should return void on success', () async {
        // Arrange
        const logId = 1;
        when(() => mockEndpointFoodIntakeLog.delete(any()))
            .thenAnswer((_) async => {});

        // Act
        final result = await repository.deleteFoodIntakeLog(logId);

        // Assert
        result.fold(
          (_) => expect(true, isTrue), // Success case
          (failure) =>
              fail('Expected success, but got failure: ${failure.message}'),
        );
        verify(() => mockEndpointFoodIntakeLog.delete(logId)).called(1);
      });

      test('should return ServerFailure when AppException is thrown', () async {
        // Arrange
        const logId = 1;
        final appException = AppException(
          module: 'nutrition',
          message: 'Failed to delete log',
          errorCode: 500,
          httpStatus: 500,
        );
        when(() => mockEndpointFoodIntakeLog.delete(any()))
            .thenThrow(appException);

        // Act
        final result = await repository.deleteFoodIntakeLog(logId);

        // Assert
        result.fold(
          (_) => fail('Expected failure, but got success'),
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.statusCode, equals(500));
          },
        );
      });
    });

    group('updateMealPlanFood', () {
      test('should return MealPlanFood on success', () async {
        // Arrange
        const mealPlanFoodId = 1;
        const servingQuantity = 1.5;
        const servingSizeId = 2;
        const quantityGrams = 150.0;
        final mockMealPlanFood = createMockMealPlanFood();
        when(
          () => mockEndpointNutritionPlan.updateMealPlanFood(
            mealPlanFoodId: any(named: 'mealPlanFoodId'),
            updateDto: any(named: 'updateDto'),
          ),
        ).thenAnswer((_) async => mockMealPlanFood);

        // Act
        final result = await repository.updateMealPlanFood(
          mealPlanFoodId: mealPlanFoodId,
          servingQuantity: servingQuantity,
          servingSizeId: servingSizeId,
          quantityGrams: quantityGrams,
        );

        // Assert
        result.fold(
          (mealPlanFood) {
            expect(mealPlanFood, equals(mockMealPlanFood));
            expect(mealPlanFood?.id, equals(1));
          },
          (failure) =>
              fail('Expected success, but got failure: ${failure.message}'),
        );
        verify(
          () => mockEndpointNutritionPlan.updateMealPlanFood(
            mealPlanFoodId: mealPlanFoodId,
            updateDto: any(named: 'updateDto'),
          ),
        ).called(1);
      });

      test('should return ServerFailure when AppException is thrown', () async {
        // Arrange
        const mealPlanFoodId = 1;
        final appException = AppException(
          module: 'nutrition',
          message: 'Failed to update meal plan food',
          errorCode: 500,
          httpStatus: 500,
        );
        when(
          () => mockEndpointNutritionPlan.updateMealPlanFood(
            mealPlanFoodId: any(named: 'mealPlanFoodId'),
            updateDto: any(named: 'updateDto'),
          ),
        ).thenThrow(appException);

        // Act
        final result = await repository.updateMealPlanFood(
          mealPlanFoodId: mealPlanFoodId,
          servingQuantity: 1.5,
          servingSizeId: 2,
          quantityGrams: 150.0,
        );

        // Assert
        result.fold(
          (mealPlanFood) =>
              fail('Expected failure, but got success: $mealPlanFood'),
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.statusCode, equals(500));
          },
        );
      });
    });

    group('deleteMealPlanFood', () {
      test('should return bool on success', () async {
        // Arrange
        const mealPlanFoodId = 1;
        when(
          () => mockEndpointNutritionPlan.deleteMealPlanFood(
            mealPlanFoodId: any(named: 'mealPlanFoodId'),
            userId: any(named: 'userId'),
          ),
        ).thenAnswer((_) async => true);

        // Act
        final result = await repository.deleteMealPlanFood(
          mealPlanFoodId: mealPlanFoodId,
        );

        // Assert
        result.fold(
          (success) {
            expect(success, isTrue);
          },
          (failure) =>
              fail('Expected success, but got failure: ${failure.message}'),
        );
        verify(
          () => mockEndpointNutritionPlan.deleteMealPlanFood(
            mealPlanFoodId: mealPlanFoodId,
            userId: 1,
          ),
        ).called(1);
      });

      test('should return ServerFailure when AppException is thrown', () async {
        // Arrange
        const mealPlanFoodId = 1;
        final appException = AppException(
          module: 'nutrition',
          message: 'Failed to delete meal plan food',
          errorCode: 500,
          httpStatus: 500,
        );
        when(
          () => mockEndpointNutritionPlan.deleteMealPlanFood(
            mealPlanFoodId: any(named: 'mealPlanFoodId'),
            userId: any(named: 'userId'),
          ),
        ).thenThrow(appException);

        // Act
        final result = await repository.deleteMealPlanFood(
          mealPlanFoodId: mealPlanFoodId,
        );

        // Assert
        result.fold(
          (success) => fail('Expected failure, but got success: $success'),
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.statusCode, equals(500));
          },
        );
      });
    });

    group('addMealPlanFood', () {
      test('should return MealPlanFood on success', () async {
        // Arrange
        const mealPlanId = 1;
        const foodId = 1;
        const servingSizeId = 1;
        const servingQuantity = 1.0;
        const quantityGrams = 100.0;
        final mockMealPlanFood = createMockMealPlanFood();
        when(
          () => mockEndpointNutritionPlan.addMealPlanFood(
            mealPlanId: any(named: 'mealPlanId'),
            foodId: any(named: 'foodId'),
            servingSizeId: any(named: 'servingSizeId'),
            servingQuantity: any(named: 'servingQuantity'),
            quantityGrams: any(named: 'quantityGrams'),
          ),
        ).thenAnswer((_) async => mockMealPlanFood);

        // Act
        final result = await repository.addMealPlanFood(
          mealPlanId: mealPlanId,
          foodId: foodId,
          servingSizeId: servingSizeId,
          servingQuantity: servingQuantity,
          quantityGrams: quantityGrams,
        );

        // Assert
        result.fold(
          (mealPlanFood) {
            expect(mealPlanFood, equals(mockMealPlanFood));
            expect(mealPlanFood?.id, equals(1));
          },
          (failure) =>
              fail('Expected success, but got failure: ${failure.message}'),
        );
        verify(
          () => mockEndpointNutritionPlan.addMealPlanFood(
            mealPlanId: mealPlanId,
            foodId: foodId,
            servingSizeId: servingSizeId,
            servingQuantity: servingQuantity,
            quantityGrams: quantityGrams,
          ),
        ).called(1);
      });

      test('should return ServerFailure when AppException is thrown', () async {
        // Arrange
        final appException = AppException(
          module: 'nutrition',
          message: 'Failed to add meal plan food',
          errorCode: 500,
          httpStatus: 500,
        );
        when(
          () => mockEndpointNutritionPlan.addMealPlanFood(
            mealPlanId: any(named: 'mealPlanId'),
            foodId: any(named: 'foodId'),
            servingSizeId: any(named: 'servingSizeId'),
            servingQuantity: any(named: 'servingQuantity'),
            quantityGrams: any(named: 'quantityGrams'),
          ),
        ).thenThrow(appException);

        // Act
        final result = await repository.addMealPlanFood(
          mealPlanId: 1,
          foodId: 1,
          servingSizeId: 1,
          servingQuantity: 1.0,
          quantityGrams: 100.0,
        );

        // Assert
        result.fold(
          (mealPlanFood) =>
              fail('Expected failure, but got success: $mealPlanFood'),
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.statusCode, equals(500));
          },
        );
      });
    });

    group('searchFoods', () {
      test('should return list of Food on success', () async {
        // Arrange
        const query = 'apple';
        final mockFoods = [
          createMockFood(name: 'Apple'),
          createMockFood(id: 2, name: 'Green Apple'),
        ];
        final mockResponse = SearchEndpointsResponseDto(
          foods: mockFoods,
          totalCount: 2,
        );
        when(
          () => mockEndpointFood.searchFoodsV2(
            query: any(named: 'query'),
            categoryId: any(named: 'categoryId'),
            limit: any(named: 'limit'),
          ),
        ).thenAnswer((_) async => mockResponse);

        // Act
        final result = await repository.searchFoods(query: query);

        // Assert
        result.fold(
          (foods) {
            expect(foods?.length, equals(2));
            expect(foods?.first.name, equals('Apple'));
            expect(foods?.last.name, equals('Green Apple'));
          },
          (failure) =>
              fail('Expected success, but got failure: ${failure.message}'),
        );
        verify(
          () => mockEndpointFood.searchFoodsV2(
            query: query,
          ),
        ).called(1);
      });

      test('should return ServerFailure when AppException is thrown', () async {
        // Arrange
        const query = 'apple';
        final appException = AppException(
          module: 'food',
          message: 'Failed to search foods',
          errorCode: 500,
          httpStatus: 500,
        );
        when(
          () => mockEndpointFood.searchFoodsV2(
            query: any(named: 'query'),
            categoryId: any(named: 'categoryId'),
            limit: any(named: 'limit'),
          ),
        ).thenThrow(appException);

        // Act
        final result = await repository.searchFoods(query: query);

        // Assert
        result.fold(
          (foods) => fail('Expected failure, but got success: $foods'),
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.statusCode, equals(500));
          },
        );
      });
    });

    group('requestNutritionPlanGeneration', () {
      test('should return stream of progress updates', () async {
        // Arrange
        const weeks = 2;
        final mealTypes = [MealPlanType.breakfast, MealPlanType.lunch];
        final progress1 = GenerateNutritionPlanProgressDto(
          success: false,
          status: StreamStatus.waiting,
          message: 'Generating plan...',
          progressPercentage: 50.0,
          currentDay: 1,
          totalDays: 14,
          updatedAt: DateTime(2024, 6, 15),
        );
        final progress2 = GenerateNutritionPlanProgressDto(
          success: true,
          status: StreamStatus.completed,
          message: 'Plan generated',
          progressPercentage: 100.0,
          currentDay: 14,
          totalDays: 14,
          updatedAt: DateTime(2024, 6, 15),
        );
        final streamController =
            StreamController<GenerateNutritionPlanProgressDto>();
        when(
          () => mockEndpointNutritionPlan.requestNutritionPlanGeneration(
            any(),
            any(),
            any(),
          ),
        ).thenAnswer((_) => streamController.stream);

        // Act
        final stream = repository.requestNutritionPlanGeneration(
          weeks: weeks,
          mealTypes: mealTypes,
        );

        // Assert
        final events = <GenerateNutritionPlanProgressDto>[];
        final subscription = stream.listen(events.add);

        streamController
          ..add(progress1)
          ..add(progress2);
        await streamController.close();
        await subscription.cancel();

        expect(events.length, equals(2));
        expect(events.first.status, equals(StreamStatus.waiting));
        expect(events.last.status, equals(StreamStatus.completed));
        verify(
          () => mockEndpointNutritionPlan.requestNutritionPlanGeneration(
            1,
            weeks,
            mealTypes,
          ),
        ).called(1);
      });
    });
  });
}
