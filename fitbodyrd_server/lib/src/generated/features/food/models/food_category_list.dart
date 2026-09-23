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
import 'package:serverpod/serverpod.dart' as _i1;
import '../../../features/food/models/food_category.dart' as _i2;
import 'package:fitbodyrd_server/src/generated/protocol.dart' as _i3;

abstract class FoodCategoryList
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  FoodCategoryList._({required this.categories});

  factory FoodCategoryList({required List<_i2.FoodCategory> categories}) =
      _FoodCategoryListImpl;

  factory FoodCategoryList.fromJson(Map<String, dynamic> jsonSerialization) {
    return FoodCategoryList(
      categories: _i3.Protocol().deserialize<List<_i2.FoodCategory>>(
        jsonSerialization['categories'],
      ),
    );
  }

  List<_i2.FoodCategory> categories;

  /// Returns a shallow copy of this [FoodCategoryList]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FoodCategoryList copyWith({List<_i2.FoodCategory>? categories});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FoodCategoryList',
      'categories': categories.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FoodCategoryList',
      'categories': categories.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _FoodCategoryListImpl extends FoodCategoryList {
  _FoodCategoryListImpl({required List<_i2.FoodCategory> categories})
    : super._(categories: categories);

  /// Returns a shallow copy of this [FoodCategoryList]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FoodCategoryList copyWith({List<_i2.FoodCategory>? categories}) {
    return FoodCategoryList(
      categories:
          categories ?? this.categories.map((e0) => e0.copyWith()).toList(),
    );
  }
}
