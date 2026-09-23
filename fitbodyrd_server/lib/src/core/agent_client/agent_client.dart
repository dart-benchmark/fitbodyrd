import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fitbodyrd_server/src/generated/protocol.dart';

class AgentClient {
  final Dio _httpClient;

  const AgentClient({required Dio httpClient}) : _httpClient = httpClient;

  Future<void> sendCreateWorkoutPlanRequest({
    required int numberOfWeeks,
    required UserProfile userProfile,
    required int baseWorkoutPlanId,
    required DateTime startDate,
    required int sessionsCount,
  }) async {
    final payload = {
      'numberOfWeeks': numberOfWeeks,
      'user': userProfile.toJson(),
      'baseWorkoutPlanId': baseWorkoutPlanId,
      'startDate': startDate.toIso8601String(),
      'sessionsCount': sessionsCount,
    };
    final response = await _httpClient.post(
      '/workoutAgent/createWorkoutPlan',
      data: jsonEncode(payload),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create workout plan: ${response.data}');
    }
  }

  Future<void> sendCreateNutritionPlanRequest({
    required int userId,
    required int weeks,
    required List<MealPlanType> mealTypes,
  }) async {
    final response = await _httpClient.post(
      '/nutritionAgent/createNutritionPlan',
      data: {
        'userId': userId,
        'weeks': weeks,
        'mealTypes': mealTypes.map((e) => e.name).toList(),
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create workout plan: ${response.data}');
    }
  }
}
