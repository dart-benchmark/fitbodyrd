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

abstract class CreateWorkoutExerciseDto
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  CreateWorkoutExerciseDto._({
    required this.exerciseId,
    required this.order,
    required this.sets,
    required this.reps,
    required this.restSeconds,
    this.notes,
  });

  factory CreateWorkoutExerciseDto({
    required int exerciseId,
    required int order,
    required int sets,
    required int reps,
    required int restSeconds,
    String? notes,
  }) = _CreateWorkoutExerciseDtoImpl;

  factory CreateWorkoutExerciseDto.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CreateWorkoutExerciseDto(
      exerciseId: jsonSerialization['exerciseId'] as int,
      order: jsonSerialization['order'] as int,
      sets: jsonSerialization['sets'] as int,
      reps: jsonSerialization['reps'] as int,
      restSeconds: jsonSerialization['restSeconds'] as int,
      notes: jsonSerialization['notes'] as String?,
    );
  }

  int exerciseId;

  int order;

  int sets;

  int reps;

  int restSeconds;

  String? notes;

  /// Returns a shallow copy of this [CreateWorkoutExerciseDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CreateWorkoutExerciseDto copyWith({
    int? exerciseId,
    int? order,
    int? sets,
    int? reps,
    int? restSeconds,
    String? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CreateWorkoutExerciseDto',
      'exerciseId': exerciseId,
      'order': order,
      'sets': sets,
      'reps': reps,
      'restSeconds': restSeconds,
      if (notes != null) 'notes': notes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CreateWorkoutExerciseDto',
      'exerciseId': exerciseId,
      'order': order,
      'sets': sets,
      'reps': reps,
      'restSeconds': restSeconds,
      if (notes != null) 'notes': notes,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CreateWorkoutExerciseDtoImpl extends CreateWorkoutExerciseDto {
  _CreateWorkoutExerciseDtoImpl({
    required int exerciseId,
    required int order,
    required int sets,
    required int reps,
    required int restSeconds,
    String? notes,
  }) : super._(
         exerciseId: exerciseId,
         order: order,
         sets: sets,
         reps: reps,
         restSeconds: restSeconds,
         notes: notes,
       );

  /// Returns a shallow copy of this [CreateWorkoutExerciseDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CreateWorkoutExerciseDto copyWith({
    int? exerciseId,
    int? order,
    int? sets,
    int? reps,
    int? restSeconds,
    Object? notes = _Undefined,
  }) {
    return CreateWorkoutExerciseDto(
      exerciseId: exerciseId ?? this.exerciseId,
      order: order ?? this.order,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      restSeconds: restSeconds ?? this.restSeconds,
      notes: notes is String? ? notes : this.notes,
    );
  }
}
