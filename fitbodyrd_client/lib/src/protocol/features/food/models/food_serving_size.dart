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

abstract class FoodServingSize implements _i1.SerializableModel {
  FoodServingSize._({
    this.id,
    required this.foodId,
    this.food,
    required this.name,
    required this.grams,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : isDefault = isDefault ?? false,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory FoodServingSize({
    int? id,
    required int foodId,
    _i2.Food? food,
    required String name,
    required double grams,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _FoodServingSizeImpl;

  factory FoodServingSize.fromJson(Map<String, dynamic> jsonSerialization) {
    return FoodServingSize(
      id: jsonSerialization['id'] as int?,
      foodId: jsonSerialization['foodId'] as int,
      food: jsonSerialization['food'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Food>(jsonSerialization['food']),
      name: jsonSerialization['name'] as String,
      grams: (jsonSerialization['grams'] as num).toDouble(),
      isDefault: jsonSerialization['isDefault'] as bool,
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

  _i2.Food? food;

  String name;

  double grams;

  bool isDefault;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [FoodServingSize]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FoodServingSize copyWith({
    int? id,
    int? foodId,
    _i2.Food? food,
    String? name,
    double? grams,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FoodServingSize',
      if (id != null) 'id': id,
      'foodId': foodId,
      if (food != null) 'food': food?.toJson(),
      'name': name,
      'grams': grams,
      'isDefault': isDefault,
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

class _FoodServingSizeImpl extends FoodServingSize {
  _FoodServingSizeImpl({
    int? id,
    required int foodId,
    _i2.Food? food,
    required String name,
    required double grams,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         foodId: foodId,
         food: food,
         name: name,
         grams: grams,
         isDefault: isDefault,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [FoodServingSize]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FoodServingSize copyWith({
    Object? id = _Undefined,
    int? foodId,
    Object? food = _Undefined,
    String? name,
    double? grams,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FoodServingSize(
      id: id is int? ? id : this.id,
      foodId: foodId ?? this.foodId,
      food: food is _i2.Food? ? food : this.food?.copyWith(),
      name: name ?? this.name,
      grams: grams ?? this.grams,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
