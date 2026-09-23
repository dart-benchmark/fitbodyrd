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

abstract class WorkoutProgressMetricsDto
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  WorkoutProgressMetricsDto._({
    required this.totalWorkoutsCompleted,
    required this.currentStreak,
    required this.longestStreak,
    required this.averageWorkoutsPerWeek,
    required this.totalExercisesLogged,
    required this.workoutsThisWeek,
    required this.workoutsThisMonth,
  });

  factory WorkoutProgressMetricsDto({
    required int totalWorkoutsCompleted,
    required int currentStreak,
    required int longestStreak,
    required double averageWorkoutsPerWeek,
    required int totalExercisesLogged,
    required int workoutsThisWeek,
    required int workoutsThisMonth,
  }) = _WorkoutProgressMetricsDtoImpl;

  factory WorkoutProgressMetricsDto.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return WorkoutProgressMetricsDto(
      totalWorkoutsCompleted:
          jsonSerialization['totalWorkoutsCompleted'] as int,
      currentStreak: jsonSerialization['currentStreak'] as int,
      longestStreak: jsonSerialization['longestStreak'] as int,
      averageWorkoutsPerWeek:
          (jsonSerialization['averageWorkoutsPerWeek'] as num).toDouble(),
      totalExercisesLogged: jsonSerialization['totalExercisesLogged'] as int,
      workoutsThisWeek: jsonSerialization['workoutsThisWeek'] as int,
      workoutsThisMonth: jsonSerialization['workoutsThisMonth'] as int,
    );
  }

  int totalWorkoutsCompleted;

  int currentStreak;

  int longestStreak;

  double averageWorkoutsPerWeek;

  int totalExercisesLogged;

  int workoutsThisWeek;

  int workoutsThisMonth;

  /// Returns a shallow copy of this [WorkoutProgressMetricsDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WorkoutProgressMetricsDto copyWith({
    int? totalWorkoutsCompleted,
    int? currentStreak,
    int? longestStreak,
    double? averageWorkoutsPerWeek,
    int? totalExercisesLogged,
    int? workoutsThisWeek,
    int? workoutsThisMonth,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WorkoutProgressMetricsDto',
      'totalWorkoutsCompleted': totalWorkoutsCompleted,
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'averageWorkoutsPerWeek': averageWorkoutsPerWeek,
      'totalExercisesLogged': totalExercisesLogged,
      'workoutsThisWeek': workoutsThisWeek,
      'workoutsThisMonth': workoutsThisMonth,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WorkoutProgressMetricsDto',
      'totalWorkoutsCompleted': totalWorkoutsCompleted,
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'averageWorkoutsPerWeek': averageWorkoutsPerWeek,
      'totalExercisesLogged': totalExercisesLogged,
      'workoutsThisWeek': workoutsThisWeek,
      'workoutsThisMonth': workoutsThisMonth,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _WorkoutProgressMetricsDtoImpl extends WorkoutProgressMetricsDto {
  _WorkoutProgressMetricsDtoImpl({
    required int totalWorkoutsCompleted,
    required int currentStreak,
    required int longestStreak,
    required double averageWorkoutsPerWeek,
    required int totalExercisesLogged,
    required int workoutsThisWeek,
    required int workoutsThisMonth,
  }) : super._(
         totalWorkoutsCompleted: totalWorkoutsCompleted,
         currentStreak: currentStreak,
         longestStreak: longestStreak,
         averageWorkoutsPerWeek: averageWorkoutsPerWeek,
         totalExercisesLogged: totalExercisesLogged,
         workoutsThisWeek: workoutsThisWeek,
         workoutsThisMonth: workoutsThisMonth,
       );

  /// Returns a shallow copy of this [WorkoutProgressMetricsDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WorkoutProgressMetricsDto copyWith({
    int? totalWorkoutsCompleted,
    int? currentStreak,
    int? longestStreak,
    double? averageWorkoutsPerWeek,
    int? totalExercisesLogged,
    int? workoutsThisWeek,
    int? workoutsThisMonth,
  }) {
    return WorkoutProgressMetricsDto(
      totalWorkoutsCompleted:
          totalWorkoutsCompleted ?? this.totalWorkoutsCompleted,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      averageWorkoutsPerWeek:
          averageWorkoutsPerWeek ?? this.averageWorkoutsPerWeek,
      totalExercisesLogged: totalExercisesLogged ?? this.totalExercisesLogged,
      workoutsThisWeek: workoutsThisWeek ?? this.workoutsThisWeek,
      workoutsThisMonth: workoutsThisMonth ?? this.workoutsThisMonth,
    );
  }
}
