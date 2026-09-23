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

abstract class FoodServingSize
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  FoodServingSize._({
    this.id,
    required this.foodId,
    this.food,
    required this.name,
    required this.grams,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : isDefault = isDefault ?? false,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory FoodServingSize({
    int? id,
    required int foodId,
    _i2.Food? food,
    required String name,
    required double grams,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _FoodServingSizeImpl;

  factory FoodServingSize.fromJson(Map<String, dynamic> jsonSerialization) {
    return FoodServingSize(
      id: jsonSerialization['id'] as int?,
      foodId: jsonSerialization['foodId'] as int,
      food: jsonSerialization['food'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Food>(jsonSerialization['food']),
      name: jsonSerialization['name'] as String,
      grams: (jsonSerialization['grams'] as num).toDouble(),
      isDefault: jsonSerialization['isDefault'] as bool,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = FoodServingSizeTable();

  static const db = FoodServingSizeRepository._();

  @override
  int? id;

  int foodId;

  _i2.Food? food;

  String name;

  double grams;

  bool isDefault;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [FoodServingSize]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FoodServingSize copyWith({
    int? id,
    int? foodId,
    _i2.Food? food,
    String? name,
    double? grams,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FoodServingSize',
      if (id != null) 'id': id,
      'foodId': foodId,
      if (food != null) 'food': food?.toJson(),
      'name': name,
      'grams': grams,
      'isDefault': isDefault,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FoodServingSize',
      if (id != null) 'id': id,
      'foodId': foodId,
      if (food != null) 'food': food?.toJsonForProtocol(),
      'name': name,
      'grams': grams,
      'isDefault': isDefault,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static FoodServingSizeInclude include({_i2.FoodInclude? food}) {
    return FoodServingSizeInclude._(food: food);
  }

  static FoodServingSizeIncludeList includeList({
    _i1.WhereExpressionBuilder<FoodServingSizeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FoodServingSizeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FoodServingSizeTable>? orderByList,
    FoodServingSizeInclude? include,
  }) {
    return FoodServingSizeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FoodServingSize.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(FoodServingSize.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FoodServingSizeImpl extends FoodServingSize {
  _FoodServingSizeImpl({
    int? id,
    required int foodId,
    _i2.Food? food,
    required String name,
    required double grams,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         foodId: foodId,
         food: food,
         name: name,
         grams: grams,
         isDefault: isDefault,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [FoodServingSize]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FoodServingSize copyWith({
    Object? id = _Undefined,
    int? foodId,
    Object? food = _Undefined,
    String? name,
    double? grams,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FoodServingSize(
      id: id is int? ? id : this.id,
      foodId: foodId ?? this.foodId,
      food: food is _i2.Food? ? food : this.food?.copyWith(),
      name: name ?? this.name,
      grams: grams ?? this.grams,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class FoodServingSizeUpdateTable extends _i1.UpdateTable<FoodServingSizeTable> {
  FoodServingSizeUpdateTable(super.table);

  _i1.ColumnValue<int, int> foodId(int value) => _i1.ColumnValue(
    table.foodId,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<double, double> grams(double value) => _i1.ColumnValue(
    table.grams,
    value,
  );

  _i1.ColumnValue<bool, bool> isDefault(bool value) => _i1.ColumnValue(
    table.isDefault,
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

class FoodServingSizeTable extends _i1.Table<int?> {
  FoodServingSizeTable({super.tableRelation})
    : super(tableName: 'food_serving_sizes') {
    updateTable = FoodServingSizeUpdateTable(this);
    foodId = _i1.ColumnInt(
      'foodId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    grams = _i1.ColumnDouble(
      'grams',
      this,
    );
    isDefault = _i1.ColumnBool(
      'isDefault',
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

  late final FoodServingSizeUpdateTable updateTable;

  late final _i1.ColumnInt foodId;

  _i2.FoodTable? _food;

  late final _i1.ColumnString name;

  late final _i1.ColumnDouble grams;

  late final _i1.ColumnBool isDefault;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  _i2.FoodTable get food {
    if (_food != null) return _food!;
    _food = _i1.createRelationTable(
      relationFieldName: 'food',
      field: FoodServingSize.t.foodId,
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
    grams,
    isDefault,
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

class FoodServingSizeInclude extends _i1.IncludeObject {
  FoodServingSizeInclude._({_i2.FoodInclude? food}) {
    _food = food;
  }

  _i2.FoodInclude? _food;

  @override
  Map<String, _i1.Include?> get includes => {'food': _food};

  @override
  _i1.Table<int?> get table => FoodServingSize.t;
}

class FoodServingSizeIncludeList extends _i1.IncludeList {
  FoodServingSizeIncludeList._({
    _i1.WhereExpressionBuilder<FoodServingSizeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FoodServingSize.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => FoodServingSize.t;
}

class FoodServingSizeRepository {
  const FoodServingSizeRepository._();

  final attachRow = const FoodServingSizeAttachRowRepository._();

  /// Returns a list of [FoodServingSize]s matching the given query parameters.
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
  Future<List<FoodServingSize>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FoodServingSizeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FoodServingSizeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FoodServingSizeTable>? orderByList,
    _i1.Transaction? transaction,
    FoodServingSizeInclude? include,
  }) async {
    return session.db.find<FoodServingSize>(
      where: where?.call(FoodServingSize.t),
      orderBy: orderBy?.call(FoodServingSize.t),
      orderByList: orderByList?.call(FoodServingSize.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [FoodServingSize] matching the given query parameters.
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
  Future<FoodServingSize?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FoodServingSizeTable>? where,
    int? offset,
    _i1.OrderByBuilder<FoodServingSizeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FoodServingSizeTable>? orderByList,
    _i1.Transaction? transaction,
    FoodServingSizeInclude? include,
  }) async {
    return session.db.findFirstRow<FoodServingSize>(
      where: where?.call(FoodServingSize.t),
      orderBy: orderBy?.call(FoodServingSize.t),
      orderByList: orderByList?.call(FoodServingSize.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [FoodServingSize] by its [id] or null if no such row exists.
  Future<FoodServingSize?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    FoodServingSizeInclude? include,
  }) async {
    return session.db.findById<FoodServingSize>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [FoodServingSize]s in the list and returns the inserted rows.
  ///
  /// The returned [FoodServingSize]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<FoodServingSize>> insert(
    _i1.Session session,
    List<FoodServingSize> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<FoodServingSize>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [FoodServingSize] and returns the inserted row.
  ///
  /// The returned [FoodServingSize] will have its `id` field set.
  Future<FoodServingSize> insertRow(
    _i1.Session session,
    FoodServingSize row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<FoodServingSize>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [FoodServingSize]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<FoodServingSize>> update(
    _i1.Session session,
    List<FoodServingSize> rows, {
    _i1.ColumnSelections<FoodServingSizeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<FoodServingSize>(
      rows,
      columns: columns?.call(FoodServingSize.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FoodServingSize]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FoodServingSize> updateRow(
    _i1.Session session,
    FoodServingSize row, {
    _i1.ColumnSelections<FoodServingSizeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<FoodServingSize>(
      row,
      columns: columns?.call(FoodServingSize.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FoodServingSize] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FoodServingSize?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<FoodServingSizeUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<FoodServingSize>(
      id,
      columnValues: columnValues(FoodServingSize.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FoodServingSize]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<FoodServingSize>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<FoodServingSizeUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<FoodServingSizeTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FoodServingSizeTable>? orderBy,
    _i1.OrderByListBuilder<FoodServingSizeTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<FoodServingSize>(
      columnValues: columnValues(FoodServingSize.t.updateTable),
      where: where(FoodServingSize.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FoodServingSize.t),
      orderByList: orderByList?.call(FoodServingSize.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [FoodServingSize]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<FoodServingSize>> delete(
    _i1.Session session,
    List<FoodServingSize> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<FoodServingSize>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [FoodServingSize].
  Future<FoodServingSize> deleteRow(
    _i1.Session session,
    FoodServingSize row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FoodServingSize>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<FoodServingSize>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<FoodServingSizeTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<FoodServingSize>(
      where: where(FoodServingSize.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FoodServingSizeTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<FoodServingSize>(
      where: where?.call(FoodServingSize.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class FoodServingSizeAttachRowRepository {
  const FoodServingSizeAttachRowRepository._();

  /// Creates a relation between the given [FoodServingSize] and [Food]
  /// by setting the [FoodServingSize]'s foreign key `foodId` to refer to the [Food].
  Future<void> food(
    _i1.Session session,
    FoodServingSize foodServingSize,
    _i2.Food food, {
    _i1.Transaction? transaction,
  }) async {
    if (foodServingSize.id == null) {
      throw ArgumentError.notNull('foodServingSize.id');
    }
    if (food.id == null) {
      throw ArgumentError.notNull('food.id');
    }

    var $foodServingSize = foodServingSize.copyWith(foodId: food.id);
    await session.db.updateRow<FoodServingSize>(
      $foodServingSize,
      columns: [FoodServingSize.t.foodId],
      transaction: transaction,
    );
  }
}
