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
import '../../../features/workouts/models/workout_session.dart' as _i2;
import 'package:fitbodyrd_client/src/protocol/protocol.dart' as _i3;

abstract class WorkoutSessionsByDateDto implements _i1.SerializableModel {
  WorkoutSessionsByDateDto._({
    required this.date,
    required this.sessions,
    required this.totalExercisesCompleted,
  });

  factory WorkoutSessionsByDateDto({
    required DateTime date,
    required List<_i2.WorkoutSession> sessions,
    required int totalExercisesCompleted,
  }) = _WorkoutSessionsByDateDtoImpl;

  factory WorkoutSessionsByDateDto.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return WorkoutSessionsByDateDto(
      date: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      sessions: _i3.Protocol().deserialize<List<_i2.WorkoutSession>>(
        jsonSerialization['sessions'],
      ),
      totalExercisesCompleted:
          jsonSerialization['totalExercisesCompleted'] as int,
    );
  }

  DateTime date;

  List<_i2.WorkoutSession> sessions;

  int totalExercisesCompleted;

  /// Returns a shallow copy of this [WorkoutSessionsByDateDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WorkoutSessionsByDateDto copyWith({
    DateTime? date,
    List<_i2.WorkoutSession>? sessions,
    int? totalExercisesCompleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WorkoutSessionsByDateDto',
      'date': date.toJson(),
      'sessions': sessions.toJson(valueToJson: (v) => v.toJson()),
      'totalExercisesCompleted': totalExercisesCompleted,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _WorkoutSessionsByDateDtoImpl extends WorkoutSessionsByDateDto {
  _WorkoutSessionsByDateDtoImpl({
    required DateTime date,
    required List<_i2.WorkoutSession> sessions,
    required int totalExercisesCompleted,
  }) : super._(
         date: date,
         sessions: sessions,
         totalExercisesCompleted: totalExercisesCompleted,
       );

  /// Returns a shallow copy of this [WorkoutSessionsByDateDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WorkoutSessionsByDateDto copyWith({
    DateTime? date,
    List<_i2.WorkoutSession>? sessions,
    int? totalExercisesCompleted,
  }) {
    return WorkoutSessionsByDateDto(
      date: date ?? this.date,
      sessions: sessions ?? this.sessions.map((e0) => e0.copyWith()).toList(),
      totalExercisesCompleted:
          totalExercisesCompleted ?? this.totalExercisesCompleted,
    );
  }
}
