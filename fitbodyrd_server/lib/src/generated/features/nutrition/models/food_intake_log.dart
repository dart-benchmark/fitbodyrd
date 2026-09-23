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
import '../../../features/nutrition_plan/models/meal_plan.dart' as _i3;
import '../../../features/food/models/food.dart' as _i4;
import '../../../features/nutrition_plan/models/meal_type.dart' as _i5;
import '../../../features/food/models/food_serving_size.dart' as _i6;
import 'package:fitbodyrd_server/src/generated/protocol.dart' as _i7;

abstract class FoodIntakeLog
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  FoodIntakeLog._({
    this.id,
    required this.userId,
    this.user,
    this.mealPlanId,
    this.mealPlan,
    required this.foodId,
    this.food,
    required this.date,
    required this.mealType,
    this.servingSizeId,
    this.servingSize,
    required this.servingQuantity,
    required this.quantityGrams,
    DateTime? consumedAt,
    this.notes,
    DateTime? createdAt,
  }) : consumedAt = consumedAt ?? DateTime.now(),
       createdAt = createdAt ?? DateTime.now();

  factory FoodIntakeLog({
    int? id,
    required int userId,
    _i2.UserProfile? user,
    int? mealPlanId,
    _i3.MealPlan? mealPlan,
    required int foodId,
    _i4.Food? food,
    required DateTime date,
    required _i5.MealPlanType mealType,
    int? servingSizeId,
    _i6.FoodServingSize? servingSize,
    required double servingQuantity,
    required double quantityGrams,
    DateTime? consumedAt,
    String? notes,
    DateTime? createdAt,
  }) = _FoodIntakeLogImpl;

  factory FoodIntakeLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return FoodIntakeLog(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i7.Protocol().deserialize<_i2.UserProfile>(
              jsonSerialization['user'],
            ),
      mealPlanId: jsonSerialization['mealPlanId'] as int?,
      mealPlan: jsonSerialization['mealPlan'] == null
          ? null
          : _i7.Protocol().deserialize<_i3.MealPlan>(
              jsonSerialization['mealPlan'],
            ),
      foodId: jsonSerialization['foodId'] as int,
      food: jsonSerialization['food'] == null
          ? null
          : _i7.Protocol().deserialize<_i4.Food>(jsonSerialization['food']),
      date: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      mealType: _i5.MealPlanType.fromJson(
        (jsonSerialization['mealType'] as String),
      ),
      servingSizeId: jsonSerialization['servingSizeId'] as int?,
      servingSize: jsonSerialization['servingSize'] == null
          ? null
          : _i7.Protocol().deserialize<_i6.FoodServingSize>(
              jsonSerialization['servingSize'],
            ),
      servingQuantity: (jsonSerialization['servingQuantity'] as num).toDouble(),
      quantityGrams: (jsonSerialization['quantityGrams'] as num).toDouble(),
      consumedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['consumedAt'],
      ),
      notes: jsonSerialization['notes'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = FoodIntakeLogTable();

  static const db = FoodIntakeLogRepository._();

  @override
  int? id;

  int userId;

  _i2.UserProfile? user;

  int? mealPlanId;

  _i3.MealPlan? mealPlan;

  int foodId;

  _i4.Food? food;

  DateTime date;

  _i5.MealPlanType mealType;

  int? servingSizeId;

  _i6.FoodServingSize? servingSize;

  double servingQuantity;

  double quantityGrams;

  DateTime consumedAt;

  String? notes;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [FoodIntakeLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FoodIntakeLog copyWith({
    int? id,
    int? userId,
    _i2.UserProfile? user,
    int? mealPlanId,
    _i3.MealPlan? mealPlan,
    int? foodId,
    _i4.Food? food,
    DateTime? date,
    _i5.MealPlanType? mealType,
    int? servingSizeId,
    _i6.FoodServingSize? servingSize,
    double? servingQuantity,
    double? quantityGrams,
    DateTime? consumedAt,
    String? notes,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FoodIntakeLog',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      if (mealPlanId != null) 'mealPlanId': mealPlanId,
      if (mealPlan != null) 'mealPlan': mealPlan?.toJson(),
      'foodId': foodId,
      if (food != null) 'food': food?.toJson(),
      'date': date.toJson(),
      'mealType': mealType.toJson(),
      if (servingSizeId != null) 'servingSizeId': servingSizeId,
      if (servingSize != null) 'servingSize': servingSize?.toJson(),
      'servingQuantity': servingQuantity,
      'quantityGrams': quantityGrams,
      'consumedAt': consumedAt.toJson(),
      if (notes != null) 'notes': notes,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FoodIntakeLog',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJsonForProtocol(),
      if (mealPlanId != null) 'mealPlanId': mealPlanId,
      if (mealPlan != null) 'mealPlan': mealPlan?.toJsonForProtocol(),
      'foodId': foodId,
      if (food != null) 'food': food?.toJsonForProtocol(),
      'date': date.toJson(),
      'mealType': mealType.toJson(),
      if (servingSizeId != null) 'servingSizeId': servingSizeId,
      if (servingSize != null) 'servingSize': servingSize?.toJsonForProtocol(),
      'servingQuantity': servingQuantity,
      'quantityGrams': quantityGrams,
      'consumedAt': consumedAt.toJson(),
      if (notes != null) 'notes': notes,
      'createdAt': createdAt.toJson(),
    };
  }

  static FoodIntakeLogInclude include({
    _i2.UserProfileInclude? user,
    _i3.MealPlanInclude? mealPlan,
    _i4.FoodInclude? food,
    _i6.FoodServingSizeInclude? servingSize,
  }) {
    return FoodIntakeLogInclude._(
      user: user,
      mealPlan: mealPlan,
      food: food,
      servingSize: servingSize,
    );
  }

  static FoodIntakeLogIncludeList includeList({
    _i1.WhereExpressionBuilder<FoodIntakeLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FoodIntakeLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FoodIntakeLogTable>? orderByList,
    FoodIntakeLogInclude? include,
  }) {
    return FoodIntakeLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FoodIntakeLog.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(FoodIntakeLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FoodIntakeLogImpl extends FoodIntakeLog {
  _FoodIntakeLogImpl({
    int? id,
    required int userId,
    _i2.UserProfile? user,
    int? mealPlanId,
    _i3.MealPlan? mealPlan,
    required int foodId,
    _i4.Food? food,
    required DateTime date,
    required _i5.MealPlanType mealType,
    int? servingSizeId,
    _i6.FoodServingSize? servingSize,
    required double servingQuantity,
    required double quantityGrams,
    DateTime? consumedAt,
    String? notes,
    DateTime? createdAt,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         mealPlanId: mealPlanId,
         mealPlan: mealPlan,
         foodId: foodId,
         food: food,
         date: date,
         mealType: mealType,
         servingSizeId: servingSizeId,
         servingSize: servingSize,
         servingQuantity: servingQuantity,
         quantityGrams: quantityGrams,
         consumedAt: consumedAt,
         notes: notes,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [FoodIntakeLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FoodIntakeLog copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    Object? mealPlanId = _Undefined,
    Object? mealPlan = _Undefined,
    int? foodId,
    Object? food = _Undefined,
    DateTime? date,
    _i5.MealPlanType? mealType,
    Object? servingSizeId = _Undefined,
    Object? servingSize = _Undefined,
    double? servingQuantity,
    double? quantityGrams,
    DateTime? consumedAt,
    Object? notes = _Undefined,
    DateTime? createdAt,
  }) {
    return FoodIntakeLog(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.UserProfile? ? user : this.user?.copyWith(),
      mealPlanId: mealPlanId is int? ? mealPlanId : this.mealPlanId,
      mealPlan: mealPlan is _i3.MealPlan?
          ? mealPlan
          : this.mealPlan?.copyWith(),
      foodId: foodId ?? this.foodId,
      food: food is _i4.Food? ? food : this.food?.copyWith(),
      date: date ?? this.date,
      mealType: mealType ?? this.mealType,
      servingSizeId: servingSizeId is int? ? servingSizeId : this.servingSizeId,
      servingSize: servingSize is _i6.FoodServingSize?
          ? servingSize
          : this.servingSize?.copyWith(),
      servingQuantity: servingQuantity ?? this.servingQuantity,
      quantityGrams: quantityGrams ?? this.quantityGrams,
      consumedAt: consumedAt ?? this.consumedAt,
      notes: notes is String? ? notes : this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class FoodIntakeLogUpdateTable extends _i1.UpdateTable<FoodIntakeLogTable> {
  FoodIntakeLogUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<int, int> mealPlanId(int? value) => _i1.ColumnValue(
    table.mealPlanId,
    value,
  );

  _i1.ColumnValue<int, int> foodId(int value) => _i1.ColumnValue(
    table.foodId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> date(DateTime value) => _i1.ColumnValue(
    table.date,
    value,
  );

  _i1.ColumnValue<_i5.MealPlanType, _i5.MealPlanType> mealType(
    _i5.MealPlanType value,
  ) => _i1.ColumnValue(
    table.mealType,
    value,
  );

  _i1.ColumnValue<int, int> servingSizeId(int? value) => _i1.ColumnValue(
    table.servingSizeId,
    value,
  );

  _i1.ColumnValue<double, double> servingQuantity(double value) =>
      _i1.ColumnValue(
        table.servingQuantity,
        value,
      );

  _i1.ColumnValue<double, double> quantityGrams(double value) =>
      _i1.ColumnValue(
        table.quantityGrams,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> consumedAt(DateTime value) =>
      _i1.ColumnValue(
        table.consumedAt,
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

class FoodIntakeLogTable extends _i1.Table<int?> {
  FoodIntakeLogTable({super.tableRelation})
    : super(tableName: 'food_intake_log') {
    updateTable = FoodIntakeLogUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    mealPlanId = _i1.ColumnInt(
      'mealPlanId',
      this,
    );
    foodId = _i1.ColumnInt(
      'foodId',
      this,
    );
    date = _i1.ColumnDateTime(
      'date',
      this,
    );
    mealType = _i1.ColumnEnum(
      'mealType',
      this,
      _i1.EnumSerialization.byName,
    );
    servingSizeId = _i1.ColumnInt(
      'servingSizeId',
      this,
    );
    servingQuantity = _i1.ColumnDouble(
      'servingQuantity',
      this,
    );
    quantityGrams = _i1.ColumnDouble(
      'quantityGrams',
      this,
    );
    consumedAt = _i1.ColumnDateTime(
      'consumedAt',
      this,
      hasDefault: true,
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

  late final FoodIntakeLogUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  _i2.UserProfileTable? _user;

  late final _i1.ColumnInt mealPlanId;

  _i3.MealPlanTable? _mealPlan;

  late final _i1.ColumnInt foodId;

  _i4.FoodTable? _food;

  late final _i1.ColumnDateTime date;

  late final _i1.ColumnEnum<_i5.MealPlanType> mealType;

  late final _i1.ColumnInt servingSizeId;

  _i6.FoodServingSizeTable? _servingSize;

  late final _i1.ColumnDouble servingQuantity;

  late final _i1.ColumnDouble quantityGrams;

  late final _i1.ColumnDateTime consumedAt;

  late final _i1.ColumnString notes;

  late final _i1.ColumnDateTime createdAt;

  _i2.UserProfileTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: FoodIntakeLog.t.userId,
      foreignField: _i2.UserProfile.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.UserProfileTable(tableRelation: foreignTableRelation),
    );
    return _user!;
  }

  _i3.MealPlanTable get mealPlan {
    if (_mealPlan != null) return _mealPlan!;
    _mealPlan = _i1.createRelationTable(
      relationFieldName: 'mealPlan',
      field: FoodIntakeLog.t.mealPlanId,
      foreignField: _i3.MealPlan.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.MealPlanTable(tableRelation: foreignTableRelation),
    );
    return _mealPlan!;
  }

  _i4.FoodTable get food {
    if (_food != null) return _food!;
    _food = _i1.createRelationTable(
      relationFieldName: 'food',
      field: FoodIntakeLog.t.foodId,
      foreignField: _i4.Food.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.FoodTable(tableRelation: foreignTableRelation),
    );
    return _food!;
  }

  _i6.FoodServingSizeTable get servingSize {
    if (_servingSize != null) return _servingSize!;
    _servingSize = _i1.createRelationTable(
      relationFieldName: 'servingSize',
      field: FoodIntakeLog.t.servingSizeId,
      foreignField: _i6.FoodServingSize.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i6.FoodServingSizeTable(tableRelation: foreignTableRelation),
    );
    return _servingSize!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    mealPlanId,
    foodId,
    date,
    mealType,
    servingSizeId,
    servingQuantity,
    quantityGrams,
    consumedAt,
    notes,
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'user') {
      return user;
    }
    if (relationField == 'mealPlan') {
      return mealPlan;
    }
    if (relationField == 'food') {
      return food;
    }
    if (relationField == 'servingSize') {
      return servingSize;
    }
    return null;
  }
}

class FoodIntakeLogInclude extends _i1.IncludeObject {
  FoodIntakeLogInclude._({
    _i2.UserProfileInclude? user,
    _i3.MealPlanInclude? mealPlan,
    _i4.FoodInclude? food,
    _i6.FoodServingSizeInclude? servingSize,
  }) {
    _user = user;
    _mealPlan = mealPlan;
    _food = food;
    _servingSize = servingSize;
  }

  _i2.UserProfileInclude? _user;

  _i3.MealPlanInclude? _mealPlan;

  _i4.FoodInclude? _food;

  _i6.FoodServingSizeInclude? _servingSize;

  @override
  Map<String, _i1.Include?> get includes => {
    'user': _user,
    'mealPlan': _mealPlan,
    'food': _food,
    'servingSize': _servingSize,
  };

  @override
  _i1.Table<int?> get table => FoodIntakeLog.t;
}

class FoodIntakeLogIncludeList extends _i1.IncludeList {
  FoodIntakeLogIncludeList._({
    _i1.WhereExpressionBuilder<FoodIntakeLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FoodIntakeLog.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => FoodIntakeLog.t;
}

class FoodIntakeLogRepository {
  const FoodIntakeLogRepository._();

  final attachRow = const FoodIntakeLogAttachRowRepository._();

  final detachRow = const FoodIntakeLogDetachRowRepository._();

  /// Returns a list of [FoodIntakeLog]s matching the given query parameters.
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
  Future<List<FoodIntakeLog>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FoodIntakeLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FoodIntakeLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FoodIntakeLogTable>? orderByList,
    _i1.Transaction? transaction,
    FoodIntakeLogInclude? include,
  }) async {
    return session.db.find<FoodIntakeLog>(
      where: where?.call(FoodIntakeLog.t),
      orderBy: orderBy?.call(FoodIntakeLog.t),
      orderByList: orderByList?.call(FoodIntakeLog.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [FoodIntakeLog] matching the given query parameters.
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
  Future<FoodIntakeLog?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FoodIntakeLogTable>? where,
    int? offset,
    _i1.OrderByBuilder<FoodIntakeLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FoodIntakeLogTable>? orderByList,
    _i1.Transaction? transaction,
    FoodIntakeLogInclude? include,
  }) async {
    return session.db.findFirstRow<FoodIntakeLog>(
      where: where?.call(FoodIntakeLog.t),
      orderBy: orderBy?.call(FoodIntakeLog.t),
      orderByList: orderByList?.call(FoodIntakeLog.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [FoodIntakeLog] by its [id] or null if no such row exists.
  Future<FoodIntakeLog?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    FoodIntakeLogInclude? include,
  }) async {
    return session.db.findById<FoodIntakeLog>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [FoodIntakeLog]s in the list and returns the inserted rows.
  ///
  /// The returned [FoodIntakeLog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<FoodIntakeLog>> insert(
    _i1.Session session,
    List<FoodIntakeLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<FoodIntakeLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [FoodIntakeLog] and returns the inserted row.
  ///
  /// The returned [FoodIntakeLog] will have its `id` field set.
  Future<FoodIntakeLog> insertRow(
    _i1.Session session,
    FoodIntakeLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<FoodIntakeLog>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [FoodIntakeLog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<FoodIntakeLog>> update(
    _i1.Session session,
    List<FoodIntakeLog> rows, {
    _i1.ColumnSelections<FoodIntakeLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<FoodIntakeLog>(
      rows,
      columns: columns?.call(FoodIntakeLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FoodIntakeLog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FoodIntakeLog> updateRow(
    _i1.Session session,
    FoodIntakeLog row, {
    _i1.ColumnSelections<FoodIntakeLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<FoodIntakeLog>(
      row,
      columns: columns?.call(FoodIntakeLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FoodIntakeLog] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FoodIntakeLog?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<FoodIntakeLogUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<FoodIntakeLog>(
      id,
      columnValues: columnValues(FoodIntakeLog.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FoodIntakeLog]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<FoodIntakeLog>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<FoodIntakeLogUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<FoodIntakeLogTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FoodIntakeLogTable>? orderBy,
    _i1.OrderByListBuilder<FoodIntakeLogTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<FoodIntakeLog>(
      columnValues: columnValues(FoodIntakeLog.t.updateTable),
      where: where(FoodIntakeLog.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FoodIntakeLog.t),
      orderByList: orderByList?.call(FoodIntakeLog.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [FoodIntakeLog]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<FoodIntakeLog>> delete(
    _i1.Session session,
    List<FoodIntakeLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<FoodIntakeLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [FoodIntakeLog].
  Future<FoodIntakeLog> deleteRow(
    _i1.Session session,
    FoodIntakeLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FoodIntakeLog>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<FoodIntakeLog>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<FoodIntakeLogTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<FoodIntakeLog>(
      where: where(FoodIntakeLog.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FoodIntakeLogTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<FoodIntakeLog>(
      where: where?.call(FoodIntakeLog.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class FoodIntakeLogAttachRowRepository {
  const FoodIntakeLogAttachRowRepository._();

  /// Creates a relation between the given [FoodIntakeLog] and [UserProfile]
  /// by setting the [FoodIntakeLog]'s foreign key `userId` to refer to the [UserProfile].
  Future<void> user(
    _i1.Session session,
    FoodIntakeLog foodIntakeLog,
    _i2.UserProfile user, {
    _i1.Transaction? transaction,
  }) async {
    if (foodIntakeLog.id == null) {
      throw ArgumentError.notNull('foodIntakeLog.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $foodIntakeLog = foodIntakeLog.copyWith(userId: user.id);
    await session.db.updateRow<FoodIntakeLog>(
      $foodIntakeLog,
      columns: [FoodIntakeLog.t.userId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [FoodIntakeLog] and [MealPlan]
  /// by setting the [FoodIntakeLog]'s foreign key `mealPlanId` to refer to the [MealPlan].
  Future<void> mealPlan(
    _i1.Session session,
    FoodIntakeLog foodIntakeLog,
    _i3.MealPlan mealPlan, {
    _i1.Transaction? transaction,
  }) async {
    if (foodIntakeLog.id == null) {
      throw ArgumentError.notNull('foodIntakeLog.id');
    }
    if (mealPlan.id == null) {
      throw ArgumentError.notNull('mealPlan.id');
    }

    var $foodIntakeLog = foodIntakeLog.copyWith(mealPlanId: mealPlan.id);
    await session.db.updateRow<FoodIntakeLog>(
      $foodIntakeLog,
      columns: [FoodIntakeLog.t.mealPlanId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [FoodIntakeLog] and [Food]
  /// by setting the [FoodIntakeLog]'s foreign key `foodId` to refer to the [Food].
  Future<void> food(
    _i1.Session session,
    FoodIntakeLog foodIntakeLog,
    _i4.Food food, {
    _i1.Transaction? transaction,
  }) async {
    if (foodIntakeLog.id == null) {
      throw ArgumentError.notNull('foodIntakeLog.id');
    }
    if (food.id == null) {
      throw ArgumentError.notNull('food.id');
    }

    var $foodIntakeLog = foodIntakeLog.copyWith(foodId: food.id);
    await session.db.updateRow<FoodIntakeLog>(
      $foodIntakeLog,
      columns: [FoodIntakeLog.t.foodId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [FoodIntakeLog] and [FoodServingSize]
  /// by setting the [FoodIntakeLog]'s foreign key `servingSizeId` to refer to the [FoodServingSize].
  Future<void> servingSize(
    _i1.Session session,
    FoodIntakeLog foodIntakeLog,
    _i6.FoodServingSize servingSize, {
    _i1.Transaction? transaction,
  }) async {
    if (foodIntakeLog.id == null) {
      throw ArgumentError.notNull('foodIntakeLog.id');
    }
    if (servingSize.id == null) {
      throw ArgumentError.notNull('servingSize.id');
    }

    var $foodIntakeLog = foodIntakeLog.copyWith(servingSizeId: servingSize.id);
    await session.db.updateRow<FoodIntakeLog>(
      $foodIntakeLog,
      columns: [FoodIntakeLog.t.servingSizeId],
      transaction: transaction,
    );
  }
}

class FoodIntakeLogDetachRowRepository {
  const FoodIntakeLogDetachRowRepository._();

  /// Detaches the relation between this [FoodIntakeLog] and the [MealPlan] set in `mealPlan`
  /// by setting the [FoodIntakeLog]'s foreign key `mealPlanId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> mealPlan(
    _i1.Session session,
    FoodIntakeLog foodIntakeLog, {
    _i1.Transaction? transaction,
  }) async {
    if (foodIntakeLog.id == null) {
      throw ArgumentError.notNull('foodIntakeLog.id');
    }

    var $foodIntakeLog = foodIntakeLog.copyWith(mealPlanId: null);
    await session.db.updateRow<FoodIntakeLog>(
      $foodIntakeLog,
      columns: [FoodIntakeLog.t.mealPlanId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [FoodIntakeLog] and the [FoodServingSize] set in `servingSize`
  /// by setting the [FoodIntakeLog]'s foreign key `servingSizeId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> servingSize(
    _i1.Session session,
    FoodIntakeLog foodIntakeLog, {
    _i1.Transaction? transaction,
  }) async {
    if (foodIntakeLog.id == null) {
      throw ArgumentError.notNull('foodIntakeLog.id');
    }

    var $foodIntakeLog = foodIntakeLog.copyWith(servingSizeId: null);
    await session.db.updateRow<FoodIntakeLog>(
      $foodIntakeLog,
      columns: [FoodIntakeLog.t.servingSizeId],
      transaction: transaction,
    );
  }
}
