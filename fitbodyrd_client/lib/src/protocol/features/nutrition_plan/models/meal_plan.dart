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
import '../../../features/nutrition_plan/models/nutrition_plan.dart' as _i2;
import '../../../features/nutrition_plan/models/meal_type.dart' as _i3;
import '../../../features/nutrition_plan/models/meal_plan_food.dart' as _i4;
import 'package:fitbodyrd_client/src/protocol/protocol.dart' as _i5;

abstract class MealPlan implements _i1.SerializableModel {
  MealPlan._({
    this.id,
    required this.nutritionPlanId,
    this.nutritionPlan,
    required this.date,
    required this.dayNumber,
    required this.mealType,
    required this.targetCalories,
    required this.targetProteins,
    required this.targetCarbs,
    required this.targetFats,
    this.notes,
    this.mealPlanFoods,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory MealPlan({
    int? id,
    required int nutritionPlanId,
    _i2.NutritionPlan? nutritionPlan,
    required DateTime date,
    required int dayNumber,
    required _i3.MealPlanType mealType,
    required double targetCalories,
    required double targetProteins,
    required double targetCarbs,
    required double targetFats,
    String? notes,
    List<_i4.MealPlanFood>? mealPlanFoods,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _MealPlanImpl;

  factory MealPlan.fromJson(Map<String, dynamic> jsonSerialization) {
    return MealPlan(
      id: jsonSerialization['id'] as int?,
      nutritionPlanId: jsonSerialization['nutritionPlanId'] as int,
      nutritionPlan: jsonSerialization['nutritionPlan'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.NutritionPlan>(
              jsonSerialization['nutritionPlan'],
            ),
      date: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      dayNumber: jsonSerialization['dayNumber'] as int,
      mealType: _i3.MealPlanType.fromJson(
        (jsonSerialization['mealType'] as String),
      ),
      targetCalories: (jsonSerialization['targetCalories'] as num).toDouble(),
      targetProteins: (jsonSerialization['targetProteins'] as num).toDouble(),
      targetCarbs: (jsonSerialization['targetCarbs'] as num).toDouble(),
      targetFats: (jsonSerialization['targetFats'] as num).toDouble(),
      notes: jsonSerialization['notes'] as String?,
      mealPlanFoods: jsonSerialization['mealPlanFoods'] == null
          ? null
          : _i5.Protocol().deserialize<List<_i4.MealPlanFood>>(
              jsonSerialization['mealPlanFoods'],
            ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int nutritionPlanId;

  _i2.NutritionPlan? nutritionPlan;

  DateTime date;

  int dayNumber;

  _i3.MealPlanType mealType;

  double targetCalories;

  double targetProteins;

  double targetCarbs;

  double targetFats;

  String? notes;

  List<_i4.MealPlanFood>? mealPlanFoods;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [MealPlan]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MealPlan copyWith({
    int? id,
    int? nutritionPlanId,
    _i2.NutritionPlan? nutritionPlan,
    DateTime? date,
    int? dayNumber,
    _i3.MealPlanType? mealType,
    double? targetCalories,
    double? targetProteins,
    double? targetCarbs,
    double? targetFats,
    String? notes,
    List<_i4.MealPlanFood>? mealPlanFoods,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MealPlan',
      if (id != null) 'id': id,
      'nutritionPlanId': nutritionPlanId,
      if (nutritionPlan != null) 'nutritionPlan': nutritionPlan?.toJson(),
      'date': date.toJson(),
      'dayNumber': dayNumber,
      'mealType': mealType.toJson(),
      'targetCalories': targetCalories,
      'targetProteins': targetProteins,
      'targetCarbs': targetCarbs,
      'targetFats': targetFats,
      if (notes != null) 'notes': notes,
      if (mealPlanFoods != null)
        'mealPlanFoods': mealPlanFoods?.toJson(valueToJson: (v) => v.toJson()),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MealPlanImpl extends MealPlan {
  _MealPlanImpl({
    int? id,
    required int nutritionPlanId,
    _i2.NutritionPlan? nutritionPlan,
    required DateTime date,
    required int dayNumber,
    required _i3.MealPlanType mealType,
    required double targetCalories,
    required double targetProteins,
    required double targetCarbs,
    required double targetFats,
    String? notes,
    List<_i4.MealPlanFood>? mealPlanFoods,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         nutritionPlanId: nutritionPlanId,
         nutritionPlan: nutritionPlan,
         date: date,
         dayNumber: dayNumber,
         mealType: mealType,
         targetCalories: targetCalories,
         targetProteins: targetProteins,
         targetCarbs: targetCarbs,
         targetFats: targetFats,
         notes: notes,
         mealPlanFoods: mealPlanFoods,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [MealPlan]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MealPlan copyWith({
    Object? id = _Undefined,
    int? nutritionPlanId,
    Object? nutritionPlan = _Undefined,
    DateTime? date,
    int? dayNumber,
    _i3.MealPlanType? mealType,
    double? targetCalories,
    double? targetProteins,
    double? targetCarbs,
    double? targetFats,
    Object? notes = _Undefined,
    Object? mealPlanFoods = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MealPlan(
      id: id is int? ? id : this.id,
      nutritionPlanId: nutritionPlanId ?? this.nutritionPlanId,
      nutritionPlan: nutritionPlan is _i2.NutritionPlan?
          ? nutritionPlan
          : this.nutritionPlan?.copyWith(),
      date: date ?? this.date,
      dayNumber: dayNumber ?? this.dayNumber,
      mealType: mealType ?? this.mealType,
      targetCalories: targetCalories ?? this.targetCalories,
      targetProteins: targetProteins ?? this.targetProteins,
      targetCarbs: targetCarbs ?? this.targetCarbs,
      targetFats: targetFats ?? this.targetFats,
      notes: notes is String? ? notes : this.notes,
      mealPlanFoods: mealPlanFoods is List<_i4.MealPlanFood>?
          ? mealPlanFoods
          : this.mealPlanFoods?.map((e0) => e0.copyWith()).toList(),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
