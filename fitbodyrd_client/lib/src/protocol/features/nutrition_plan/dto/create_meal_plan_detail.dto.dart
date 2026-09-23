/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import '../../../features/nutrition_plan/models/meal_type.dart' as _i2;
import '../../../features/nutrition_plan/dto/create_meal_plan_food.dto.dart'
    as _i3;
import 'package:fitbodyrd_client/src/protocol/protocol.dart' as _i4;

abstract class CreateMealPlanDetailDto implements _i1.SerializableModel {
  CreateMealPlanDetailDto._({
    required this.mealType,
    required this.targetCalories,
    required this.targetProteins,
    required this.targetCarbs,
    required this.targetFats,
    required this.foods,
  });

  factory CreateMealPlanDetailDto({
    required _i2.MealPlanType mealType,
    required double targetCalories,
    required double targetProteins,
    required double targetCarbs,
    required double targetFats,
    required List<_i3.CreateMealPlanFoodDto> foods,
  }) = _CreateMealPlanDetailDtoImpl;

  factory CreateMealPlanDetailDto.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CreateMealPlanDetailDto(
      mealType: _i2.MealPlanType.fromJson(
        (jsonSerialization['mealType'] as String),
      ),
      targetCalories: (jsonSerialization['targetCalories'] as num).toDouble(),
      targetProteins: (jsonSerialization['targetProteins'] as num).toDouble(),
      targetCarbs: (jsonSerialization['targetCarbs'] as num).toDouble(),
      targetFats: (jsonSerialization['targetFats'] as num).toDouble(),
      foods: _i4.Protocol().deserialize<List<_i3.CreateMealPlanFoodDto>>(
        jsonSerialization['foods'],
      ),
    );
  }

  _i2.MealPlanType mealType;

  double targetCalories;

  double targetProteins;

  double targetCarbs;

  double targetFats;

  List<_i3.CreateMealPlanFoodDto> foods;

  /// Returns a shallow copy of this [CreateMealPlanDetailDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CreateMealPlanDetailDto copyWith({
    _i2.MealPlanType? mealType,
    double? targetCalories,
    double? targetProteins,
    double? targetCarbs,
    double? targetFats,
    List<_i3.CreateMealPlanFoodDto>? foods,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CreateMealPlanDetailDto',
      'mealType': mealType.toJson(),
      'targetCalories': targetCalories,
      'targetProteins': targetProteins,
      'targetCarbs': targetCarbs,
      'targetFats': targetFats,
      'foods': foods.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _CreateMealPlanDetailDtoImpl extends CreateMealPlanDetailDto {
  _CreateMealPlanDetailDtoImpl({
    required _i2.MealPlanType mealType,
    required double targetCalories,
    required double targetProteins,
    required double targetCarbs,
    required double targetFats,
    required List<_i3.CreateMealPlanFoodDto> foods,
  }) : super._(
         mealType: mealType,
         targetCalories: targetCalories,
         targetProteins: targetProteins,
         targetCarbs: targetCarbs,
         targetFats: targetFats,
         foods: foods,
       );

  /// Returns a shallow copy of this [CreateMealPlanDetailDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CreateMealPlanDetailDto copyWith({
    _i2.MealPlanType? mealType,
    double? targetCalories,
    double? targetProteins,
    double? targetCarbs,
    double? targetFats,
    List<_i3.CreateMealPlanFoodDto>? foods,
  }) {
    return CreateMealPlanDetailDto(
      mealType: mealType ?? this.mealType,
      targetCalories: targetCalories ?? this.targetCalories,
      targetProteins: targetProteins ?? this.targetProteins,
      targetCarbs: targetCarbs ?? this.targetCarbs,
      targetFats: targetFats ?? this.targetFats,
      foods: foods ?? this.foods.map((e0) => e0.copyWith()).toList(),
    );
  }
}
