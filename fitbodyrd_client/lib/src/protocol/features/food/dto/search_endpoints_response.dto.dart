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

abstract class SearchEndpointsResponseDto implements _i1.SerializableModel {
  SearchEndpointsResponseDto._({
    required this.foods,
    required this.totalCount,
  });

  factory SearchEndpointsResponseDto({
    required List<_i2.Food> foods,
    required int totalCount,
  }) = _SearchEndpointsResponseDtoImpl;

  factory SearchEndpointsResponseDto.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return SearchEndpointsResponseDto(
      foods: _i3.Protocol().deserialize<List<_i2.Food>>(
        jsonSerialization['foods'],
      ),
      totalCount: jsonSerialization['totalCount'] as int,
    );
  }

  List<_i2.Food> foods;

  int totalCount;

  /// Returns a shallow copy of this [SearchEndpointsResponseDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SearchEndpointsResponseDto copyWith({
    List<_i2.Food>? foods,
    int? totalCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SearchEndpointsResponseDto',
      'foods': foods.toJson(valueToJson: (v) => v.toJson()),
      'totalCount': totalCount,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _SearchEndpointsResponseDtoImpl extends SearchEndpointsResponseDto {
  _SearchEndpointsResponseDtoImpl({
    required List<_i2.Food> foods,
    required int totalCount,
  }) : super._(
         foods: foods,
         totalCount: totalCount,
       );

  /// Returns a shallow copy of this [SearchEndpointsResponseDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SearchEndpointsResponseDto copyWith({
    List<_i2.Food>? foods,
    int? totalCount,
  }) {
    return SearchEndpointsResponseDto(
      foods: foods ?? this.foods.map((e0) => e0.copyWith()).toList(),
      totalCount: totalCount ?? this.totalCount,
    );
  }
}
