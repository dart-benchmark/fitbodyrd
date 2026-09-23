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

abstract class WorkoutTip
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  WorkoutTip._({
    this.id,
    required this.content,
    required this.order,
  });

  factory WorkoutTip({
    int? id,
    required String content,
    required int order,
  }) = _WorkoutTipImpl;

  factory WorkoutTip.fromJson(Map<String, dynamic> jsonSerialization) {
    return WorkoutTip(
      id: jsonSerialization['id'] as int?,
      content: jsonSerialization['content'] as String,
      order: jsonSerialization['order'] as int,
    );
  }

  static final t = WorkoutTipTable();

  static const db = WorkoutTipRepository._();

  @override
  int? id;

  String content;

  int order;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [WorkoutTip]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WorkoutTip copyWith({
    int? id,
    String? content,
    int? order,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WorkoutTip',
      if (id != null) 'id': id,
      'content': content,
      'order': order,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WorkoutTip',
      if (id != null) 'id': id,
      'content': content,
      'order': order,
    };
  }

  static WorkoutTipInclude include() {
    return WorkoutTipInclude._();
  }

  static WorkoutTipIncludeList includeList({
    _i1.WhereExpressionBuilder<WorkoutTipTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkoutTipTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkoutTipTable>? orderByList,
    WorkoutTipInclude? include,
  }) {
    return WorkoutTipIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WorkoutTip.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(WorkoutTip.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WorkoutTipImpl extends WorkoutTip {
  _WorkoutTipImpl({
    int? id,
    required String content,
    required int order,
  }) : super._(
         id: id,
         content: content,
         order: order,
       );

  /// Returns a shallow copy of this [WorkoutTip]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WorkoutTip copyWith({
    Object? id = _Undefined,
    String? content,
    int? order,
  }) {
    return WorkoutTip(
      id: id is int? ? id : this.id,
      content: content ?? this.content,
      order: order ?? this.order,
    );
  }
}

class WorkoutTipUpdateTable extends _i1.UpdateTable<WorkoutTipTable> {
  WorkoutTipUpdateTable(super.table);

  _i1.ColumnValue<String, String> content(String value) => _i1.ColumnValue(
    table.content,
    value,
  );

  _i1.ColumnValue<int, int> order(int value) => _i1.ColumnValue(
    table.order,
    value,
  );
}

class WorkoutTipTable extends _i1.Table<int?> {
  WorkoutTipTable({super.tableRelation}) : super(tableName: 'workout_tips') {
    updateTable = WorkoutTipUpdateTable(this);
    content = _i1.ColumnString(
      'content',
      this,
    );
    order = _i1.ColumnInt(
      'order',
      this,
    );
  }

  late final WorkoutTipUpdateTable updateTable;

  late final _i1.ColumnString content;

  late final _i1.ColumnInt order;

  @override
  List<_i1.Column> get columns => [
    id,
    content,
    order,
  ];
}

class WorkoutTipInclude extends _i1.IncludeObject {
  WorkoutTipInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => WorkoutTip.t;
}

class WorkoutTipIncludeList extends _i1.IncludeList {
  WorkoutTipIncludeList._({
    _i1.WhereExpressionBuilder<WorkoutTipTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(WorkoutTip.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => WorkoutTip.t;
}

class WorkoutTipRepository {
  const WorkoutTipRepository._();

  /// Returns a list of [WorkoutTip]s matching the given query parameters.
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
  Future<List<WorkoutTip>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<WorkoutTipTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkoutTipTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkoutTipTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<WorkoutTip>(
      where: where?.call(WorkoutTip.t),
      orderBy: orderBy?.call(WorkoutTip.t),
      orderByList: orderByList?.call(WorkoutTip.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [WorkoutTip] matching the given query parameters.
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
  Future<WorkoutTip?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<WorkoutTipTable>? where,
    int? offset,
    _i1.OrderByBuilder<WorkoutTipTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkoutTipTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<WorkoutTip>(
      where: where?.call(WorkoutTip.t),
      orderBy: orderBy?.call(WorkoutTip.t),
      orderByList: orderByList?.call(WorkoutTip.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [WorkoutTip] by its [id] or null if no such row exists.
  Future<WorkoutTip?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<WorkoutTip>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [WorkoutTip]s in the list and returns the inserted rows.
  ///
  /// The returned [WorkoutTip]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<WorkoutTip>> insert(
    _i1.Session session,
    List<WorkoutTip> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<WorkoutTip>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [WorkoutTip] and returns the inserted row.
  ///
  /// The returned [WorkoutTip] will have its `id` field set.
  Future<WorkoutTip> insertRow(
    _i1.Session session,
    WorkoutTip row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<WorkoutTip>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [WorkoutTip]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<WorkoutTip>> update(
    _i1.Session session,
    List<WorkoutTip> rows, {
    _i1.ColumnSelections<WorkoutTipTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<WorkoutTip>(
      rows,
      columns: columns?.call(WorkoutTip.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WorkoutTip]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<WorkoutTip> updateRow(
    _i1.Session session,
    WorkoutTip row, {
    _i1.ColumnSelections<WorkoutTipTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<WorkoutTip>(
      row,
      columns: columns?.call(WorkoutTip.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WorkoutTip] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<WorkoutTip?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<WorkoutTipUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<WorkoutTip>(
      id,
      columnValues: columnValues(WorkoutTip.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [WorkoutTip]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<WorkoutTip>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<WorkoutTipUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<WorkoutTipTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkoutTipTable>? orderBy,
    _i1.OrderByListBuilder<WorkoutTipTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<WorkoutTip>(
      columnValues: columnValues(WorkoutTip.t.updateTable),
      where: where(WorkoutTip.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WorkoutTip.t),
      orderByList: orderByList?.call(WorkoutTip.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [WorkoutTip]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<WorkoutTip>> delete(
    _i1.Session session,
    List<WorkoutTip> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<WorkoutTip>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [WorkoutTip].
  Future<WorkoutTip> deleteRow(
    _i1.Session session,
    WorkoutTip row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<WorkoutTip>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<WorkoutTip>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<WorkoutTipTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<WorkoutTip>(
      where: where(WorkoutTip.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<WorkoutTipTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<WorkoutTip>(
      where: where?.call(WorkoutTip.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
