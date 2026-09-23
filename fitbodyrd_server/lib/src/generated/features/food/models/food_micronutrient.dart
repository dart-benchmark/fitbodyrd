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
import '../../../features/food/models/food.dart' as _i2;
import 'package:fitbodyrd_server/src/generated/protocol.dart' as _i3;

abstract class FoodMicronutrient
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  FoodMicronutrient._({
    this.id,
    required this.foodId,
    this.food,
    required this.name,
    required this.amount,
    required this.unit,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory FoodMicronutrient({
    int? id,
    required int foodId,
    _i2.Food? food,
    required String name,
    required double amount,
    required String unit,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _FoodMicronutrientImpl;

  factory FoodMicronutrient.fromJson(Map<String, dynamic> jsonSerialization) {
    return FoodMicronutrient(
      id: jsonSerialization['id'] as int?,
      foodId: jsonSerialization['foodId'] as int,
      food: jsonSerialization['food'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Food>(jsonSerialization['food']),
      name: jsonSerialization['name'] as String,
      amount: (jsonSerialization['amount'] as num).toDouble(),
      unit: jsonSerialization['unit'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = FoodMicronutrientTable();

  static const db = FoodMicronutrientRepository._();

  @override
  int? id;

  int foodId;

  /// The food item associated with these micronutrients.
  _i2.Food? food;

  String name;

  double amount;

  String unit;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [FoodMicronutrient]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FoodMicronutrient copyWith({
    int? id,
    int? foodId,
    _i2.Food? food,
    String? name,
    double? amount,
    String? unit,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FoodMicronutrient',
      if (id != null) 'id': id,
      'foodId': foodId,
      if (food != null) 'food': food?.toJson(),
      'name': name,
      'amount': amount,
      'unit': unit,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FoodMicronutrient',
      if (id != null) 'id': id,
      'foodId': foodId,
      if (food != null) 'food': food?.toJsonForProtocol(),
      'name': name,
      'amount': amount,
      'unit': unit,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static FoodMicronutrientInclude include({_i2.FoodInclude? food}) {
    return FoodMicronutrientInclude._(food: food);
  }

  static FoodMicronutrientIncludeList includeList({
    _i1.WhereExpressionBuilder<FoodMicronutrientTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FoodMicronutrientTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FoodMicronutrientTable>? orderByList,
    FoodMicronutrientInclude? include,
  }) {
    return FoodMicronutrientIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FoodMicronutrient.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(FoodMicronutrient.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FoodMicronutrientImpl extends FoodMicronutrient {
  _FoodMicronutrientImpl({
    int? id,
    required int foodId,
    _i2.Food? food,
    required String name,
    required double amount,
    required String unit,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         foodId: foodId,
         food: food,
         name: name,
         amount: amount,
         unit: unit,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [FoodMicronutrient]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FoodMicronutrient copyWith({
    Object? id = _Undefined,
    int? foodId,
    Object? food = _Undefined,
    String? name,
    double? amount,
    String? unit,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FoodMicronutrient(
      id: id is int? ? id : this.id,
      foodId: foodId ?? this.foodId,
      food: food is _i2.Food? ? food : this.food?.copyWith(),
      name: name ?? this.name,
      amount: amount ?? this.amount,
      unit: unit ?? this.unit,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class FoodMicronutrientUpdateTable
    extends _i1.UpdateTable<FoodMicronutrientTable> {
  FoodMicronutrientUpdateTable(super.table);

  _i1.ColumnValue<int, int> foodId(int value) => _i1.ColumnValue(
    table.foodId,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<double, double> amount(double value) => _i1.ColumnValue(
    table.amount,
    value,
  );

  _i1.ColumnValue<String, String> unit(String value) => _i1.ColumnValue(
    table.unit,
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

class FoodMicronutrientTable extends _i1.Table<int?> {
  FoodMicronutrientTable({super.tableRelation})
    : super(tableName: 'food_micronutrients') {
    updateTable = FoodMicronutrientUpdateTable(this);
    foodId = _i1.ColumnInt(
      'foodId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    amount = _i1.ColumnDouble(
      'amount',
      this,
    );
    unit = _i1.ColumnString(
      'unit',
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

  late final FoodMicronutrientUpdateTable updateTable;

  late final _i1.ColumnInt foodId;

  /// The food item associated with these micronutrients.
  _i2.FoodTable? _food;

  late final _i1.ColumnString name;

  late final _i1.ColumnDouble amount;

  late final _i1.ColumnString unit;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  _i2.FoodTable get food {
    if (_food != null) return _food!;
    _food = _i1.createRelationTable(
      relationFieldName: 'food',
      field: FoodMicronutrient.t.foodId,
      foreignField: _i2.Food.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.FoodTable(tableRelation: foreignTableRelation),
    );
    return _food!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    foodId,
    name,
    amount,
    unit,
    createdAt,
    updatedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'food') {
      return food;
    }
    return null;
  }
}

class FoodMicronutrientInclude extends _i1.IncludeObject {
  FoodMicronutrientInclude._({_i2.FoodInclude? food}) {
    _food = food;
  }

  _i2.FoodInclude? _food;

  @override
  Map<String, _i1.Include?> get includes => {'food': _food};

  @override
  _i1.Table<int?> get table => FoodMicronutrient.t;
}

class FoodMicronutrientIncludeList extends _i1.IncludeList {
  FoodMicronutrientIncludeList._({
    _i1.WhereExpressionBuilder<FoodMicronutrientTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FoodMicronutrient.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => FoodMicronutrient.t;
}

class FoodMicronutrientRepository {
  const FoodMicronutrientRepository._();

  final attachRow = const FoodMicronutrientAttachRowRepository._();

  /// Returns a list of [FoodMicronutrient]s matching the given query parameters.
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
  Future<List<FoodMicronutrient>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FoodMicronutrientTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FoodMicronutrientTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FoodMicronutrientTable>? orderByList,
    _i1.Transaction? transaction,
    FoodMicronutrientInclude? include,
  }) async {
    return session.db.find<FoodMicronutrient>(
      where: where?.call(FoodMicronutrient.t),
      orderBy: orderBy?.call(FoodMicronutrient.t),
      orderByList: orderByList?.call(FoodMicronutrient.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [FoodMicronutrient] matching the given query parameters.
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
  Future<FoodMicronutrient?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FoodMicronutrientTable>? where,
    int? offset,
    _i1.OrderByBuilder<FoodMicronutrientTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FoodMicronutrientTable>? orderByList,
    _i1.Transaction? transaction,
    FoodMicronutrientInclude? include,
  }) async {
    return session.db.findFirstRow<FoodMicronutrient>(
      where: where?.call(FoodMicronutrient.t),
      orderBy: orderBy?.call(FoodMicronutrient.t),
      orderByList: orderByList?.call(FoodMicronutrient.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [FoodMicronutrient] by its [id] or null if no such row exists.
  Future<FoodMicronutrient?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    FoodMicronutrientInclude? include,
  }) async {
    return session.db.findById<FoodMicronutrient>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [FoodMicronutrient]s in the list and returns the inserted rows.
  ///
  /// The returned [FoodMicronutrient]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<FoodMicronutrient>> insert(
    _i1.Session session,
    List<FoodMicronutrient> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<FoodMicronutrient>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [FoodMicronutrient] and returns the inserted row.
  ///
  /// The returned [FoodMicronutrient] will have its `id` field set.
  Future<FoodMicronutrient> insertRow(
    _i1.Session session,
    FoodMicronutrient row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<FoodMicronutrient>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [FoodMicronutrient]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<FoodMicronutrient>> update(
    _i1.Session session,
    List<FoodMicronutrient> rows, {
    _i1.ColumnSelections<FoodMicronutrientTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<FoodMicronutrient>(
      rows,
      columns: columns?.call(FoodMicronutrient.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FoodMicronutrient]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FoodMicronutrient> updateRow(
    _i1.Session session,
    FoodMicronutrient row, {
    _i1.ColumnSelections<FoodMicronutrientTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<FoodMicronutrient>(
      row,
      columns: columns?.call(FoodMicronutrient.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FoodMicronutrient] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FoodMicronutrient?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<FoodMicronutrientUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<FoodMicronutrient>(
      id,
      columnValues: columnValues(FoodMicronutrient.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FoodMicronutrient]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<FoodMicronutrient>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<FoodMicronutrientUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<FoodMicronutrientTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FoodMicronutrientTable>? orderBy,
    _i1.OrderByListBuilder<FoodMicronutrientTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<FoodMicronutrient>(
      columnValues: columnValues(FoodMicronutrient.t.updateTable),
      where: where(FoodMicronutrient.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FoodMicronutrient.t),
      orderByList: orderByList?.call(FoodMicronutrient.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [FoodMicronutrient]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<FoodMicronutrient>> delete(
    _i1.Session session,
    List<FoodMicronutrient> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<FoodMicronutrient>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [FoodMicronutrient].
  Future<FoodMicronutrient> deleteRow(
    _i1.Session session,
    FoodMicronutrient row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FoodMicronutrient>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<FoodMicronutrient>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<FoodMicronutrientTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<FoodMicronutrient>(
      where: where(FoodMicronutrient.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FoodMicronutrientTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<FoodMicronutrient>(
      where: where?.call(FoodMicronutrient.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class FoodMicronutrientAttachRowRepository {
  const FoodMicronutrientAttachRowRepository._();

  /// Creates a relation between the given [FoodMicronutrient] and [Food]
  /// by setting the [FoodMicronutrient]'s foreign key `foodId` to refer to the [Food].
  Future<void> food(
    _i1.Session session,
    FoodMicronutrient foodMicronutrient,
    _i2.Food food, {
    _i1.Transaction? transaction,
  }) async {
    if (foodMicronutrient.id == null) {
      throw ArgumentError.notNull('foodMicronutrient.id');
    }
    if (food.id == null) {
      throw ArgumentError.notNull('food.id');
    }

    var $foodMicronutrient = foodMicronutrient.copyWith(foodId: food.id);
    await session.db.updateRow<FoodMicronutrient>(
      $foodMicronutrient,
      columns: [FoodMicronutrient.t.foodId],
      transaction: transaction,
    );
  }
}
