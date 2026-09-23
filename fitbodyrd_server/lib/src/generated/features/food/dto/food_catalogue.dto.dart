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
import '../../../features/food/dto/food_category_detail.dto.dart' as _i2;
import 'package:fitbodyrd_server/src/generated/protocol.dart' as _i3;

abstract class FoodCatalogueDto
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  FoodCatalogueDto._({required this.categories});

  factory FoodCatalogueDto({
    required List<_i2.FoodCategoryDetailDto> categories,
  }) = _FoodCatalogueDtoImpl;

  factory FoodCatalogueDto.fromJson(Map<String, dynamic> jsonSerialization) {
    return FoodCatalogueDto(
      categories: _i3.Protocol().deserialize<List<_i2.FoodCategoryDetailDto>>(
        jsonSerialization['categories'],
      ),
    );
  }

  List<_i2.FoodCategoryDetailDto> categories;

  /// Returns a shallow copy of this [FoodCatalogueDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FoodCatalogueDto copyWith({List<_i2.FoodCategoryDetailDto>? categories});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FoodCatalogueDto',
      'categories': categories.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FoodCatalogueDto',
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

class _FoodCatalogueDtoImpl extends FoodCatalogueDto {
  _FoodCatalogueDtoImpl({required List<_i2.FoodCategoryDetailDto> categories})
    : super._(categories: categories);

  /// Returns a shallow copy of this [FoodCatalogueDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FoodCatalogueDto copyWith({List<_i2.FoodCategoryDetailDto>? categories}) {
    return FoodCatalogueDto(
      categories:
          categories ?? this.categories.map((e0) => e0.copyWith()).toList(),
    );
  }
}
