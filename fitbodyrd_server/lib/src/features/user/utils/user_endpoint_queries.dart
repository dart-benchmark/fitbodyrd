part of 'package:fitbodyrd_server/src/features/user/endpoints/user_endpoint.dart';

const _insertUserQuery = '''
INSERT INTO public.user_profiles(
	id, "userInfoId", "fullName", email, "birthDate", sex, "weightKgs", "heightMs", "bodyGoal", "activityLevel", "daysPerWeekExercise", "timePerExerciseSessionMinutes", "experienceLevel", "authMethod", "hasEquipment", "dietaryRestrictions", "deletedAt", "createdAt", "updatedAt")
	VALUES (@id, @userInfoId, @fullName, @email, @birthDate, @sex, @weightKgs, @heightMs, @bodyGoal, @activityLevel, @daysPerWeekExercise, @timePerExerciseSessionMinutes, @experienceLevel, @authMethod, @hasEquipment, @dietaryRestrictions, @deletedAt, @createdAt, @updatedAt);
''';
