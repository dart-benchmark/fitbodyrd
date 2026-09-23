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
import '../../../features/nutrition_plan/dto/create_meal_plan_detail.dto.dart'
    as _i2;
import 'package:fitbodyrd_client/src/protocol/protocol.dart' as _i3;

abstract class CreateMealPlanDto implements _i1.SerializableModel {
  CreateMealPlanDto._({
    required this.nutritionPlanId,
    required this.date,
    required this.dayNumber,
    required this.meals,
  });

  factory CreateMealPlanDto({
    required int nutritionPlanId,
    required DateTime date,
    required int dayNumber,
    required List<_i2.CreateMealPlanDetailDto> meals,
  }) = _CreateMealPlanDtoImpl;

  factory CreateMealPlanDto.fromJson(Map<String, dynamic> jsonSerialization) {
    return CreateMealPlanDto(
      nutritionPlanId: jsonSerialization['nutritionPlanId'] as int,
      date: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      dayNumber: jsonSerialization['dayNumber'] as int,
      meals: _i3.Protocol().deserialize<List<_i2.CreateMealPlanDetailDto>>(
        jsonSerialization['meals'],
      ),
    );
  }

  int nutritionPlanId;

  DateTime date;

  int dayNumber;

  List<_i2.CreateMealPlanDetailDto> meals;

  /// Returns a shallow copy of this [CreateMealPlanDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CreateMealPlanDto copyWith({
    int? nutritionPlanId,
    DateTime? date,
    int? dayNumber,
    List<_i2.CreateMealPlanDetailDto>? meals,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CreateMealPlanDto',
      'nutritionPlanId': nutritionPlanId,
      'date': date.toJson(),
      'dayNumber': dayNumber,
      'meals': meals.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _CreateMealPlanDtoImpl extends CreateMealPlanDto {
  _CreateMealPlanDtoImpl({
    required int nutritionPlanId,
    required DateTime date,
    required int dayNumber,
    required List<_i2.CreateMealPlanDetailDto> meals,
  }) : super._(
         nutritionPlanId: nutritionPlanId,
         date: date,
         dayNumber: dayNumber,
         meals: meals,
       );

  /// Returns a shallow copy of this [CreateMealPlanDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CreateMealPlanDto copyWith({
    int? nutritionPlanId,
    DateTime? date,
    int? dayNumber,
    List<_i2.CreateMealPlanDetailDto>? meals,
  }) {
    return CreateMealPlanDto(
      nutritionPlanId: nutritionPlanId ?? this.nutritionPlanId,
      date: date ?? this.date,
      dayNumber: dayNumber ?? this.dayNumber,
      meals: meals ?? this.meals.map((e0) => e0.copyWith()).toList(),
    );
  }
}
