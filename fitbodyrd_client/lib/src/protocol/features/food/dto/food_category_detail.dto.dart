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

abstract class FoodCategoryDetailDto implements _i1.SerializableModel {
  FoodCategoryDetailDto._({
    required this.category,
    required this.categoryId,
    required this.foods,
  });

  factory FoodCategoryDetailDto({
    required String category,
    required int categoryId,
    required List<_i2.Food> foods,
  }) = _FoodCategoryDetailDtoImpl;

  factory FoodCategoryDetailDto.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return FoodCategoryDetailDto(
      category: jsonSerialization['category'] as String,
      categoryId: jsonSerialization['categoryId'] as int,
      foods: _i3.Protocol().deserialize<List<_i2.Food>>(
        jsonSerialization['foods'],
      ),
    );
  }

  String category;

  int categoryId;

  List<_i2.Food> foods;

  /// Returns a shallow copy of this [FoodCategoryDetailDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FoodCategoryDetailDto copyWith({
    String? category,
    int? categoryId,
    List<_i2.Food>? foods,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FoodCategoryDetailDto',
      'category': category,
      'categoryId': categoryId,
      'foods': foods.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _FoodCategoryDetailDtoImpl extends FoodCategoryDetailDto {
  _FoodCategoryDetailDtoImpl({
    required String category,
    required int categoryId,
    required List<_i2.Food> foods,
  }) : super._(
         category: category,
         categoryId: categoryId,
         foods: foods,
       );

  /// Returns a shallow copy of this [FoodCategoryDetailDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FoodCategoryDetailDto copyWith({
    String? category,
    int? categoryId,
    List<_i2.Food>? foods,
  }) {
    return FoodCategoryDetailDto(
      category: category ?? this.category,
      categoryId: categoryId ?? this.categoryId,
      foods: foods ?? this.foods.map((e0) => e0.copyWith()).toList(),
    );
  }
}
