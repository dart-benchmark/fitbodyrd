import 'package:fitbodyrd_server/src/features/nutrition_plan/utils/nutrition_plan_utils.dart';
import 'package:fitbodyrd_server/src/generated/protocol.dart';
import 'package:test/test.dart';

void main() {
  group('NutritionPlanUtils', () {
    group('calculateVariance', () {
      test('should calculate variance for calories correctly', () {
        // Arrange
        final actual = CreatedMealPlanTotalsDto(
          calories: 2500.0,
          proteins: 150.0,
          carbs: 300.0,
          fats: 80.0,
        );
        final target = NutritionPlan(
          userProfileId: 1,
          startDate: DateTime(2024, 1, 1),
          endDate: DateTime(2024, 1, 7),
          dailyCalories: 2000.0,
          dailyProteins: 120.0,
          dailyCarbs: 250.0,
          dailyFats: 70.0,
          status: Status.active,
        );

        // Act
        final result = NutritionPlanUtils.calculateVariance(
          actual: actual,
          target: target,
        );

        // Assert
        expect(result.calories, equals(500.0)); // 2500 - 2000
      });

      test('should calculate variance for proteins correctly', () {
        // Arrange
        final actual = CreatedMealPlanTotalsDto(
          calories: 2000.0,
          proteins: 150.0,
          carbs: 250.0,
          fats: 70.0,
        );
        final target = NutritionPlan(
          userProfileId: 1,
          startDate: DateTime(2024, 1, 1),
          endDate: DateTime(2024, 1, 7),
          dailyCalories: 2000.0,
          dailyProteins: 120.0,
          dailyCarbs: 250.0,
          dailyFats: 70.0,
          status: Status.active,
        );

        // Act
        final result = NutritionPlanUtils.calculateVariance(
          actual: actual,
          target: target,
        );

        // Assert
        expect(result.proteins, equals(30.0)); // 150 - 120
      });

      test('should calculate variance for carbs correctly', () {
        // Arrange
        final actual = CreatedMealPlanTotalsDto(
          calories: 2000.0,
          proteins: 120.0,
          carbs: 300.0,
          fats: 70.0,
        );
        final target = NutritionPlan(
          userProfileId: 1,
          startDate: DateTime(2024, 1, 1),
          endDate: DateTime(2024, 1, 7),
          dailyCalories: 2000.0,
          dailyProteins: 120.0,
          dailyCarbs: 250.0,
          dailyFats: 70.0,
          status: Status.active,
        );

        // Act
        final result = NutritionPlanUtils.calculateVariance(
          actual: actual,
          target: target,
        );

        // Assert
        expect(result.carbs, equals(50.0)); // 300 - 250
      });

      test('should calculate variance for fats correctly', () {
        // Arrange
        final actual = CreatedMealPlanTotalsDto(
          calories: 2000.0,
          proteins: 120.0,
          carbs: 250.0,
          fats: 80.0,
        );
        final target = NutritionPlan(
          userProfileId: 1,
          startDate: DateTime(2024, 1, 1),
          endDate: DateTime(2024, 1, 7),
          dailyCalories: 2000.0,
          dailyProteins: 120.0,
          dailyCarbs: 250.0,
          dailyFats: 70.0,
          status: Status.active,
        );

        // Act
        final result = NutritionPlanUtils.calculateVariance(
          actual: actual,
          target: target,
        );

        // Assert
        expect(result.fats, equals(10.0)); // 80 - 70
      });

      test(
          'should calculate positive variance when actual is greater than target',
          () {
        // Arrange
        final actual = CreatedMealPlanTotalsDto(
          calories: 2500.0,
          proteins: 150.0,
          carbs: 300.0,
          fats: 80.0,
        );
        final target = NutritionPlan(
          userProfileId: 1,
          startDate: DateTime(2024, 1, 1),
          endDate: DateTime(2024, 1, 7),
          dailyCalories: 2000.0,
          dailyProteins: 120.0,
          dailyCarbs: 250.0,
          dailyFats: 70.0,
          status: Status.active,
        );

        // Act
        final result = NutritionPlanUtils.calculateVariance(
          actual: actual,
          target: target,
        );

        // Assert
        expect(result.calories, greaterThan(0));
        expect(result.proteins, greaterThan(0));
        expect(result.carbs, greaterThan(0));
        expect(result.fats, greaterThan(0));
      });

      test('should calculate negative variance when actual is less than target',
          () {
        // Arrange
        final actual = CreatedMealPlanTotalsDto(
          calories: 1500.0,
          proteins: 100.0,
          carbs: 200.0,
          fats: 60.0,
        );
        final target = NutritionPlan(
          userProfileId: 1,
          startDate: DateTime(2024, 1, 1),
          endDate: DateTime(2024, 1, 7),
          dailyCalories: 2000.0,
          dailyProteins: 120.0,
          dailyCarbs: 250.0,
          dailyFats: 70.0,
          status: Status.active,
        );

        // Act
        final result = NutritionPlanUtils.calculateVariance(
          actual: actual,
          target: target,
        );

        // Assert
        expect(result.calories, lessThan(0));
        expect(result.proteins, lessThan(0));
        expect(result.carbs, lessThan(0));
        expect(result.fats, lessThan(0));
      });

      test('should calculate zero variance when actual equals target', () {
        // Arrange
        final actual = CreatedMealPlanTotalsDto(
          calories: 2000.0,
          proteins: 120.0,
          carbs: 250.0,
          fats: 70.0,
        );
        final target = NutritionPlan(
          userProfileId: 1,
          startDate: DateTime(2024, 1, 1),
          endDate: DateTime(2024, 1, 7),
          dailyCalories: 2000.0,
          dailyProteins: 120.0,
          dailyCarbs: 250.0,
          dailyFats: 70.0,
          status: Status.active,
        );

        // Act
        final result = NutritionPlanUtils.calculateVariance(
          actual: actual,
          target: target,
        );

        // Assert
        expect(result.calories, equals(0.0));
        expect(result.proteins, equals(0.0));
        expect(result.carbs, equals(0.0));
        expect(result.fats, equals(0.0));
      });
    });

    group('calculateProgressPercentage', () {
      test('should calculate normal progress percentage correctly', () {
        // Arrange
        const daysCompleted = 5;
        const totalDays = 10;

        // Act
        final result = NutritionPlanUtils.calculateProgressPercentage(
          daysCompleted: daysCompleted,
          totalDays: totalDays,
        );

        // Assert
        expect(result, equals(50.0)); // 5 / 10 * 100
      });

      test('should return 0.0 when totalDays is zero', () {
        // Arrange
        const daysCompleted = 5;
        const totalDays = 0;

        // Act
        final result = NutritionPlanUtils.calculateProgressPercentage(
          daysCompleted: daysCompleted,
          totalDays: totalDays,
        );

        // Assert
        expect(result, equals(0.0));
      });

      test('should return 100.0 when daysCompleted equals totalDays', () {
        // Arrange
        const daysCompleted = 10;
        const totalDays = 10;

        // Act
        final result = NutritionPlanUtils.calculateProgressPercentage(
          daysCompleted: daysCompleted,
          totalDays: totalDays,
        );

        // Assert
        expect(result, equals(100.0));
      });

      test('should return 0.0 when daysCompleted is zero', () {
        // Arrange
        const daysCompleted = 0;
        const totalDays = 10;

        // Act
        final result = NutritionPlanUtils.calculateProgressPercentage(
          daysCompleted: daysCompleted,
          totalDays: totalDays,
        );

        // Assert
        expect(result, equals(0.0));
      });

      test('should calculate partial progress correctly', () {
        // Arrange
        const daysCompleted = 3;
        const totalDays = 7;

        // Act
        final result = NutritionPlanUtils.calculateProgressPercentage(
          daysCompleted: daysCompleted,
          totalDays: totalDays,
        );

        // Assert
        expect(result, closeTo(42.857, 0.001)); // 3 / 7 * 100
      });

      test('should handle single day correctly', () {
        // Arrange
        const daysCompleted = 1;
        const totalDays = 1;

        // Act
        final result = NutritionPlanUtils.calculateProgressPercentage(
          daysCompleted: daysCompleted,
          totalDays: totalDays,
        );

        // Assert
        expect(result, equals(100.0));
      });
    });
  });
}
