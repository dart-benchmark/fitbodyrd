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

abstract class CreateFoodIntakeLog implements _i1.SerializableModel {
  CreateFoodIntakeLog._({
    this.mealPlanId,
    required this.foodId,
    required this.date,
    required this.mealType,
    this.servingSizeId,
    required this.servingQuantity,
    required this.quantityGrams,
    this.notes,
  });

  factory CreateFoodIntakeLog({
    int? mealPlanId,
    required int foodId,
    required DateTime date,
    required _i2.MealPlanType mealType,
    int? servingSizeId,
    required double servingQuantity,
    required double quantityGrams,
    String? notes,
  }) = _CreateFoodIntakeLogImpl;

  factory CreateFoodIntakeLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return CreateFoodIntakeLog(
      mealPlanId: jsonSerialization['mealPlanId'] as int?,
      foodId: jsonSerialization['foodId'] as int,
      date: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      mealType: _i2.MealPlanType.fromJson(
        (jsonSerialization['mealType'] as String),
      ),
      servingSizeId: jsonSerialization['servingSizeId'] as int?,
      servingQuantity: (jsonSerialization['servingQuantity'] as num).toDouble(),
      quantityGrams: (jsonSerialization['quantityGrams'] as num).toDouble(),
      notes: jsonSerialization['notes'] as String?,
    );
  }

  int? mealPlanId;

  int foodId;

  DateTime date;

  _i2.MealPlanType mealType;

  int? servingSizeId;

  double servingQuantity;

  double quantityGrams;

  String? notes;

  /// Returns a shallow copy of this [CreateFoodIntakeLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CreateFoodIntakeLog copyWith({
    int? mealPlanId,
    int? foodId,
    DateTime? date,
    _i2.MealPlanType? mealType,
    int? servingSizeId,
    double? servingQuantity,
    double? quantityGrams,
    String? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CreateFoodIntakeLog',
      if (mealPlanId != null) 'mealPlanId': mealPlanId,
      'foodId': foodId,
      'date': date.toJson(),
      'mealType': mealType.toJson(),
      if (servingSizeId != null) 'servingSizeId': servingSizeId,
      'servingQuantity': servingQuantity,
      'quantityGrams': quantityGrams,
      if (notes != null) 'notes': notes,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CreateFoodIntakeLogImpl extends CreateFoodIntakeLog {
  _CreateFoodIntakeLogImpl({
    int? mealPlanId,
    required int foodId,
    required DateTime date,
    required _i2.MealPlanType mealType,
    int? servingSizeId,
    required double servingQuantity,
    required double quantityGrams,
    String? notes,
  }) : super._(
         mealPlanId: mealPlanId,
         foodId: foodId,
         date: date,
         mealType: mealType,
         servingSizeId: servingSizeId,
         servingQuantity: servingQuantity,
         quantityGrams: quantityGrams,
         notes: notes,
       );

  /// Returns a shallow copy of this [CreateFoodIntakeLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CreateFoodIntakeLog copyWith({
    Object? mealPlanId = _Undefined,
    int? foodId,
    DateTime? date,
    _i2.MealPlanType? mealType,
    Object? servingSizeId = _Undefined,
    double? servingQuantity,
    double? quantityGrams,
    Object? notes = _Undefined,
  }) {
    return CreateFoodIntakeLog(
      mealPlanId: mealPlanId is int? ? mealPlanId : this.mealPlanId,
      foodId: foodId ?? this.foodId,
      date: date ?? this.date,
      mealType: mealType ?? this.mealType,
      servingSizeId: servingSizeId is int? ? servingSizeId : this.servingSizeId,
      servingQuantity: servingQuantity ?? this.servingQuantity,
      quantityGrams: quantityGrams ?? this.quantityGrams,
      notes: notes is String? ? notes : this.notes,
    );
  }
}
