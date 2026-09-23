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
import '../../../features/workouts/dto/create_workout_exercise.dto.dart' as _i2;
import 'package:fitbodyrd_client/src/protocol/protocol.dart' as _i3;

abstract class CreateWorkoutSessionDto implements _i1.SerializableModel {
  CreateWorkoutSessionDto._({
    required this.date,
    required this.dayName,
    required this.focus,
    required this.exercises,
    this.notes,
  });

  factory CreateWorkoutSessionDto({
    required DateTime date,
    required String dayName,
    required String focus,
    required List<_i2.CreateWorkoutExerciseDto> exercises,
    String? notes,
  }) = _CreateWorkoutSessionDtoImpl;

  factory CreateWorkoutSessionDto.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CreateWorkoutSessionDto(
      date: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      dayName: jsonSerialization['dayName'] as String,
      focus: jsonSerialization['focus'] as String,
      exercises: _i3.Protocol().deserialize<List<_i2.CreateWorkoutExerciseDto>>(
        jsonSerialization['exercises'],
      ),
      notes: jsonSerialization['notes'] as String?,
    );
  }

  DateTime date;

  String dayName;

  String focus;

  List<_i2.CreateWorkoutExerciseDto> exercises;

  String? notes;

  /// Returns a shallow copy of this [CreateWorkoutSessionDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CreateWorkoutSessionDto copyWith({
    DateTime? date,
    String? dayName,
    String? focus,
    List<_i2.CreateWorkoutExerciseDto>? exercises,
    String? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CreateWorkoutSessionDto',
      'date': date.toJson(),
      'dayName': dayName,
      'focus': focus,
      'exercises': exercises.toJson(valueToJson: (v) => v.toJson()),
      if (notes != null) 'notes': notes,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CreateWorkoutSessionDtoImpl extends CreateWorkoutSessionDto {
  _CreateWorkoutSessionDtoImpl({
    required DateTime date,
    required String dayName,
    required String focus,
    required List<_i2.CreateWorkoutExerciseDto> exercises,
    String? notes,
  }) : super._(
         date: date,
         dayName: dayName,
         focus: focus,
         exercises: exercises,
         notes: notes,
       );

  /// Returns a shallow copy of this [CreateWorkoutSessionDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CreateWorkoutSessionDto copyWith({
    DateTime? date,
    String? dayName,
    String? focus,
    List<_i2.CreateWorkoutExerciseDto>? exercises,
    Object? notes = _Undefined,
  }) {
    return CreateWorkoutSessionDto(
      date: date ?? this.date,
      dayName: dayName ?? this.dayName,
      focus: focus ?? this.focus,
      exercises:
          exercises ?? this.exercises.map((e0) => e0.copyWith()).toList(),
      notes: notes is String? ? notes : this.notes,
    );
  }
}
