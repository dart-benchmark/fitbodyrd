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
import '../../../features/user/models/app_user.dart' as _i3;
import '../../../features/food/models/food_micronutrient.dart' as _i4;
import '../../../features/food/models/food_serving_size.dart' as _i5;
import 'package:fitbodyrd_client/src/protocol/protocol.dart' as _i6;

abstract class Food implements _i1.SerializableModel {
  Food._({
    this.id,
    required this.name,
    required this.categoryId,
    this.category,
    required this.calories,
    required this.proteins,
    required this.carbs,
    required this.fats,
    required this.fiber,
    bool? isActive,
    bool? isLocal,
    this.imageUrl,
    this.brand,
    this.barcode,
    bool? isCustom,
    this.createdByUserIdId,
    this.createdByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.micronutrients,
    this.servingSizes,
  }) : isActive = isActive ?? true,
       isLocal = isLocal ?? true,
       isCustom = isCustom ?? false,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Food({
    int? id,
    required String name,
    required int categoryId,
    _i2.FoodCategory? category,
    required double calories,
    required double proteins,
    required double carbs,
    required double fats,
    required double fiber,
    bool? isActive,
    bool? isLocal,
    String? imageUrl,
    String? brand,
    String? barcode,
    bool? isCustom,
    int? createdByUserIdId,
    _i3.UserProfile? createdByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<_i4.FoodMicronutrient>? micronutrients,
    List<_i5.FoodServingSize>? servingSizes,
  }) = _FoodImpl;

  factory Food.fromJson(Map<String, dynamic> jsonSerialization) {
    return Food(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      categoryId: jsonSerialization['categoryId'] as int,
      category: jsonSerialization['category'] == null
          ? null
          : _i6.Protocol().deserialize<_i2.FoodCategory>(
              jsonSerialization['category'],
            ),
      calories: (jsonSerialization['calories'] as num).toDouble(),
      proteins: (jsonSerialization['proteins'] as num).toDouble(),
      carbs: (jsonSerialization['carbs'] as num).toDouble(),
      fats: (jsonSerialization['fats'] as num).toDouble(),
      fiber: (jsonSerialization['fiber'] as num).toDouble(),
      isActive: jsonSerialization['isActive'] as bool,
      isLocal: jsonSerialization['isLocal'] as bool,
      imageUrl: jsonSerialization['imageUrl'] as String?,
      brand: jsonSerialization['brand'] as String?,
      barcode: jsonSerialization['barcode'] as String?,
      isCustom: jsonSerialization['isCustom'] as bool,
      createdByUserIdId: jsonSerialization['createdByUserIdId'] as int?,
      createdByUserId: jsonSerialization['createdByUserId'] == null
          ? null
          : _i6.Protocol().deserialize<_i3.UserProfile>(
              jsonSerialization['createdByUserId'],
            ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
      micronutrients: jsonSerialization['micronutrients'] == null
          ? null
          : _i6.Protocol().deserialize<List<_i4.FoodMicronutrient>>(
              jsonSerialization['micronutrients'],
            ),
      servingSizes: jsonSerialization['servingSizes'] == null
          ? null
          : _i6.Protocol().deserialize<List<_i5.FoodServingSize>>(
              jsonSerialization['servingSizes'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Name of the food item
  String name;

  int categoryId;

  /// Category of the food item
  _i2.FoodCategory? category;

  /// Caloric content per 100g
  double calories;

  /// Proteins in grams per 100g
  double proteins;

  /// Carbohydrates in grams per 100g
  double carbs;

  /// Fats in grams per 100g
  double fats;

  /// Fiber in grams per 100g
  double fiber;

  /// Indicates if the food item is active or deprecated
  bool isActive;

  /// Indicates if the food item is locally available
  bool isLocal;

  /// URL of the food image
  String? imageUrl;

  /// Brand of the food item
  String? brand;

  /// Barcode of the food item
  String? barcode;

  /// Indicates if the food item was created by a user
  bool isCustom;

  int? createdByUserIdId;

  /// ID of the user who created the food item (if custom)
  _i3.UserProfile? createdByUserId;

  /// Timestamp when the food item was created
  DateTime createdAt;

  /// Timestamp when the food item was last updated
  DateTime updatedAt;

  /// Micronutrients associated with the food item
  List<_i4.FoodMicronutrient>? micronutrients;

  /// Serving sizes available for the food item
  List<_i5.FoodServingSize>? servingSizes;

  /// Returns a shallow copy of this [Food]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Food copyWith({
    int? id,
    String? name,
    int? categoryId,
    _i2.FoodCategory? category,
    double? calories,
    double? proteins,
    double? carbs,
    double? fats,
    double? fiber,
    bool? isActive,
    bool? isLocal,
    String? imageUrl,
    String? brand,
    String? barcode,
    bool? isCustom,
    int? createdByUserIdId,
    _i3.UserProfile? createdByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<_i4.FoodMicronutrient>? micronutrients,
    List<_i5.FoodServingSize>? servingSizes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Food',
      if (id != null) 'id': id,
      'name': name,
      'categoryId': categoryId,
      if (category != null) 'category': category?.toJson(),
      'calories': calories,
      'proteins': proteins,
      'carbs': carbs,
      'fats': fats,
      'fiber': fiber,
      'isActive': isActive,
      'isLocal': isLocal,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (brand != null) 'brand': brand,
      if (barcode != null) 'barcode': barcode,
      'isCustom': isCustom,
      if (createdByUserIdId != null) 'createdByUserIdId': createdByUserIdId,
      if (createdByUserId != null) 'createdByUserId': createdByUserId?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (micronutrients != null)
        'micronutrients': micronutrients?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (servingSizes != null)
        'servingSizes': servingSizes?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FoodImpl extends Food {
  _FoodImpl({
    int? id,
    required String name,
    required int categoryId,
    _i2.FoodCategory? category,
    required double calories,
    required double proteins,
    required double carbs,
    required double fats,
    required double fiber,
    bool? isActive,
    bool? isLocal,
    String? imageUrl,
    String? brand,
    String? barcode,
    bool? isCustom,
    int? createdByUserIdId,
    _i3.UserProfile? createdByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<_i4.FoodMicronutrient>? micronutrients,
    List<_i5.FoodServingSize>? servingSizes,
  }) : super._(
         id: id,
         name: name,
         categoryId: categoryId,
         category: category,
         calories: calories,
         proteins: proteins,
         carbs: carbs,
         fats: fats,
         fiber: fiber,
         isActive: isActive,
         isLocal: isLocal,
         imageUrl: imageUrl,
         brand: brand,
         barcode: barcode,
         isCustom: isCustom,
         createdByUserIdId: createdByUserIdId,
         createdByUserId: createdByUserId,
         createdAt: createdAt,
         updatedAt: updatedAt,
         micronutrients: micronutrients,
         servingSizes: servingSizes,
       );

  /// Returns a shallow copy of this [Food]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Food copyWith({
    Object? id = _Undefined,
    String? name,
    int? categoryId,
    Object? category = _Undefined,
    double? calories,
    double? proteins,
    double? carbs,
    double? fats,
    double? fiber,
    bool? isActive,
    bool? isLocal,
    Object? imageUrl = _Undefined,
    Object? brand = _Undefined,
    Object? barcode = _Undefined,
    bool? isCustom,
    Object? createdByUserIdId = _Undefined,
    Object? createdByUserId = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? micronutrients = _Undefined,
    Object? servingSizes = _Undefined,
  }) {
    return Food(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      category: category is _i2.FoodCategory?
          ? category
          : this.category?.copyWith(),
      calories: calories ?? this.calories,
      proteins: proteins ?? this.proteins,
      carbs: carbs ?? this.carbs,
      fats: fats ?? this.fats,
      fiber: fiber ?? this.fiber,
      isActive: isActive ?? this.isActive,
      isLocal: isLocal ?? this.isLocal,
      imageUrl: imageUrl is String? ? imageUrl : this.imageUrl,
      brand: brand is String? ? brand : this.brand,
      barcode: barcode is String? ? barcode : this.barcode,
      isCustom: isCustom ?? this.isCustom,
      createdByUserIdId: createdByUserIdId is int?
          ? createdByUserIdId
          : this.createdByUserIdId,
      createdByUserId: createdByUserId is _i3.UserProfile?
          ? createdByUserId
          : this.createdByUserId?.copyWith(),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      micronutrients: micronutrients is List<_i4.FoodMicronutrient>?
          ? micronutrients
          : this.micronutrients?.map((e0) => e0.copyWith()).toList(),
      servingSizes: servingSizes is List<_i5.FoodServingSize>?
          ? servingSizes
          : this.servingSizes?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
