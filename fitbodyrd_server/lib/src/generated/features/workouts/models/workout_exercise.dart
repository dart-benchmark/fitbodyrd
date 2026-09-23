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
import '../../../features/workouts/models/workout_session.dart' as _i2;
import '../../../features/exercise/models/exercise.dart' as _i3;
import '../../../features/workouts/models/exercise_log.dart' as _i4;
import 'package:fitbodyrd_server/src/generated/protocol.dart' as _i5;

abstract class WorkoutExercise
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  WorkoutExercise._({
    this.id,
    required this.workoutSessionId,
    this.workoutSession,
    required this.exerciseId,
    this.exercise,
    required this.order,
    required this.sets,
    required this.reps,
    required this.restSeconds,
    this.notes,
    this.logs,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory WorkoutExercise({
    int? id,
    required int workoutSessionId,
    _i2.WorkoutSession? workoutSession,
    required int exerciseId,
    _i3.Exercise? exercise,
    required int order,
    required int sets,
    required int reps,
    required int restSeconds,
    String? notes,
    List<_i4.ExerciseLog>? logs,
    DateTime? createdAt,
  }) = _WorkoutExerciseImpl;

  factory WorkoutExercise.fromJson(Map<String, dynamic> jsonSerialization) {
    return WorkoutExercise(
      id: jsonSerialization['id'] as int?,
      workoutSessionId: jsonSerialization['workoutSessionId'] as int,
      workoutSession: jsonSerialization['workoutSession'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.WorkoutSession>(
              jsonSerialization['workoutSession'],
            ),
      exerciseId: jsonSerialization['exerciseId'] as int,
      exercise: jsonSerialization['exercise'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.Exercise>(
              jsonSerialization['exercise'],
            ),
      order: jsonSerialization['order'] as int,
      sets: jsonSerialization['sets'] as int,
      reps: jsonSerialization['reps'] as int,
      restSeconds: jsonSerialization['restSeconds'] as int,
      notes: jsonSerialization['notes'] as String?,
      logs: jsonSerialization['logs'] == null
          ? null
          : _i5.Protocol().deserialize<List<_i4.ExerciseLog>>(
              jsonSerialization['logs'],
            ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = WorkoutExerciseTable();

  static const db = WorkoutExerciseRepository._();

  @override
  int? id;

  int workoutSessionId;

  _i2.WorkoutSession? workoutSession;

  int exerciseId;

  _i3.Exercise? exercise;

  int order;

  int sets;

  int reps;

  int restSeconds;

  String? notes;

  List<_i4.ExerciseLog>? logs;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [WorkoutExercise]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WorkoutExercise copyWith({
    int? id,
    int? workoutSessionId,
    _i2.WorkoutSession? workoutSession,
    int? exerciseId,
    _i3.Exercise? exercise,
    int? order,
    int? sets,
    int? reps,
    int? restSeconds,
    String? notes,
    List<_i4.ExerciseLog>? logs,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WorkoutExercise',
      if (id != null) 'id': id,
      'workoutSessionId': workoutSessionId,
      if (workoutSession != null) 'workoutSession': workoutSession?.toJson(),
      'exerciseId': exerciseId,
      if (exercise != null) 'exercise': exercise?.toJson(),
      'order': order,
      'sets': sets,
      'reps': reps,
      'restSeconds': restSeconds,
      if (notes != null) 'notes': notes,
      if (logs != null) 'logs': logs?.toJson(valueToJson: (v) => v.toJson()),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WorkoutExercise',
      if (id != null) 'id': id,
      'workoutSessionId': workoutSessionId,
      if (workoutSession != null)
        'workoutSession': workoutSession?.toJsonForProtocol(),
      'exerciseId': exerciseId,
      if (exercise != null) 'exercise': exercise?.toJsonForProtocol(),
      'order': order,
      'sets': sets,
      'reps': reps,
      'restSeconds': restSeconds,
      if (notes != null) 'notes': notes,
      if (logs != null)
        'logs': logs?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'createdAt': createdAt.toJson(),
    };
  }

  static WorkoutExerciseInclude include({
    _i2.WorkoutSessionInclude? workoutSession,
    _i3.ExerciseInclude? exercise,
    _i4.ExerciseLogIncludeList? logs,
  }) {
    return WorkoutExerciseInclude._(
      workoutSession: workoutSession,
      exercise: exercise,
      logs: logs,
    );
  }

  static WorkoutExerciseIncludeList includeList({
    _i1.WhereExpressionBuilder<WorkoutExerciseTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkoutExerciseTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkoutExerciseTable>? orderByList,
    WorkoutExerciseInclude? include,
  }) {
    return WorkoutExerciseIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WorkoutExercise.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(WorkoutExercise.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WorkoutExerciseImpl extends WorkoutExercise {
  _WorkoutExerciseImpl({
    int? id,
    required int workoutSessionId,
    _i2.WorkoutSession? workoutSession,
    required int exerciseId,
    _i3.Exercise? exercise,
    required int order,
    required int sets,
    required int reps,
    required int restSeconds,
    String? notes,
    List<_i4.ExerciseLog>? logs,
    DateTime? createdAt,
  }) : super._(
         id: id,
         workoutSessionId: workoutSessionId,
         workoutSession: workoutSession,
         exerciseId: exerciseId,
         exercise: exercise,
         order: order,
         sets: sets,
         reps: reps,
         restSeconds: restSeconds,
         notes: notes,
         logs: logs,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [WorkoutExercise]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WorkoutExercise copyWith({
    Object? id = _Undefined,
    int? workoutSessionId,
    Object? workoutSession = _Undefined,
    int? exerciseId,
    Object? exercise = _Undefined,
    int? order,
    int? sets,
    int? reps,
    int? restSeconds,
    Object? notes = _Undefined,
    Object? logs = _Undefined,
    DateTime? createdAt,
  }) {
    return WorkoutExercise(
      id: id is int? ? id : this.id,
      workoutSessionId: workoutSessionId ?? this.workoutSessionId,
      workoutSession: workoutSession is _i2.WorkoutSession?
          ? workoutSession
          : this.workoutSession?.copyWith(),
      exerciseId: exerciseId ?? this.exerciseId,
      exercise: exercise is _i3.Exercise?
          ? exercise
          : this.exercise?.copyWith(),
      order: order ?? this.order,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      restSeconds: restSeconds ?? this.restSeconds,
      notes: notes is String? ? notes : this.notes,
      logs: logs is List<_i4.ExerciseLog>?
          ? logs
          : this.logs?.map((e0) => e0.copyWith()).toList(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class WorkoutExerciseUpdateTable extends _i1.UpdateTable<WorkoutExerciseTable> {
  WorkoutExerciseUpdateTable(super.table);

  _i1.ColumnValue<int, int> workoutSessionId(int value) => _i1.ColumnValue(
    table.workoutSessionId,
    value,
  );

  _i1.ColumnValue<int, int> exerciseId(int value) => _i1.ColumnValue(
    table.exerciseId,
    value,
  );

  _i1.ColumnValue<int, int> order(int value) => _i1.ColumnValue(
    table.order,
    value,
  );

  _i1.ColumnValue<int, int> sets(int value) => _i1.ColumnValue(
    table.sets,
    value,
  );

  _i1.ColumnValue<int, int> reps(int value) => _i1.ColumnValue(
    table.reps,
    value,
  );

  _i1.ColumnValue<int, int> restSeconds(int value) => _i1.ColumnValue(
    table.restSeconds,
    value,
  );

  _i1.ColumnValue<String, String> notes(String? value) => _i1.ColumnValue(
    table.notes,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class WorkoutExerciseTable extends _i1.Table<int?> {
  WorkoutExerciseTable({super.tableRelation})
    : super(tableName: 'workout_exercises') {
    updateTable = WorkoutExerciseUpdateTable(this);
    workoutSessionId = _i1.ColumnInt(
      'workoutSessionId',
      this,
    );
    exerciseId = _i1.ColumnInt(
      'exerciseId',
      this,
    );
    order = _i1.ColumnInt(
      'order',
      this,
    );
    sets = _i1.ColumnInt(
      'sets',
      this,
    );
    reps = _i1.ColumnInt(
      'reps',
      this,
    );
    restSeconds = _i1.ColumnInt(
      'restSeconds',
      this,
    );
    notes = _i1.ColumnString(
      'notes',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final WorkoutExerciseUpdateTable updateTable;

  late final _i1.ColumnInt workoutSessionId;

  _i2.WorkoutSessionTable? _workoutSession;

  late final _i1.ColumnInt exerciseId;

  _i3.ExerciseTable? _exercise;

  late final _i1.ColumnInt order;

  late final _i1.ColumnInt sets;

  late final _i1.ColumnInt reps;

  late final _i1.ColumnInt restSeconds;

  late final _i1.ColumnString notes;

  _i4.ExerciseLogTable? ___logs;

  _i1.ManyRelation<_i4.ExerciseLogTable>? _logs;

  late final _i1.ColumnDateTime createdAt;

  _i2.WorkoutSessionTable get workoutSession {
    if (_workoutSession != null) return _workoutSession!;
    _workoutSession = _i1.createRelationTable(
      relationFieldName: 'workoutSession',
      field: WorkoutExercise.t.workoutSessionId,
      foreignField: _i2.WorkoutSession.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.WorkoutSessionTable(tableRelation: foreignTableRelation),
    );
    return _workoutSession!;
  }

  _i3.ExerciseTable get exercise {
    if (_exercise != null) return _exercise!;
    _exercise = _i1.createRelationTable(
      relationFieldName: 'exercise',
      field: WorkoutExercise.t.exerciseId,
      foreignField: _i3.Exercise.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.ExerciseTable(tableRelation: foreignTableRelation),
    );
    return _exercise!;
  }

  _i4.ExerciseLogTable get __logs {
    if (___logs != null) return ___logs!;
    ___logs = _i1.createRelationTable(
      relationFieldName: '__logs',
      field: WorkoutExercise.t.id,
      foreignField: _i4.ExerciseLog.t.$_workoutExercisesLogsWorkoutExercisesId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.ExerciseLogTable(tableRelation: foreignTableRelation),
    );
    return ___logs!;
  }

  _i1.ManyRelation<_i4.ExerciseLogTable> get logs {
    if (_logs != null) return _logs!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'logs',
      field: WorkoutExercise.t.id,
      foreignField: _i4.ExerciseLog.t.$_workoutExercisesLogsWorkoutExercisesId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.ExerciseLogTable(tableRelation: foreignTableRelation),
    );
    _logs = _i1.ManyRelation<_i4.ExerciseLogTable>(
      tableWithRelations: relationTable,
      table: _i4.ExerciseLogTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _logs!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    workoutSessionId,
    exerciseId,
    order,
    sets,
    reps,
    restSeconds,
    notes,
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'workoutSession') {
      return workoutSession;
    }
    if (relationField == 'exercise') {
      return exercise;
    }
    if (relationField == 'logs') {
      return __logs;
    }
    return null;
  }
}

class WorkoutExerciseInclude extends _i1.IncludeObject {
  WorkoutExerciseInclude._({
    _i2.WorkoutSessionInclude? workoutSession,
    _i3.ExerciseInclude? exercise,
    _i4.ExerciseLogIncludeList? logs,
  }) {
    _workoutSession = workoutSession;
    _exercise = exercise;
    _logs = logs;
  }

  _i2.WorkoutSessionInclude? _workoutSession;

  _i3.ExerciseInclude? _exercise;

  _i4.ExerciseLogIncludeList? _logs;

  @override
  Map<String, _i1.Include?> get includes => {
    'workoutSession': _workoutSession,
    'exercise': _exercise,
    'logs': _logs,
  };

  @override
  _i1.Table<int?> get table => WorkoutExercise.t;
}

class WorkoutExerciseIncludeList extends _i1.IncludeList {
  WorkoutExerciseIncludeList._({
    _i1.WhereExpressionBuilder<WorkoutExerciseTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(WorkoutExercise.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => WorkoutExercise.t;
}

class WorkoutExerciseRepository {
  const WorkoutExerciseRepository._();

  final attach = const WorkoutExerciseAttachRepository._();

  final attachRow = const WorkoutExerciseAttachRowRepository._();

  final detach = const WorkoutExerciseDetachRepository._();

  final detachRow = const WorkoutExerciseDetachRowRepository._();

  /// Returns a list of [WorkoutExercise]s matching the given query parameters.
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
  Future<List<WorkoutExercise>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<WorkoutExerciseTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkoutExerciseTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkoutExerciseTable>? orderByList,
    _i1.Transaction? transaction,
    WorkoutExerciseInclude? include,
  }) async {
    return session.db.find<WorkoutExercise>(
      where: where?.call(WorkoutExercise.t),
      orderBy: orderBy?.call(WorkoutExercise.t),
      orderByList: orderByList?.call(WorkoutExercise.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [WorkoutExercise] matching the given query parameters.
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
  Future<WorkoutExercise?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<WorkoutExerciseTable>? where,
    int? offset,
    _i1.OrderByBuilder<WorkoutExerciseTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkoutExerciseTable>? orderByList,
    _i1.Transaction? transaction,
    WorkoutExerciseInclude? include,
  }) async {
    return session.db.findFirstRow<WorkoutExercise>(
      where: where?.call(WorkoutExercise.t),
      orderBy: orderBy?.call(WorkoutExercise.t),
      orderByList: orderByList?.call(WorkoutExercise.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [WorkoutExercise] by its [id] or null if no such row exists.
  Future<WorkoutExercise?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    WorkoutExerciseInclude? include,
  }) async {
    return session.db.findById<WorkoutExercise>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [WorkoutExercise]s in the list and returns the inserted rows.
  ///
  /// The returned [WorkoutExercise]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<WorkoutExercise>> insert(
    _i1.Session session,
    List<WorkoutExercise> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<WorkoutExercise>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [WorkoutExercise] and returns the inserted row.
  ///
  /// The returned [WorkoutExercise] will have its `id` field set.
  Future<WorkoutExercise> insertRow(
    _i1.Session session,
    WorkoutExercise row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<WorkoutExercise>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [WorkoutExercise]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<WorkoutExercise>> update(
    _i1.Session session,
    List<WorkoutExercise> rows, {
    _i1.ColumnSelections<WorkoutExerciseTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<WorkoutExercise>(
      rows,
      columns: columns?.call(WorkoutExercise.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WorkoutExercise]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<WorkoutExercise> updateRow(
    _i1.Session session,
    WorkoutExercise row, {
    _i1.ColumnSelections<WorkoutExerciseTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<WorkoutExercise>(
      row,
      columns: columns?.call(WorkoutExercise.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WorkoutExercise] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<WorkoutExercise?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<WorkoutExerciseUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<WorkoutExercise>(
      id,
      columnValues: columnValues(WorkoutExercise.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [WorkoutExercise]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<WorkoutExercise>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<WorkoutExerciseUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<WorkoutExerciseTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkoutExerciseTable>? orderBy,
    _i1.OrderByListBuilder<WorkoutExerciseTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<WorkoutExercise>(
      columnValues: columnValues(WorkoutExercise.t.updateTable),
      where: where(WorkoutExercise.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WorkoutExercise.t),
      orderByList: orderByList?.call(WorkoutExercise.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [WorkoutExercise]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<WorkoutExercise>> delete(
    _i1.Session session,
    List<WorkoutExercise> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<WorkoutExercise>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [WorkoutExercise].
  Future<WorkoutExercise> deleteRow(
    _i1.Session session,
    WorkoutExercise row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<WorkoutExercise>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<WorkoutExercise>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<WorkoutExerciseTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<WorkoutExercise>(
      where: where(WorkoutExercise.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<WorkoutExerciseTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<WorkoutExercise>(
      where: where?.call(WorkoutExercise.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class WorkoutExerciseAttachRepository {
  const WorkoutExerciseAttachRepository._();

  /// Creates a relation between this [WorkoutExercise] and the given [ExerciseLog]s
  /// by setting each [ExerciseLog]'s foreign key `_workoutExercisesLogsWorkoutExercisesId` to refer to this [WorkoutExercise].
  Future<void> logs(
    _i1.Session session,
    WorkoutExercise workoutExercise,
    List<_i4.ExerciseLog> exerciseLog, {
    _i1.Transaction? transaction,
  }) async {
    if (exerciseLog.any((e) => e.id == null)) {
      throw ArgumentError.notNull('exerciseLog.id');
    }
    if (workoutExercise.id == null) {
      throw ArgumentError.notNull('workoutExercise.id');
    }

    var $exerciseLog = exerciseLog
        .map(
          (e) => _i4.ExerciseLogImplicit(
            e,
            $_workoutExercisesLogsWorkoutExercisesId: workoutExercise.id,
          ),
        )
        .toList();
    await session.db.update<_i4.ExerciseLog>(
      $exerciseLog,
      columns: [_i4.ExerciseLog.t.$_workoutExercisesLogsWorkoutExercisesId],
      transaction: transaction,
    );
  }
}

class WorkoutExerciseAttachRowRepository {
  const WorkoutExerciseAttachRowRepository._();

  /// Creates a relation between the given [WorkoutExercise] and [WorkoutSession]
  /// by setting the [WorkoutExercise]'s foreign key `workoutSessionId` to refer to the [WorkoutSession].
  Future<void> workoutSession(
    _i1.Session session,
    WorkoutExercise workoutExercise,
    _i2.WorkoutSession workoutSession, {
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
    await session.db.updateRow<WorkoutExercise>(
      $workoutExercise,
      columns: [WorkoutExercise.t.workoutSessionId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [WorkoutExercise] and [Exercise]
  /// by setting the [WorkoutExercise]'s foreign key `exerciseId` to refer to the [Exercise].
  Future<void> exercise(
    _i1.Session session,
    WorkoutExercise workoutExercise,
    _i3.Exercise exercise, {
    _i1.Transaction? transaction,
  }) async {
    if (workoutExercise.id == null) {
      throw ArgumentError.notNull('workoutExercise.id');
    }
    if (exercise.id == null) {
      throw ArgumentError.notNull('exercise.id');
    }

    var $workoutExercise = workoutExercise.copyWith(exerciseId: exercise.id);
    await session.db.updateRow<WorkoutExercise>(
      $workoutExercise,
      columns: [WorkoutExercise.t.exerciseId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [WorkoutExercise] and the given [ExerciseLog]
  /// by setting the [ExerciseLog]'s foreign key `_workoutExercisesLogsWorkoutExercisesId` to refer to this [WorkoutExercise].
  Future<void> logs(
    _i1.Session session,
    WorkoutExercise workoutExercise,
    _i4.ExerciseLog exerciseLog, {
    _i1.Transaction? transaction,
  }) async {
    if (exerciseLog.id == null) {
      throw ArgumentError.notNull('exerciseLog.id');
    }
    if (workoutExercise.id == null) {
      throw ArgumentError.notNull('workoutExercise.id');
    }

    var $exerciseLog = _i4.ExerciseLogImplicit(
      exerciseLog,
      $_workoutExercisesLogsWorkoutExercisesId: workoutExercise.id,
    );
    await session.db.updateRow<_i4.ExerciseLog>(
      $exerciseLog,
      columns: [_i4.ExerciseLog.t.$_workoutExercisesLogsWorkoutExercisesId],
      transaction: transaction,
    );
  }
}

class WorkoutExerciseDetachRepository {
  const WorkoutExerciseDetachRepository._();

  /// Detaches the relation between this [WorkoutExercise] and the given [ExerciseLog]
  /// by setting the [ExerciseLog]'s foreign key `_workoutExercisesLogsWorkoutExercisesId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> logs(
    _i1.Session session,
    List<_i4.ExerciseLog> exerciseLog, {
    _i1.Transaction? transaction,
  }) async {
    if (exerciseLog.any((e) => e.id == null)) {
      throw ArgumentError.notNull('exerciseLog.id');
    }

    var $exerciseLog = exerciseLog
        .map(
          (e) => _i4.ExerciseLogImplicit(
            e,
            $_workoutExercisesLogsWorkoutExercisesId: null,
          ),
        )
        .toList();
    await session.db.update<_i4.ExerciseLog>(
      $exerciseLog,
      columns: [_i4.ExerciseLog.t.$_workoutExercisesLogsWorkoutExercisesId],
      transaction: transaction,
    );
  }
}

class WorkoutExerciseDetachRowRepository {
  const WorkoutExerciseDetachRowRepository._();

  /// Detaches the relation between this [WorkoutExercise] and the given [ExerciseLog]
  /// by setting the [ExerciseLog]'s foreign key `_workoutExercisesLogsWorkoutExercisesId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> logs(
    _i1.Session session,
    _i4.ExerciseLog exerciseLog, {
    _i1.Transaction? transaction,
  }) async {
    if (exerciseLog.id == null) {
      throw ArgumentError.notNull('exerciseLog.id');
    }

    var $exerciseLog = _i4.ExerciseLogImplicit(
      exerciseLog,
      $_workoutExercisesLogsWorkoutExercisesId: null,
    );
    await session.db.updateRow<_i4.ExerciseLog>(
      $exerciseLog,
      columns: [_i4.ExerciseLog.t.$_workoutExercisesLogsWorkoutExercisesId],
      transaction: transaction,
    );
  }
}
