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
import '../../../features/food/models/food.dart' as _i2;
import 'package:fitbodyrd_client/src/protocol/protocol.dart' as _i3;

abstract class FoodMicronutrient implements _i1.SerializableModel {
  FoodMicronutrient._({
    this.id,
    required this.foodId,
    this.food,
    required this.name,
    required this.amount,
    required this.unit,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory FoodMicronutrient({
    int? id,
    required int foodId,
    _i2.Food? food,
    required String name,
    required double amount,
    required String unit,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _FoodMicronutrientImpl;

  factory FoodMicronutrient.fromJson(Map<String, dynamic> jsonSerialization) {
    return FoodMicronutrient(
      id: jsonSerialization['id'] as int?,
      foodId: jsonSerialization['foodId'] as int,
      food: jsonSerialization['food'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Food>(jsonSerialization['food']),
      name: jsonSerialization['name'] as String,
      amount: (jsonSerialization['amount'] as num).toDouble(),
      unit: jsonSerialization['unit'] as String,
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

  int foodId;

  /// The food item associated with these micronutrients.
  _i2.Food? food;

  String name;

  double amount;

  String unit;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [FoodMicronutrient]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FoodMicronutrient copyWith({
    int? id,
    int? foodId,
    _i2.Food? food,
    String? name,
    double? amount,
    String? unit,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FoodMicronutrient',
      if (id != null) 'id': id,
      'foodId': foodId,
      if (food != null) 'food': food?.toJson(),
      'name': name,
      'amount': amount,
      'unit': unit,
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

class _FoodMicronutrientImpl extends FoodMicronutrient {
  _FoodMicronutrientImpl({
    int? id,
    required int foodId,
    _i2.Food? food,
    required String name,
    required double amount,
    required String unit,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         foodId: foodId,
         food: food,
         name: name,
         amount: amount,
         unit: unit,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [FoodMicronutrient]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FoodMicronutrient copyWith({
    Object? id = _Undefined,
    int? foodId,
    Object? food = _Undefined,
    String? name,
    double? amount,
    String? unit,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FoodMicronutrient(
      id: id is int? ? id : this.id,
      foodId: foodId ?? this.foodId,
      food: food is _i2.Food? ? food : this.food?.copyWith(),
      name: name ?? this.name,
      amount: amount ?? this.amount,
      unit: unit ?? this.unit,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
