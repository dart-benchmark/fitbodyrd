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
import '../../../features/user/models/app_user.dart' as _i2;
import 'package:fitbodyrd_server/src/generated/protocol.dart' as _i3;

abstract class ExerciseLog
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ExerciseLog._({
    this.id,
    required this.userId,
    this.user,
    required this.exerciseId,
    this.workoutExerciseId,
    required this.date,
    required this.setsCompleted,
    required this.repsCompleted,
    this.weightUsed,
    this.difficultyRating,
    this.notes,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       _workoutExercisesLogsWorkoutExercisesId = null;

  factory ExerciseLog({
    int? id,
    required int userId,
    _i2.UserProfile? user,
    required int exerciseId,
    int? workoutExerciseId,
    required DateTime date,
    required int setsCompleted,
    required int repsCompleted,
    double? weightUsed,
    int? difficultyRating,
    String? notes,
    DateTime? createdAt,
  }) = _ExerciseLogImpl;

  factory ExerciseLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return ExerciseLogImplicit._(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.UserProfile>(
              jsonSerialization['user'],
            ),
      exerciseId: jsonSerialization['exerciseId'] as int,
      workoutExerciseId: jsonSerialization['workoutExerciseId'] as int?,
      date: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      setsCompleted: jsonSerialization['setsCompleted'] as int,
      repsCompleted: jsonSerialization['repsCompleted'] as int,
      weightUsed: (jsonSerialization['weightUsed'] as num?)?.toDouble(),
      difficultyRating: jsonSerialization['difficultyRating'] as int?,
      notes: jsonSerialization['notes'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      $_workoutExercisesLogsWorkoutExercisesId:
          jsonSerialization['_workoutExercisesLogsWorkoutExercisesId'] as int?,
    );
  }

  static final t = ExerciseLogTable();

  static const db = ExerciseLogRepository._();

  @override
  int? id;

  int userId;

  _i2.UserProfile? user;

  int exerciseId;

  int? workoutExerciseId;

  DateTime date;

  int setsCompleted;

  int repsCompleted;

  double? weightUsed;

  int? difficultyRating;

  String? notes;

  DateTime createdAt;

  final int? _workoutExercisesLogsWorkoutExercisesId;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ExerciseLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ExerciseLog copyWith({
    int? id,
    int? userId,
    _i2.UserProfile? user,
    int? exerciseId,
    int? workoutExerciseId,
    DateTime? date,
    int? setsCompleted,
    int? repsCompleted,
    double? weightUsed,
    int? difficultyRating,
    String? notes,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ExerciseLog',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'exerciseId': exerciseId,
      if (workoutExerciseId != null) 'workoutExerciseId': workoutExerciseId,
      'date': date.toJson(),
      'setsCompleted': setsCompleted,
      'repsCompleted': repsCompleted,
      if (weightUsed != null) 'weightUsed': weightUsed,
      if (difficultyRating != null) 'difficultyRating': difficultyRating,
      if (notes != null) 'notes': notes,
      'createdAt': createdAt.toJson(),
      if (_workoutExercisesLogsWorkoutExercisesId != null)
        '_workoutExercisesLogsWorkoutExercisesId':
            _workoutExercisesLogsWorkoutExercisesId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ExerciseLog',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJsonForProtocol(),
      'exerciseId': exerciseId,
      if (workoutExerciseId != null) 'workoutExerciseId': workoutExerciseId,
      'date': date.toJson(),
      'setsCompleted': setsCompleted,
      'repsCompleted': repsCompleted,
      if (weightUsed != null) 'weightUsed': weightUsed,
      if (difficultyRating != null) 'difficultyRating': difficultyRating,
      if (notes != null) 'notes': notes,
      'createdAt': createdAt.toJson(),
    };
  }

  static ExerciseLogInclude include({_i2.UserProfileInclude? user}) {
    return ExerciseLogInclude._(user: user);
  }

  static ExerciseLogIncludeList includeList({
    _i1.WhereExpressionBuilder<ExerciseLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ExerciseLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExerciseLogTable>? orderByList,
    ExerciseLogInclude? include,
  }) {
    return ExerciseLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ExerciseLog.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ExerciseLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ExerciseLogImpl extends ExerciseLog {
  _ExerciseLogImpl({
    int? id,
    required int userId,
    _i2.UserProfile? user,
    required int exerciseId,
    int? workoutExerciseId,
    required DateTime date,
    required int setsCompleted,
    required int repsCompleted,
    double? weightUsed,
    int? difficultyRating,
    String? notes,
    DateTime? createdAt,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         exerciseId: exerciseId,
         workoutExerciseId: workoutExerciseId,
         date: date,
         setsCompleted: setsCompleted,
         repsCompleted: repsCompleted,
         weightUsed: weightUsed,
         difficultyRating: difficultyRating,
         notes: notes,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ExerciseLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ExerciseLog copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    int? exerciseId,
    Object? workoutExerciseId = _Undefined,
    DateTime? date,
    int? setsCompleted,
    int? repsCompleted,
    Object? weightUsed = _Undefined,
    Object? difficultyRating = _Undefined,
    Object? notes = _Undefined,
    DateTime? createdAt,
  }) {
    return ExerciseLogImplicit._(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.UserProfile? ? user : this.user?.copyWith(),
      exerciseId: exerciseId ?? this.exerciseId,
      workoutExerciseId: workoutExerciseId is int?
          ? workoutExerciseId
          : this.workoutExerciseId,
      date: date ?? this.date,
      setsCompleted: setsCompleted ?? this.setsCompleted,
      repsCompleted: repsCompleted ?? this.repsCompleted,
      weightUsed: weightUsed is double? ? weightUsed : this.weightUsed,
      difficultyRating: difficultyRating is int?
          ? difficultyRating
          : this.difficultyRating,
      notes: notes is String? ? notes : this.notes,
      createdAt: createdAt ?? this.createdAt,
      $_workoutExercisesLogsWorkoutExercisesId:
          this._workoutExercisesLogsWorkoutExercisesId,
    );
  }
}

class ExerciseLogImplicit extends _ExerciseLogImpl {
  ExerciseLogImplicit._({
    int? id,
    required int userId,
    _i2.UserProfile? user,
    required int exerciseId,
    int? workoutExerciseId,
    required DateTime date,
    required int setsCompleted,
    required int repsCompleted,
    double? weightUsed,
    int? difficultyRating,
    String? notes,
    DateTime? createdAt,
    int? $_workoutExercisesLogsWorkoutExercisesId,
  }) : _workoutExercisesLogsWorkoutExercisesId =
           $_workoutExercisesLogsWorkoutExercisesId,
       super(
         id: id,
         userId: userId,
         user: user,
         exerciseId: exerciseId,
         workoutExerciseId: workoutExerciseId,
         date: date,
         setsCompleted: setsCompleted,
         repsCompleted: repsCompleted,
         weightUsed: weightUsed,
         difficultyRating: difficultyRating,
         notes: notes,
         createdAt: createdAt,
       );

  factory ExerciseLogImplicit(
    ExerciseLog exerciseLog, {
    int? $_workoutExercisesLogsWorkoutExercisesId,
  }) {
    return ExerciseLogImplicit._(
      id: exerciseLog.id,
      userId: exerciseLog.userId,
      user: exerciseLog.user,
      exerciseId: exerciseLog.exerciseId,
      workoutExerciseId: exerciseLog.workoutExerciseId,
      date: exerciseLog.date,
      setsCompleted: exerciseLog.setsCompleted,
      repsCompleted: exerciseLog.repsCompleted,
      weightUsed: exerciseLog.weightUsed,
      difficultyRating: exerciseLog.difficultyRating,
      notes: exerciseLog.notes,
      createdAt: exerciseLog.createdAt,
      $_workoutExercisesLogsWorkoutExercisesId:
          $_workoutExercisesLogsWorkoutExercisesId,
    );
  }

  @override
  final int? _workoutExercisesLogsWorkoutExercisesId;
}

class ExerciseLogUpdateTable extends _i1.UpdateTable<ExerciseLogTable> {
  ExerciseLogUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<int, int> exerciseId(int value) => _i1.ColumnValue(
    table.exerciseId,
    value,
  );

  _i1.ColumnValue<int, int> workoutExerciseId(int? value) => _i1.ColumnValue(
    table.workoutExerciseId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> date(DateTime value) => _i1.ColumnValue(
    table.date,
    value,
  );

  _i1.ColumnValue<int, int> setsCompleted(int value) => _i1.ColumnValue(
    table.setsCompleted,
    value,
  );

  _i1.ColumnValue<int, int> repsCompleted(int value) => _i1.ColumnValue(
    table.repsCompleted,
    value,
  );

  _i1.ColumnValue<double, double> weightUsed(double? value) => _i1.ColumnValue(
    table.weightUsed,
    value,
  );

  _i1.ColumnValue<int, int> difficultyRating(int? value) => _i1.ColumnValue(
    table.difficultyRating,
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

  _i1.ColumnValue<int, int> $_workoutExercisesLogsWorkoutExercisesId(
    int? value,
  ) => _i1.ColumnValue(
    table.$_workoutExercisesLogsWorkoutExercisesId,
    value,
  );
}

class ExerciseLogTable extends _i1.Table<int?> {
  ExerciseLogTable({super.tableRelation}) : super(tableName: 'exercise_logs') {
    updateTable = ExerciseLogUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    exerciseId = _i1.ColumnInt(
      'exerciseId',
      this,
    );
    workoutExerciseId = _i1.ColumnInt(
      'workoutExerciseId',
      this,
    );
    date = _i1.ColumnDateTime(
      'date',
      this,
    );
    setsCompleted = _i1.ColumnInt(
      'setsCompleted',
      this,
    );
    repsCompleted = _i1.ColumnInt(
      'repsCompleted',
      this,
    );
    weightUsed = _i1.ColumnDouble(
      'weightUsed',
      this,
    );
    difficultyRating = _i1.ColumnInt(
      'difficultyRating',
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
    $_workoutExercisesLogsWorkoutExercisesId = _i1.ColumnInt(
      '_workoutExercisesLogsWorkoutExercisesId',
      this,
    );
  }

  late final ExerciseLogUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  _i2.UserProfileTable? _user;

  late final _i1.ColumnInt exerciseId;

  late final _i1.ColumnInt workoutExerciseId;

  late final _i1.ColumnDateTime date;

  late final _i1.ColumnInt setsCompleted;

  late final _i1.ColumnInt repsCompleted;

  late final _i1.ColumnDouble weightUsed;

  late final _i1.ColumnInt difficultyRating;

  late final _i1.ColumnString notes;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnInt $_workoutExercisesLogsWorkoutExercisesId;

  _i2.UserProfileTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: ExerciseLog.t.userId,
      foreignField: _i2.UserProfile.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.UserProfileTable(tableRelation: foreignTableRelation),
    );
    return _user!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    exerciseId,
    workoutExerciseId,
    date,
    setsCompleted,
    repsCompleted,
    weightUsed,
    difficultyRating,
    notes,
    createdAt,
    $_workoutExercisesLogsWorkoutExercisesId,
  ];

  @override
  List<_i1.Column> get managedColumns => [
    id,
    userId,
    exerciseId,
    workoutExerciseId,
    date,
    setsCompleted,
    repsCompleted,
    weightUsed,
    difficultyRating,
    notes,
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'user') {
      return user;
    }
    return null;
  }
}

class ExerciseLogInclude extends _i1.IncludeObject {
  ExerciseLogInclude._({_i2.UserProfileInclude? user}) {
    _user = user;
  }

  _i2.UserProfileInclude? _user;

  @override
  Map<String, _i1.Include?> get includes => {'user': _user};

  @override
  _i1.Table<int?> get table => ExerciseLog.t;
}

class ExerciseLogIncludeList extends _i1.IncludeList {
  ExerciseLogIncludeList._({
    _i1.WhereExpressionBuilder<ExerciseLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ExerciseLog.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ExerciseLog.t;
}

class ExerciseLogRepository {
  const ExerciseLogRepository._();

  final attachRow = const ExerciseLogAttachRowRepository._();

  /// Returns a list of [ExerciseLog]s matching the given query parameters.
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
  Future<List<ExerciseLog>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ExerciseLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ExerciseLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExerciseLogTable>? orderByList,
    _i1.Transaction? transaction,
    ExerciseLogInclude? include,
  }) async {
    return session.db.find<ExerciseLog>(
      where: where?.call(ExerciseLog.t),
      orderBy: orderBy?.call(ExerciseLog.t),
      orderByList: orderByList?.call(ExerciseLog.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [ExerciseLog] matching the given query parameters.
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
  Future<ExerciseLog?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ExerciseLogTable>? where,
    int? offset,
    _i1.OrderByBuilder<ExerciseLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExerciseLogTable>? orderByList,
    _i1.Transaction? transaction,
    ExerciseLogInclude? include,
  }) async {
    return session.db.findFirstRow<ExerciseLog>(
      where: where?.call(ExerciseLog.t),
      orderBy: orderBy?.call(ExerciseLog.t),
      orderByList: orderByList?.call(ExerciseLog.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [ExerciseLog] by its [id] or null if no such row exists.
  Future<ExerciseLog?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    ExerciseLogInclude? include,
  }) async {
    return session.db.findById<ExerciseLog>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [ExerciseLog]s in the list and returns the inserted rows.
  ///
  /// The returned [ExerciseLog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ExerciseLog>> insert(
    _i1.Session session,
    List<ExerciseLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ExerciseLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ExerciseLog] and returns the inserted row.
  ///
  /// The returned [ExerciseLog] will have its `id` field set.
  Future<ExerciseLog> insertRow(
    _i1.Session session,
    ExerciseLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ExerciseLog>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ExerciseLog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ExerciseLog>> update(
    _i1.Session session,
    List<ExerciseLog> rows, {
    _i1.ColumnSelections<ExerciseLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ExerciseLog>(
      rows,
      columns: columns?.call(ExerciseLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ExerciseLog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ExerciseLog> updateRow(
    _i1.Session session,
    ExerciseLog row, {
    _i1.ColumnSelections<ExerciseLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ExerciseLog>(
      row,
      columns: columns?.call(ExerciseLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ExerciseLog] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ExerciseLog?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<ExerciseLogUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ExerciseLog>(
      id,
      columnValues: columnValues(ExerciseLog.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ExerciseLog]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ExerciseLog>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<ExerciseLogUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ExerciseLogTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ExerciseLogTable>? orderBy,
    _i1.OrderByListBuilder<ExerciseLogTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ExerciseLog>(
      columnValues: columnValues(ExerciseLog.t.updateTable),
      where: where(ExerciseLog.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ExerciseLog.t),
      orderByList: orderByList?.call(ExerciseLog.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ExerciseLog]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ExerciseLog>> delete(
    _i1.Session session,
    List<ExerciseLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ExerciseLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ExerciseLog].
  Future<ExerciseLog> deleteRow(
    _i1.Session session,
    ExerciseLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ExerciseLog>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ExerciseLog>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ExerciseLogTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ExerciseLog>(
      where: where(ExerciseLog.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ExerciseLogTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ExerciseLog>(
      where: where?.call(ExerciseLog.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class ExerciseLogAttachRowRepository {
  const ExerciseLogAttachRowRepository._();

  /// Creates a relation between the given [ExerciseLog] and [UserProfile]
  /// by setting the [ExerciseLog]'s foreign key `userId` to refer to the [UserProfile].
  Future<void> user(
    _i1.Session session,
    ExerciseLog exerciseLog,
    _i2.UserProfile user, {
    _i1.Transaction? transaction,
  }) async {
    if (exerciseLog.id == null) {
      throw ArgumentError.notNull('exerciseLog.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $exerciseLog = exerciseLog.copyWith(userId: user.id);
    await session.db.updateRow<ExerciseLog>(
      $exerciseLog,
      columns: [ExerciseLog.t.userId],
      transaction: transaction,
    );
  }
}
