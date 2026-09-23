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
import '../../../features/exercise/models/exercise.dart' as _i2;
import 'package:fitbodyrd_client/src/protocol/protocol.dart' as _i3;

abstract class ExerciseAlternative implements _i1.SerializableModel {
  ExerciseAlternative._({
    this.id,
    required this.exerciseId,
    this.exercise,
    required this.alternativeExerciseId,
    this.alternativeExercise,
  });

  factory ExerciseAlternative({
    int? id,
    required int exerciseId,
    _i2.Exercise? exercise,
    required int alternativeExerciseId,
    _i2.Exercise? alternativeExercise,
  }) = _ExerciseAlternativeImpl;

  factory ExerciseAlternative.fromJson(Map<String, dynamic> jsonSerialization) {
    return ExerciseAlternative(
      id: jsonSerialization['id'] as int?,
      exerciseId: jsonSerialization['exerciseId'] as int,
      exercise: jsonSerialization['exercise'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Exercise>(
              jsonSerialization['exercise'],
            ),
      alternativeExerciseId: jsonSerialization['alternativeExerciseId'] as int,
      alternativeExercise: jsonSerialization['alternativeExercise'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Exercise>(
              jsonSerialization['alternativeExercise'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int exerciseId;

  /// The exercise that this alternative is replacing.
  _i2.Exercise? exercise;

  int alternativeExerciseId;

  /// The alternative exercise.
  _i2.Exercise? alternativeExercise;

  /// Returns a shallow copy of this [ExerciseAlternative]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ExerciseAlternative copyWith({
    int? id,
    int? exerciseId,
    _i2.Exercise? exercise,
    int? alternativeExerciseId,
    _i2.Exercise? alternativeExercise,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ExerciseAlternative',
      if (id != null) 'id': id,
      'exerciseId': exerciseId,
      if (exercise != null) 'exercise': exercise?.toJson(),
      'alternativeExerciseId': alternativeExerciseId,
      if (alternativeExercise != null)
        'alternativeExercise': alternativeExercise?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ExerciseAlternativeImpl extends ExerciseAlternative {
  _ExerciseAlternativeImpl({
    int? id,
    required int exerciseId,
    _i2.Exercise? exercise,
    required int alternativeExerciseId,
    _i2.Exercise? alternativeExercise,
  }) : super._(
         id: id,
         exerciseId: exerciseId,
         exercise: exercise,
         alternativeExerciseId: alternativeExerciseId,
         alternativeExercise: alternativeExercise,
       );

  /// Returns a shallow copy of this [ExerciseAlternative]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ExerciseAlternative copyWith({
    Object? id = _Undefined,
    int? exerciseId,
    Object? exercise = _Undefined,
    int? alternativeExerciseId,
    Object? alternativeExercise = _Undefined,
  }) {
    return ExerciseAlternative(
      id: id is int? ? id : this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      exercise: exercise is _i2.Exercise?
          ? exercise
          : this.exercise?.copyWith(),
      alternativeExerciseId:
          alternativeExerciseId ?? this.alternativeExerciseId,
      alternativeExercise: alternativeExercise is _i2.Exercise?
          ? alternativeExercise
          : this.alternativeExercise?.copyWith(),
    );
  }
}
