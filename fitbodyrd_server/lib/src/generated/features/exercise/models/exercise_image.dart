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

abstract class ExerciseImage
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = ExerciseImageTable();

  static const db = ExerciseImageRepository._();

  @override
  int? id;

  int exerciseId;

  _i2.Exercise? exercise;

  String imageUrl;

  /// Order index for sorting images. Lower values appear first.
  int orderIndex;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ExerciseImage',
      if (id != null) 'id': id,
      'exerciseId': exerciseId,
      if (exercise != null) 'exercise': exercise?.toJsonForProtocol(),
      'imageUrl': imageUrl,
      'orderIndex': orderIndex,
      'createdAt': createdAt.toJson(),
    };
  }

  static ExerciseImageInclude include({_i2.ExerciseInclude? exercise}) {
    return ExerciseImageInclude._(exercise: exercise);
  }

  static ExerciseImageIncludeList includeList({
    _i1.WhereExpressionBuilder<ExerciseImageTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ExerciseImageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExerciseImageTable>? orderByList,
    ExerciseImageInclude? include,
  }) {
    return ExerciseImageIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ExerciseImage.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ExerciseImage.t),
      include: include,
    );
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

class ExerciseImageUpdateTable extends _i1.UpdateTable<ExerciseImageTable> {
  ExerciseImageUpdateTable(super.table);

  _i1.ColumnValue<int, int> exerciseId(int value) => _i1.ColumnValue(
    table.exerciseId,
    value,
  );

  _i1.ColumnValue<String, String> imageUrl(String value) => _i1.ColumnValue(
    table.imageUrl,
    value,
  );

  _i1.ColumnValue<int, int> orderIndex(int value) => _i1.ColumnValue(
    table.orderIndex,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class ExerciseImageTable extends _i1.Table<int?> {
  ExerciseImageTable({super.tableRelation})
    : super(tableName: 'exercise_images') {
    updateTable = ExerciseImageUpdateTable(this);
    exerciseId = _i1.ColumnInt(
      'exerciseId',
      this,
    );
    imageUrl = _i1.ColumnString(
      'imageUrl',
      this,
    );
    orderIndex = _i1.ColumnInt(
      'orderIndex',
      this,
      hasDefault: true,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final ExerciseImageUpdateTable updateTable;

  late final _i1.ColumnInt exerciseId;

  _i2.ExerciseTable? _exercise;

  late final _i1.ColumnString imageUrl;

  /// Order index for sorting images. Lower values appear first.
  late final _i1.ColumnInt orderIndex;

  late final _i1.ColumnDateTime createdAt;

  _i2.ExerciseTable get exercise {
    if (_exercise != null) return _exercise!;
    _exercise = _i1.createRelationTable(
      relationFieldName: 'exercise',
      field: ExerciseImage.t.exerciseId,
      foreignField: _i2.Exercise.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.ExerciseTable(tableRelation: foreignTableRelation),
    );
    return _exercise!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    exerciseId,
    imageUrl,
    orderIndex,
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'exercise') {
      return exercise;
    }
    return null;
  }
}

class ExerciseImageInclude extends _i1.IncludeObject {
  ExerciseImageInclude._({_i2.ExerciseInclude? exercise}) {
    _exercise = exercise;
  }

  _i2.ExerciseInclude? _exercise;

  @override
  Map<String, _i1.Include?> get includes => {'exercise': _exercise};

  @override
  _i1.Table<int?> get table => ExerciseImage.t;
}

class ExerciseImageIncludeList extends _i1.IncludeList {
  ExerciseImageIncludeList._({
    _i1.WhereExpressionBuilder<ExerciseImageTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ExerciseImage.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ExerciseImage.t;
}

class ExerciseImageRepository {
  const ExerciseImageRepository._();

  final attachRow = const ExerciseImageAttachRowRepository._();

  /// Returns a list of [ExerciseImage]s matching the given query parameters.
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
  Future<List<ExerciseImage>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ExerciseImageTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ExerciseImageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExerciseImageTable>? orderByList,
    _i1.Transaction? transaction,
    ExerciseImageInclude? include,
  }) async {
    return session.db.find<ExerciseImage>(
      where: where?.call(ExerciseImage.t),
      orderBy: orderBy?.call(ExerciseImage.t),
      orderByList: orderByList?.call(ExerciseImage.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [ExerciseImage] matching the given query parameters.
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
  Future<ExerciseImage?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ExerciseImageTable>? where,
    int? offset,
    _i1.OrderByBuilder<ExerciseImageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExerciseImageTable>? orderByList,
    _i1.Transaction? transaction,
    ExerciseImageInclude? include,
  }) async {
    return session.db.findFirstRow<ExerciseImage>(
      where: where?.call(ExerciseImage.t),
      orderBy: orderBy?.call(ExerciseImage.t),
      orderByList: orderByList?.call(ExerciseImage.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [ExerciseImage] by its [id] or null if no such row exists.
  Future<ExerciseImage?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    ExerciseImageInclude? include,
  }) async {
    return session.db.findById<ExerciseImage>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [ExerciseImage]s in the list and returns the inserted rows.
  ///
  /// The returned [ExerciseImage]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ExerciseImage>> insert(
    _i1.Session session,
    List<ExerciseImage> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ExerciseImage>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ExerciseImage] and returns the inserted row.
  ///
  /// The returned [ExerciseImage] will have its `id` field set.
  Future<ExerciseImage> insertRow(
    _i1.Session session,
    ExerciseImage row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ExerciseImage>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ExerciseImage]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ExerciseImage>> update(
    _i1.Session session,
    List<ExerciseImage> rows, {
    _i1.ColumnSelections<ExerciseImageTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ExerciseImage>(
      rows,
      columns: columns?.call(ExerciseImage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ExerciseImage]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ExerciseImage> updateRow(
    _i1.Session session,
    ExerciseImage row, {
    _i1.ColumnSelections<ExerciseImageTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ExerciseImage>(
      row,
      columns: columns?.call(ExerciseImage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ExerciseImage] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ExerciseImage?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<ExerciseImageUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ExerciseImage>(
      id,
      columnValues: columnValues(ExerciseImage.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ExerciseImage]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ExerciseImage>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<ExerciseImageUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ExerciseImageTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ExerciseImageTable>? orderBy,
    _i1.OrderByListBuilder<ExerciseImageTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ExerciseImage>(
      columnValues: columnValues(ExerciseImage.t.updateTable),
      where: where(ExerciseImage.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ExerciseImage.t),
      orderByList: orderByList?.call(ExerciseImage.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ExerciseImage]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ExerciseImage>> delete(
    _i1.Session session,
    List<ExerciseImage> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ExerciseImage>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ExerciseImage].
  Future<ExerciseImage> deleteRow(
    _i1.Session session,
    ExerciseImage row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ExerciseImage>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ExerciseImage>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ExerciseImageTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ExerciseImage>(
      where: where(ExerciseImage.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ExerciseImageTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ExerciseImage>(
      where: where?.call(ExerciseImage.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class ExerciseImageAttachRowRepository {
  const ExerciseImageAttachRowRepository._();

  /// Creates a relation between the given [ExerciseImage] and [Exercise]
  /// by setting the [ExerciseImage]'s foreign key `exerciseId` to refer to the [Exercise].
  Future<void> exercise(
    _i1.Session session,
    ExerciseImage exerciseImage,
    _i2.Exercise exercise, {
    _i1.Transaction? transaction,
  }) async {
    if (exerciseImage.id == null) {
      throw ArgumentError.notNull('exerciseImage.id');
    }
    if (exercise.id == null) {
      throw ArgumentError.notNull('exercise.id');
    }

    var $exerciseImage = exerciseImage.copyWith(exerciseId: exercise.id);
    await session.db.updateRow<ExerciseImage>(
      $exerciseImage,
      columns: [ExerciseImage.t.exerciseId],
      transaction: transaction,
    );
  }
}
