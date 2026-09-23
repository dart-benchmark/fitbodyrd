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

abstract class MealIndividualDistributionDto
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  MealIndividualDistributionDto._({
    required this.calories,
    required this.proteins,
    required this.carbs,
    required this.fats,
    required this.percentage,
  });

  factory MealIndividualDistributionDto({
    required double calories,
    required double proteins,
    required double carbs,
    required double fats,
    required double percentage,
  }) = _MealIndividualDistributionDtoImpl;

  factory MealIndividualDistributionDto.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return MealIndividualDistributionDto(
      calories: (jsonSerialization['calories'] as num).toDouble(),
      proteins: (jsonSerialization['proteins'] as num).toDouble(),
      carbs: (jsonSerialization['carbs'] as num).toDouble(),
      fats: (jsonSerialization['fats'] as num).toDouble(),
      percentage: (jsonSerialization['percentage'] as num).toDouble(),
    );
  }

  double calories;

  double proteins;

  double carbs;

  double fats;

  double percentage;

  /// Returns a shallow copy of this [MealIndividualDistributionDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MealIndividualDistributionDto copyWith({
    double? calories,
    double? proteins,
    double? carbs,
    double? fats,
    double? percentage,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MealIndividualDistributionDto',
      'calories': calories,
      'proteins': proteins,
      'carbs': carbs,
      'fats': fats,
      'percentage': percentage,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MealIndividualDistributionDto',
      'calories': calories,
      'proteins': proteins,
      'carbs': carbs,
      'fats': fats,
      'percentage': percentage,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _MealIndividualDistributionDtoImpl extends MealIndividualDistributionDto {
  _MealIndividualDistributionDtoImpl({
    required double calories,
    required double proteins,
    required double carbs,
    required double fats,
    required double percentage,
  }) : super._(
         calories: calories,
         proteins: proteins,
         carbs: carbs,
         fats: fats,
         percentage: percentage,
       );

  /// Returns a shallow copy of this [MealIndividualDistributionDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MealIndividualDistributionDto copyWith({
    double? calories,
    double? proteins,
    double? carbs,
    double? fats,
    double? percentage,
  }) {
    return MealIndividualDistributionDto(
      calories: calories ?? this.calories,
      proteins: proteins ?? this.proteins,
      carbs: carbs ?? this.carbs,
      fats: fats ?? this.fats,
      percentage: percentage ?? this.percentage,
    );
  }
}
