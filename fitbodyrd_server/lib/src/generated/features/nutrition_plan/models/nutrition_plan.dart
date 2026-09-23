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
import '../../../common/models/status.dart' as _i3;
import '../../../features/nutrition_plan/models/meal_plan.dart' as _i4;
import 'package:fitbodyrd_server/src/generated/protocol.dart' as _i5;

abstract class NutritionPlan
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  NutritionPlan._({
    this.id,
    required this.userProfileId,
    this.userProfile,
    required this.startDate,
    required this.endDate,
    required this.dailyCalories,
    required this.dailyProteins,
    required this.dailyCarbs,
    required this.dailyFats,
    required this.status,
    this.notes,
    this.mealPlans,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory NutritionPlan({
    int? id,
    required int userProfileId,
    _i2.UserProfile? userProfile,
    required DateTime startDate,
    required DateTime endDate,
    required double dailyCalories,
    required double dailyProteins,
    required double dailyCarbs,
    required double dailyFats,
    required _i3.Status status,
    String? notes,
    List<_i4.MealPlan>? mealPlans,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _NutritionPlanImpl;

  factory NutritionPlan.fromJson(Map<String, dynamic> jsonSerialization) {
    return NutritionPlan(
      id: jsonSerialization['id'] as int?,
      userProfileId: jsonSerialization['userProfileId'] as int,
      userProfile: jsonSerialization['userProfile'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.UserProfile>(
              jsonSerialization['userProfile'],
            ),
      startDate: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startDate'],
      ),
      endDate: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endDate']),
      dailyCalories: (jsonSerialization['dailyCalories'] as num).toDouble(),
      dailyProteins: (jsonSerialization['dailyProteins'] as num).toDouble(),
      dailyCarbs: (jsonSerialization['dailyCarbs'] as num).toDouble(),
      dailyFats: (jsonSerialization['dailyFats'] as num).toDouble(),
      status: _i3.Status.fromJson((jsonSerialization['status'] as String)),
      notes: jsonSerialization['notes'] as String?,
      mealPlans: jsonSerialization['mealPlans'] == null
          ? null
          : _i5.Protocol().deserialize<List<_i4.MealPlan>>(
              jsonSerialization['mealPlans'],
            ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = NutritionPlanTable();

  static const db = NutritionPlanRepository._();

  @override
  int? id;

  int userProfileId;

  _i2.UserProfile? userProfile;

  DateTime startDate;

  DateTime endDate;

  double dailyCalories;

  double dailyProteins;

  double dailyCarbs;

  double dailyFats;

  _i3.Status status;

  String? notes;

  List<_i4.MealPlan>? mealPlans;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [NutritionPlan]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  NutritionPlan copyWith({
    int? id,
    int? userProfileId,
    _i2.UserProfile? userProfile,
    DateTime? startDate,
    DateTime? endDate,
    double? dailyCalories,
    double? dailyProteins,
    double? dailyCarbs,
    double? dailyFats,
    _i3.Status? status,
    String? notes,
    List<_i4.MealPlan>? mealPlans,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'NutritionPlan',
      if (id != null) 'id': id,
      'userProfileId': userProfileId,
      if (userProfile != null) 'userProfile': userProfile?.toJson(),
      'startDate': startDate.toJson(),
      'endDate': endDate.toJson(),
      'dailyCalories': dailyCalories,
      'dailyProteins': dailyProteins,
      'dailyCarbs': dailyCarbs,
      'dailyFats': dailyFats,
      'status': status.toJson(),
      if (notes != null) 'notes': notes,
      if (mealPlans != null)
        'mealPlans': mealPlans?.toJson(valueToJson: (v) => v.toJson()),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'NutritionPlan',
      if (id != null) 'id': id,
      'userProfileId': userProfileId,
      if (userProfile != null) 'userProfile': userProfile?.toJsonForProtocol(),
      'startDate': startDate.toJson(),
      'endDate': endDate.toJson(),
      'dailyCalories': dailyCalories,
      'dailyProteins': dailyProteins,
      'dailyCarbs': dailyCarbs,
      'dailyFats': dailyFats,
      'status': status.toJson(),
      if (notes != null) 'notes': notes,
      if (mealPlans != null)
        'mealPlans': mealPlans?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static NutritionPlanInclude include({
    _i2.UserProfileInclude? userProfile,
    _i4.MealPlanIncludeList? mealPlans,
  }) {
    return NutritionPlanInclude._(
      userProfile: userProfile,
      mealPlans: mealPlans,
    );
  }

  static NutritionPlanIncludeList includeList({
    _i1.WhereExpressionBuilder<NutritionPlanTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<NutritionPlanTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<NutritionPlanTable>? orderByList,
    NutritionPlanInclude? include,
  }) {
    return NutritionPlanIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(NutritionPlan.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(NutritionPlan.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _NutritionPlanImpl extends NutritionPlan {
  _NutritionPlanImpl({
    int? id,
    required int userProfileId,
    _i2.UserProfile? userProfile,
    required DateTime startDate,
    required DateTime endDate,
    required double dailyCalories,
    required double dailyProteins,
    required double dailyCarbs,
    required double dailyFats,
    required _i3.Status status,
    String? notes,
    List<_i4.MealPlan>? mealPlans,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         userProfileId: userProfileId,
         userProfile: userProfile,
         startDate: startDate,
         endDate: endDate,
         dailyCalories: dailyCalories,
         dailyProteins: dailyProteins,
         dailyCarbs: dailyCarbs,
         dailyFats: dailyFats,
         status: status,
         notes: notes,
         mealPlans: mealPlans,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [NutritionPlan]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  NutritionPlan copyWith({
    Object? id = _Undefined,
    int? userProfileId,
    Object? userProfile = _Undefined,
    DateTime? startDate,
    DateTime? endDate,
    double? dailyCalories,
    double? dailyProteins,
    double? dailyCarbs,
    double? dailyFats,
    _i3.Status? status,
    Object? notes = _Undefined,
    Object? mealPlans = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return NutritionPlan(
      id: id is int? ? id : this.id,
      userProfileId: userProfileId ?? this.userProfileId,
      userProfile: userProfile is _i2.UserProfile?
          ? userProfile
          : this.userProfile?.copyWith(),
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      dailyCalories: dailyCalories ?? this.dailyCalories,
      dailyProteins: dailyProteins ?? this.dailyProteins,
      dailyCarbs: dailyCarbs ?? this.dailyCarbs,
      dailyFats: dailyFats ?? this.dailyFats,
      status: status ?? this.status,
      notes: notes is String? ? notes : this.notes,
      mealPlans: mealPlans is List<_i4.MealPlan>?
          ? mealPlans
          : this.mealPlans?.map((e0) => e0.copyWith()).toList(),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class NutritionPlanUpdateTable extends _i1.UpdateTable<NutritionPlanTable> {
  NutritionPlanUpdateTable(super.table);

  _i1.ColumnValue<int, int> userProfileId(int value) => _i1.ColumnValue(
    table.userProfileId,
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

  _i1.ColumnValue<double, double> dailyCalories(double value) =>
      _i1.ColumnValue(
        table.dailyCalories,
        value,
      );

  _i1.ColumnValue<double, double> dailyProteins(double value) =>
      _i1.ColumnValue(
        table.dailyProteins,
        value,
      );

  _i1.ColumnValue<double, double> dailyCarbs(double value) => _i1.ColumnValue(
    table.dailyCarbs,
    value,
  );

  _i1.ColumnValue<double, double> dailyFats(double value) => _i1.ColumnValue(
    table.dailyFats,
    value,
  );

  _i1.ColumnValue<_i3.Status, _i3.Status> status(_i3.Status value) =>
      _i1.ColumnValue(
        table.status,
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

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class NutritionPlanTable extends _i1.Table<int?> {
  NutritionPlanTable({super.tableRelation})
    : super(tableName: 'nutrition_plans') {
    updateTable = NutritionPlanUpdateTable(this);
    userProfileId = _i1.ColumnInt(
      'userProfileId',
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
    dailyCalories = _i1.ColumnDouble(
      'dailyCalories',
      this,
    );
    dailyProteins = _i1.ColumnDouble(
      'dailyProteins',
      this,
    );
    dailyCarbs = _i1.ColumnDouble(
      'dailyCarbs',
      this,
    );
    dailyFats = _i1.ColumnDouble(
      'dailyFats',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
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
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
  }

  late final NutritionPlanUpdateTable updateTable;

  late final _i1.ColumnInt userProfileId;

  _i2.UserProfileTable? _userProfile;

  late final _i1.ColumnDateTime startDate;

  late final _i1.ColumnDateTime endDate;

  late final _i1.ColumnDouble dailyCalories;

  late final _i1.ColumnDouble dailyProteins;

  late final _i1.ColumnDouble dailyCarbs;

  late final _i1.ColumnDouble dailyFats;

  late final _i1.ColumnEnum<_i3.Status> status;

  late final _i1.ColumnString notes;

  _i4.MealPlanTable? ___mealPlans;

  _i1.ManyRelation<_i4.MealPlanTable>? _mealPlans;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  _i2.UserProfileTable get userProfile {
    if (_userProfile != null) return _userProfile!;
    _userProfile = _i1.createRelationTable(
      relationFieldName: 'userProfile',
      field: NutritionPlan.t.userProfileId,
      foreignField: _i2.UserProfile.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.UserProfileTable(tableRelation: foreignTableRelation),
    );
    return _userProfile!;
  }

  _i4.MealPlanTable get __mealPlans {
    if (___mealPlans != null) return ___mealPlans!;
    ___mealPlans = _i1.createRelationTable(
      relationFieldName: '__mealPlans',
      field: NutritionPlan.t.id,
      foreignField: _i4.MealPlan.t.nutritionPlanId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.MealPlanTable(tableRelation: foreignTableRelation),
    );
    return ___mealPlans!;
  }

  _i1.ManyRelation<_i4.MealPlanTable> get mealPlans {
    if (_mealPlans != null) return _mealPlans!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'mealPlans',
      field: NutritionPlan.t.id,
      foreignField: _i4.MealPlan.t.nutritionPlanId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.MealPlanTable(tableRelation: foreignTableRelation),
    );
    _mealPlans = _i1.ManyRelation<_i4.MealPlanTable>(
      tableWithRelations: relationTable,
      table: _i4.MealPlanTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _mealPlans!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    userProfileId,
    startDate,
    endDate,
    dailyCalories,
    dailyProteins,
    dailyCarbs,
    dailyFats,
    status,
    notes,
    createdAt,
    updatedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'userProfile') {
      return userProfile;
    }
    if (relationField == 'mealPlans') {
      return __mealPlans;
    }
    return null;
  }
}

class NutritionPlanInclude extends _i1.IncludeObject {
  NutritionPlanInclude._({
    _i2.UserProfileInclude? userProfile,
    _i4.MealPlanIncludeList? mealPlans,
  }) {
    _userProfile = userProfile;
    _mealPlans = mealPlans;
  }

  _i2.UserProfileInclude? _userProfile;

  _i4.MealPlanIncludeList? _mealPlans;

  @override
  Map<String, _i1.Include?> get includes => {
    'userProfile': _userProfile,
    'mealPlans': _mealPlans,
  };

  @override
  _i1.Table<int?> get table => NutritionPlan.t;
}

class NutritionPlanIncludeList extends _i1.IncludeList {
  NutritionPlanIncludeList._({
    _i1.WhereExpressionBuilder<NutritionPlanTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(NutritionPlan.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => NutritionPlan.t;
}

class NutritionPlanRepository {
  const NutritionPlanRepository._();

  final attach = const NutritionPlanAttachRepository._();

  final attachRow = const NutritionPlanAttachRowRepository._();

  /// Returns a list of [NutritionPlan]s matching the given query parameters.
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
  Future<List<NutritionPlan>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<NutritionPlanTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<NutritionPlanTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<NutritionPlanTable>? orderByList,
    _i1.Transaction? transaction,
    NutritionPlanInclude? include,
  }) async {
    return session.db.find<NutritionPlan>(
      where: where?.call(NutritionPlan.t),
      orderBy: orderBy?.call(NutritionPlan.t),
      orderByList: orderByList?.call(NutritionPlan.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [NutritionPlan] matching the given query parameters.
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
  Future<NutritionPlan?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<NutritionPlanTable>? where,
    int? offset,
    _i1.OrderByBuilder<NutritionPlanTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<NutritionPlanTable>? orderByList,
    _i1.Transaction? transaction,
    NutritionPlanInclude? include,
  }) async {
    return session.db.findFirstRow<NutritionPlan>(
      where: where?.call(NutritionPlan.t),
      orderBy: orderBy?.call(NutritionPlan.t),
      orderByList: orderByList?.call(NutritionPlan.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [NutritionPlan] by its [id] or null if no such row exists.
  Future<NutritionPlan?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    NutritionPlanInclude? include,
  }) async {
    return session.db.findById<NutritionPlan>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [NutritionPlan]s in the list and returns the inserted rows.
  ///
  /// The returned [NutritionPlan]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<NutritionPlan>> insert(
    _i1.Session session,
    List<NutritionPlan> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<NutritionPlan>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [NutritionPlan] and returns the inserted row.
  ///
  /// The returned [NutritionPlan] will have its `id` field set.
  Future<NutritionPlan> insertRow(
    _i1.Session session,
    NutritionPlan row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<NutritionPlan>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [NutritionPlan]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<NutritionPlan>> update(
    _i1.Session session,
    List<NutritionPlan> rows, {
    _i1.ColumnSelections<NutritionPlanTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<NutritionPlan>(
      rows,
      columns: columns?.call(NutritionPlan.t),
      transaction: transaction,
    );
  }

  /// Updates a single [NutritionPlan]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<NutritionPlan> updateRow(
    _i1.Session session,
    NutritionPlan row, {
    _i1.ColumnSelections<NutritionPlanTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<NutritionPlan>(
      row,
      columns: columns?.call(NutritionPlan.t),
      transaction: transaction,
    );
  }

  /// Updates a single [NutritionPlan] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<NutritionPlan?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<NutritionPlanUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<NutritionPlan>(
      id,
      columnValues: columnValues(NutritionPlan.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [NutritionPlan]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<NutritionPlan>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<NutritionPlanUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<NutritionPlanTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<NutritionPlanTable>? orderBy,
    _i1.OrderByListBuilder<NutritionPlanTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<NutritionPlan>(
      columnValues: columnValues(NutritionPlan.t.updateTable),
      where: where(NutritionPlan.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(NutritionPlan.t),
      orderByList: orderByList?.call(NutritionPlan.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [NutritionPlan]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<NutritionPlan>> delete(
    _i1.Session session,
    List<NutritionPlan> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<NutritionPlan>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [NutritionPlan].
  Future<NutritionPlan> deleteRow(
    _i1.Session session,
    NutritionPlan row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<NutritionPlan>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<NutritionPlan>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<NutritionPlanTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<NutritionPlan>(
      where: where(NutritionPlan.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<NutritionPlanTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<NutritionPlan>(
      where: where?.call(NutritionPlan.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class NutritionPlanAttachRepository {
  const NutritionPlanAttachRepository._();

  /// Creates a relation between this [NutritionPlan] and the given [MealPlan]s
  /// by setting each [MealPlan]'s foreign key `nutritionPlanId` to refer to this [NutritionPlan].
  Future<void> mealPlans(
    _i1.Session session,
    NutritionPlan nutritionPlan,
    List<_i4.MealPlan> mealPlan, {
    _i1.Transaction? transaction,
  }) async {
    if (mealPlan.any((e) => e.id == null)) {
      throw ArgumentError.notNull('mealPlan.id');
    }
    if (nutritionPlan.id == null) {
      throw ArgumentError.notNull('nutritionPlan.id');
    }

    var $mealPlan = mealPlan
        .map((e) => e.copyWith(nutritionPlanId: nutritionPlan.id))
        .toList();
    await session.db.update<_i4.MealPlan>(
      $mealPlan,
      columns: [_i4.MealPlan.t.nutritionPlanId],
      transaction: transaction,
    );
  }
}

class NutritionPlanAttachRowRepository {
  const NutritionPlanAttachRowRepository._();

  /// Creates a relation between the given [NutritionPlan] and [UserProfile]
  /// by setting the [NutritionPlan]'s foreign key `userProfileId` to refer to the [UserProfile].
  Future<void> userProfile(
    _i1.Session session,
    NutritionPlan nutritionPlan,
    _i2.UserProfile userProfile, {
    _i1.Transaction? transaction,
  }) async {
    if (nutritionPlan.id == null) {
      throw ArgumentError.notNull('nutritionPlan.id');
    }
    if (userProfile.id == null) {
      throw ArgumentError.notNull('userProfile.id');
    }

    var $nutritionPlan = nutritionPlan.copyWith(userProfileId: userProfile.id);
    await session.db.updateRow<NutritionPlan>(
      $nutritionPlan,
      columns: [NutritionPlan.t.userProfileId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [NutritionPlan] and the given [MealPlan]
  /// by setting the [MealPlan]'s foreign key `nutritionPlanId` to refer to this [NutritionPlan].
  Future<void> mealPlans(
    _i1.Session session,
    NutritionPlan nutritionPlan,
    _i4.MealPlan mealPlan, {
    _i1.Transaction? transaction,
  }) async {
    if (mealPlan.id == null) {
      throw ArgumentError.notNull('mealPlan.id');
    }
    if (nutritionPlan.id == null) {
      throw ArgumentError.notNull('nutritionPlan.id');
    }

    var $mealPlan = mealPlan.copyWith(nutritionPlanId: nutritionPlan.id);
    await session.db.updateRow<_i4.MealPlan>(
      $mealPlan,
      columns: [_i4.MealPlan.t.nutritionPlanId],
      transaction: transaction,
    );
  }
}
