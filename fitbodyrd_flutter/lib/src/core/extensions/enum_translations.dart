import 'package:fitbodyrd_client/fitbodyrd_client.dart';

extension SexTranslation on Sex {
  String get displayName {
    switch (this) {
      case Sex.male:
        return 'Masculino';
      case Sex.female:
        return 'Femenino';
      case Sex.other:
        return 'Otro';
    }
  }
}

extension BodyGoalTranslation on BodyGoal {
  String get displayName {
    switch (this) {
      case BodyGoal.loseWeight:
        return 'Perder peso';
      case BodyGoal.gainMuscleMass:
        return 'Ganar músculo';
      case BodyGoal.maintainWeight:
        return 'Mantener peso';
    }
  }
}

extension ActivityLevelTranslation on ActivityLevel {
  String get displayName {
    switch (this) {
      case ActivityLevel.sedentary:
        return 'Sedentario';
      case ActivityLevel.lightlyActive:
        return 'Ligeramente activo';
      case ActivityLevel.moderatelyActive:
        return 'Moderadamente activo';
      case ActivityLevel.veryActive:
        return 'Muy activo';
      case ActivityLevel.active:
        return 'Activo';
    }
  }
}

extension ExerciseDifficultyTranslation on ExerciseDifficulty {
  String get displayName {
    switch (this) {
      case ExerciseDifficulty.beginner:
        return 'Principiante';
      case ExerciseDifficulty.intermediate:
        return 'Intermedio';
      case ExerciseDifficulty.advanced:
        return 'Avanzado';
    }
  }
}

extension DietaryRestrictionTranslation on DietaryRestriction {
  String get displayName {
    switch (this) {
      case DietaryRestriction.none:
        return 'Ninguna';
      case DietaryRestriction.vegetarian:
        return 'Vegetariano';
      case DietaryRestriction.vegan:
        return 'Vegano';
      case DietaryRestriction.keto:
        return 'Keto';
      case DietaryRestriction.paleo:
        return 'Paleo';
      case DietaryRestriction.pescatarian:
        return 'Pescatariano';
    }
  }
}

extension MealPlanTypeTranslation on MealPlanType {
  String get displayName {
    switch (this) {
      case MealPlanType.breakfast:
        return 'Desayuno';
      case MealPlanType.lunch:
        return 'Almuerzo';
      case MealPlanType.dinner:
        return 'Cena';
      case MealPlanType.snack:
        return 'Snack';
      case MealPlanType.brunch:
        return 'Brunch';
    }
  }
}

extension MuscleGroupTranslation on ExerciseMuscleGroup {
  String get displayName {
    switch (this) {
      case ExerciseMuscleGroup.back:
        return 'Espalda';
      case ExerciseMuscleGroup.chest:
        return 'Pecho';
      case ExerciseMuscleGroup.shoulders:
        return 'Hombros';
      case ExerciseMuscleGroup.arms:
        return 'Brazos';
      case ExerciseMuscleGroup.core:
        return 'Core';
      case ExerciseMuscleGroup.legs:
        return 'Piernas';
      case ExerciseMuscleGroup.fullBody:
        return 'Todo el cuerpo';
    }
  }
}
