/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../../../features/exercise/models/exercise_category.dart' as _i2;
import '../../../features/exercise/models/exercise_muscle_group.dart' as _i3;
import '../../../common/models/exercise_difficulty.dart' as _i4;
import '../../../features/exercise/models/exercise_image.dart' as _i5;
import '../../../features/exercise/models/exercise_alternative.dart' as _i6;
import 'package:fitbodyrd_server/src/generated/protocol.dart' as _i7;

abstract class Exercise
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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
    this.alternativesFor,
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
    List<_i6.ExerciseAlternative>? alternativesFor,
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
      alternativesFor: jsonSerialization['alternativesFor'] == null
          ? null
          : _i7.Protocol().deserialize<List<_i6.ExerciseAlternative>>(
              jsonSerialization['alternativesFor'],
            ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = ExerciseTable();

  static const db = ExerciseRepository._();

  @override
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

  /// Exercises for which this exercise is an alternative.
  List<_i6.ExerciseAlternative>? alternativesFor;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

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
    List<_i6.ExerciseAlternative>? alternativesFor,
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
      if (alternativesFor != null)
        'alternativesFor': alternativesFor?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
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
        'images': images?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (alternatives != null)
        'alternatives': alternatives?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ExerciseInclude include({
    _i5.ExerciseImageIncludeList? images,
    _i6.ExerciseAlternativeIncludeList? alternatives,
    _i6.ExerciseAlternativeIncludeList? alternativesFor,
  }) {
    return ExerciseInclude._(
      images: images,
      alternatives: alternatives,
      alternativesFor: alternativesFor,
    );
  }

  static ExerciseIncludeList includeList({
    _i1.WhereExpressionBuilder<ExerciseTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ExerciseTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExerciseTable>? orderByList,
    ExerciseInclude? include,
  }) {
    return ExerciseIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Exercise.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Exercise.t),
      include: include,
    );
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
    List<_i6.ExerciseAlternative>? alternativesFor,
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
         alternativesFor: alternativesFor,
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
    Object? alternativesFor = _Undefined,
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
      alternativesFor: alternativesFor is List<_i6.ExerciseAlternative>?
          ? alternativesFor
          : this.alternativesFor?.map((e0) => e0.copyWith()).toList(),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ExerciseUpdateTable extends _i1.UpdateTable<ExerciseTable> {
  ExerciseUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> description(String? value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<List<_i2.ExerciseCategory>, List<_i2.ExerciseCategory>>
  category(List<_i2.ExerciseCategory> value) => _i1.ColumnValue(
    table.category,
    value,
  );

  _i1.ColumnValue<List<_i3.ExerciseMuscleGroup>, List<_i3.ExerciseMuscleGroup>>
  muscleGroup(List<_i3.ExerciseMuscleGroup> value) => _i1.ColumnValue(
    table.muscleGroup,
    value,
  );

  _i1.ColumnValue<_i4.ExerciseDifficulty, _i4.ExerciseDifficulty> difficulty(
    _i4.ExerciseDifficulty value,
  ) => _i1.ColumnValue(
    table.difficulty,
    value,
  );

  _i1.ColumnValue<bool, bool> requiresEquipment(bool value) => _i1.ColumnValue(
    table.requiresEquipment,
    value,
  );

  _i1.ColumnValue<String, String> equipmentNeeded(String? value) =>
      _i1.ColumnValue(
        table.equipmentNeeded,
        value,
      );

  _i1.ColumnValue<String, String> videoUrl(String? value) => _i1.ColumnValue(
    table.videoUrl,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class ExerciseTable extends _i1.Table<int?> {
  ExerciseTable({super.tableRelation}) : super(tableName: 'exercises') {
    updateTable = ExerciseUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    category = _i1.ColumnSerializable<List<_i2.ExerciseCategory>>(
      'category',
      this,
    );
    muscleGroup = _i1.ColumnSerializable<List<_i3.ExerciseMuscleGroup>>(
      'muscleGroup',
      this,
    );
    difficulty = _i1.ColumnEnum(
      'difficulty',
      this,
      _i1.EnumSerialization.byName,
    );
    requiresEquipment = _i1.ColumnBool(
      'requiresEquipment',
      this,
      hasDefault: true,
    );
    equipmentNeeded = _i1.ColumnString(
      'equipmentNeeded',
      this,
    );
    videoUrl = _i1.ColumnString(
      'videoUrl',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
  }

  late final ExerciseUpdateTable updateTable;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnSerializable<List<_i2.ExerciseCategory>> category;

  late final _i1.ColumnSerializable<List<_i3.ExerciseMuscleGroup>> muscleGroup;

  late final _i1.ColumnEnum<_i4.ExerciseDifficulty> difficulty;

  /// Indicates if the exercise requires any equipment.
  late final _i1.ColumnBool requiresEquipment;

  /// Description of the equipment needed, if any.
  late final _i1.ColumnString equipmentNeeded;

  late final _i1.ColumnString videoUrl;

  _i5.ExerciseImageTable? ___images;

  _i1.ManyRelation<_i5.ExerciseImageTable>? _images;

  /// Exercises that can be used as alternatives to this exercise.
  _i6.ExerciseAlternativeTable? ___alternatives;

  /// Exercises that can be used as alternatives to this exercise.
  _i1.ManyRelation<_i6.ExerciseAlternativeTable>? _alternatives;

  /// Exercises for which this exercise is an alternative.
  _i6.ExerciseAlternativeTable? ___alternativesFor;

  /// Exercises for which this exercise is an alternative.
  _i1.ManyRelation<_i6.ExerciseAlternativeTable>? _alternativesFor;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  _i5.ExerciseImageTable get __images {
    if (___images != null) return ___images!;
    ___images = _i1.createRelationTable(
      relationFieldName: '__images',
      field: Exercise.t.id,
      foreignField: _i5.ExerciseImage.t.exerciseId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.ExerciseImageTable(tableRelation: foreignTableRelation),
    );
    return ___images!;
  }

  _i6.ExerciseAlternativeTable get __alternatives {
    if (___alternatives != null) return ___alternatives!;
    ___alternatives = _i1.createRelationTable(
      relationFieldName: '__alternatives',
      field: Exercise.t.id,
      foreignField: _i6.ExerciseAlternative.t.exerciseId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i6.ExerciseAlternativeTable(tableRelation: foreignTableRelation),
    );
    return ___alternatives!;
  }

  _i6.ExerciseAlternativeTable get __alternativesFor {
    if (___alternativesFor != null) return ___alternativesFor!;
    ___alternativesFor = _i1.createRelationTable(
      relationFieldName: '__alternativesFor',
      field: Exercise.t.id,
      foreignField: _i6.ExerciseAlternative.t.alternativeExerciseId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i6.ExerciseAlternativeTable(tableRelation: foreignTableRelation),
    );
    return ___alternativesFor!;
  }

  _i1.ManyRelation<_i5.ExerciseImageTable> get images {
    if (_images != null) return _images!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'images',
      field: Exercise.t.id,
      foreignField: _i5.ExerciseImage.t.exerciseId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.ExerciseImageTable(tableRelation: foreignTableRelation),
    );
    _images = _i1.ManyRelation<_i5.ExerciseImageTable>(
      tableWithRelations: relationTable,
      table: _i5.ExerciseImageTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _images!;
  }

  _i1.ManyRelation<_i6.ExerciseAlternativeTable> get alternatives {
    if (_alternatives != null) return _alternatives!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'alternatives',
      field: Exercise.t.id,
      foreignField: _i6.ExerciseAlternative.t.exerciseId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i6.ExerciseAlternativeTable(tableRelation: foreignTableRelation),
    );
    _alternatives = _i1.ManyRelation<_i6.ExerciseAlternativeTable>(
      tableWithRelations: relationTable,
      table: _i6.ExerciseAlternativeTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _alternatives!;
  }

  _i1.ManyRelation<_i6.ExerciseAlternativeTable> get alternativesFor {
    if (_alternativesFor != null) return _alternativesFor!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'alternativesFor',
      field: Exercise.t.id,
      foreignField: _i6.ExerciseAlternative.t.alternativeExerciseId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i6.ExerciseAlternativeTable(tableRelation: foreignTableRelation),
    );
    _alternativesFor = _i1.ManyRelation<_i6.ExerciseAlternativeTable>(
      tableWithRelations: relationTable,
      table: _i6.ExerciseAlternativeTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _alternativesFor!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    name,
    description,
    category,
    muscleGroup,
    difficulty,
    requiresEquipment,
    equipmentNeeded,
    videoUrl,
    createdAt,
    updatedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'images') {
      return __images;
    }
    if (relationField == 'alternatives') {
      return __alternatives;
    }
    if (relationField == 'alternativesFor') {
      return __alternativesFor;
    }
    return null;
  }
}

class ExerciseInclude extends _i1.IncludeObject {
  ExerciseInclude._({
    _i5.ExerciseImageIncludeList? images,
    _i6.ExerciseAlternativeIncludeList? alternatives,
    _i6.ExerciseAlternativeIncludeList? alternativesFor,
  }) {
    _images = images;
    _alternatives = alternatives;
    _alternativesFor = alternativesFor;
  }

  _i5.ExerciseImageIncludeList? _images;

  _i6.ExerciseAlternativeIncludeList? _alternatives;

  _i6.ExerciseAlternativeIncludeList? _alternativesFor;

  @override
  Map<String, _i1.Include?> get includes => {
    'images': _images,
    'alternatives': _alternatives,
    'alternativesFor': _alternativesFor,
  };

  @override
  _i1.Table<int?> get table => Exercise.t;
}

class ExerciseIncludeList extends _i1.IncludeList {
  ExerciseIncludeList._({
    _i1.WhereExpressionBuilder<ExerciseTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Exercise.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Exercise.t;
}

class ExerciseRepository {
  const ExerciseRepository._();

  final attach = const ExerciseAttachRepository._();

  final attachRow = const ExerciseAttachRowRepository._();

  final detach = const ExerciseDetachRepository._();

  final detachRow = const ExerciseDetachRowRepository._();

  /// Returns a list of [Exercise]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Exercise>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ExerciseTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ExerciseTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExerciseTable>? orderByList,
    _i1.Transaction? transaction,
    ExerciseInclude? include,
  }) async {
    return session.db.find<Exercise>(
      where: where?.call(Exercise.t),
      orderBy: orderBy?.call(Exercise.t),
      orderByList: orderByList?.call(Exercise.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [Exercise] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Exercise?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ExerciseTable>? where,
    int? offset,
    _i1.OrderByBuilder<ExerciseTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExerciseTable>? orderByList,
    _i1.Transaction? transaction,
    ExerciseInclude? include,
  }) async {
    return session.db.findFirstRow<Exercise>(
      where: where?.call(Exercise.t),
      orderBy: orderBy?.call(Exercise.t),
      orderByList: orderByList?.call(Exercise.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [Exercise] by its [id] or null if no such row exists.
  Future<Exercise?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    ExerciseInclude? include,
  }) async {
    return session.db.findById<Exercise>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [Exercise]s in the list and returns the inserted rows.
  ///
  /// The returned [Exercise]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Exercise>> insert(
    _i1.Session session,
    List<Exercise> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Exercise>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Exercise] and returns the inserted row.
  ///
  /// The returned [Exercise] will have its `id` field set.
  Future<Exercise> insertRow(
    _i1.Session session,
    Exercise row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Exercise>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Exercise]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Exercise>> update(
    _i1.Session session,
    List<Exercise> rows, {
    _i1.ColumnSelections<ExerciseTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Exercise>(
      rows,
      columns: columns?.call(Exercise.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Exercise]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Exercise> updateRow(
    _i1.Session session,
    Exercise row, {
    _i1.ColumnSelections<ExerciseTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Exercise>(
      row,
      columns: columns?.call(Exercise.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Exercise] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Exercise?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<ExerciseUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Exercise>(
      id,
      columnValues: columnValues(Exercise.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Exercise]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Exercise>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<ExerciseUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ExerciseTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ExerciseTable>? orderBy,
    _i1.OrderByListBuilder<ExerciseTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Exercise>(
      columnValues: columnValues(Exercise.t.updateTable),
      where: where(Exercise.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Exercise.t),
      orderByList: orderByList?.call(Exercise.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Exercise]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Exercise>> delete(
    _i1.Session session,
    List<Exercise> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Exercise>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Exercise].
  Future<Exercise> deleteRow(
    _i1.Session session,
    Exercise row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Exercise>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Exercise>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ExerciseTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Exercise>(
      where: where(Exercise.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ExerciseTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Exercise>(
      where: where?.call(Exercise.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class ExerciseAttachRepository {
  const ExerciseAttachRepository._();

  /// Creates a relation between this [Exercise] and the given [ExerciseImage]s
  /// by setting each [ExerciseImage]'s foreign key `exerciseId` to refer to this [Exercise].
  Future<void> images(
    _i1.Session session,
    Exercise exercise,
    List<_i5.ExerciseImage> exerciseImage, {
    _i1.Transaction? transaction,
  }) async {
    if (exerciseImage.any((e) => e.id == null)) {
      throw ArgumentError.notNull('exerciseImage.id');
    }
    if (exercise.id == null) {
      throw ArgumentError.notNull('exercise.id');
    }

    var $exerciseImage = exerciseImage
        .map((e) => e.copyWith(exerciseId: exercise.id))
        .toList();
    await session.db.update<_i5.ExerciseImage>(
      $exerciseImage,
      columns: [_i5.ExerciseImage.t.exerciseId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Exercise] and the given [ExerciseAlternative]s
  /// by setting each [ExerciseAlternative]'s foreign key `exerciseId` to refer to this [Exercise].
  Future<void> alternatives(
    _i1.Session session,
    Exercise exercise,
    List<_i6.ExerciseAlternative> exerciseAlternative, {
    _i1.Transaction? transaction,
  }) async {
    if (exerciseAlternative.any((e) => e.id == null)) {
      throw ArgumentError.notNull('exerciseAlternative.id');
    }
    if (exercise.id == null) {
      throw ArgumentError.notNull('exercise.id');
    }

    var $exerciseAlternative = exerciseAlternative
        .map((e) => e.copyWith(exerciseId: exercise.id))
        .toList();
    await session.db.update<_i6.ExerciseAlternative>(
      $exerciseAlternative,
      columns: [_i6.ExerciseAlternative.t.exerciseId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Exercise] and the given [ExerciseAlternative]s
  /// by setting each [ExerciseAlternative]'s foreign key `alternativeExerciseId` to refer to this [Exercise].
  Future<void> alternativesFor(
    _i1.Session session,
    Exercise exercise,
    List<_i6.ExerciseAlternative> exerciseAlternative, {
    _i1.Transaction? transaction,
  }) async {
    if (exerciseAlternative.any((e) => e.id == null)) {
      throw ArgumentError.notNull('exerciseAlternative.id');
    }
    if (exercise.id == null) {
      throw ArgumentError.notNull('exercise.id');
    }

    var $exerciseAlternative = exerciseAlternative
        .map((e) => e.copyWith(alternativeExerciseId: exercise.id))
        .toList();
    await session.db.update<_i6.ExerciseAlternative>(
      $exerciseAlternative,
      columns: [_i6.ExerciseAlternative.t.alternativeExerciseId],
      transaction: transaction,
    );
  }
}

class ExerciseAttachRowRepository {
  const ExerciseAttachRowRepository._();

  /// Creates a relation between this [Exercise] and the given [ExerciseImage]
  /// by setting the [ExerciseImage]'s foreign key `exerciseId` to refer to this [Exercise].
  Future<void> images(
    _i1.Session session,
    Exercise exercise,
    _i5.ExerciseImage exerciseImage, {
    _i1.Transaction? transaction,
  }) async {
    if (exerciseImage.id == null) {
      throw ArgumentError.notNull('exerciseImage.id');
    }
    if (exercise.id == null) {
      throw ArgumentError.notNull('exercise.id');
    }

    var $exerciseImage = exerciseImage.copyWith(exerciseId: exercise.id);
    await session.db.updateRow<_i5.ExerciseImage>(
      $exerciseImage,
      columns: [_i5.ExerciseImage.t.exerciseId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Exercise] and the given [ExerciseAlternative]
  /// by setting the [ExerciseAlternative]'s foreign key `exerciseId` to refer to this [Exercise].
  Future<void> alternatives(
    _i1.Session session,
    Exercise exercise,
    _i6.ExerciseAlternative exerciseAlternative, {
    _i1.Transaction? transaction,
  }) async {
    if (exerciseAlternative.id == null) {
      throw ArgumentError.notNull('exerciseAlternative.id');
    }
    if (exercise.id == null) {
      throw ArgumentError.notNull('exercise.id');
    }

    var $exerciseAlternative = exerciseAlternative.copyWith(
      exerciseId: exercise.id,
    );
    await session.db.updateRow<_i6.ExerciseAlternative>(
      $exerciseAlternative,
      columns: [_i6.ExerciseAlternative.t.exerciseId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Exercise] and the given [ExerciseAlternative]
  /// by setting the [ExerciseAlternative]'s foreign key `alternativeExerciseId` to refer to this [Exercise].
  Future<void> alternativesFor(
    _i1.Session session,
    Exercise exercise,
    _i6.ExerciseAlternative exerciseAlternative, {
    _i1.Transaction? transaction,
  }) async {
    if (exerciseAlternative.id == null) {
      throw ArgumentError.notNull('exerciseAlternative.id');
    }
    if (exercise.id == null) {
      throw ArgumentError.notNull('exercise.id');
    }

    var $exerciseAlternative = exerciseAlternative.copyWith(
      alternativeExerciseId: exercise.id,
    );
    await session.db.updateRow<_i6.ExerciseAlternative>(
      $exerciseAlternative,
      columns: [_i6.ExerciseAlternative.t.alternativeExerciseId],
      transaction: transaction,
    );
  }
}

class ExerciseDetachRepository {
  const ExerciseDetachRepository._();

  /// Detaches the relation between this [Exercise] and the given [ExerciseImage]
  /// by setting the [ExerciseImage]'s foreign key `exerciseId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> images(
    _i1.Session session,
    List<_i5.ExerciseImage> exerciseImage, {
    _i1.Transaction? transaction,
  }) async {
    if (exerciseImage.any((e) => e.id == null)) {
      throw ArgumentError.notNull('exerciseImage.id');
    }

    var $exerciseImage = exerciseImage
        .map((e) => e.copyWith(exerciseId: null))
        .toList();
    await session.db.update<_i5.ExerciseImage>(
      $exerciseImage,
      columns: [_i5.ExerciseImage.t.exerciseId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [Exercise] and the given [ExerciseAlternative]
  /// by setting the [ExerciseAlternative]'s foreign key `exerciseId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> alternatives(
    _i1.Session session,
    List<_i6.ExerciseAlternative> exerciseAlternative, {
    _i1.Transaction? transaction,
  }) async {
    if (exerciseAlternative.any((e) => e.id == null)) {
      throw ArgumentError.notNull('exerciseAlternative.id');
    }

    var $exerciseAlternative = exerciseAlternative
        .map((e) => e.copyWith(exerciseId: null))
        .toList();
    await session.db.update<_i6.ExerciseAlternative>(
      $exerciseAlternative,
      columns: [_i6.ExerciseAlternative.t.exerciseId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [Exercise] and the given [ExerciseAlternative]
  /// by setting the [ExerciseAlternative]'s foreign key `alternativeExerciseId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> alternativesFor(
    _i1.Session session,
    List<_i6.ExerciseAlternative> exerciseAlternative, {
    _i1.Transaction? transaction,
  }) async {
    if (exerciseAlternative.any((e) => e.id == null)) {
      throw ArgumentError.notNull('exerciseAlternative.id');
    }

    var $exerciseAlternative = exerciseAlternative
        .map((e) => e.copyWith(alternativeExerciseId: null))
        .toList();
    await session.db.update<_i6.ExerciseAlternative>(
      $exerciseAlternative,
      columns: [_i6.ExerciseAlternative.t.alternativeExerciseId],
      transaction: transaction,
    );
  }
}

class ExerciseDetachRowRepository {
  const ExerciseDetachRowRepository._();

  /// Detaches the relation between this [Exercise] and the given [ExerciseImage]
  /// by setting the [ExerciseImage]'s foreign key `exerciseId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> images(
    _i1.Session session,
    _i5.ExerciseImage exerciseImage, {
    _i1.Transaction? transaction,
  }) async {
    if (exerciseImage.id == null) {
      throw ArgumentError.notNull('exerciseImage.id');
    }

    var $exerciseImage = exerciseImage.copyWith(exerciseId: null);
    await session.db.updateRow<_i5.ExerciseImage>(
      $exerciseImage,
      columns: [_i5.ExerciseImage.t.exerciseId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [Exercise] and the given [ExerciseAlternative]
  /// by setting the [ExerciseAlternative]'s foreign key `exerciseId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> alternatives(
    _i1.Session session,
    _i6.ExerciseAlternative exerciseAlternative, {
    _i1.Transaction? transaction,
  }) async {
    if (exerciseAlternative.id == null) {
      throw ArgumentError.notNull('exerciseAlternative.id');
    }

    var $exerciseAlternative = exerciseAlternative.copyWith(exerciseId: null);
    await session.db.updateRow<_i6.ExerciseAlternative>(
      $exerciseAlternative,
      columns: [_i6.ExerciseAlternative.t.exerciseId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [Exercise] and the given [ExerciseAlternative]
  /// by setting the [ExerciseAlternative]'s foreign key `alternativeExerciseId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> alternativesFor(
    _i1.Session session,
    _i6.ExerciseAlternative exerciseAlternative, {
    _i1.Transaction? transaction,
  }) async {
    if (exerciseAlternative.id == null) {
      throw ArgumentError.notNull('exerciseAlternative.id');
    }

    var $exerciseAlternative = exerciseAlternative.copyWith(
      alternativeExerciseId: null,
    );
    await session.db.updateRow<_i6.ExerciseAlternative>(
      $exerciseAlternative,
      columns: [_i6.ExerciseAlternative.t.alternativeExerciseId],
      transaction: transaction,
    );
  }
}
