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
import '../../../features/user/models/app_user.dart' as _i2;
import '../../../features/nutrition_plan/models/meal_plan.dart' as _i3;
import '../../../features/food/models/food.dart' as _i4;
import '../../../features/nutrition_plan/models/meal_type.dart' as _i5;
import '../../../features/food/models/food_serving_size.dart' as _i6;
import 'package:fitbodyrd_client/src/protocol/protocol.dart' as _i7;

abstract class FoodIntakeLog implements _i1.SerializableModel {
  FoodIntakeLog._({
    this.id,
    required this.userId,
    this.user,
    this.mealPlanId,
    this.mealPlan,
    required this.foodId,
    this.food,
    required this.date,
    required this.mealType,
    this.servingSizeId,
    this.servingSize,
    required this.servingQuantity,
    required this.quantityGrams,
    DateTime? consumedAt,
    this.notes,
    DateTime? createdAt,
  }) : consumedAt = consumedAt ?? DateTime.now(),
       createdAt = createdAt ?? DateTime.now();

  factory FoodIntakeLog({
    int? id,
    required int userId,
    _i2.UserProfile? user,
    int? mealPlanId,
    _i3.MealPlan? mealPlan,
    required int foodId,
    _i4.Food? food,
    required DateTime date,
    required _i5.MealPlanType mealType,
    int? servingSizeId,
    _i6.FoodServingSize? servingSize,
    required double servingQuantity,
    required double quantityGrams,
    DateTime? consumedAt,
    String? notes,
    DateTime? createdAt,
  }) = _FoodIntakeLogImpl;

  factory FoodIntakeLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return FoodIntakeLog(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i7.Protocol().deserialize<_i2.UserProfile>(
              jsonSerialization['user'],
            ),
      mealPlanId: jsonSerialization['mealPlanId'] as int?,
      mealPlan: jsonSerialization['mealPlan'] == null
          ? null
          : _i7.Protocol().deserialize<_i3.MealPlan>(
              jsonSerialization['mealPlan'],
            ),
      foodId: jsonSerialization['foodId'] as int,
      food: jsonSerialization['food'] == null
          ? null
          : _i7.Protocol().deserialize<_i4.Food>(jsonSerialization['food']),
      date: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      mealType: _i5.MealPlanType.fromJson(
        (jsonSerialization['mealType'] as String),
      ),
      servingSizeId: jsonSerialization['servingSizeId'] as int?,
      servingSize: jsonSerialization['servingSize'] == null
          ? null
          : _i7.Protocol().deserialize<_i6.FoodServingSize>(
              jsonSerialization['servingSize'],
            ),
      servingQuantity: (jsonSerialization['servingQuantity'] as num).toDouble(),
      quantityGrams: (jsonSerialization['quantityGrams'] as num).toDouble(),
      consumedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['consumedAt'],
      ),
      notes: jsonSerialization['notes'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  _i2.UserProfile? user;

  int? mealPlanId;

  _i3.MealPlan? mealPlan;

  int foodId;

  _i4.Food? food;

  DateTime date;

  _i5.MealPlanType mealType;

  int? servingSizeId;

  _i6.FoodServingSize? servingSize;

  double servingQuantity;

  double quantityGrams;

  DateTime consumedAt;

  String? notes;

  DateTime createdAt;

  /// Returns a shallow copy of this [FoodIntakeLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FoodIntakeLog copyWith({
    int? id,
    int? userId,
    _i2.UserProfile? user,
    int? mealPlanId,
    _i3.MealPlan? mealPlan,
    int? foodId,
    _i4.Food? food,
    DateTime? date,
    _i5.MealPlanType? mealType,
    int? servingSizeId,
    _i6.FoodServingSize? servingSize,
    double? servingQuantity,
    double? quantityGrams,
    DateTime? consumedAt,
    String? notes,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FoodIntakeLog',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      if (mealPlanId != null) 'mealPlanId': mealPlanId,
      if (mealPlan != null) 'mealPlan': mealPlan?.toJson(),
      'foodId': foodId,
      if (food != null) 'food': food?.toJson(),
      'date': date.toJson(),
      'mealType': mealType.toJson(),
      if (servingSizeId != null) 'servingSizeId': servingSizeId,
      if (servingSize != null) 'servingSize': servingSize?.toJson(),
      'servingQuantity': servingQuantity,
      'quantityGrams': quantityGrams,
      'consumedAt': consumedAt.toJson(),
      if (notes != null) 'notes': notes,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FoodIntakeLogImpl extends FoodIntakeLog {
  _FoodIntakeLogImpl({
    int? id,
    required int userId,
    _i2.UserProfile? user,
    int? mealPlanId,
    _i3.MealPlan? mealPlan,
    required int foodId,
    _i4.Food? food,
    required DateTime date,
    required _i5.MealPlanType mealType,
    int? servingSizeId,
    _i6.FoodServingSize? servingSize,
    required double servingQuantity,
    required double quantityGrams,
    DateTime? consumedAt,
    String? notes,
    DateTime? createdAt,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         mealPlanId: mealPlanId,
         mealPlan: mealPlan,
         foodId: foodId,
         food: food,
         date: date,
         mealType: mealType,
         servingSizeId: servingSizeId,
         servingSize: servingSize,
         servingQuantity: servingQuantity,
         quantityGrams: quantityGrams,
         consumedAt: consumedAt,
         notes: notes,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [FoodIntakeLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FoodIntakeLog copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    Object? mealPlanId = _Undefined,
    Object? mealPlan = _Undefined,
    int? foodId,
    Object? food = _Undefined,
    DateTime? date,
    _i5.MealPlanType? mealType,
    Object? servingSizeId = _Undefined,
    Object? servingSize = _Undefined,
    double? servingQuantity,
    double? quantityGrams,
    DateTime? consumedAt,
    Object? notes = _Undefined,
    DateTime? createdAt,
  }) {
    return FoodIntakeLog(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.UserProfile? ? user : this.user?.copyWith(),
      mealPlanId: mealPlanId is int? ? mealPlanId : this.mealPlanId,
      mealPlan: mealPlan is _i3.MealPlan?
          ? mealPlan
          : this.mealPlan?.copyWith(),
      foodId: foodId ?? this.foodId,
      food: food is _i4.Food? ? food : this.food?.copyWith(),
      date: date ?? this.date,
      mealType: mealType ?? this.mealType,
      servingSizeId: servingSizeId is int? ? servingSizeId : this.servingSizeId,
      servingSize: servingSize is _i6.FoodServingSize?
          ? servingSize
          : this.servingSize?.copyWith(),
      servingQuantity: servingQuantity ?? this.servingQuantity,
      quantityGrams: quantityGrams ?? this.quantityGrams,
      consumedAt: consumedAt ?? this.consumedAt,
      notes: notes is String? ? notes : this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
