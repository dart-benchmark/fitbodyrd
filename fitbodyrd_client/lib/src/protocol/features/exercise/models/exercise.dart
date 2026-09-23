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
import '../../../features/exercise/models/exercise_category.dart' as _i2;
import '../../../features/exercise/models/exercise_muscle_group.dart' as _i3;
import '../../../common/models/exercise_difficulty.dart' as _i4;
import '../../../features/exercise/models/exercise_image.dart' as _i5;
import '../../../features/exercise/models/exercise_alternative.dart' as _i6;
import 'package:fitbodyrd_client/src/protocol/protocol.dart' as _i7;

abstract class Exercise implements _i1.SerializableModel {
  Exercise._({
    this.id,
    required this.name,
    this.description,
    required this.category,
    required this.muscleGroup,
    required this.difficulty,
    bool? requiresEquipment,
    this.equipmentNeeded,
    this.videoUrl,
    this.images,
    this.alternatives,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : requiresEquipment = requiresEquipment ?? false,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Exercise({
    int? id,
    required String name,
    String? description,
    required List<_i2.ExerciseCategory> category,
    required List<_i3.ExerciseMuscleGroup> muscleGroup,
    required _i4.ExerciseDifficulty difficulty,
    bool? requiresEquipment,
    String? equipmentNeeded,
    String? videoUrl,
    List<_i5.ExerciseImage>? images,
    List<_i6.ExerciseAlternative>? alternatives,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ExerciseImpl;

  factory Exercise.fromJson(Map<String, dynamic> jsonSerialization) {
    return Exercise(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      category: _i7.Protocol().deserialize<List<_i2.ExerciseCategory>>(
        jsonSerialization['category'],
      ),
      muscleGroup: _i7.Protocol().deserialize<List<_i3.ExerciseMuscleGroup>>(
        jsonSerialization['muscleGroup'],
      ),
      difficulty: _i4.ExerciseDifficulty.fromJson(
        (jsonSerialization['difficulty'] as String),
      ),
      requiresEquipment: jsonSerialization['requiresEquipment'] as bool,
      equipmentNeeded: jsonSerialization['equipmentNeeded'] as String?,
      videoUrl: jsonSerialization['videoUrl'] as String?,
      images: jsonSerialization['images'] == null
          ? null
          : _i7.Protocol().deserialize<List<_i5.ExerciseImage>>(
              jsonSerialization['images'],
            ),
      alternatives: jsonSerialization['alternatives'] == null
          ? null
          : _i7.Protocol().deserialize<List<_i6.ExerciseAlternative>>(
              jsonSerialization['alternatives'],
            ),
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

  String name;

  String? description;

  List<_i2.ExerciseCategory> category;

  List<_i3.ExerciseMuscleGroup> muscleGroup;

  _i4.ExerciseDifficulty difficulty;

  /// Indicates if the exercise requires any equipment.
  bool requiresEquipment;

  /// Description of the equipment needed, if any.
  String? equipmentNeeded;

  String? videoUrl;

  List<_i5.ExerciseImage>? images;

  /// Exercises that can be used as alternatives to this exercise.
  List<_i6.ExerciseAlternative>? alternatives;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Exercise]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Exercise copyWith({
    int? id,
    String? name,
    String? description,
    List<_i2.ExerciseCategory>? category,
    List<_i3.ExerciseMuscleGroup>? muscleGroup,
    _i4.ExerciseDifficulty? difficulty,
    bool? requiresEquipment,
    String? equipmentNeeded,
    String? videoUrl,
    List<_i5.ExerciseImage>? images,
    List<_i6.ExerciseAlternative>? alternatives,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Exercise',
      if (id != null) 'id': id,
      'name': name,
      if (description != null) 'description': description,
      'category': category.toJson(valueToJson: (v) => v.toJson()),
      'muscleGroup': muscleGroup.toJson(valueToJson: (v) => v.toJson()),
      'difficulty': difficulty.toJson(),
      'requiresEquipment': requiresEquipment,
      if (equipmentNeeded != null) 'equipmentNeeded': equipmentNeeded,
      if (videoUrl != null) 'videoUrl': videoUrl,
      if (images != null)
        'images': images?.toJson(valueToJson: (v) => v.toJson()),
      if (alternatives != null)
        'alternatives': alternatives?.toJson(valueToJson: (v) => v.toJson()),
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

class _ExerciseImpl extends Exercise {
  _ExerciseImpl({
    int? id,
    required String name,
    String? description,
    required List<_i2.ExerciseCategory> category,
    required List<_i3.ExerciseMuscleGroup> muscleGroup,
    required _i4.ExerciseDifficulty difficulty,
    bool? requiresEquipment,
    String? equipmentNeeded,
    String? videoUrl,
    List<_i5.ExerciseImage>? images,
    List<_i6.ExerciseAlternative>? alternatives,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         name: name,
         description: description,
         category: category,
         muscleGroup: muscleGroup,
         difficulty: difficulty,
         requiresEquipment: requiresEquipment,
         equipmentNeeded: equipmentNeeded,
         videoUrl: videoUrl,
         images: images,
         alternatives: alternatives,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Exercise]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Exercise copyWith({
    Object? id = _Undefined,
    String? name,
    Object? description = _Undefined,
    List<_i2.ExerciseCategory>? category,
    List<_i3.ExerciseMuscleGroup>? muscleGroup,
    _i4.ExerciseDifficulty? difficulty,
    bool? requiresEquipment,
    Object? equipmentNeeded = _Undefined,
    Object? videoUrl = _Undefined,
    Object? images = _Undefined,
    Object? alternatives = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Exercise(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      category: category ?? this.category.map((e0) => e0).toList(),
      muscleGroup: muscleGroup ?? this.muscleGroup.map((e0) => e0).toList(),
      difficulty: difficulty ?? this.difficulty,
      requiresEquipment: requiresEquipment ?? this.requiresEquipment,
      equipmentNeeded: equipmentNeeded is String?
          ? equipmentNeeded
          : this.equipmentNeeded,
      videoUrl: videoUrl is String? ? videoUrl : this.videoUrl,
      images: images is List<_i5.ExerciseImage>?
          ? images
          : this.images?.map((e0) => e0.copyWith()).toList(),
      alternatives: alternatives is List<_i6.ExerciseAlternative>?
          ? alternatives
          : this.alternatives?.map((e0) => e0.copyWith()).toList(),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
