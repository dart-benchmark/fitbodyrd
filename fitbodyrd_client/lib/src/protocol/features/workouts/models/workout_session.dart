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
import '../../../features/workouts/models/workout_plan.dart' as _i2;
import '../../../features/workouts/models/workout_exercise.dart' as _i3;
import 'package:fitbodyrd_client/src/protocol/protocol.dart' as _i4;

abstract class WorkoutSession implements _i1.SerializableModel {
  WorkoutSession._({
    this.id,
    required this.workoutPlanId,
    this.workoutPlan,
    required this.date,
    required this.dayName,
    required this.focus,
    this.exercises,
    this.notes,
    bool? sessionComplete,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : sessionComplete = sessionComplete ?? false,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory WorkoutSession({
    int? id,
    required int workoutPlanId,
    _i2.WorkoutPlan? workoutPlan,
    required DateTime date,
    required String dayName,
    required String focus,
    List<_i3.WorkoutExercise>? exercises,
    String? notes,
    bool? sessionComplete,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _WorkoutSessionImpl;

  factory WorkoutSession.fromJson(Map<String, dynamic> jsonSerialization) {
    return WorkoutSession(
      id: jsonSerialization['id'] as int?,
      workoutPlanId: jsonSerialization['workoutPlanId'] as int,
      workoutPlan: jsonSerialization['workoutPlan'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.WorkoutPlan>(
              jsonSerialization['workoutPlan'],
            ),
      date: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      dayName: jsonSerialization['dayName'] as String,
      focus: jsonSerialization['focus'] as String,
      exercises: jsonSerialization['exercises'] == null
          ? null
          : _i4.Protocol().deserialize<List<_i3.WorkoutExercise>>(
              jsonSerialization['exercises'],
            ),
      notes: jsonSerialization['notes'] as String?,
      sessionComplete: jsonSerialization['sessionComplete'] as bool,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int workoutPlanId;

  _i2.WorkoutPlan? workoutPlan;

  DateTime date;

  String dayName;

  String focus;

  List<_i3.WorkoutExercise>? exercises;

  String? notes;

  bool sessionComplete;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [WorkoutSession]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WorkoutSession copyWith({
    int? id,
    int? workoutPlanId,
    _i2.WorkoutPlan? workoutPlan,
    DateTime? date,
    String? dayName,
    String? focus,
    List<_i3.WorkoutExercise>? exercises,
    String? notes,
    bool? sessionComplete,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WorkoutSession',
      if (id != null) 'id': id,
      'workoutPlanId': workoutPlanId,
      if (workoutPlan != null) 'workoutPlan': workoutPlan?.toJson(),
      'date': date.toJson(),
      'dayName': dayName,
      'focus': focus,
      if (exercises != null)
        'exercises': exercises?.toJson(valueToJson: (v) => v.toJson()),
      if (notes != null) 'notes': notes,
      'sessionComplete': sessionComplete,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WorkoutSessionImpl extends WorkoutSession {
  _WorkoutSessionImpl({
    int? id,
    required int workoutPlanId,
    _i2.WorkoutPlan? workoutPlan,
    required DateTime date,
    required String dayName,
    required String focus,
    List<_i3.WorkoutExercise>? exercises,
    String? notes,
    bool? sessionComplete,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         workoutPlanId: workoutPlanId,
         workoutPlan: workoutPlan,
         date: date,
         dayName: dayName,
         focus: focus,
         exercises: exercises,
         notes: notes,
         sessionComplete: sessionComplete,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [WorkoutSession]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WorkoutSession copyWith({
    Object? id = _Undefined,
    int? workoutPlanId,
    Object? workoutPlan = _Undefined,
    DateTime? date,
    String? dayName,
    String? focus,
    Object? exercises = _Undefined,
    Object? notes = _Undefined,
    bool? sessionComplete,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return WorkoutSession(
      id: id is int? ? id : this.id,
      workoutPlanId: workoutPlanId ?? this.workoutPlanId,
      workoutPlan: workoutPlan is _i2.WorkoutPlan?
          ? workoutPlan
          : this.workoutPlan?.copyWith(),
      date: date ?? this.date,
      dayName: dayName ?? this.dayName,
      focus: focus ?? this.focus,
      exercises: exercises is List<_i3.WorkoutExercise>?
          ? exercises
          : this.exercises?.map((e0) => e0.copyWith()).toList(),
      notes: notes is String? ? notes : this.notes,
      sessionComplete: sessionComplete ?? this.sessionComplete,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
