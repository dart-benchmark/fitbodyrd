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
import '../../../common/models/exercise_difficulty.dart' as _i2;
import '../../../features/workouts/dto/create_workout_session.dto.dart' as _i3;
import 'package:fitbodyrd_client/src/protocol/protocol.dart' as _i4;

abstract class CreateWorkoutPlanDto implements _i1.SerializableModel {
  CreateWorkoutPlanDto._({
    required this.userId,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.difficultyLevel,
    this.sessions,
  });

  factory CreateWorkoutPlanDto({
    required int userId,
    required String name,
    required DateTime startDate,
    required DateTime endDate,
    required _i2.ExerciseDifficulty difficultyLevel,
    List<_i3.CreateWorkoutSessionDto>? sessions,
  }) = _CreateWorkoutPlanDtoImpl;

  factory CreateWorkoutPlanDto.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CreateWorkoutPlanDto(
      userId: jsonSerialization['userId'] as int,
      name: jsonSerialization['name'] as String,
      startDate: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startDate'],
      ),
      endDate: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endDate']),
      difficultyLevel: _i2.ExerciseDifficulty.fromJson(
        (jsonSerialization['difficultyLevel'] as String),
      ),
      sessions: jsonSerialization['sessions'] == null
          ? null
          : _i4.Protocol().deserialize<List<_i3.CreateWorkoutSessionDto>>(
              jsonSerialization['sessions'],
            ),
    );
  }

  int userId;

  String name;

  DateTime startDate;

  DateTime endDate;

  _i2.ExerciseDifficulty difficultyLevel;

  List<_i3.CreateWorkoutSessionDto>? sessions;

  /// Returns a shallow copy of this [CreateWorkoutPlanDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CreateWorkoutPlanDto copyWith({
    int? userId,
    String? name,
    DateTime? startDate,
    DateTime? endDate,
    _i2.ExerciseDifficulty? difficultyLevel,
    List<_i3.CreateWorkoutSessionDto>? sessions,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CreateWorkoutPlanDto',
      'userId': userId,
      'name': name,
      'startDate': startDate.toJson(),
      'endDate': endDate.toJson(),
      'difficultyLevel': difficultyLevel.toJson(),
      if (sessions != null)
        'sessions': sessions?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CreateWorkoutPlanDtoImpl extends CreateWorkoutPlanDto {
  _CreateWorkoutPlanDtoImpl({
    required int userId,
    required String name,
    required DateTime startDate,
    required DateTime endDate,
    required _i2.ExerciseDifficulty difficultyLevel,
    List<_i3.CreateWorkoutSessionDto>? sessions,
  }) : super._(
         userId: userId,
         name: name,
         startDate: startDate,
         endDate: endDate,
         difficultyLevel: difficultyLevel,
         sessions: sessions,
       );

  /// Returns a shallow copy of this [CreateWorkoutPlanDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CreateWorkoutPlanDto copyWith({
    int? userId,
    String? name,
    DateTime? startDate,
    DateTime? endDate,
    _i2.ExerciseDifficulty? difficultyLevel,
    Object? sessions = _Undefined,
  }) {
    return CreateWorkoutPlanDto(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      difficultyLevel: difficultyLevel ?? this.difficultyLevel,
      sessions: sessions is List<_i3.CreateWorkoutSessionDto>?
          ? sessions
          : this.sessions?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
