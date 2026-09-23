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
import '../../../features/workouts/models/workout_plan.dart' as _i2;
import '../../../features/workouts/models/workout_exercise.dart' as _i3;
import 'package:fitbodyrd_server/src/generated/protocol.dart' as _i4;

abstract class WorkoutSession
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  WorkoutSession._({
    this.id,
    required this.workoutPlanId,
    this.workoutPlan,
    required this.date,
    required this.dayName,
    required this.focus,
    this.exercises,
    this.notes,
    bool? sessionComplete,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : sessionComplete = sessionComplete ?? false,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory WorkoutSession({
    int? id,
    required int workoutPlanId,
    _i2.WorkoutPlan? workoutPlan,
    required DateTime date,
    required String dayName,
    required String focus,
    List<_i3.WorkoutExercise>? exercises,
    String? notes,
    bool? sessionComplete,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _WorkoutSessionImpl;

  factory WorkoutSession.fromJson(Map<String, dynamic> jsonSerialization) {
    return WorkoutSession(
      id: jsonSerialization['id'] as int?,
      workoutPlanId: jsonSerialization['workoutPlanId'] as int,
      workoutPlan: jsonSerialization['workoutPlan'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.WorkoutPlan>(
              jsonSerialization['workoutPlan'],
            ),
      date: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      dayName: jsonSerialization['dayName'] as String,
      focus: jsonSerialization['focus'] as String,
      exercises: jsonSerialization['exercises'] == null
          ? null
          : _i4.Protocol().deserialize<List<_i3.WorkoutExercise>>(
              jsonSerialization['exercises'],
            ),
      notes: jsonSerialization['notes'] as String?,
      sessionComplete: jsonSerialization['sessionComplete'] as bool,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = WorkoutSessionTable();

  static const db = WorkoutSessionRepository._();

  @override
  int? id;

  int workoutPlanId;

  _i2.WorkoutPlan? workoutPlan;

  DateTime date;

  String dayName;

  String focus;

  List<_i3.WorkoutExercise>? exercises;

  String? notes;

  bool sessionComplete;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [WorkoutSession]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WorkoutSession copyWith({
    int? id,
    int? workoutPlanId,
    _i2.WorkoutPlan? workoutPlan,
    DateTime? date,
    String? dayName,
    String? focus,
    List<_i3.WorkoutExercise>? exercises,
    String? notes,
    bool? sessionComplete,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WorkoutSession',
      if (id != null) 'id': id,
      'workoutPlanId': workoutPlanId,
      if (workoutPlan != null) 'workoutPlan': workoutPlan?.toJson(),
      'date': date.toJson(),
      'dayName': dayName,
      'focus': focus,
      if (exercises != null)
        'exercises': exercises?.toJson(valueToJson: (v) => v.toJson()),
      if (notes != null) 'notes': notes,
      'sessionComplete': sessionComplete,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WorkoutSession',
      if (id != null) 'id': id,
      'workoutPlanId': workoutPlanId,
      if (workoutPlan != null) 'workoutPlan': workoutPlan?.toJsonForProtocol(),
      'date': date.toJson(),
      'dayName': dayName,
      'focus': focus,
      if (exercises != null)
        'exercises': exercises?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (notes != null) 'notes': notes,
      'sessionComplete': sessionComplete,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static WorkoutSessionInclude include({
    _i2.WorkoutPlanInclude? workoutPlan,
    _i3.WorkoutExerciseIncludeList? exercises,
  }) {
    return WorkoutSessionInclude._(
      workoutPlan: workoutPlan,
      exercises: exercises,
    );
  }

  static WorkoutSessionIncludeList includeList({
    _i1.WhereExpressionBuilder<WorkoutSessionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkoutSessionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkoutSessionTable>? orderByList,
    WorkoutSessionInclude? include,
  }) {
    return WorkoutSessionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WorkoutSession.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(WorkoutSession.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WorkoutSessionImpl extends WorkoutSession {
  _WorkoutSessionImpl({
    int? id,
    required int workoutPlanId,
    _i2.WorkoutPlan? workoutPlan,
    required DateTime date,
    required String dayName,
    required String focus,
    List<_i3.WorkoutExercise>? exercises,
    String? notes,
    bool? sessionComplete,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         workoutPlanId: workoutPlanId,
         workoutPlan: workoutPlan,
         date: date,
         dayName: dayName,
         focus: focus,
         exercises: exercises,
         notes: notes,
         sessionComplete: sessionComplete,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [WorkoutSession]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WorkoutSession copyWith({
    Object? id = _Undefined,
    int? workoutPlanId,
    Object? workoutPlan = _Undefined,
    DateTime? date,
    String? dayName,
    String? focus,
    Object? exercises = _Undefined,
    Object? notes = _Undefined,
    bool? sessionComplete,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return WorkoutSession(
      id: id is int? ? id : this.id,
      workoutPlanId: workoutPlanId ?? this.workoutPlanId,
      workoutPlan: workoutPlan is _i2.WorkoutPlan?
          ? workoutPlan
          : this.workoutPlan?.copyWith(),
      date: date ?? this.date,
      dayName: dayName ?? this.dayName,
      focus: focus ?? this.focus,
      exercises: exercises is List<_i3.WorkoutExercise>?
          ? exercises
          : this.exercises?.map((e0) => e0.copyWith()).toList(),
      notes: notes is String? ? notes : this.notes,
      sessionComplete: sessionComplete ?? this.sessionComplete,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class WorkoutSessionUpdateTable extends _i1.UpdateTable<WorkoutSessionTable> {
  WorkoutSessionUpdateTable(super.table);

  _i1.ColumnValue<int, int> workoutPlanId(int value) => _i1.ColumnValue(
    table.workoutPlanId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> date(DateTime value) => _i1.ColumnValue(
    table.date,
    value,
  );

  _i1.ColumnValue<String, String> dayName(String value) => _i1.ColumnValue(
    table.dayName,
    value,
  );

  _i1.ColumnValue<String, String> focus(String value) => _i1.ColumnValue(
    table.focus,
    value,
  );

  _i1.ColumnValue<String, String> notes(String? value) => _i1.ColumnValue(
    table.notes,
    value,
  );

  _i1.ColumnValue<bool, bool> sessionComplete(bool value) => _i1.ColumnValue(
    table.sessionComplete,
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

class WorkoutSessionTable extends _i1.Table<int?> {
  WorkoutSessionTable({super.tableRelation})
    : super(tableName: 'workout_sessions') {
    updateTable = WorkoutSessionUpdateTable(this);
    workoutPlanId = _i1.ColumnInt(
      'workoutPlanId',
      this,
    );
    date = _i1.ColumnDateTime(
      'date',
      this,
    );
    dayName = _i1.ColumnString(
      'dayName',
      this,
    );
    focus = _i1.ColumnString(
      'focus',
      this,
    );
    notes = _i1.ColumnString(
      'notes',
      this,
    );
    sessionComplete = _i1.ColumnBool(
      'sessionComplete',
      this,
      hasDefault: true,
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

  late final WorkoutSessionUpdateTable updateTable;

  late final _i1.ColumnInt workoutPlanId;

  _i2.WorkoutPlanTable? _workoutPlan;

  late final _i1.ColumnDateTime date;

  late final _i1.ColumnString dayName;

  late final _i1.ColumnString focus;

  _i3.WorkoutExerciseTable? ___exercises;

  _i1.ManyRelation<_i3.WorkoutExerciseTable>? _exercises;

  late final _i1.ColumnString notes;

  late final _i1.ColumnBool sessionComplete;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  _i2.WorkoutPlanTable get workoutPlan {
    if (_workoutPlan != null) return _workoutPlan!;
    _workoutPlan = _i1.createRelationTable(
      relationFieldName: 'workoutPlan',
      field: WorkoutSession.t.workoutPlanId,
      foreignField: _i2.WorkoutPlan.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.WorkoutPlanTable(tableRelation: foreignTableRelation),
    );
    return _workoutPlan!;
  }

  _i3.WorkoutExerciseTable get __exercises {
    if (___exercises != null) return ___exercises!;
    ___exercises = _i1.createRelationTable(
      relationFieldName: '__exercises',
      field: WorkoutSession.t.id,
      foreignField: _i3.WorkoutExercise.t.workoutSessionId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.WorkoutExerciseTable(tableRelation: foreignTableRelation),
    );
    return ___exercises!;
  }

  _i1.ManyRelation<_i3.WorkoutExerciseTable> get exercises {
    if (_exercises != null) return _exercises!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'exercises',
      field: WorkoutSession.t.id,
      foreignField: _i3.WorkoutExercise.t.workoutSessionId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.WorkoutExerciseTable(tableRelation: foreignTableRelation),
    );
    _exercises = _i1.ManyRelation<_i3.WorkoutExerciseTable>(
      tableWithRelations: relationTable,
      table: _i3.WorkoutExerciseTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _exercises!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    workoutPlanId,
    date,
    dayName,
    focus,
    notes,
    sessionComplete,
    createdAt,
    updatedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'workoutPlan') {
      return workoutPlan;
    }
    if (relationField == 'exercises') {
      return __exercises;
    }
    return null;
  }
}

class WorkoutSessionInclude extends _i1.IncludeObject {
  WorkoutSessionInclude._({
    _i2.WorkoutPlanInclude? workoutPlan,
    _i3.WorkoutExerciseIncludeList? exercises,
  }) {
    _workoutPlan = workoutPlan;
    _exercises = exercises;
  }

  _i2.WorkoutPlanInclude? _workoutPlan;

  _i3.WorkoutExerciseIncludeList? _exercises;

  @override
  Map<String, _i1.Include?> get includes => {
    'workoutPlan': _workoutPlan,
    'exercises': _exercises,
  };

  @override
  _i1.Table<int?> get table => WorkoutSession.t;
}

class WorkoutSessionIncludeList extends _i1.IncludeList {
  WorkoutSessionIncludeList._({
    _i1.WhereExpressionBuilder<WorkoutSessionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(WorkoutSession.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => WorkoutSession.t;
}

class WorkoutSessionRepository {
  const WorkoutSessionRepository._();

  final attach = const WorkoutSessionAttachRepository._();

  final attachRow = const WorkoutSessionAttachRowRepository._();

  /// Returns a list of [WorkoutSession]s matching the given query parameters.
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
  Future<List<WorkoutSession>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<WorkoutSessionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkoutSessionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkoutSessionTable>? orderByList,
    _i1.Transaction? transaction,
    WorkoutSessionInclude? include,
  }) async {
    return session.db.find<WorkoutSession>(
      where: where?.call(WorkoutSession.t),
      orderBy: orderBy?.call(WorkoutSession.t),
      orderByList: orderByList?.call(WorkoutSession.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [WorkoutSession] matching the given query parameters.
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
  Future<WorkoutSession?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<WorkoutSessionTable>? where,
    int? offset,
    _i1.OrderByBuilder<WorkoutSessionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkoutSessionTable>? orderByList,
    _i1.Transaction? transaction,
    WorkoutSessionInclude? include,
  }) async {
    return session.db.findFirstRow<WorkoutSession>(
      where: where?.call(WorkoutSession.t),
      orderBy: orderBy?.call(WorkoutSession.t),
      orderByList: orderByList?.call(WorkoutSession.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [WorkoutSession] by its [id] or null if no such row exists.
  Future<WorkoutSession?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    WorkoutSessionInclude? include,
  }) async {
    return session.db.findById<WorkoutSession>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [WorkoutSession]s in the list and returns the inserted rows.
  ///
  /// The returned [WorkoutSession]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<WorkoutSession>> insert(
    _i1.Session session,
    List<WorkoutSession> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<WorkoutSession>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [WorkoutSession] and returns the inserted row.
  ///
  /// The returned [WorkoutSession] will have its `id` field set.
  Future<WorkoutSession> insertRow(
    _i1.Session session,
    WorkoutSession row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<WorkoutSession>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [WorkoutSession]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<WorkoutSession>> update(
    _i1.Session session,
    List<WorkoutSession> rows, {
    _i1.ColumnSelections<WorkoutSessionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<WorkoutSession>(
      rows,
      columns: columns?.call(WorkoutSession.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WorkoutSession]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<WorkoutSession> updateRow(
    _i1.Session session,
    WorkoutSession row, {
    _i1.ColumnSelections<WorkoutSessionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<WorkoutSession>(
      row,
      columns: columns?.call(WorkoutSession.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WorkoutSession] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<WorkoutSession?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<WorkoutSessionUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<WorkoutSession>(
      id,
      columnValues: columnValues(WorkoutSession.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [WorkoutSession]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<WorkoutSession>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<WorkoutSessionUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<WorkoutSessionTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkoutSessionTable>? orderBy,
    _i1.OrderByListBuilder<WorkoutSessionTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<WorkoutSession>(
      columnValues: columnValues(WorkoutSession.t.updateTable),
      where: where(WorkoutSession.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WorkoutSession.t),
      orderByList: orderByList?.call(WorkoutSession.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [WorkoutSession]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<WorkoutSession>> delete(
    _i1.Session session,
    List<WorkoutSession> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<WorkoutSession>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [WorkoutSession].
  Future<WorkoutSession> deleteRow(
    _i1.Session session,
    WorkoutSession row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<WorkoutSession>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<WorkoutSession>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<WorkoutSessionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<WorkoutSession>(
      where: where(WorkoutSession.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<WorkoutSessionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<WorkoutSession>(
      where: where?.call(WorkoutSession.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class WorkoutSessionAttachRepository {
  const WorkoutSessionAttachRepository._();

  /// Creates a relation between this [WorkoutSession] and the given [WorkoutExercise]s
  /// by setting each [WorkoutExercise]'s foreign key `workoutSessionId` to refer to this [WorkoutSession].
  Future<void> exercises(
    _i1.Session session,
    WorkoutSession workoutSession,
    List<_i3.WorkoutExercise> workoutExercise, {
    _i1.Transaction? transaction,
  }) async {
    if (workoutExercise.any((e) => e.id == null)) {
      throw ArgumentError.notNull('workoutExercise.id');
    }
    if (workoutSession.id == null) {
      throw ArgumentError.notNull('workoutSession.id');
    }

    var $workoutExercise = workoutExercise
        .map((e) => e.copyWith(workoutSessionId: workoutSession.id))
        .toList();
    await session.db.update<_i3.WorkoutExercise>(
      $workoutExercise,
      columns: [_i3.WorkoutExercise.t.workoutSessionId],
      transaction: transaction,
    );
  }
}

class WorkoutSessionAttachRowRepository {
  const WorkoutSessionAttachRowRepository._();

  /// Creates a relation between the given [WorkoutSession] and [WorkoutPlan]
  /// by setting the [WorkoutSession]'s foreign key `workoutPlanId` to refer to the [WorkoutPlan].
  Future<void> workoutPlan(
    _i1.Session session,
    WorkoutSession workoutSession,
    _i2.WorkoutPlan workoutPlan, {
    _i1.Transaction? transaction,
  }) async {
    if (workoutSession.id == null) {
      throw ArgumentError.notNull('workoutSession.id');
    }
    if (workoutPlan.id == null) {
      throw ArgumentError.notNull('workoutPlan.id');
    }

    var $workoutSession = workoutSession.copyWith(
      workoutPlanId: workoutPlan.id,
    );
    await session.db.updateRow<WorkoutSession>(
      $workoutSession,
      columns: [WorkoutSession.t.workoutPlanId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [WorkoutSession] and the given [WorkoutExercise]
  /// by setting the [WorkoutExercise]'s foreign key `workoutSessionId` to refer to this [WorkoutSession].
  Future<void> exercises(
    _i1.Session session,
    WorkoutSession workoutSession,
    _i3.WorkoutExercise workoutExercise, {
    _i1.Transaction? transaction,
  }) async {
    if (workoutExercise.id == null) {
      throw ArgumentError.notNull('workoutExercise.id');
    }
    if (workoutSession.id == null) {
      throw ArgumentError.notNull('workoutSession.id');
    }

    var $workoutExercise = workoutExercise.copyWith(
      workoutSessionId: workoutSession.id,
    );
    await session.db.updateRow<_i3.WorkoutExercise>(
      $workoutExercise,
      columns: [_i3.WorkoutExercise.t.workoutSessionId],
      transaction: transaction,
    );
  }
}
