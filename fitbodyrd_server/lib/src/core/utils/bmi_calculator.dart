import 'package:fitbodyrd_server/src/generated/protocol.dart';

class BMICalculator {
  static double calculate(double weightKg, double heightM) {
    if (heightM <= 0) {
      throw ArgumentError('Height must be greater than 0');
    }
    return weightKg / (heightM * heightM);
  }

  static WeightCategory getCategory(double bmi) {
    if (bmi < 18.5) return WeightCategory.underweight;
    if (bmi < 25) return WeightCategory.normal;
    if (bmi < 30) return WeightCategory.overweight;
    return WeightCategory.obese;
  }
}
