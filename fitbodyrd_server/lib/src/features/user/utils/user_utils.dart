import 'package:fitbodyrd_server/src/core/utils/bmi_calculator.dart';
import 'package:fitbodyrd_server/src/generated/protocol.dart';

extension UserProfileExtensions on UserProfile {
  UserProfile completeProfile() {
    return _updateWithUserAge()._updateWithBMI();
  }

  UserProfile _updateWithUserAge() {
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    return copyWith(age: age);
  }

  UserProfile _updateWithBMI() {
    final bmi = BMICalculator.calculate(weightKgs, heightMs);
    final category = BMICalculator.getCategory(bmi);
    return copyWith(bmi: bmi, weightCategory: category);
  }
}
