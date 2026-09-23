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
import '../../../features/exercise/models/exercise.dart' as _i2;
import 'package:fitbodyrd_server/src/generated/protocol.dart' as _i3;

abstract class ExerciseAlternative
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = ExerciseAlternativeTable();

  static const db = ExerciseAlternativeRepository._();

  @override
  int? id;

  int exerciseId;

  /// The exercise that this alternative is replacing.
  _i2.Exercise? exercise;

  int alternativeExerciseId;

  /// The alternative exercise.
  _i2.Exercise? alternativeExercise;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ExerciseAlternative',
      if (id != null) 'id': id,
      'exerciseId': exerciseId,
      if (exercise != null) 'exercise': exercise?.toJsonForProtocol(),
      'alternativeExerciseId': alternativeExerciseId,
      if (alternativeExercise != null)
        'alternativeExercise': alternativeExercise?.toJsonForProtocol(),
    };
  }

  static ExerciseAlternativeInclude include({
    _i2.ExerciseInclude? exercise,
    _i2.ExerciseInclude? alternativeExercise,
  }) {
    return ExerciseAlternativeInclude._(
      exercise: exercise,
      alternativeExercise: alternativeExercise,
    );
  }

  static ExerciseAlternativeIncludeList includeList({
    _i1.WhereExpressionBuilder<ExerciseAlternativeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ExerciseAlternativeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExerciseAlternativeTable>? orderByList,
    ExerciseAlternativeInclude? include,
  }) {
    return ExerciseAlternativeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ExerciseAlternative.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ExerciseAlternative.t),
      include: include,
    );
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

class ExerciseAlternativeUpdateTable
    extends _i1.UpdateTable<ExerciseAlternativeTable> {
  ExerciseAlternativeUpdateTable(super.table);

  _i1.ColumnValue<int, int> exerciseId(int value) => _i1.ColumnValue(
    table.exerciseId,
    value,
  );

  _i1.ColumnValue<int, int> alternativeExerciseId(int value) => _i1.ColumnValue(
    table.alternativeExerciseId,
    value,
  );
}

class ExerciseAlternativeTable extends _i1.Table<int?> {
  ExerciseAlternativeTable({super.tableRelation})
    : super(tableName: 'exercise_alternatives') {
    updateTable = ExerciseAlternativeUpdateTable(this);
    exerciseId = _i1.ColumnInt(
      'exerciseId',
      this,
    );
    alternativeExerciseId = _i1.ColumnInt(
      'alternativeExerciseId',
      this,
    );
  }

  late final ExerciseAlternativeUpdateTable updateTable;

  late final _i1.ColumnInt exerciseId;

  /// The exercise that this alternative is replacing.
  _i2.ExerciseTable? _exercise;

  late final _i1.ColumnInt alternativeExerciseId;

  /// The alternative exercise.
  _i2.ExerciseTable? _alternativeExercise;

  _i2.ExerciseTable get exercise {
    if (_exercise != null) return _exercise!;
    _exercise = _i1.createRelationTable(
      relationFieldName: 'exercise',
      field: ExerciseAlternative.t.exerciseId,
      foreignField: _i2.Exercise.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.ExerciseTable(tableRelation: foreignTableRelation),
    );
    return _exercise!;
  }

  _i2.ExerciseTable get alternativeExercise {
    if (_alternativeExercise != null) return _alternativeExercise!;
    _alternativeExercise = _i1.createRelationTable(
      relationFieldName: 'alternativeExercise',
      field: ExerciseAlternative.t.alternativeExerciseId,
      foreignField: _i2.Exercise.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.ExerciseTable(tableRelation: foreignTableRelation),
    );
    return _alternativeExercise!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    exerciseId,
    alternativeExerciseId,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'exercise') {
      return exercise;
    }
    if (relationField == 'alternativeExercise') {
      return alternativeExercise;
    }
    return null;
  }
}

class ExerciseAlternativeInclude extends _i1.IncludeObject {
  ExerciseAlternativeInclude._({
    _i2.ExerciseInclude? exercise,
    _i2.ExerciseInclude? alternativeExercise,
  }) {
    _exercise = exercise;
    _alternativeExercise = alternativeExercise;
  }

  _i2.ExerciseInclude? _exercise;

  _i2.ExerciseInclude? _alternativeExercise;

  @override
  Map<String, _i1.Include?> get includes => {
    'exercise': _exercise,
    'alternativeExercise': _alternativeExercise,
  };

  @override
  _i1.Table<int?> get table => ExerciseAlternative.t;
}

class ExerciseAlternativeIncludeList extends _i1.IncludeList {
  ExerciseAlternativeIncludeList._({
    _i1.WhereExpressionBuilder<ExerciseAlternativeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ExerciseAlternative.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ExerciseAlternative.t;
}

class ExerciseAlternativeRepository {
  const ExerciseAlternativeRepository._();

  final attachRow = const ExerciseAlternativeAttachRowRepository._();

  /// Returns a list of [ExerciseAlternative]s matching the given query parameters.
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
  Future<List<ExerciseAlternative>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ExerciseAlternativeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ExerciseAlternativeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExerciseAlternativeTable>? orderByList,
    _i1.Transaction? transaction,
    ExerciseAlternativeInclude? include,
  }) async {
    return session.db.find<ExerciseAlternative>(
      where: where?.call(ExerciseAlternative.t),
      orderBy: orderBy?.call(ExerciseAlternative.t),
      orderByList: orderByList?.call(ExerciseAlternative.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [ExerciseAlternative] matching the given query parameters.
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
  Future<ExerciseAlternative?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ExerciseAlternativeTable>? where,
    int? offset,
    _i1.OrderByBuilder<ExerciseAlternativeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExerciseAlternativeTable>? orderByList,
    _i1.Transaction? transaction,
    ExerciseAlternativeInclude? include,
  }) async {
    return session.db.findFirstRow<ExerciseAlternative>(
      where: where?.call(ExerciseAlternative.t),
      orderBy: orderBy?.call(ExerciseAlternative.t),
      orderByList: orderByList?.call(ExerciseAlternative.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [ExerciseAlternative] by its [id] or null if no such row exists.
  Future<ExerciseAlternative?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    ExerciseAlternativeInclude? include,
  }) async {
    return session.db.findById<ExerciseAlternative>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [ExerciseAlternative]s in the list and returns the inserted rows.
  ///
  /// The returned [ExerciseAlternative]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ExerciseAlternative>> insert(
    _i1.Session session,
    List<ExerciseAlternative> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ExerciseAlternative>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ExerciseAlternative] and returns the inserted row.
  ///
  /// The returned [ExerciseAlternative] will have its `id` field set.
  Future<ExerciseAlternative> insertRow(
    _i1.Session session,
    ExerciseAlternative row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ExerciseAlternative>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ExerciseAlternative]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ExerciseAlternative>> update(
    _i1.Session session,
    List<ExerciseAlternative> rows, {
    _i1.ColumnSelections<ExerciseAlternativeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ExerciseAlternative>(
      rows,
      columns: columns?.call(ExerciseAlternative.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ExerciseAlternative]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ExerciseAlternative> updateRow(
    _i1.Session session,
    ExerciseAlternative row, {
    _i1.ColumnSelections<ExerciseAlternativeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ExerciseAlternative>(
      row,
      columns: columns?.call(ExerciseAlternative.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ExerciseAlternative] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ExerciseAlternative?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<ExerciseAlternativeUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ExerciseAlternative>(
      id,
      columnValues: columnValues(ExerciseAlternative.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ExerciseAlternative]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ExerciseAlternative>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<ExerciseAlternativeUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<ExerciseAlternativeTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ExerciseAlternativeTable>? orderBy,
    _i1.OrderByListBuilder<ExerciseAlternativeTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ExerciseAlternative>(
      columnValues: columnValues(ExerciseAlternative.t.updateTable),
      where: where(ExerciseAlternative.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ExerciseAlternative.t),
      orderByList: orderByList?.call(ExerciseAlternative.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ExerciseAlternative]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ExerciseAlternative>> delete(
    _i1.Session session,
    List<ExerciseAlternative> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ExerciseAlternative>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ExerciseAlternative].
  Future<ExerciseAlternative> deleteRow(
    _i1.Session session,
    ExerciseAlternative row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ExerciseAlternative>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ExerciseAlternative>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ExerciseAlternativeTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ExerciseAlternative>(
      where: where(ExerciseAlternative.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ExerciseAlternativeTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ExerciseAlternative>(
      where: where?.call(ExerciseAlternative.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class ExerciseAlternativeAttachRowRepository {
  const ExerciseAlternativeAttachRowRepository._();

  /// Creates a relation between the given [ExerciseAlternative] and [Exercise]
  /// by setting the [ExerciseAlternative]'s foreign key `exerciseId` to refer to the [Exercise].
  Future<void> exercise(
    _i1.Session session,
    ExerciseAlternative exerciseAlternative,
    _i2.Exercise exercise, {
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
    await session.db.updateRow<ExerciseAlternative>(
      $exerciseAlternative,
      columns: [ExerciseAlternative.t.exerciseId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ExerciseAlternative] and [Exercise]
  /// by setting the [ExerciseAlternative]'s foreign key `alternativeExerciseId` to refer to the [Exercise].
  Future<void> alternativeExercise(
    _i1.Session session,
    ExerciseAlternative exerciseAlternative,
    _i2.Exercise alternativeExercise, {
    _i1.Transaction? transaction,
  }) async {
    if (exerciseAlternative.id == null) {
      throw ArgumentError.notNull('exerciseAlternative.id');
    }
    if (alternativeExercise.id == null) {
      throw ArgumentError.notNull('alternativeExercise.id');
    }

    var $exerciseAlternative = exerciseAlternative.copyWith(
      alternativeExerciseId: alternativeExercise.id,
    );
    await session.db.updateRow<ExerciseAlternative>(
      $exerciseAlternative,
      columns: [ExerciseAlternative.t.alternativeExerciseId],
      transaction: transaction,
    );
  }
}
