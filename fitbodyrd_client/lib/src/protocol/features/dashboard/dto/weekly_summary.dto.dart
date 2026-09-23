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

abstract class WeeklySummaryDto implements _i1.SerializableModel {
  WeeklySummaryDto._({
    required this.workoutsCompleted,
    required this.workoutsScheduled,
    required this.nutritionDaysLogged,
    required this.totalExercisesLogged,
    required this.totalMealsLogged,
    required this.weekStartDate,
    required this.weekEndDate,
  });

  factory WeeklySummaryDto({
    required int workoutsCompleted,
    required int workoutsScheduled,
    required int nutritionDaysLogged,
    required int totalExercisesLogged,
    required int totalMealsLogged,
    required DateTime weekStartDate,
    required DateTime weekEndDate,
  }) = _WeeklySummaryDtoImpl;

  factory WeeklySummaryDto.fromJson(Map<String, dynamic> jsonSerialization) {
    return WeeklySummaryDto(
      workoutsCompleted: jsonSerialization['workoutsCompleted'] as int,
      workoutsScheduled: jsonSerialization['workoutsScheduled'] as int,
      nutritionDaysLogged: jsonSerialization['nutritionDaysLogged'] as int,
      totalExercisesLogged: jsonSerialization['totalExercisesLogged'] as int,
      totalMealsLogged: jsonSerialization['totalMealsLogged'] as int,
      weekStartDate: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['weekStartDate'],
      ),
      weekEndDate: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['weekEndDate'],
      ),
    );
  }

  int workoutsCompleted;

  int workoutsScheduled;

  int nutritionDaysLogged;

  int totalExercisesLogged;

  int totalMealsLogged;

  DateTime weekStartDate;

  DateTime weekEndDate;

  /// Returns a shallow copy of this [WeeklySummaryDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WeeklySummaryDto copyWith({
    int? workoutsCompleted,
    int? workoutsScheduled,
    int? nutritionDaysLogged,
    int? totalExercisesLogged,
    int? totalMealsLogged,
    DateTime? weekStartDate,
    DateTime? weekEndDate,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WeeklySummaryDto',
      'workoutsCompleted': workoutsCompleted,
      'workoutsScheduled': workoutsScheduled,
      'nutritionDaysLogged': nutritionDaysLogged,
      'totalExercisesLogged': totalExercisesLogged,
      'totalMealsLogged': totalMealsLogged,
      'weekStartDate': weekStartDate.toJson(),
      'weekEndDate': weekEndDate.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _WeeklySummaryDtoImpl extends WeeklySummaryDto {
  _WeeklySummaryDtoImpl({
    required int workoutsCompleted,
    required int workoutsScheduled,
    required int nutritionDaysLogged,
    required int totalExercisesLogged,
    required int totalMealsLogged,
    required DateTime weekStartDate,
    required DateTime weekEndDate,
  }) : super._(
         workoutsCompleted: workoutsCompleted,
         workoutsScheduled: workoutsScheduled,
         nutritionDaysLogged: nutritionDaysLogged,
         totalExercisesLogged: totalExercisesLogged,
         totalMealsLogged: totalMealsLogged,
         weekStartDate: weekStartDate,
         weekEndDate: weekEndDate,
       );

  /// Returns a shallow copy of this [WeeklySummaryDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WeeklySummaryDto copyWith({
    int? workoutsCompleted,
    int? workoutsScheduled,
    int? nutritionDaysLogged,
    int? totalExercisesLogged,
    int? totalMealsLogged,
    DateTime? weekStartDate,
    DateTime? weekEndDate,
  }) {
    return WeeklySummaryDto(
      workoutsCompleted: workoutsCompleted ?? this.workoutsCompleted,
      workoutsScheduled: workoutsScheduled ?? this.workoutsScheduled,
      nutritionDaysLogged: nutritionDaysLogged ?? this.nutritionDaysLogged,
      totalExercisesLogged: totalExercisesLogged ?? this.totalExercisesLogged,
      totalMealsLogged: totalMealsLogged ?? this.totalMealsLogged,
      weekStartDate: weekStartDate ?? this.weekStartDate,
      weekEndDate: weekEndDate ?? this.weekEndDate,
    );
  }
}
