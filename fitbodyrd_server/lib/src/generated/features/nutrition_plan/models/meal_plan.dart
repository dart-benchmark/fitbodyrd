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
import '../../../features/nutrition_plan/models/nutrition_plan.dart' as _i2;
import '../../../features/nutrition_plan/models/meal_type.dart' as _i3;
import '../../../features/nutrition_plan/models/meal_plan_food.dart' as _i4;
import 'package:fitbodyrd_server/src/generated/protocol.dart' as _i5;

abstract class MealPlan
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  MealPlan._({
    this.id,
    required this.nutritionPlanId,
    this.nutritionPlan,
    required this.date,
    required this.dayNumber,
    required this.mealType,
    required this.targetCalories,
    required this.targetProteins,
    required this.targetCarbs,
    required this.targetFats,
    this.notes,
    this.mealPlanFoods,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory MealPlan({
    int? id,
    required int nutritionPlanId,
    _i2.NutritionPlan? nutritionPlan,
    required DateTime date,
    required int dayNumber,
    required _i3.MealPlanType mealType,
    required double targetCalories,
    required double targetProteins,
    required double targetCarbs,
    required double targetFats,
    String? notes,
    List<_i4.MealPlanFood>? mealPlanFoods,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _MealPlanImpl;

  factory MealPlan.fromJson(Map<String, dynamic> jsonSerialization) {
    return MealPlan(
      id: jsonSerialization['id'] as int?,
      nutritionPlanId: jsonSerialization['nutritionPlanId'] as int,
      nutritionPlan: jsonSerialization['nutritionPlan'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.NutritionPlan>(
              jsonSerialization['nutritionPlan'],
            ),
      date: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      dayNumber: jsonSerialization['dayNumber'] as int,
      mealType: _i3.MealPlanType.fromJson(
        (jsonSerialization['mealType'] as String),
      ),
      targetCalories: (jsonSerialization['targetCalories'] as num).toDouble(),
      targetProteins: (jsonSerialization['targetProteins'] as num).toDouble(),
      targetCarbs: (jsonSerialization['targetCarbs'] as num).toDouble(),
      targetFats: (jsonSerialization['targetFats'] as num).toDouble(),
      notes: jsonSerialization['notes'] as String?,
      mealPlanFoods: jsonSerialization['mealPlanFoods'] == null
          ? null
          : _i5.Protocol().deserialize<List<_i4.MealPlanFood>>(
              jsonSerialization['mealPlanFoods'],
            ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = MealPlanTable();

  static const db = MealPlanRepository._();

  @override
  int? id;

  int nutritionPlanId;

  _i2.NutritionPlan? nutritionPlan;

  DateTime date;

  int dayNumber;

  _i3.MealPlanType mealType;

  double targetCalories;

  double targetProteins;

  double targetCarbs;

  double targetFats;

  String? notes;

  List<_i4.MealPlanFood>? mealPlanFoods;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [MealPlan]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MealPlan copyWith({
    int? id,
    int? nutritionPlanId,
    _i2.NutritionPlan? nutritionPlan,
    DateTime? date,
    int? dayNumber,
    _i3.MealPlanType? mealType,
    double? targetCalories,
    double? targetProteins,
    double? targetCarbs,
    double? targetFats,
    String? notes,
    List<_i4.MealPlanFood>? mealPlanFoods,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MealPlan',
      if (id != null) 'id': id,
      'nutritionPlanId': nutritionPlanId,
      if (nutritionPlan != null) 'nutritionPlan': nutritionPlan?.toJson(),
      'date': date.toJson(),
      'dayNumber': dayNumber,
      'mealType': mealType.toJson(),
      'targetCalories': targetCalories,
      'targetProteins': targetProteins,
      'targetCarbs': targetCarbs,
      'targetFats': targetFats,
      if (notes != null) 'notes': notes,
      if (mealPlanFoods != null)
        'mealPlanFoods': mealPlanFoods?.toJson(valueToJson: (v) => v.toJson()),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MealPlan',
      if (id != null) 'id': id,
      'nutritionPlanId': nutritionPlanId,
      if (nutritionPlan != null)
        'nutritionPlan': nutritionPlan?.toJsonForProtocol(),
      'date': date.toJson(),
      'dayNumber': dayNumber,
      'mealType': mealType.toJson(),
      'targetCalories': targetCalories,
      'targetProteins': targetProteins,
      'targetCarbs': targetCarbs,
      'targetFats': targetFats,
      if (notes != null) 'notes': notes,
      if (mealPlanFoods != null)
        'mealPlanFoods': mealPlanFoods?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static MealPlanInclude include({
    _i2.NutritionPlanInclude? nutritionPlan,
    _i4.MealPlanFoodIncludeList? mealPlanFoods,
  }) {
    return MealPlanInclude._(
      nutritionPlan: nutritionPlan,
      mealPlanFoods: mealPlanFoods,
    );
  }

  static MealPlanIncludeList includeList({
    _i1.WhereExpressionBuilder<MealPlanTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MealPlanTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MealPlanTable>? orderByList,
    MealPlanInclude? include,
  }) {
    return MealPlanIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MealPlan.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(MealPlan.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MealPlanImpl extends MealPlan {
  _MealPlanImpl({
    int? id,
    required int nutritionPlanId,
    _i2.NutritionPlan? nutritionPlan,
    required DateTime date,
    required int dayNumber,
    required _i3.MealPlanType mealType,
    required double targetCalories,
    required double targetProteins,
    required double targetCarbs,
    required double targetFats,
    String? notes,
    List<_i4.MealPlanFood>? mealPlanFoods,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         nutritionPlanId: nutritionPlanId,
         nutritionPlan: nutritionPlan,
         date: date,
         dayNumber: dayNumber,
         mealType: mealType,
         targetCalories: targetCalories,
         targetProteins: targetProteins,
         targetCarbs: targetCarbs,
         targetFats: targetFats,
         notes: notes,
         mealPlanFoods: mealPlanFoods,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [MealPlan]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MealPlan copyWith({
    Object? id = _Undefined,
    int? nutritionPlanId,
    Object? nutritionPlan = _Undefined,
    DateTime? date,
    int? dayNumber,
    _i3.MealPlanType? mealType,
    double? targetCalories,
    double? targetProteins,
    double? targetCarbs,
    double? targetFats,
    Object? notes = _Undefined,
    Object? mealPlanFoods = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MealPlan(
      id: id is int? ? id : this.id,
      nutritionPlanId: nutritionPlanId ?? this.nutritionPlanId,
      nutritionPlan: nutritionPlan is _i2.NutritionPlan?
          ? nutritionPlan
          : this.nutritionPlan?.copyWith(),
      date: date ?? this.date,
      dayNumber: dayNumber ?? this.dayNumber,
      mealType: mealType ?? this.mealType,
      targetCalories: targetCalories ?? this.targetCalories,
      targetProteins: targetProteins ?? this.targetProteins,
      targetCarbs: targetCarbs ?? this.targetCarbs,
      targetFats: targetFats ?? this.targetFats,
      notes: notes is String? ? notes : this.notes,
      mealPlanFoods: mealPlanFoods is List<_i4.MealPlanFood>?
          ? mealPlanFoods
          : this.mealPlanFoods?.map((e0) => e0.copyWith()).toList(),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class MealPlanUpdateTable extends _i1.UpdateTable<MealPlanTable> {
  MealPlanUpdateTable(super.table);

  _i1.ColumnValue<int, int> nutritionPlanId(int value) => _i1.ColumnValue(
    table.nutritionPlanId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> date(DateTime value) => _i1.ColumnValue(
    table.date,
    value,
  );

  _i1.ColumnValue<int, int> dayNumber(int value) => _i1.ColumnValue(
    table.dayNumber,
    value,
  );

  _i1.ColumnValue<_i3.MealPlanType, _i3.MealPlanType> mealType(
    _i3.MealPlanType value,
  ) => _i1.ColumnValue(
    table.mealType,
    value,
  );

  _i1.ColumnValue<double, double> targetCalories(double value) =>
      _i1.ColumnValue(
        table.targetCalories,
        value,
      );

  _i1.ColumnValue<double, double> targetProteins(double value) =>
      _i1.ColumnValue(
        table.targetProteins,
        value,
      );

  _i1.ColumnValue<double, double> targetCarbs(double value) => _i1.ColumnValue(
    table.targetCarbs,
    value,
  );

  _i1.ColumnValue<double, double> targetFats(double value) => _i1.ColumnValue(
    table.targetFats,
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

class MealPlanTable extends _i1.Table<int?> {
  MealPlanTable({super.tableRelation}) : super(tableName: 'meal_plans') {
    updateTable = MealPlanUpdateTable(this);
    nutritionPlanId = _i1.ColumnInt(
      'nutritionPlanId',
      this,
    );
    date = _i1.ColumnDateTime(
      'date',
      this,
    );
    dayNumber = _i1.ColumnInt(
      'dayNumber',
      this,
    );
    mealType = _i1.ColumnEnum(
      'mealType',
      this,
      _i1.EnumSerialization.byName,
    );
    targetCalories = _i1.ColumnDouble(
      'targetCalories',
      this,
    );
    targetProteins = _i1.ColumnDouble(
      'targetProteins',
      this,
    );
    targetCarbs = _i1.ColumnDouble(
      'targetCarbs',
      this,
    );
    targetFats = _i1.ColumnDouble(
      'targetFats',
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
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
  }

  late final MealPlanUpdateTable updateTable;

  late final _i1.ColumnInt nutritionPlanId;

  _i2.NutritionPlanTable? _nutritionPlan;

  late final _i1.ColumnDateTime date;

  late final _i1.ColumnInt dayNumber;

  late final _i1.ColumnEnum<_i3.MealPlanType> mealType;

  late final _i1.ColumnDouble targetCalories;

  late final _i1.ColumnDouble targetProteins;

  late final _i1.ColumnDouble targetCarbs;

  late final _i1.ColumnDouble targetFats;

  late final _i1.ColumnString notes;

  _i4.MealPlanFoodTable? ___mealPlanFoods;

  _i1.ManyRelation<_i4.MealPlanFoodTable>? _mealPlanFoods;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  _i2.NutritionPlanTable get nutritionPlan {
    if (_nutritionPlan != null) return _nutritionPlan!;
    _nutritionPlan = _i1.createRelationTable(
      relationFieldName: 'nutritionPlan',
      field: MealPlan.t.nutritionPlanId,
      foreignField: _i2.NutritionPlan.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.NutritionPlanTable(tableRelation: foreignTableRelation),
    );
    return _nutritionPlan!;
  }

  _i4.MealPlanFoodTable get __mealPlanFoods {
    if (___mealPlanFoods != null) return ___mealPlanFoods!;
    ___mealPlanFoods = _i1.createRelationTable(
      relationFieldName: '__mealPlanFoods',
      field: MealPlan.t.id,
      foreignField: _i4.MealPlanFood.t.mealPlanId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.MealPlanFoodTable(tableRelation: foreignTableRelation),
    );
    return ___mealPlanFoods!;
  }

  _i1.ManyRelation<_i4.MealPlanFoodTable> get mealPlanFoods {
    if (_mealPlanFoods != null) return _mealPlanFoods!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'mealPlanFoods',
      field: MealPlan.t.id,
      foreignField: _i4.MealPlanFood.t.mealPlanId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.MealPlanFoodTable(tableRelation: foreignTableRelation),
    );
    _mealPlanFoods = _i1.ManyRelation<_i4.MealPlanFoodTable>(
      tableWithRelations: relationTable,
      table: _i4.MealPlanFoodTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _mealPlanFoods!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    nutritionPlanId,
    date,
    dayNumber,
    mealType,
    targetCalories,
    targetProteins,
    targetCarbs,
    targetFats,
    notes,
    createdAt,
    updatedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'nutritionPlan') {
      return nutritionPlan;
    }
    if (relationField == 'mealPlanFoods') {
      return __mealPlanFoods;
    }
    return null;
  }
}

class MealPlanInclude extends _i1.IncludeObject {
  MealPlanInclude._({
    _i2.NutritionPlanInclude? nutritionPlan,
    _i4.MealPlanFoodIncludeList? mealPlanFoods,
  }) {
    _nutritionPlan = nutritionPlan;
    _mealPlanFoods = mealPlanFoods;
  }

  _i2.NutritionPlanInclude? _nutritionPlan;

  _i4.MealPlanFoodIncludeList? _mealPlanFoods;

  @override
  Map<String, _i1.Include?> get includes => {
    'nutritionPlan': _nutritionPlan,
    'mealPlanFoods': _mealPlanFoods,
  };

  @override
  _i1.Table<int?> get table => MealPlan.t;
}

class MealPlanIncludeList extends _i1.IncludeList {
  MealPlanIncludeList._({
    _i1.WhereExpressionBuilder<MealPlanTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MealPlan.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => MealPlan.t;
}

class MealPlanRepository {
  const MealPlanRepository._();

  final attach = const MealPlanAttachRepository._();

  final attachRow = const MealPlanAttachRowRepository._();

  final detach = const MealPlanDetachRepository._();

  final detachRow = const MealPlanDetachRowRepository._();

  /// Returns a list of [MealPlan]s matching the given query parameters.
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
  Future<List<MealPlan>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MealPlanTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MealPlanTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MealPlanTable>? orderByList,
    _i1.Transaction? transaction,
    MealPlanInclude? include,
  }) async {
    return session.db.find<MealPlan>(
      where: where?.call(MealPlan.t),
      orderBy: orderBy?.call(MealPlan.t),
      orderByList: orderByList?.call(MealPlan.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [MealPlan] matching the given query parameters.
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
  Future<MealPlan?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MealPlanTable>? where,
    int? offset,
    _i1.OrderByBuilder<MealPlanTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MealPlanTable>? orderByList,
    _i1.Transaction? transaction,
    MealPlanInclude? include,
  }) async {
    return session.db.findFirstRow<MealPlan>(
      where: where?.call(MealPlan.t),
      orderBy: orderBy?.call(MealPlan.t),
      orderByList: orderByList?.call(MealPlan.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [MealPlan] by its [id] or null if no such row exists.
  Future<MealPlan?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    MealPlanInclude? include,
  }) async {
    return session.db.findById<MealPlan>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [MealPlan]s in the list and returns the inserted rows.
  ///
  /// The returned [MealPlan]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<MealPlan>> insert(
    _i1.Session session,
    List<MealPlan> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<MealPlan>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [MealPlan] and returns the inserted row.
  ///
  /// The returned [MealPlan] will have its `id` field set.
  Future<MealPlan> insertRow(
    _i1.Session session,
    MealPlan row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<MealPlan>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [MealPlan]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<MealPlan>> update(
    _i1.Session session,
    List<MealPlan> rows, {
    _i1.ColumnSelections<MealPlanTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<MealPlan>(
      rows,
      columns: columns?.call(MealPlan.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MealPlan]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MealPlan> updateRow(
    _i1.Session session,
    MealPlan row, {
    _i1.ColumnSelections<MealPlanTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<MealPlan>(
      row,
      columns: columns?.call(MealPlan.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MealPlan] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<MealPlan?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<MealPlanUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<MealPlan>(
      id,
      columnValues: columnValues(MealPlan.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [MealPlan]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<MealPlan>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<MealPlanUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<MealPlanTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MealPlanTable>? orderBy,
    _i1.OrderByListBuilder<MealPlanTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<MealPlan>(
      columnValues: columnValues(MealPlan.t.updateTable),
      where: where(MealPlan.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MealPlan.t),
      orderByList: orderByList?.call(MealPlan.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [MealPlan]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<MealPlan>> delete(
    _i1.Session session,
    List<MealPlan> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<MealPlan>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [MealPlan].
  Future<MealPlan> deleteRow(
    _i1.Session session,
    MealPlan row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MealPlan>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<MealPlan>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<MealPlanTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<MealPlan>(
      where: where(MealPlan.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MealPlanTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<MealPlan>(
      where: where?.call(MealPlan.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class MealPlanAttachRepository {
  const MealPlanAttachRepository._();

  /// Creates a relation between this [MealPlan] and the given [MealPlanFood]s
  /// by setting each [MealPlanFood]'s foreign key `mealPlanId` to refer to this [MealPlan].
  Future<void> mealPlanFoods(
    _i1.Session session,
    MealPlan mealPlan,
    List<_i4.MealPlanFood> mealPlanFood, {
    _i1.Transaction? transaction,
  }) async {
    if (mealPlanFood.any((e) => e.id == null)) {
      throw ArgumentError.notNull('mealPlanFood.id');
    }
    if (mealPlan.id == null) {
      throw ArgumentError.notNull('mealPlan.id');
    }

    var $mealPlanFood = mealPlanFood
        .map((e) => e.copyWith(mealPlanId: mealPlan.id))
        .toList();
    await session.db.update<_i4.MealPlanFood>(
      $mealPlanFood,
      columns: [_i4.MealPlanFood.t.mealPlanId],
      transaction: transaction,
    );
  }
}

class MealPlanAttachRowRepository {
  const MealPlanAttachRowRepository._();

  /// Creates a relation between the given [MealPlan] and [NutritionPlan]
  /// by setting the [MealPlan]'s foreign key `nutritionPlanId` to refer to the [NutritionPlan].
  Future<void> nutritionPlan(
    _i1.Session session,
    MealPlan mealPlan,
    _i2.NutritionPlan nutritionPlan, {
    _i1.Transaction? transaction,
  }) async {
    if (mealPlan.id == null) {
      throw ArgumentError.notNull('mealPlan.id');
    }
    if (nutritionPlan.id == null) {
      throw ArgumentError.notNull('nutritionPlan.id');
    }

    var $mealPlan = mealPlan.copyWith(nutritionPlanId: nutritionPlan.id);
    await session.db.updateRow<MealPlan>(
      $mealPlan,
      columns: [MealPlan.t.nutritionPlanId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [MealPlan] and the given [MealPlanFood]
  /// by setting the [MealPlanFood]'s foreign key `mealPlanId` to refer to this [MealPlan].
  Future<void> mealPlanFoods(
    _i1.Session session,
    MealPlan mealPlan,
    _i4.MealPlanFood mealPlanFood, {
    _i1.Transaction? transaction,
  }) async {
    if (mealPlanFood.id == null) {
      throw ArgumentError.notNull('mealPlanFood.id');
    }
    if (mealPlan.id == null) {
      throw ArgumentError.notNull('mealPlan.id');
    }

    var $mealPlanFood = mealPlanFood.copyWith(mealPlanId: mealPlan.id);
    await session.db.updateRow<_i4.MealPlanFood>(
      $mealPlanFood,
      columns: [_i4.MealPlanFood.t.mealPlanId],
      transaction: transaction,
    );
  }
}

class MealPlanDetachRepository {
  const MealPlanDetachRepository._();

  /// Detaches the relation between this [MealPlan] and the given [MealPlanFood]
  /// by setting the [MealPlanFood]'s foreign key `mealPlanId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> mealPlanFoods(
    _i1.Session session,
    List<_i4.MealPlanFood> mealPlanFood, {
    _i1.Transaction? transaction,
  }) async {
    if (mealPlanFood.any((e) => e.id == null)) {
      throw ArgumentError.notNull('mealPlanFood.id');
    }

    var $mealPlanFood = mealPlanFood
        .map((e) => e.copyWith(mealPlanId: null))
        .toList();
    await session.db.update<_i4.MealPlanFood>(
      $mealPlanFood,
      columns: [_i4.MealPlanFood.t.mealPlanId],
      transaction: transaction,
    );
  }
}

class MealPlanDetachRowRepository {
  const MealPlanDetachRowRepository._();

  /// Detaches the relation between this [MealPlan] and the given [MealPlanFood]
  /// by setting the [MealPlanFood]'s foreign key `mealPlanId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> mealPlanFoods(
    _i1.Session session,
    _i4.MealPlanFood mealPlanFood, {
    _i1.Transaction? transaction,
  }) async {
    if (mealPlanFood.id == null) {
      throw ArgumentError.notNull('mealPlanFood.id');
    }

    var $mealPlanFood = mealPlanFood.copyWith(mealPlanId: null);
    await session.db.updateRow<_i4.MealPlanFood>(
      $mealPlanFood,
      columns: [_i4.MealPlanFood.t.mealPlanId],
      transaction: transaction,
    );
  }
}
