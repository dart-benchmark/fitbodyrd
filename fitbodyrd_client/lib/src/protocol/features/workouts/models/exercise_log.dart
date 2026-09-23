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
import '../../../features/user/models/app_user.dart' as _i2;
import 'package:fitbodyrd_client/src/protocol/protocol.dart' as _i3;

abstract class ExerciseLog implements _i1.SerializableModel {
  ExerciseLog._({
    this.id,
    required this.userId,
    this.user,
    required this.exerciseId,
    this.workoutExerciseId,
    required this.date,
    required this.setsCompleted,
    required this.repsCompleted,
    this.weightUsed,
    this.difficultyRating,
    this.notes,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory ExerciseLog({
    int? id,
    required int userId,
    _i2.UserProfile? user,
    required int exerciseId,
    int? workoutExerciseId,
    required DateTime date,
    required int setsCompleted,
    required int repsCompleted,
    double? weightUsed,
    int? difficultyRating,
    String? notes,
    DateTime? createdAt,
  }) = _ExerciseLogImpl;

  factory ExerciseLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return ExerciseLog(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.UserProfile>(
              jsonSerialization['user'],
            ),
      exerciseId: jsonSerialization['exerciseId'] as int,
      workoutExerciseId: jsonSerialization['workoutExerciseId'] as int?,
      date: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      setsCompleted: jsonSerialization['setsCompleted'] as int,
      repsCompleted: jsonSerialization['repsCompleted'] as int,
      weightUsed: (jsonSerialization['weightUsed'] as num?)?.toDouble(),
      difficultyRating: jsonSerialization['difficultyRating'] as int?,
      notes: jsonSerialization['notes'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  _i2.UserProfile? user;

  int exerciseId;

  int? workoutExerciseId;

  DateTime date;

  int setsCompleted;

  int repsCompleted;

  double? weightUsed;

  int? difficultyRating;

  String? notes;

  DateTime createdAt;

  /// Returns a shallow copy of this [ExerciseLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ExerciseLog copyWith({
    int? id,
    int? userId,
    _i2.UserProfile? user,
    int? exerciseId,
    int? workoutExerciseId,
    DateTime? date,
    int? setsCompleted,
    int? repsCompleted,
    double? weightUsed,
    int? difficultyRating,
    String? notes,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ExerciseLog',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'exerciseId': exerciseId,
      if (workoutExerciseId != null) 'workoutExerciseId': workoutExerciseId,
      'date': date.toJson(),
      'setsCompleted': setsCompleted,
      'repsCompleted': repsCompleted,
      if (weightUsed != null) 'weightUsed': weightUsed,
      if (difficultyRating != null) 'difficultyRating': difficultyRating,
      if (notes != null) 'notes': notes,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ExerciseLogImpl extends ExerciseLog {
  _ExerciseLogImpl({
    int? id,
    required int userId,
    _i2.UserProfile? user,
    required int exerciseId,
    int? workoutExerciseId,
    required DateTime date,
    required int setsCompleted,
    required int repsCompleted,
    double? weightUsed,
    int? difficultyRating,
    String? notes,
    DateTime? createdAt,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         exerciseId: exerciseId,
         workoutExerciseId: workoutExerciseId,
         date: date,
         setsCompleted: setsCompleted,
         repsCompleted: repsCompleted,
         weightUsed: weightUsed,
         difficultyRating: difficultyRating,
         notes: notes,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ExerciseLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ExerciseLog copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    int? exerciseId,
    Object? workoutExerciseId = _Undefined,
    DateTime? date,
    int? setsCompleted,
    int? repsCompleted,
    Object? weightUsed = _Undefined,
    Object? difficultyRating = _Undefined,
    Object? notes = _Undefined,
    DateTime? createdAt,
  }) {
    return ExerciseLog(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.UserProfile? ? user : this.user?.copyWith(),
      exerciseId: exerciseId ?? this.exerciseId,
      workoutExerciseId: workoutExerciseId is int?
          ? workoutExerciseId
          : this.workoutExerciseId,
      date: date ?? this.date,
      setsCompleted: setsCompleted ?? this.setsCompleted,
      repsCompleted: repsCompleted ?? this.repsCompleted,
      weightUsed: weightUsed is double? ? weightUsed : this.weightUsed,
      difficultyRating: difficultyRating is int?
          ? difficultyRating
          : this.difficultyRating,
      notes: notes is String? ? notes : this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
