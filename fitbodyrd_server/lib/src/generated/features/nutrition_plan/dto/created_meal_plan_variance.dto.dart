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

abstract class CreatedMealPlanVarianceDto
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  CreatedMealPlanVarianceDto._({
    required this.calories,
    required this.proteins,
    required this.carbs,
    required this.fats,
  });

  factory CreatedMealPlanVarianceDto({
    required double calories,
    required double proteins,
    required double carbs,
    required double fats,
  }) = _CreatedMealPlanVarianceDtoImpl;

  factory CreatedMealPlanVarianceDto.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CreatedMealPlanVarianceDto(
      calories: (jsonSerialization['calories'] as num).toDouble(),
      proteins: (jsonSerialization['proteins'] as num).toDouble(),
      carbs: (jsonSerialization['carbs'] as num).toDouble(),
      fats: (jsonSerialization['fats'] as num).toDouble(),
    );
  }

  double calories;

  double proteins;

  double carbs;

  double fats;

  /// Returns a shallow copy of this [CreatedMealPlanVarianceDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CreatedMealPlanVarianceDto copyWith({
    double? calories,
    double? proteins,
    double? carbs,
    double? fats,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CreatedMealPlanVarianceDto',
      'calories': calories,
      'proteins': proteins,
      'carbs': carbs,
      'fats': fats,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CreatedMealPlanVarianceDto',
      'calories': calories,
      'proteins': proteins,
      'carbs': carbs,
      'fats': fats,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _CreatedMealPlanVarianceDtoImpl extends CreatedMealPlanVarianceDto {
  _CreatedMealPlanVarianceDtoImpl({
    required double calories,
    required double proteins,
    required double carbs,
    required double fats,
  }) : super._(
         calories: calories,
         proteins: proteins,
         carbs: carbs,
         fats: fats,
       );

  /// Returns a shallow copy of this [CreatedMealPlanVarianceDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CreatedMealPlanVarianceDto copyWith({
    double? calories,
    double? proteins,
    double? carbs,
    double? fats,
  }) {
    return CreatedMealPlanVarianceDto(
      calories: calories ?? this.calories,
      proteins: proteins ?? this.proteins,
      carbs: carbs ?? this.carbs,
      fats: fats ?? this.fats,
    );
  }
}
