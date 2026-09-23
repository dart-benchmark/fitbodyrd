# Example Test Patterns for Backend

This file demonstrates the testing patterns used in the Serverpod backend.

## Endpoint Test Example

```dart
import 'package:test/test.dart';
import 'package:serverpod_test/serverpod_test.dart';
import 'package:fitbodyrd_server/test/integration/test_tools/serverpod_test_tools.dart';
import 'package:fitbodyrd_server/src/features/nutrition/endpoints/nutrition_endpoint.dart';

void main() {
  withServerpod('Given Nutrition endpoint', (sessionBuilder, endpoints) {
    test('when calculating macros for male user, then BMR is calculated correctly', () async {
      // Arrange
      final request = CalculateMacrosRequest(
        gender: Gender.male,
        age: 30,
        height: 180, // cm
        weight: 80, // kg
        activityLevel: ActivityLevel.moderatelyActive,
        bodyGoal: BodyGoal.loseWeight,
        mealTypes: [MealType.breakfast, MealType.lunch, MealType.dinner],
      );

      // Act
      final result = await endpoints.nutrition.calculateMacros(
        sessionBuilder(),
        request,
      );

      // Assert
      expect(result.bmr, greaterThan(0));
      expect(result.tdee, greaterThan(result.bmr));
      expect(result.macros.calories, greaterThan(0));
      expect(result.macros.protein, greaterThan(0));
      expect(result.macros.carbs, greaterThan(0));
      expect(result.macros.fats, greaterThan(0));
    });

    test('when calculating macros with invalid meal type count, then throws exception', () async {
      // Arrange
      final request = CalculateMacrosRequest(
        gender: Gender.male,
        age: 30,
        height: 180,
        weight: 80,
        activityLevel: ActivityLevel.moderatelyActive,
        bodyGoal: BodyGoal.maintainWeight,
        mealTypes: [MealType.breakfast], // Only 1 meal type (invalid)
      );

      // Act & Assert
      expect(
        () => endpoints.nutrition.calculateMacros(sessionBuilder(), request),
        throwsA(isA<InvalidMealTypeCountException>()),
      );
    });
  });
}
```

## Utility Function Test Example

```dart
import 'package:test/test.dart';
import 'package:fitbodyrd_server/src/core/utils/bmi_calculator.dart';

void main() {
  group('BMICalculator', () {
    test('calculate returns correct BMI for valid inputs', () {
      // Arrange
      const height = 180.0; // cm
      const weight = 80.0; // kg

      // Act
      final bmi = BMICalculator.calculate(height: height, weight: weight);

      // Assert
      expect(bmi, closeTo(24.69, 0.01)); // BMI = 80 / (1.8)^2 ≈ 24.69
    });

    test('calculate throws exception for zero height', () {
      // Arrange
      const height = 0.0;
      const weight = 80.0;

      // Act & Assert
      expect(
        () => BMICalculator.calculate(height: height, weight: weight),
        throwsArgumentError,
      );
    });

    test('getCategory returns correct category for BMI', () {
      expect(BMICalculator.getCategory(17.0), equals(BMICategory.underweight));
      expect(BMICalculator.getCategory(22.0), equals(BMICategory.normal));
      expect(BMICalculator.getCategory(27.0), equals(BMICategory.overweight));
      expect(BMICalculator.getCategory(32.0), equals(BMICategory.obese));
    });
  });
}
```

## Notes

- Use `withServerpod` helper for endpoint tests
- Use `sessionBuilder()` to create test sessions
- Access endpoints through the `endpoints` parameter
- Test both success and failure paths
- Test edge cases and boundary conditions
- Use descriptive test names following "when...then..." pattern
- For utility functions, use standard `test` and `group` from `package:test`

