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
import '../../../features/nutrition_plan/dto/created_meal_plan_totals.dto.dart'
    as _i2;
import '../../../features/nutrition_plan/dto/created_meal_plan_variance.dto.dart'
    as _i3;
import '../../../features/nutrition_plan/dto/created_meal_plan_id.dto.dart'
    as _i4;
import 'package:fitbodyrd_server/src/generated/protocol.dart' as _i5;

abstract class CreatedMealPlanDto
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  CreatedMealPlanDto._({
    required this.dayNumber,
    required this.date,
    required this.mealsCreated,
    required this.totalFoodsAdded,
    required this.actualTotals,
    required this.variance,
    required this.mealPlanIds,
  });

  factory CreatedMealPlanDto({
    required int dayNumber,
    required DateTime date,
    required int mealsCreated,
    required int totalFoodsAdded,
    required _i2.CreatedMealPlanTotalsDto actualTotals,
    required _i3.CreatedMealPlanVarianceDto variance,
    required List<_i4.CreatedMealPlanIdDto> mealPlanIds,
  }) = _CreatedMealPlanDtoImpl;

  factory CreatedMealPlanDto.fromJson(Map<String, dynamic> jsonSerialization) {
    return CreatedMealPlanDto(
      dayNumber: jsonSerialization['dayNumber'] as int,
      date: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      mealsCreated: jsonSerialization['mealsCreated'] as int,
      totalFoodsAdded: jsonSerialization['totalFoodsAdded'] as int,
      actualTotals: _i5.Protocol().deserialize<_i2.CreatedMealPlanTotalsDto>(
        jsonSerialization['actualTotals'],
      ),
      variance: _i5.Protocol().deserialize<_i3.CreatedMealPlanVarianceDto>(
        jsonSerialization['variance'],
      ),
      mealPlanIds: _i5.Protocol().deserialize<List<_i4.CreatedMealPlanIdDto>>(
        jsonSerialization['mealPlanIds'],
      ),
    );
  }

  int dayNumber;

  DateTime date;

  int mealsCreated;

  int totalFoodsAdded;

  _i2.CreatedMealPlanTotalsDto actualTotals;

  _i3.CreatedMealPlanVarianceDto variance;

  List<_i4.CreatedMealPlanIdDto> mealPlanIds;

  /// Returns a shallow copy of this [CreatedMealPlanDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CreatedMealPlanDto copyWith({
    int? dayNumber,
    DateTime? date,
    int? mealsCreated,
    int? totalFoodsAdded,
    _i2.CreatedMealPlanTotalsDto? actualTotals,
    _i3.CreatedMealPlanVarianceDto? variance,
    List<_i4.CreatedMealPlanIdDto>? mealPlanIds,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CreatedMealPlanDto',
      'dayNumber': dayNumber,
      'date': date.toJson(),
      'mealsCreated': mealsCreated,
      'totalFoodsAdded': totalFoodsAdded,
      'actualTotals': actualTotals.toJson(),
      'variance': variance.toJson(),
      'mealPlanIds': mealPlanIds.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CreatedMealPlanDto',
      'dayNumber': dayNumber,
      'date': date.toJson(),
      'mealsCreated': mealsCreated,
      'totalFoodsAdded': totalFoodsAdded,
      'actualTotals': actualTotals.toJsonForProtocol(),
      'variance': variance.toJsonForProtocol(),
      'mealPlanIds': mealPlanIds.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _CreatedMealPlanDtoImpl extends CreatedMealPlanDto {
  _CreatedMealPlanDtoImpl({
    required int dayNumber,
    required DateTime date,
    required int mealsCreated,
    required int totalFoodsAdded,
    required _i2.CreatedMealPlanTotalsDto actualTotals,
    required _i3.CreatedMealPlanVarianceDto variance,
    required List<_i4.CreatedMealPlanIdDto> mealPlanIds,
  }) : super._(
         dayNumber: dayNumber,
         date: date,
         mealsCreated: mealsCreated,
         totalFoodsAdded: totalFoodsAdded,
         actualTotals: actualTotals,
         variance: variance,
         mealPlanIds: mealPlanIds,
       );

  /// Returns a shallow copy of this [CreatedMealPlanDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CreatedMealPlanDto copyWith({
    int? dayNumber,
    DateTime? date,
    int? mealsCreated,
    int? totalFoodsAdded,
    _i2.CreatedMealPlanTotalsDto? actualTotals,
    _i3.CreatedMealPlanVarianceDto? variance,
    List<_i4.CreatedMealPlanIdDto>? mealPlanIds,
  }) {
    return CreatedMealPlanDto(
      dayNumber: dayNumber ?? this.dayNumber,
      date: date ?? this.date,
      mealsCreated: mealsCreated ?? this.mealsCreated,
      totalFoodsAdded: totalFoodsAdded ?? this.totalFoodsAdded,
      actualTotals: actualTotals ?? this.actualTotals.copyWith(),
      variance: variance ?? this.variance.copyWith(),
      mealPlanIds:
          mealPlanIds ?? this.mealPlanIds.map((e0) => e0.copyWith()).toList(),
    );
  }
}
