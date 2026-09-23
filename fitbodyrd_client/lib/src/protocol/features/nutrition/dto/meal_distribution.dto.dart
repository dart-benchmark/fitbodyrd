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
import '../../../features/nutrition/dto/meal_individual_distribution.dto.dart'
    as _i2;
import 'package:fitbodyrd_client/src/protocol/protocol.dart' as _i3;

abstract class MealDistributionDto implements _i1.SerializableModel {
  MealDistributionDto._({
    this.breakfast,
    this.brunch,
    this.lunch,
    this.snack,
    this.dinner,
  });

  factory MealDistributionDto({
    _i2.MealIndividualDistributionDto? breakfast,
    _i2.MealIndividualDistributionDto? brunch,
    _i2.MealIndividualDistributionDto? lunch,
    _i2.MealIndividualDistributionDto? snack,
    _i2.MealIndividualDistributionDto? dinner,
  }) = _MealDistributionDtoImpl;

  factory MealDistributionDto.fromJson(Map<String, dynamic> jsonSerialization) {
    return MealDistributionDto(
      breakfast: jsonSerialization['breakfast'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.MealIndividualDistributionDto>(
              jsonSerialization['breakfast'],
            ),
      brunch: jsonSerialization['brunch'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.MealIndividualDistributionDto>(
              jsonSerialization['brunch'],
            ),
      lunch: jsonSerialization['lunch'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.MealIndividualDistributionDto>(
              jsonSerialization['lunch'],
            ),
      snack: jsonSerialization['snack'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.MealIndividualDistributionDto>(
              jsonSerialization['snack'],
            ),
      dinner: jsonSerialization['dinner'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.MealIndividualDistributionDto>(
              jsonSerialization['dinner'],
            ),
    );
  }

  _i2.MealIndividualDistributionDto? breakfast;

  _i2.MealIndividualDistributionDto? brunch;

  _i2.MealIndividualDistributionDto? lunch;

  _i2.MealIndividualDistributionDto? snack;

  _i2.MealIndividualDistributionDto? dinner;

  /// Returns a shallow copy of this [MealDistributionDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MealDistributionDto copyWith({
    _i2.MealIndividualDistributionDto? breakfast,
    _i2.MealIndividualDistributionDto? brunch,
    _i2.MealIndividualDistributionDto? lunch,
    _i2.MealIndividualDistributionDto? snack,
    _i2.MealIndividualDistributionDto? dinner,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MealDistributionDto',
      if (breakfast != null) 'breakfast': breakfast?.toJson(),
      if (brunch != null) 'brunch': brunch?.toJson(),
      if (lunch != null) 'lunch': lunch?.toJson(),
      if (snack != null) 'snack': snack?.toJson(),
      if (dinner != null) 'dinner': dinner?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MealDistributionDtoImpl extends MealDistributionDto {
  _MealDistributionDtoImpl({
    _i2.MealIndividualDistributionDto? breakfast,
    _i2.MealIndividualDistributionDto? brunch,
    _i2.MealIndividualDistributionDto? lunch,
    _i2.MealIndividualDistributionDto? snack,
    _i2.MealIndividualDistributionDto? dinner,
  }) : super._(
         breakfast: breakfast,
         brunch: brunch,
         lunch: lunch,
         snack: snack,
         dinner: dinner,
       );

  /// Returns a shallow copy of this [MealDistributionDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MealDistributionDto copyWith({
    Object? breakfast = _Undefined,
    Object? brunch = _Undefined,
    Object? lunch = _Undefined,
    Object? snack = _Undefined,
    Object? dinner = _Undefined,
  }) {
    return MealDistributionDto(
      breakfast: breakfast is _i2.MealIndividualDistributionDto?
          ? breakfast
          : this.breakfast?.copyWith(),
      brunch: brunch is _i2.MealIndividualDistributionDto?
          ? brunch
          : this.brunch?.copyWith(),
      lunch: lunch is _i2.MealIndividualDistributionDto?
          ? lunch
          : this.lunch?.copyWith(),
      snack: snack is _i2.MealIndividualDistributionDto?
          ? snack
          : this.snack?.copyWith(),
      dinner: dinner is _i2.MealIndividualDistributionDto?
          ? dinner
          : this.dinner?.copyWith(),
    );
  }
}
