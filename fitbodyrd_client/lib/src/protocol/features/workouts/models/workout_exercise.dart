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
import '../../../features/exercise/models/exercise.dart' as _i3;
import '../../../features/workouts/models/exercise_log.dart' as _i4;
import 'package:fitbodyrd_client/src/protocol/protocol.dart' as _i5;

abstract class WorkoutExercise implements _i1.SerializableModel {
  WorkoutExercise._({
    this.id,
    required this.workoutSessionId,
    this.workoutSession,
    required this.exerciseId,
    this.exercise,
    required this.order,
    required this.sets,
    required this.reps,
    required this.restSeconds,
    this.notes,
    this.logs,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory WorkoutExercise({
    int? id,
    required int workoutSessionId,
    _i2.WorkoutSession? workoutSession,
    required int exerciseId,
    _i3.Exercise? exercise,
    required int order,
    required int sets,
    required int reps,
    required int restSeconds,
    String? notes,
    List<_i4.ExerciseLog>? logs,
    DateTime? createdAt,
  }) = _WorkoutExerciseImpl;

  factory WorkoutExercise.fromJson(Map<String, dynamic> jsonSerialization) {
    return WorkoutExercise(
      id: jsonSerialization['id'] as int?,
      workoutSessionId: jsonSerialization['workoutSessionId'] as int,
      workoutSession: jsonSerialization['workoutSession'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.WorkoutSession>(
              jsonSerialization['workoutSession'],
            ),
      exerciseId: jsonSerialization['exerciseId'] as int,
      exercise: jsonSerialization['exercise'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.Exercise>(
              jsonSerialization['exercise'],
            ),
      order: jsonSerialization['order'] as int,
      sets: jsonSerialization['sets'] as int,
      reps: jsonSerialization['reps'] as int,
      restSeconds: jsonSerialization['restSeconds'] as int,
      notes: jsonSerialization['notes'] as String?,
      logs: jsonSerialization['logs'] == null
          ? null
          : _i5.Protocol().deserialize<List<_i4.ExerciseLog>>(
              jsonSerialization['logs'],
            ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int workoutSessionId;

  _i2.WorkoutSession? workoutSession;

  int exerciseId;

  _i3.Exercise? exercise;

  int order;

  int sets;

  int reps;

  int restSeconds;

  String? notes;

  List<_i4.ExerciseLog>? logs;

  DateTime createdAt;

  /// Returns a shallow copy of this [WorkoutExercise]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WorkoutExercise copyWith({
    int? id,
    int? workoutSessionId,
    _i2.WorkoutSession? workoutSession,
    int? exerciseId,
    _i3.Exercise? exercise,
    int? order,
    int? sets,
    int? reps,
    int? restSeconds,
    String? notes,
    List<_i4.ExerciseLog>? logs,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WorkoutExercise',
      if (id != null) 'id': id,
      'workoutSessionId': workoutSessionId,
      if (workoutSession != null) 'workoutSession': workoutSession?.toJson(),
      'exerciseId': exerciseId,
      if (exercise != null) 'exercise': exercise?.toJson(),
      'order': order,
      'sets': sets,
      'reps': reps,
      'restSeconds': restSeconds,
      if (notes != null) 'notes': notes,
      if (logs != null) 'logs': logs?.toJson(valueToJson: (v) => v.toJson()),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WorkoutExerciseImpl extends WorkoutExercise {
  _WorkoutExerciseImpl({
    int? id,
    required int workoutSessionId,
    _i2.WorkoutSession? workoutSession,
    required int exerciseId,
    _i3.Exercise? exercise,
    required int order,
    required int sets,
    required int reps,
    required int restSeconds,
    String? notes,
    List<_i4.ExerciseLog>? logs,
    DateTime? createdAt,
  }) : super._(
         id: id,
         workoutSessionId: workoutSessionId,
         workoutSession: workoutSession,
         exerciseId: exerciseId,
         exercise: exercise,
         order: order,
         sets: sets,
         reps: reps,
         restSeconds: restSeconds,
         notes: notes,
         logs: logs,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [WorkoutExercise]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WorkoutExercise copyWith({
    Object? id = _Undefined,
    int? workoutSessionId,
    Object? workoutSession = _Undefined,
    int? exerciseId,
    Object? exercise = _Undefined,
    int? order,
    int? sets,
    int? reps,
    int? restSeconds,
    Object? notes = _Undefined,
    Object? logs = _Undefined,
    DateTime? createdAt,
  }) {
    return WorkoutExercise(
      id: id is int? ? id : this.id,
      workoutSessionId: workoutSessionId ?? this.workoutSessionId,
      workoutSession: workoutSession is _i2.WorkoutSession?
          ? workoutSession
          : this.workoutSession?.copyWith(),
      exerciseId: exerciseId ?? this.exerciseId,
      exercise: exercise is _i3.Exercise?
          ? exercise
          : this.exercise?.copyWith(),
      order: order ?? this.order,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      restSeconds: restSeconds ?? this.restSeconds,
      notes: notes is String? ? notes : this.notes,
      logs: logs is List<_i4.ExerciseLog>?
          ? logs
          : this.logs?.map((e0) => e0.copyWith()).toList(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
