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
import '../../../features/food/models/food_category.dart' as _i2;
import '../../../features/food/models/food.dart' as _i3;
import 'package:fitbodyrd_client/src/protocol/protocol.dart' as _i4;

abstract class FoodCategory implements _i1.SerializableModel {
  FoodCategory._({
    this.id,
    required this.name,
    required this.slug,
    required this.iconName,
    this.parentCategoryId,
    this.parentCategory,
    this.subCategories,
    required this.colorHex,
    int? displayOrder,
    this.foods,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : displayOrder = displayOrder ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory FoodCategory({
    int? id,
    required String name,
    required String slug,
    required String iconName,
    int? parentCategoryId,
    _i2.FoodCategory? parentCategory,
    List<_i2.FoodCategory>? subCategories,
    required String colorHex,
    int? displayOrder,
    List<_i3.Food>? foods,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _FoodCategoryImpl;

  factory FoodCategory.fromJson(Map<String, dynamic> jsonSerialization) {
    return FoodCategory(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      slug: jsonSerialization['slug'] as String,
      iconName: jsonSerialization['iconName'] as String,
      parentCategoryId: jsonSerialization['parentCategoryId'] as int?,
      parentCategory: jsonSerialization['parentCategory'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.FoodCategory>(
              jsonSerialization['parentCategory'],
            ),
      subCategories: jsonSerialization['subCategories'] == null
          ? null
          : _i4.Protocol().deserialize<List<_i2.FoodCategory>>(
              jsonSerialization['subCategories'],
            ),
      colorHex: jsonSerialization['colorHex'] as String,
      displayOrder: jsonSerialization['displayOrder'] as int,
      foods: jsonSerialization['foods'] == null
          ? null
          : _i4.Protocol().deserialize<List<_i3.Food>>(
              jsonSerialization['foods'],
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

  String name;

  String slug;

  String iconName;

  int? parentCategoryId;

  _i2.FoodCategory? parentCategory;

  List<_i2.FoodCategory>? subCategories;

  String colorHex;

  int displayOrder;

  List<_i3.Food>? foods;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [FoodCategory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FoodCategory copyWith({
    int? id,
    String? name,
    String? slug,
    String? iconName,
    int? parentCategoryId,
    _i2.FoodCategory? parentCategory,
    List<_i2.FoodCategory>? subCategories,
    String? colorHex,
    int? displayOrder,
    List<_i3.Food>? foods,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FoodCategory',
      if (id != null) 'id': id,
      'name': name,
      'slug': slug,
      'iconName': iconName,
      if (parentCategoryId != null) 'parentCategoryId': parentCategoryId,
      if (parentCategory != null) 'parentCategory': parentCategory?.toJson(),
      if (subCategories != null)
        'subCategories': subCategories?.toJson(valueToJson: (v) => v.toJson()),
      'colorHex': colorHex,
      'displayOrder': displayOrder,
      if (foods != null) 'foods': foods?.toJson(valueToJson: (v) => v.toJson()),
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

class _FoodCategoryImpl extends FoodCategory {
  _FoodCategoryImpl({
    int? id,
    required String name,
    required String slug,
    required String iconName,
    int? parentCategoryId,
    _i2.FoodCategory? parentCategory,
    List<_i2.FoodCategory>? subCategories,
    required String colorHex,
    int? displayOrder,
    List<_i3.Food>? foods,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         name: name,
         slug: slug,
         iconName: iconName,
         parentCategoryId: parentCategoryId,
         parentCategory: parentCategory,
         subCategories: subCategories,
         colorHex: colorHex,
         displayOrder: displayOrder,
         foods: foods,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [FoodCategory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FoodCategory copyWith({
    Object? id = _Undefined,
    String? name,
    String? slug,
    String? iconName,
    Object? parentCategoryId = _Undefined,
    Object? parentCategory = _Undefined,
    Object? subCategories = _Undefined,
    String? colorHex,
    int? displayOrder,
    Object? foods = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FoodCategory(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      iconName: iconName ?? this.iconName,
      parentCategoryId: parentCategoryId is int?
          ? parentCategoryId
          : this.parentCategoryId,
      parentCategory: parentCategory is _i2.FoodCategory?
          ? parentCategory
          : this.parentCategory?.copyWith(),
      subCategories: subCategories is List<_i2.FoodCategory>?
          ? subCategories
          : this.subCategories?.map((e0) => e0.copyWith()).toList(),
      colorHex: colorHex ?? this.colorHex,
      displayOrder: displayOrder ?? this.displayOrder,
      foods: foods is List<_i3.Food>?
          ? foods
          : this.foods?.map((e0) => e0.copyWith()).toList(),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
