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
import '../../../common/models/status.dart' as _i2;
import '../../../features/user/models/app_user.dart' as _i3;
import '../../../common/models/exercise_difficulty.dart' as _i4;
import '../../../features/workouts/models/workout_session.dart' as _i5;
import 'package:fitbodyrd_server/src/generated/protocol.dart' as _i6;

abstract class WorkoutPlan
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  WorkoutPlan._({
    this.id,
    required this.userId,
    this.user,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.difficultyLevel,
    this.sessions,
    int? sessionsCount,
    _i2.Status? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : sessionsCount = sessionsCount ?? 0,
       status = status ?? _i2.Status.active,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory WorkoutPlan({
    int? id,
    required int userId,
    _i3.UserProfile? user,
    required String name,
    required DateTime startDate,
    required DateTime endDate,
    required _i4.ExerciseDifficulty difficultyLevel,
    List<_i5.WorkoutSession>? sessions,
    int? sessionsCount,
    _i2.Status? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _WorkoutPlanImpl;

  factory WorkoutPlan.fromJson(Map<String, dynamic> jsonSerialization) {
    return WorkoutPlan(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i6.Protocol().deserialize<_i3.UserProfile>(
              jsonSerialization['user'],
            ),
      name: jsonSerialization['name'] as String,
      startDate: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startDate'],
      ),
      endDate: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endDate']),
      difficultyLevel: _i4.ExerciseDifficulty.fromJson(
        (jsonSerialization['difficultyLevel'] as String),
      ),
      sessions: jsonSerialization['sessions'] == null
          ? null
          : _i6.Protocol().deserialize<List<_i5.WorkoutSession>>(
              jsonSerialization['sessions'],
            ),
      sessionsCount: jsonSerialization['sessionsCount'] as int,
      status: _i2.Status.fromJson((jsonSerialization['status'] as String)),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = WorkoutPlanTable();

  static const db = WorkoutPlanRepository._();

  @override
  int? id;

  int userId;

  _i3.UserProfile? user;

  String name;

  DateTime startDate;

  DateTime endDate;

  _i4.ExerciseDifficulty difficultyLevel;

  List<_i5.WorkoutSession>? sessions;

  int sessionsCount;

  _i2.Status status;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [WorkoutPlan]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WorkoutPlan copyWith({
    int? id,
    int? userId,
    _i3.UserProfile? user,
    String? name,
    DateTime? startDate,
    DateTime? endDate,
    _i4.ExerciseDifficulty? difficultyLevel,
    List<_i5.WorkoutSession>? sessions,
    int? sessionsCount,
    _i2.Status? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WorkoutPlan',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'name': name,
      'startDate': startDate.toJson(),
      'endDate': endDate.toJson(),
      'difficultyLevel': difficultyLevel.toJson(),
      if (sessions != null)
        'sessions': sessions?.toJson(valueToJson: (v) => v.toJson()),
      'sessionsCount': sessionsCount,
      'status': status.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WorkoutPlan',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJsonForProtocol(),
      'name': name,
      'startDate': startDate.toJson(),
      'endDate': endDate.toJson(),
      'difficultyLevel': difficultyLevel.toJson(),
      if (sessions != null)
        'sessions': sessions?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'sessionsCount': sessionsCount,
      'status': status.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static WorkoutPlanInclude include({
    _i3.UserProfileInclude? user,
    _i5.WorkoutSessionIncludeList? sessions,
  }) {
    return WorkoutPlanInclude._(
      user: user,
      sessions: sessions,
    );
  }

  static WorkoutPlanIncludeList includeList({
    _i1.WhereExpressionBuilder<WorkoutPlanTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkoutPlanTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkoutPlanTable>? orderByList,
    WorkoutPlanInclude? include,
  }) {
    return WorkoutPlanIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WorkoutPlan.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(WorkoutPlan.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WorkoutPlanImpl extends WorkoutPlan {
  _WorkoutPlanImpl({
    int? id,
    required int userId,
    _i3.UserProfile? user,
    required String name,
    required DateTime startDate,
    required DateTime endDate,
    required _i4.ExerciseDifficulty difficultyLevel,
    List<_i5.WorkoutSession>? sessions,
    int? sessionsCount,
    _i2.Status? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         name: name,
         startDate: startDate,
         endDate: endDate,
         difficultyLevel: difficultyLevel,
         sessions: sessions,
         sessionsCount: sessionsCount,
         status: status,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [WorkoutPlan]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WorkoutPlan copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    String? name,
    DateTime? startDate,
    DateTime? endDate,
    _i4.ExerciseDifficulty? difficultyLevel,
    Object? sessions = _Undefined,
    int? sessionsCount,
    _i2.Status? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return WorkoutPlan(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i3.UserProfile? ? user : this.user?.copyWith(),
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      difficultyLevel: difficultyLevel ?? this.difficultyLevel,
      sessions: sessions is List<_i5.WorkoutSession>?
          ? sessions
          : this.sessions?.map((e0) => e0.copyWith()).toList(),
      sessionsCount: sessionsCount ?? this.sessionsCount,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class WorkoutPlanUpdateTable extends _i1.UpdateTable<WorkoutPlanTable> {
  WorkoutPlanUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> startDate(DateTime value) =>
      _i1.ColumnValue(
        table.startDate,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> endDate(DateTime value) =>
      _i1.ColumnValue(
        table.endDate,
        value,
      );

  _i1.ColumnValue<_i4.ExerciseDifficulty, _i4.ExerciseDifficulty>
  difficultyLevel(_i4.ExerciseDifficulty value) => _i1.ColumnValue(
    table.difficultyLevel,
    value,
  );

  _i1.ColumnValue<int, int> sessionsCount(int value) => _i1.ColumnValue(
    table.sessionsCount,
    value,
  );

  _i1.ColumnValue<_i2.Status, _i2.Status> status(_i2.Status value) =>
      _i1.ColumnValue(
        table.status,
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

class WorkoutPlanTable extends _i1.Table<int?> {
  WorkoutPlanTable({super.tableRelation}) : super(tableName: 'workout_plans') {
    updateTable = WorkoutPlanUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    startDate = _i1.ColumnDateTime(
      'startDate',
      this,
    );
    endDate = _i1.ColumnDateTime(
      'endDate',
      this,
    );
    difficultyLevel = _i1.ColumnEnum(
      'difficultyLevel',
      this,
      _i1.EnumSerialization.byName,
    );
    sessionsCount = _i1.ColumnInt(
      'sessionsCount',
      this,
      hasDefault: true,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
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

  late final WorkoutPlanUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  _i3.UserProfileTable? _user;

  late final _i1.ColumnString name;

  late final _i1.ColumnDateTime startDate;

  late final _i1.ColumnDateTime endDate;

  late final _i1.ColumnEnum<_i4.ExerciseDifficulty> difficultyLevel;

  _i5.WorkoutSessionTable? ___sessions;

  _i1.ManyRelation<_i5.WorkoutSessionTable>? _sessions;

  late final _i1.ColumnInt sessionsCount;

  late final _i1.ColumnEnum<_i2.Status> status;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  _i3.UserProfileTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: WorkoutPlan.t.userId,
      foreignField: _i3.UserProfile.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.UserProfileTable(tableRelation: foreignTableRelation),
    );
    return _user!;
  }

  _i5.WorkoutSessionTable get __sessions {
    if (___sessions != null) return ___sessions!;
    ___sessions = _i1.createRelationTable(
      relationFieldName: '__sessions',
      field: WorkoutPlan.t.id,
      foreignField: _i5.WorkoutSession.t.workoutPlanId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.WorkoutSessionTable(tableRelation: foreignTableRelation),
    );
    return ___sessions!;
  }

  _i1.ManyRelation<_i5.WorkoutSessionTable> get sessions {
    if (_sessions != null) return _sessions!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'sessions',
      field: WorkoutPlan.t.id,
      foreignField: _i5.WorkoutSession.t.workoutPlanId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.WorkoutSessionTable(tableRelation: foreignTableRelation),
    );
    _sessions = _i1.ManyRelation<_i5.WorkoutSessionTable>(
      tableWithRelations: relationTable,
      table: _i5.WorkoutSessionTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _sessions!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    name,
    startDate,
    endDate,
    difficultyLevel,
    sessionsCount,
    status,
    createdAt,
    updatedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'user') {
      return user;
    }
    if (relationField == 'sessions') {
      return __sessions;
    }
    return null;
  }
}

class WorkoutPlanInclude extends _i1.IncludeObject {
  WorkoutPlanInclude._({
    _i3.UserProfileInclude? user,
    _i5.WorkoutSessionIncludeList? sessions,
  }) {
    _user = user;
    _sessions = sessions;
  }

  _i3.UserProfileInclude? _user;

  _i5.WorkoutSessionIncludeList? _sessions;

  @override
  Map<String, _i1.Include?> get includes => {
    'user': _user,
    'sessions': _sessions,
  };

  @override
  _i1.Table<int?> get table => WorkoutPlan.t;
}

class WorkoutPlanIncludeList extends _i1.IncludeList {
  WorkoutPlanIncludeList._({
    _i1.WhereExpressionBuilder<WorkoutPlanTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(WorkoutPlan.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => WorkoutPlan.t;
}

class WorkoutPlanRepository {
  const WorkoutPlanRepository._();

  final attach = const WorkoutPlanAttachRepository._();

  final attachRow = const WorkoutPlanAttachRowRepository._();

  final detach = const WorkoutPlanDetachRepository._();

  final detachRow = const WorkoutPlanDetachRowRepository._();

  /// Returns a list of [WorkoutPlan]s matching the given query parameters.
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
  Future<List<WorkoutPlan>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<WorkoutPlanTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkoutPlanTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkoutPlanTable>? orderByList,
    _i1.Transaction? transaction,
    WorkoutPlanInclude? include,
  }) async {
    return session.db.find<WorkoutPlan>(
      where: where?.call(WorkoutPlan.t),
      orderBy: orderBy?.call(WorkoutPlan.t),
      orderByList: orderByList?.call(WorkoutPlan.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [WorkoutPlan] matching the given query parameters.
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
  Future<WorkoutPlan?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<WorkoutPlanTable>? where,
    int? offset,
    _i1.OrderByBuilder<WorkoutPlanTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkoutPlanTable>? orderByList,
    _i1.Transaction? transaction,
    WorkoutPlanInclude? include,
  }) async {
    return session.db.findFirstRow<WorkoutPlan>(
      where: where?.call(WorkoutPlan.t),
      orderBy: orderBy?.call(WorkoutPlan.t),
      orderByList: orderByList?.call(WorkoutPlan.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [WorkoutPlan] by its [id] or null if no such row exists.
  Future<WorkoutPlan?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    WorkoutPlanInclude? include,
  }) async {
    return session.db.findById<WorkoutPlan>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [WorkoutPlan]s in the list and returns the inserted rows.
  ///
  /// The returned [WorkoutPlan]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<WorkoutPlan>> insert(
    _i1.Session session,
    List<WorkoutPlan> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<WorkoutPlan>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [WorkoutPlan] and returns the inserted row.
  ///
  /// The returned [WorkoutPlan] will have its `id` field set.
  Future<WorkoutPlan> insertRow(
    _i1.Session session,
    WorkoutPlan row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<WorkoutPlan>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [WorkoutPlan]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<WorkoutPlan>> update(
    _i1.Session session,
    List<WorkoutPlan> rows, {
    _i1.ColumnSelections<WorkoutPlanTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<WorkoutPlan>(
      rows,
      columns: columns?.call(WorkoutPlan.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WorkoutPlan]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<WorkoutPlan> updateRow(
    _i1.Session session,
    WorkoutPlan row, {
    _i1.ColumnSelections<WorkoutPlanTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<WorkoutPlan>(
      row,
      columns: columns?.call(WorkoutPlan.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WorkoutPlan] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<WorkoutPlan?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<WorkoutPlanUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<WorkoutPlan>(
      id,
      columnValues: columnValues(WorkoutPlan.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [WorkoutPlan]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<WorkoutPlan>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<WorkoutPlanUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<WorkoutPlanTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkoutPlanTable>? orderBy,
    _i1.OrderByListBuilder<WorkoutPlanTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<WorkoutPlan>(
      columnValues: columnValues(WorkoutPlan.t.updateTable),
      where: where(WorkoutPlan.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WorkoutPlan.t),
      orderByList: orderByList?.call(WorkoutPlan.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [WorkoutPlan]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<WorkoutPlan>> delete(
    _i1.Session session,
    List<WorkoutPlan> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<WorkoutPlan>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [WorkoutPlan].
  Future<WorkoutPlan> deleteRow(
    _i1.Session session,
    WorkoutPlan row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<WorkoutPlan>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<WorkoutPlan>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<WorkoutPlanTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<WorkoutPlan>(
      where: where(WorkoutPlan.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<WorkoutPlanTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<WorkoutPlan>(
      where: where?.call(WorkoutPlan.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class WorkoutPlanAttachRepository {
  const WorkoutPlanAttachRepository._();

  /// Creates a relation between this [WorkoutPlan] and the given [WorkoutSession]s
  /// by setting each [WorkoutSession]'s foreign key `workoutPlanId` to refer to this [WorkoutPlan].
  Future<void> sessions(
    _i1.Session session,
    WorkoutPlan workoutPlan,
    List<_i5.WorkoutSession> workoutSession, {
    _i1.Transaction? transaction,
  }) async {
    if (workoutSession.any((e) => e.id == null)) {
      throw ArgumentError.notNull('workoutSession.id');
    }
    if (workoutPlan.id == null) {
      throw ArgumentError.notNull('workoutPlan.id');
    }

    var $workoutSession = workoutSession
        .map((e) => e.copyWith(workoutPlanId: workoutPlan.id))
        .toList();
    await session.db.update<_i5.WorkoutSession>(
      $workoutSession,
      columns: [_i5.WorkoutSession.t.workoutPlanId],
      transaction: transaction,
    );
  }
}

class WorkoutPlanAttachRowRepository {
  const WorkoutPlanAttachRowRepository._();

  /// Creates a relation between the given [WorkoutPlan] and [UserProfile]
  /// by setting the [WorkoutPlan]'s foreign key `userId` to refer to the [UserProfile].
  Future<void> user(
    _i1.Session session,
    WorkoutPlan workoutPlan,
    _i3.UserProfile user, {
    _i1.Transaction? transaction,
  }) async {
    if (workoutPlan.id == null) {
      throw ArgumentError.notNull('workoutPlan.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $workoutPlan = workoutPlan.copyWith(userId: user.id);
    await session.db.updateRow<WorkoutPlan>(
      $workoutPlan,
      columns: [WorkoutPlan.t.userId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [WorkoutPlan] and the given [WorkoutSession]
  /// by setting the [WorkoutSession]'s foreign key `workoutPlanId` to refer to this [WorkoutPlan].
  Future<void> sessions(
    _i1.Session session,
    WorkoutPlan workoutPlan,
    _i5.WorkoutSession workoutSession, {
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
    await session.db.updateRow<_i5.WorkoutSession>(
      $workoutSession,
      columns: [_i5.WorkoutSession.t.workoutPlanId],
      transaction: transaction,
    );
  }
}

class WorkoutPlanDetachRepository {
  const WorkoutPlanDetachRepository._();

  /// Detaches the relation between this [WorkoutPlan] and the given [WorkoutSession]
  /// by setting the [WorkoutSession]'s foreign key `workoutPlanId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> sessions(
    _i1.Session session,
    List<_i5.WorkoutSession> workoutSession, {
    _i1.Transaction? transaction,
  }) async {
    if (workoutSession.any((e) => e.id == null)) {
      throw ArgumentError.notNull('workoutSession.id');
    }

    var $workoutSession = workoutSession
        .map((e) => e.copyWith(workoutPlanId: null))
        .toList();
    await session.db.update<_i5.WorkoutSession>(
      $workoutSession,
      columns: [_i5.WorkoutSession.t.workoutPlanId],
      transaction: transaction,
    );
  }
}

class WorkoutPlanDetachRowRepository {
  const WorkoutPlanDetachRowRepository._();

  /// Detaches the relation between this [WorkoutPlan] and the given [WorkoutSession]
  /// by setting the [WorkoutSession]'s foreign key `workoutPlanId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> sessions(
    _i1.Session session,
    _i5.WorkoutSession workoutSession, {
    _i1.Transaction? transaction,
  }) async {
    if (workoutSession.id == null) {
      throw ArgumentError.notNull('workoutSession.id');
    }

    var $workoutSession = workoutSession.copyWith(workoutPlanId: null);
    await session.db.updateRow<_i5.WorkoutSession>(
      $workoutSession,
      columns: [_i5.WorkoutSession.t.workoutPlanId],
      transaction: transaction,
    );
  }
}
