import 'package:test/test.dart';
import 'package:fitbodyrd_server/src/core/utils/bmi_calculator.dart';
import 'package:fitbodyrd_server/src/generated/protocol.dart';

void main() {
  group('BMICalculator', () {
    group('calculate', () {
      test('returns correct BMI for valid inputs with normal values', () {
        // Arrange
        const weightKg = 80.0;
        const heightM = 1.8;

        // Act
        final bmi = BMICalculator.calculate(weightKg, heightM);

        // Assert
        // BMI = 80 / (1.8)^2 = 80 / 3.24 ≈ 24.69
        expect(bmi, closeTo(24.69, 0.01));
      });

      test('returns correct BMI for different weight/height combinations', () {
        // Arrange & Act & Assert
        // Test case 1: 70kg, 1.75m
        expect(
          BMICalculator.calculate(70.0, 1.75),
          closeTo(22.86, 0.01), // 70 / (1.75)^2 = 70 / 3.0625 ≈ 22.86
        );

        // Test case 2: 90kg, 1.85m
        expect(
          BMICalculator.calculate(90.0, 1.85),
          closeTo(26.30, 0.01), // 90 / (1.85)^2 = 90 / 3.4225 ≈ 26.30
        );

        // Test case 3: 60kg, 1.65m
        expect(
          BMICalculator.calculate(60.0, 1.65),
          closeTo(22.04, 0.01), // 60 / (1.65)^2 = 60 / 2.7225 ≈ 22.04
        );
      });

      test('handles very large weight values correctly', () {
        // Arrange
        const weightKg = 150.0;
        const heightM = 1.8;

        // Act
        final bmi = BMICalculator.calculate(weightKg, heightM);

        // Assert
        // BMI = 150 / (1.8)^2 = 150 / 3.24 ≈ 46.30
        expect(bmi, closeTo(46.30, 0.01));
      });

      test('handles very small weight values correctly', () {
        // Arrange
        const weightKg = 45.0;
        const heightM = 1.7;

        // Act
        final bmi = BMICalculator.calculate(weightKg, heightM);

        // Assert
        // BMI = 45 / (1.7)^2 = 45 / 2.89 ≈ 15.57
        expect(bmi, closeTo(15.57, 0.01));
      });

      test('throws ArgumentError when height is zero', () {
        // Arrange
        const weightKg = 80.0;
        const heightM = 0.0;

        // Act & Assert
        expect(
          () => BMICalculator.calculate(weightKg, heightM),
          throwsA(isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            'Height must be greater than 0',
          )),
        );
      });

      test('throws ArgumentError when height is negative', () {
        // Arrange
        const weightKg = 80.0;
        const heightM = -1.5;

        // Act & Assert
        expect(
          () => BMICalculator.calculate(weightKg, heightM),
          throwsA(isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            'Height must be greater than 0',
          )),
        );
      });

      test('handles very small positive height values correctly', () {
        // Arrange
        const weightKg = 80.0;
        const heightM = 0.0001;

        // Act
        final bmi = BMICalculator.calculate(weightKg, heightM);

        // Assert
        // Very small positive values should work (0.0001 > 0)
        expect(bmi, greaterThan(0));
        // BMI = 80 / (0.0001)^2 = 80 / 0.00000001 = 8,000,000,000
        expect(bmi, closeTo(8000000000.0, 1000000.0));
      });
    });

    group('getCategory', () {
      group('underweight category', () {
        test('returns underweight for BMI less than 18.5', () {
          // Arrange & Act & Assert
          expect(BMICalculator.getCategory(17.0), equals(WeightCategory.underweight));
          expect(BMICalculator.getCategory(18.0), equals(WeightCategory.underweight));
          expect(BMICalculator.getCategory(18.4), equals(WeightCategory.underweight));
        });

        test('returns underweight for very low BMI values', () {
          expect(BMICalculator.getCategory(15.0), equals(WeightCategory.underweight));
          expect(BMICalculator.getCategory(10.0), equals(WeightCategory.underweight));
        });
      });

      group('normal category', () {
        test('returns normal for BMI between 18.5 and 24.9', () {
          // Arrange & Act & Assert
          expect(BMICalculator.getCategory(18.5), equals(WeightCategory.normal));
          expect(BMICalculator.getCategory(20.0), equals(WeightCategory.normal));
          expect(BMICalculator.getCategory(22.5), equals(WeightCategory.normal));
          expect(BMICalculator.getCategory(24.9), equals(WeightCategory.normal));
        });
      });

      group('overweight category', () {
        test('returns overweight for BMI between 25.0 and 29.9', () {
          // Arrange & Act & Assert
          expect(BMICalculator.getCategory(25.0), equals(WeightCategory.overweight));
          expect(BMICalculator.getCategory(27.0), equals(WeightCategory.overweight));
          expect(BMICalculator.getCategory(29.9), equals(WeightCategory.overweight));
        });
      });

      group('obese category', () {
        test('returns obese for BMI greater than or equal to 30.0', () {
          // Arrange & Act & Assert
          expect(BMICalculator.getCategory(30.0), equals(WeightCategory.obese));
          expect(BMICalculator.getCategory(35.0), equals(WeightCategory.obese));
          expect(BMICalculator.getCategory(40.0), equals(WeightCategory.obese));
          expect(BMICalculator.getCategory(50.0), equals(WeightCategory.obese));
        });
      });

      group('boundary values', () {
        test('boundary at 18.5 returns normal (not underweight)', () {
          // Arrange & Act & Assert
          // 18.5 is the lower boundary for normal, so it should return normal
          expect(BMICalculator.getCategory(18.5), equals(WeightCategory.normal));
        });

        test('boundary at 25.0 returns overweight (not normal)', () {
          // Arrange & Act & Assert
          // 25.0 is the lower boundary for overweight, so it should return overweight
          expect(BMICalculator.getCategory(25.0), equals(WeightCategory.overweight));
        });

        test('boundary at 30.0 returns obese (not overweight)', () {
          // Arrange & Act & Assert
          // 30.0 is the lower boundary for obese, so it should return obese
          expect(BMICalculator.getCategory(30.0), equals(WeightCategory.obese));
        });

        test('value just below 18.5 returns underweight', () {
          // Arrange & Act & Assert
          expect(BMICalculator.getCategory(18.49), equals(WeightCategory.underweight));
        });

        test('value just below 25.0 returns normal', () {
          // Arrange & Act & Assert
          expect(BMICalculator.getCategory(24.99), equals(WeightCategory.normal));
        });

        test('value just below 30.0 returns overweight', () {
          // Arrange & Act & Assert
          expect(BMICalculator.getCategory(29.99), equals(WeightCategory.overweight));
        });
      });
    });
  });
}

