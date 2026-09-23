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
import '../../../features/nutrition_plan/models/meal_type.dart' as _i2;

abstract class CreatedMealPlanIdDto
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  CreatedMealPlanIdDto._({
    required this.id,
    required this.mealType,
  });

  factory CreatedMealPlanIdDto({
    required int id,
    required _i2.MealPlanType mealType,
  }) = _CreatedMealPlanIdDtoImpl;

  factory CreatedMealPlanIdDto.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CreatedMealPlanIdDto(
      id: jsonSerialization['id'] as int,
      mealType: _i2.MealPlanType.fromJson(
        (jsonSerialization['mealType'] as String),
      ),
    );
  }

  _i2.MealPlanType mealType;

  int id;

  /// Returns a shallow copy of this [CreatedMealPlanIdDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CreatedMealPlanIdDto copyWith({
    int? id,
    _i2.MealPlanType? mealType,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CreatedMealPlanIdDto',
      'id': id,
      'mealType': mealType.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CreatedMealPlanIdDto',
      'id': id,
      'mealType': mealType.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _CreatedMealPlanIdDtoImpl extends CreatedMealPlanIdDto {
  _CreatedMealPlanIdDtoImpl({
    required int id,
    required _i2.MealPlanType mealType,
  }) : super._(
         id: id,
         mealType: mealType,
       );

  /// Returns a shallow copy of this [CreatedMealPlanIdDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CreatedMealPlanIdDto copyWith({
    int? id,
    _i2.MealPlanType? mealType,
  }) {
    return CreatedMealPlanIdDto(
      id: id ?? this.id,
      mealType: mealType ?? this.mealType,
    );
  }
}
