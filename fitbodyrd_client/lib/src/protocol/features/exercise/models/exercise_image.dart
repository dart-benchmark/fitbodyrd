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

abstract class ExerciseImage implements _i1.SerializableModel {
  ExerciseImage._({
    this.id,
    required this.exerciseId,
    this.exercise,
    required this.imageUrl,
    int? orderIndex,
    DateTime? createdAt,
  }) : orderIndex = orderIndex ?? 0,
       createdAt = createdAt ?? DateTime.now();

  factory ExerciseImage({
    int? id,
    required int exerciseId,
    _i2.Exercise? exercise,
    required String imageUrl,
    int? orderIndex,
    DateTime? createdAt,
  }) = _ExerciseImageImpl;

  factory ExerciseImage.fromJson(Map<String, dynamic> jsonSerialization) {
    return ExerciseImage(
      id: jsonSerialization['id'] as int?,
      exerciseId: jsonSerialization['exerciseId'] as int,
      exercise: jsonSerialization['exercise'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Exercise>(
              jsonSerialization['exercise'],
            ),
      imageUrl: jsonSerialization['imageUrl'] as String,
      orderIndex: jsonSerialization['orderIndex'] as int,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int exerciseId;

  _i2.Exercise? exercise;

  String imageUrl;

  /// Order index for sorting images. Lower values appear first.
  int orderIndex;

  DateTime createdAt;

  /// Returns a shallow copy of this [ExerciseImage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ExerciseImage copyWith({
    int? id,
    int? exerciseId,
    _i2.Exercise? exercise,
    String? imageUrl,
    int? orderIndex,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ExerciseImage',
      if (id != null) 'id': id,
      'exerciseId': exerciseId,
      if (exercise != null) 'exercise': exercise?.toJson(),
      'imageUrl': imageUrl,
      'orderIndex': orderIndex,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ExerciseImageImpl extends ExerciseImage {
  _ExerciseImageImpl({
    int? id,
    required int exerciseId,
    _i2.Exercise? exercise,
    required String imageUrl,
    int? orderIndex,
    DateTime? createdAt,
  }) : super._(
         id: id,
         exerciseId: exerciseId,
         exercise: exercise,
         imageUrl: imageUrl,
         orderIndex: orderIndex,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ExerciseImage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ExerciseImage copyWith({
    Object? id = _Undefined,
    int? exerciseId,
    Object? exercise = _Undefined,
    String? imageUrl,
    int? orderIndex,
    DateTime? createdAt,
  }) {
    return ExerciseImage(
      id: id is int? ? id : this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      exercise: exercise is _i2.Exercise?
          ? exercise
          : this.exercise?.copyWith(),
      imageUrl: imageUrl ?? this.imageUrl,
      orderIndex: orderIndex ?? this.orderIndex,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
