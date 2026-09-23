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
import '../../../features/nutrition_plan/models/meal_plan.dart' as _i2;
import '../../../features/food/models/food.dart' as _i3;
import '../../../features/food/models/food_serving_size.dart' as _i4;
import '../../../features/user/models/app_user.dart' as _i5;
import 'package:fitbodyrd_client/src/protocol/protocol.dart' as _i6;

abstract class MealPlanFood implements _i1.SerializableModel {
  MealPlanFood._({
    this.id,
    required this.mealPlanId,
    this.mealPlan,
    required this.foodId,
    this.food,
    required this.servingSizeId,
    this.servingSize,
    required this.servingQuantity,
    required this.quantityGrams,
    bool? isUserModified,
    bool? wasUserDeleted,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.deletedAt,
    this.deletedById,
    this.deletedBy,
  }) : isUserModified = isUserModified ?? false,
       wasUserDeleted = wasUserDeleted ?? false,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory MealPlanFood({
    int? id,
    required int mealPlanId,
    _i2.MealPlan? mealPlan,
    required int foodId,
    _i3.Food? food,
    required int servingSizeId,
    _i4.FoodServingSize? servingSize,
    required double servingQuantity,
    required double quantityGrams,
    bool? isUserModified,
    bool? wasUserDeleted,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    int? deletedById,
    _i5.UserProfile? deletedBy,
  }) = _MealPlanFoodImpl;

  factory MealPlanFood.fromJson(Map<String, dynamic> jsonSerialization) {
    return MealPlanFood(
      id: jsonSerialization['id'] as int?,
      mealPlanId: jsonSerialization['mealPlanId'] as int,
      mealPlan: jsonSerialization['mealPlan'] == null
          ? null
          : _i6.Protocol().deserialize<_i2.MealPlan>(
              jsonSerialization['mealPlan'],
            ),
      foodId: jsonSerialization['foodId'] as int,
      food: jsonSerialization['food'] == null
          ? null
          : _i6.Protocol().deserialize<_i3.Food>(jsonSerialization['food']),
      servingSizeId: jsonSerialization['servingSizeId'] as int,
      servingSize: jsonSerialization['servingSize'] == null
          ? null
          : _i6.Protocol().deserialize<_i4.FoodServingSize>(
              jsonSerialization['servingSize'],
            ),
      servingQuantity: (jsonSerialization['servingQuantity'] as num).toDouble(),
      quantityGrams: (jsonSerialization['quantityGrams'] as num).toDouble(),
      isUserModified: jsonSerialization['isUserModified'] as bool,
      wasUserDeleted: jsonSerialization['wasUserDeleted'] as bool,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
      deletedAt: jsonSerialization['deletedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['deletedAt']),
      deletedById: jsonSerialization['deletedById'] as int?,
      deletedBy: jsonSerialization['deletedBy'] == null
          ? null
          : _i6.Protocol().deserialize<_i5.UserProfile>(
              jsonSerialization['deletedBy'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int mealPlanId;

  _i2.MealPlan? mealPlan;

  int foodId;

  _i3.Food? food;

  int servingSizeId;

  _i4.FoodServingSize? servingSize;

  double servingQuantity;

  double quantityGrams;

  bool isUserModified;

  bool wasUserDeleted;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? deletedAt;

  int? deletedById;

  _i5.UserProfile? deletedBy;

  /// Returns a shallow copy of this [MealPlanFood]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MealPlanFood copyWith({
    int? id,
    int? mealPlanId,
    _i2.MealPlan? mealPlan,
    int? foodId,
    _i3.Food? food,
    int? servingSizeId,
    _i4.FoodServingSize? servingSize,
    double? servingQuantity,
    double? quantityGrams,
    bool? isUserModified,
    bool? wasUserDeleted,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    int? deletedById,
    _i5.UserProfile? deletedBy,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MealPlanFood',
      if (id != null) 'id': id,
      'mealPlanId': mealPlanId,
      if (mealPlan != null) 'mealPlan': mealPlan?.toJson(),
      'foodId': foodId,
      if (food != null) 'food': food?.toJson(),
      'servingSizeId': servingSizeId,
      if (servingSize != null) 'servingSize': servingSize?.toJson(),
      'servingQuantity': servingQuantity,
      'quantityGrams': quantityGrams,
      'isUserModified': isUserModified,
      'wasUserDeleted': wasUserDeleted,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
      if (deletedById != null) 'deletedById': deletedById,
      if (deletedBy != null) 'deletedBy': deletedBy?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MealPlanFoodImpl extends MealPlanFood {
  _MealPlanFoodImpl({
    int? id,
    required int mealPlanId,
    _i2.MealPlan? mealPlan,
    required int foodId,
    _i3.Food? food,
    required int servingSizeId,
    _i4.FoodServingSize? servingSize,
    required double servingQuantity,
    required double quantityGrams,
    bool? isUserModified,
    bool? wasUserDeleted,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    int? deletedById,
    _i5.UserProfile? deletedBy,
  }) : super._(
         id: id,
         mealPlanId: mealPlanId,
         mealPlan: mealPlan,
         foodId: foodId,
         food: food,
         servingSizeId: servingSizeId,
         servingSize: servingSize,
         servingQuantity: servingQuantity,
         quantityGrams: quantityGrams,
         isUserModified: isUserModified,
         wasUserDeleted: wasUserDeleted,
         createdAt: createdAt,
         updatedAt: updatedAt,
         deletedAt: deletedAt,
         deletedById: deletedById,
         deletedBy: deletedBy,
       );

  /// Returns a shallow copy of this [MealPlanFood]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MealPlanFood copyWith({
    Object? id = _Undefined,
    int? mealPlanId,
    Object? mealPlan = _Undefined,
    int? foodId,
    Object? food = _Undefined,
    int? servingSizeId,
    Object? servingSize = _Undefined,
    double? servingQuantity,
    double? quantityGrams,
    bool? isUserModified,
    bool? wasUserDeleted,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? deletedAt = _Undefined,
    Object? deletedById = _Undefined,
    Object? deletedBy = _Undefined,
  }) {
    return MealPlanFood(
      id: id is int? ? id : this.id,
      mealPlanId: mealPlanId ?? this.mealPlanId,
      mealPlan: mealPlan is _i2.MealPlan?
          ? mealPlan
          : this.mealPlan?.copyWith(),
      foodId: foodId ?? this.foodId,
      food: food is _i3.Food? ? food : this.food?.copyWith(),
      servingSizeId: servingSizeId ?? this.servingSizeId,
      servingSize: servingSize is _i4.FoodServingSize?
          ? servingSize
          : this.servingSize?.copyWith(),
      servingQuantity: servingQuantity ?? this.servingQuantity,
      quantityGrams: quantityGrams ?? this.quantityGrams,
      isUserModified: isUserModified ?? this.isUserModified,
      wasUserDeleted: wasUserDeleted ?? this.wasUserDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
      deletedById: deletedById is int? ? deletedById : this.deletedById,
      deletedBy: deletedBy is _i5.UserProfile?
          ? deletedBy
          : this.deletedBy?.copyWith(),
    );
  }
}
