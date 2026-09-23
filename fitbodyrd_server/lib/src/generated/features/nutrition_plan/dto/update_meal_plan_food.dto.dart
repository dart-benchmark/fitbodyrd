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

abstract class UpdateMealPlanFoodDto
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  UpdateMealPlanFoodDto._({
    required this.servingQuantity,
    required this.servingSizeId,
    required this.quantityGrams,
  });

  factory UpdateMealPlanFoodDto({
    required double servingQuantity,
    required int servingSizeId,
    required double quantityGrams,
  }) = _UpdateMealPlanFoodDtoImpl;

  factory UpdateMealPlanFoodDto.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return UpdateMealPlanFoodDto(
      servingQuantity: (jsonSerialization['servingQuantity'] as num).toDouble(),
      servingSizeId: jsonSerialization['servingSizeId'] as int,
      quantityGrams: (jsonSerialization['quantityGrams'] as num).toDouble(),
    );
  }

  double servingQuantity;

  int servingSizeId;

  double quantityGrams;

  /// Returns a shallow copy of this [UpdateMealPlanFoodDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UpdateMealPlanFoodDto copyWith({
    double? servingQuantity,
    int? servingSizeId,
    double? quantityGrams,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UpdateMealPlanFoodDto',
      'servingQuantity': servingQuantity,
      'servingSizeId': servingSizeId,
      'quantityGrams': quantityGrams,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UpdateMealPlanFoodDto',
      'servingQuantity': servingQuantity,
      'servingSizeId': servingSizeId,
      'quantityGrams': quantityGrams,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _UpdateMealPlanFoodDtoImpl extends UpdateMealPlanFoodDto {
  _UpdateMealPlanFoodDtoImpl({
    required double servingQuantity,
    required int servingSizeId,
    required double quantityGrams,
  }) : super._(
         servingQuantity: servingQuantity,
         servingSizeId: servingSizeId,
         quantityGrams: quantityGrams,
       );

  /// Returns a shallow copy of this [UpdateMealPlanFoodDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UpdateMealPlanFoodDto copyWith({
    double? servingQuantity,
    int? servingSizeId,
    double? quantityGrams,
  }) {
    return UpdateMealPlanFoodDto(
      servingQuantity: servingQuantity ?? this.servingQuantity,
      servingSizeId: servingSizeId ?? this.servingSizeId,
      quantityGrams: quantityGrams ?? this.quantityGrams,
    );
  }
}
