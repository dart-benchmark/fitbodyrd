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

abstract class CreateMealPlanFoodDto implements _i1.SerializableModel {
  CreateMealPlanFoodDto._({
    required this.foodId,
    required this.servingSizeId,
    required this.servingQuantity,
    required this.quantityGrams,
    required this.calories,
    required this.proteins,
    required this.carbs,
    required this.fats,
  });

  factory CreateMealPlanFoodDto({
    required int foodId,
    required int servingSizeId,
    required double servingQuantity,
    required double quantityGrams,
    required double calories,
    required double proteins,
    required double carbs,
    required double fats,
  }) = _CreateMealPlanFoodDtoImpl;

  factory CreateMealPlanFoodDto.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CreateMealPlanFoodDto(
      foodId: jsonSerialization['foodId'] as int,
      servingSizeId: jsonSerialization['servingSizeId'] as int,
      servingQuantity: (jsonSerialization['servingQuantity'] as num).toDouble(),
      quantityGrams: (jsonSerialization['quantityGrams'] as num).toDouble(),
      calories: (jsonSerialization['calories'] as num).toDouble(),
      proteins: (jsonSerialization['proteins'] as num).toDouble(),
      carbs: (jsonSerialization['carbs'] as num).toDouble(),
      fats: (jsonSerialization['fats'] as num).toDouble(),
    );
  }

  int foodId;

  int servingSizeId;

  double servingQuantity;

  double quantityGrams;

  double calories;

  double proteins;

  double carbs;

  double fats;

  /// Returns a shallow copy of this [CreateMealPlanFoodDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CreateMealPlanFoodDto copyWith({
    int? foodId,
    int? servingSizeId,
    double? servingQuantity,
    double? quantityGrams,
    double? calories,
    double? proteins,
    double? carbs,
    double? fats,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CreateMealPlanFoodDto',
      'foodId': foodId,
      'servingSizeId': servingSizeId,
      'servingQuantity': servingQuantity,
      'quantityGrams': quantityGrams,
      'calories': calories,
      'proteins': proteins,
      'carbs': carbs,
      'fats': fats,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _CreateMealPlanFoodDtoImpl extends CreateMealPlanFoodDto {
  _CreateMealPlanFoodDtoImpl({
    required int foodId,
    required int servingSizeId,
    required double servingQuantity,
    required double quantityGrams,
    required double calories,
    required double proteins,
    required double carbs,
    required double fats,
  }) : super._(
         foodId: foodId,
         servingSizeId: servingSizeId,
         servingQuantity: servingQuantity,
         quantityGrams: quantityGrams,
         calories: calories,
         proteins: proteins,
         carbs: carbs,
         fats: fats,
       );

  /// Returns a shallow copy of this [CreateMealPlanFoodDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CreateMealPlanFoodDto copyWith({
    int? foodId,
    int? servingSizeId,
    double? servingQuantity,
    double? quantityGrams,
    double? calories,
    double? proteins,
    double? carbs,
    double? fats,
  }) {
    return CreateMealPlanFoodDto(
      foodId: foodId ?? this.foodId,
      servingSizeId: servingSizeId ?? this.servingSizeId,
      servingQuantity: servingQuantity ?? this.servingQuantity,
      quantityGrams: quantityGrams ?? this.quantityGrams,
      calories: calories ?? this.calories,
      proteins: proteins ?? this.proteins,
      carbs: carbs ?? this.carbs,
      fats: fats ?? this.fats,
    );
  }
}
