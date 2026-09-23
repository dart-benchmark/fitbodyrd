import 'package:fitbodyrd_server/src/features/user/utils/user_utils.dart';
import 'package:fitbodyrd_server/src/generated/protocol.dart';
import 'package:test/test.dart';

void main() {
  group('UserProfileExtensions', () {
    group('completeProfile', () {
      test('should calculate age correctly', () {
        // Arrange
        final today = DateTime.now();
        final birthDate = DateTime(today.year - 25, today.month, today.day);
        final profile = UserProfile(
          userInfoId: 1,
          fullName: 'Test User',
          email: 'test@example.com',
          birthDate: birthDate,
          sex: Sex.male,
          weightKgs: 75.0,
          heightMs: 1.75,
          bodyGoal: BodyGoal.loseWeight,
          activityLevel: ActivityLevel.sedentary,
          daysPerWeekExercise: 3,
          timePerExerciseSessionMinutes: 30,
          experienceLevel: ExerciseDifficulty.beginner,
        );

        // Act
        final completed = profile.completeProfile();

        // Assert
        expect(completed.age, equals(25));
        expect(completed.bmi, isNotNull);
        expect(completed.weightCategory, isNotNull);
      });

      test(
          'should calculate age correctly when birthday has not occurred this year',
          () {
        // Arrange - Use fixed date to avoid month overflow issues
        // Set a fixed "today" date (e.g., June 15, 2024)
        // Birthday is July 15, 1999 (hasn't occurred yet in 2024)
        final birthDate = DateTime(1999, 7, 15);
        final profile = UserProfile(
          userInfoId: 1,
          fullName: 'Test User',
          email: 'test@example.com',
          birthDate: birthDate,
          sex: Sex.male,
          weightKgs: 75.0,
          heightMs: 1.75,
          bodyGoal: BodyGoal.loseWeight,
          activityLevel: ActivityLevel.sedentary,
          daysPerWeekExercise: 3,
          timePerExerciseSessionMinutes: 30,
          experienceLevel: ExerciseDifficulty.beginner,
        );

        // Act
        final completed = profile.completeProfile();

        // Assert
        // Age calculation: current year - birth year, adjusted if birthday hasn't occurred
        // If today is before July 15, age should be (current year - 1999) - 1
        // If today is after July 15, age should be (current year - 1999)
        final today = DateTime.now();
        final expectedAge = today.year - 1999;
        final hasBirthdayOccurred =
            today.month > 7 || (today.month == 7 && today.day >= 15);
        final actualExpectedAge =
            hasBirthdayOccurred ? expectedAge : expectedAge - 1;

        expect(completed.age, equals(actualExpectedAge));
        expect(completed.bmi, isNotNull);
        expect(completed.weightCategory, isNotNull);
      });

      test(
          'should calculate age correctly when birthday is same month but later day',
          () {
        // Arrange - Use fixed date to avoid day overflow issues
        // Birthday is June 20, 1999
        // If today is before June 20, age should be (current year - 1999) - 1
        final birthDate = DateTime(1999, 6, 20);
        final profile = UserProfile(
          userInfoId: 1,
          fullName: 'Test User',
          email: 'test@example.com',
          birthDate: birthDate,
          sex: Sex.male,
          weightKgs: 75.0,
          heightMs: 1.75,
          bodyGoal: BodyGoal.loseWeight,
          activityLevel: ActivityLevel.sedentary,
          daysPerWeekExercise: 3,
          timePerExerciseSessionMinutes: 30,
          experienceLevel: ExerciseDifficulty.beginner,
        );

        // Act
        final completed = profile.completeProfile();

        // Assert
        // Age calculation: current year - birth year, adjusted if birthday hasn't occurred
        final today = DateTime.now();
        final expectedAge = today.year - 1999;
        final hasBirthdayOccurred =
            today.month > 6 || (today.month == 6 && today.day >= 20);
        final actualExpectedAge =
            hasBirthdayOccurred ? expectedAge : expectedAge - 1;

        expect(completed.age, equals(actualExpectedAge));
        expect(completed.bmi, isNotNull);
        expect(completed.weightCategory, isNotNull);
      });

      test('should calculate BMI correctly', () {
        // Arrange
        final profile = UserProfile(
          userInfoId: 1,
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

        // Act
        final completed = profile.completeProfile();

        // Assert
        // BMI = weight (kg) / height (m)^2 = 75 / (1.75)^2 = 75 / 3.0625 ≈ 24.49
        expect(completed.bmi, closeTo(24.49, 0.01));
        expect(completed.weightCategory, isNotNull);
      });

      test('should assign correct weight category based on BMI', () {
        // Arrange - Underweight (BMI < 18.5)
        final underweightProfile = UserProfile(
          userInfoId: 1,
          fullName: 'Underweight User',
          email: 'underweight@example.com',
          birthDate: DateTime(1990, 1, 1),
          sex: Sex.male,
          weightKgs: 50.0, // 50 kg
          heightMs: 1.75, // 1.75 m -> BMI ≈ 16.33
          bodyGoal: BodyGoal.loseWeight,
          activityLevel: ActivityLevel.sedentary,
          daysPerWeekExercise: 3,
          timePerExerciseSessionMinutes: 30,
          experienceLevel: ExerciseDifficulty.beginner,
        );

        // Act
        final completed = underweightProfile.completeProfile();

        // Assert
        expect(completed.bmi, lessThan(18.5));
        expect(completed.weightCategory, equals(WeightCategory.underweight));
      });

      test('should update both age and BMI in completeProfile', () {
        // Arrange
        final today = DateTime.now();
        final birthDate = DateTime(today.year - 30, today.month, today.day);
        final profile = UserProfile(
          userInfoId: 1,
          fullName: 'Test User',
          email: 'test@example.com',
          birthDate: birthDate,
          sex: Sex.male,
          weightKgs: 80.0,
          heightMs: 1.80,
          bodyGoal: BodyGoal.loseWeight,
          activityLevel: ActivityLevel.sedentary,
          daysPerWeekExercise: 3,
          timePerExerciseSessionMinutes: 30,
          experienceLevel: ExerciseDifficulty.beginner,
        );

        // Act
        final completed = profile.completeProfile();

        // Assert
        expect(completed.age, equals(30));
        expect(completed.bmi, isNotNull);
        expect(completed.weightCategory, isNotNull);
        // Verify original profile is not modified
        expect(profile.age, isNull);
        expect(profile.bmi, isNull);
        expect(profile.weightCategory, isNull);
      });
    });
  });
}
