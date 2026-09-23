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
import '../../../common/models/status.dart' as _i2;
import '../../../features/user/models/app_user.dart' as _i3;
import '../../../common/models/exercise_difficulty.dart' as _i4;
import '../../../features/workouts/models/workout_session.dart' as _i5;
import 'package:fitbodyrd_client/src/protocol/protocol.dart' as _i6;

abstract class WorkoutPlan implements _i1.SerializableModel {
  WorkoutPlan._({
    this.id,
    required this.userId,
    this.user,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.difficultyLevel,
    this.sessions,
    int? sessionsCount,
    _i2.Status? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : sessionsCount = sessionsCount ?? 0,
       status = status ?? _i2.Status.active,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory WorkoutPlan({
    int? id,
    required int userId,
    _i3.UserProfile? user,
    required String name,
    required DateTime startDate,
    required DateTime endDate,
    required _i4.ExerciseDifficulty difficultyLevel,
    List<_i5.WorkoutSession>? sessions,
    int? sessionsCount,
    _i2.Status? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _WorkoutPlanImpl;

  factory WorkoutPlan.fromJson(Map<String, dynamic> jsonSerialization) {
    return WorkoutPlan(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i6.Protocol().deserialize<_i3.UserProfile>(
              jsonSerialization['user'],
            ),
      name: jsonSerialization['name'] as String,
      startDate: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startDate'],
      ),
      endDate: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endDate']),
      difficultyLevel: _i4.ExerciseDifficulty.fromJson(
        (jsonSerialization['difficultyLevel'] as String),
      ),
      sessions: jsonSerialization['sessions'] == null
          ? null
          : _i6.Protocol().deserialize<List<_i5.WorkoutSession>>(
              jsonSerialization['sessions'],
            ),
      sessionsCount: jsonSerialization['sessionsCount'] as int,
      status: _i2.Status.fromJson((jsonSerialization['status'] as String)),
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

  int userId;

  _i3.UserProfile? user;

  String name;

  DateTime startDate;

  DateTime endDate;

  _i4.ExerciseDifficulty difficultyLevel;

  List<_i5.WorkoutSession>? sessions;

  int sessionsCount;

  _i2.Status status;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [WorkoutPlan]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WorkoutPlan copyWith({
    int? id,
    int? userId,
    _i3.UserProfile? user,
    String? name,
    DateTime? startDate,
    DateTime? endDate,
    _i4.ExerciseDifficulty? difficultyLevel,
    List<_i5.WorkoutSession>? sessions,
    int? sessionsCount,
    _i2.Status? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WorkoutPlan',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'name': name,
      'startDate': startDate.toJson(),
      'endDate': endDate.toJson(),
      'difficultyLevel': difficultyLevel.toJson(),
      if (sessions != null)
        'sessions': sessions?.toJson(valueToJson: (v) => v.toJson()),
      'sessionsCount': sessionsCount,
      'status': status.toJson(),
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

class _WorkoutPlanImpl extends WorkoutPlan {
  _WorkoutPlanImpl({
    int? id,
    required int userId,
    _i3.UserProfile? user,
    required String name,
    required DateTime startDate,
    required DateTime endDate,
    required _i4.ExerciseDifficulty difficultyLevel,
    List<_i5.WorkoutSession>? sessions,
    int? sessionsCount,
    _i2.Status? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         name: name,
         startDate: startDate,
         endDate: endDate,
         difficultyLevel: difficultyLevel,
         sessions: sessions,
         sessionsCount: sessionsCount,
         status: status,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [WorkoutPlan]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WorkoutPlan copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    String? name,
    DateTime? startDate,
    DateTime? endDate,
    _i4.ExerciseDifficulty? difficultyLevel,
    Object? sessions = _Undefined,
    int? sessionsCount,
    _i2.Status? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return WorkoutPlan(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i3.UserProfile? ? user : this.user?.copyWith(),
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      difficultyLevel: difficultyLevel ?? this.difficultyLevel,
      sessions: sessions is List<_i5.WorkoutSession>?
          ? sessions
          : this.sessions?.map((e0) => e0.copyWith()).toList(),
      sessionsCount: sessionsCount ?? this.sessionsCount,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
