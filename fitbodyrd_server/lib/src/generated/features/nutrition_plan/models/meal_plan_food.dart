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
import '../../../features/nutrition_plan/models/meal_plan.dart' as _i2;
import '../../../features/food/models/food.dart' as _i3;
import '../../../features/food/models/food_serving_size.dart' as _i4;
import '../../../features/user/models/app_user.dart' as _i5;
import 'package:fitbodyrd_server/src/generated/protocol.dart' as _i6;

abstract class MealPlanFood
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  MealPlanFood._({
    this.id,
    required this.mealPlanId,
    this.mealPlan,
    required this.foodId,
    this.food,
    required this.servingSizeId,
    this.servingSize,
    required this.servingQuantity,
    required this.quantityGrams,
    bool? isUserModified,
    bool? wasUserDeleted,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.deletedAt,
    this.deletedById,
    this.deletedBy,
  }) : isUserModified = isUserModified ?? false,
       wasUserDeleted = wasUserDeleted ?? false,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory MealPlanFood({
    int? id,
    required int mealPlanId,
    _i2.MealPlan? mealPlan,
    required int foodId,
    _i3.Food? food,
    required int servingSizeId,
    _i4.FoodServingSize? servingSize,
    required double servingQuantity,
    required double quantityGrams,
    bool? isUserModified,
    bool? wasUserDeleted,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    int? deletedById,
    _i5.UserProfile? deletedBy,
  }) = _MealPlanFoodImpl;

  factory MealPlanFood.fromJson(Map<String, dynamic> jsonSerialization) {
    return MealPlanFood(
      id: jsonSerialization['id'] as int?,
      mealPlanId: jsonSerialization['mealPlanId'] as int,
      mealPlan: jsonSerialization['mealPlan'] == null
          ? null
          : _i6.Protocol().deserialize<_i2.MealPlan>(
              jsonSerialization['mealPlan'],
            ),
      foodId: jsonSerialization['foodId'] as int,
      food: jsonSerialization['food'] == null
          ? null
          : _i6.Protocol().deserialize<_i3.Food>(jsonSerialization['food']),
      servingSizeId: jsonSerialization['servingSizeId'] as int,
      servingSize: jsonSerialization['servingSize'] == null
          ? null
          : _i6.Protocol().deserialize<_i4.FoodServingSize>(
              jsonSerialization['servingSize'],
            ),
      servingQuantity: (jsonSerialization['servingQuantity'] as num).toDouble(),
      quantityGrams: (jsonSerialization['quantityGrams'] as num).toDouble(),
      isUserModified: jsonSerialization['isUserModified'] as bool,
      wasUserDeleted: jsonSerialization['wasUserDeleted'] as bool,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
      deletedAt: jsonSerialization['deletedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['deletedAt']),
      deletedById: jsonSerialization['deletedById'] as int?,
      deletedBy: jsonSerialization['deletedBy'] == null
          ? null
          : _i6.Protocol().deserialize<_i5.UserProfile>(
              jsonSerialization['deletedBy'],
            ),
    );
  }

  static final t = MealPlanFoodTable();

  static const db = MealPlanFoodRepository._();

  @override
  int? id;

  int mealPlanId;

  _i2.MealPlan? mealPlan;

  int foodId;

  _i3.Food? food;

  int servingSizeId;

  _i4.FoodServingSize? servingSize;

  double servingQuantity;

  double quantityGrams;

  bool isUserModified;

  bool wasUserDeleted;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? deletedAt;

  int? deletedById;

  _i5.UserProfile? deletedBy;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [MealPlanFood]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MealPlanFood copyWith({
    int? id,
    int? mealPlanId,
    _i2.MealPlan? mealPlan,
    int? foodId,
    _i3.Food? food,
    int? servingSizeId,
    _i4.FoodServingSize? servingSize,
    double? servingQuantity,
    double? quantityGrams,
    bool? isUserModified,
    bool? wasUserDeleted,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    int? deletedById,
    _i5.UserProfile? deletedBy,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MealPlanFood',
      if (id != null) 'id': id,
      'mealPlanId': mealPlanId,
      if (mealPlan != null) 'mealPlan': mealPlan?.toJson(),
      'foodId': foodId,
      if (food != null) 'food': food?.toJson(),
      'servingSizeId': servingSizeId,
      if (servingSize != null) 'servingSize': servingSize?.toJson(),
      'servingQuantity': servingQuantity,
      'quantityGrams': quantityGrams,
      'isUserModified': isUserModified,
      'wasUserDeleted': wasUserDeleted,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
      if (deletedById != null) 'deletedById': deletedById,
      if (deletedBy != null) 'deletedBy': deletedBy?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MealPlanFood',
      if (id != null) 'id': id,
      'mealPlanId': mealPlanId,
      if (mealPlan != null) 'mealPlan': mealPlan?.toJsonForProtocol(),
      'foodId': foodId,
      if (food != null) 'food': food?.toJsonForProtocol(),
      'servingSizeId': servingSizeId,
      if (servingSize != null) 'servingSize': servingSize?.toJsonForProtocol(),
      'servingQuantity': servingQuantity,
      'quantityGrams': quantityGrams,
      'isUserModified': isUserModified,
      'wasUserDeleted': wasUserDeleted,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
      if (deletedById != null) 'deletedById': deletedById,
      if (deletedBy != null) 'deletedBy': deletedBy?.toJsonForProtocol(),
    };
  }

  static MealPlanFoodInclude include({
    _i2.MealPlanInclude? mealPlan,
    _i3.FoodInclude? food,
    _i4.FoodServingSizeInclude? servingSize,
    _i5.UserProfileInclude? deletedBy,
  }) {
    return MealPlanFoodInclude._(
      mealPlan: mealPlan,
      food: food,
      servingSize: servingSize,
      deletedBy: deletedBy,
    );
  }

  static MealPlanFoodIncludeList includeList({
    _i1.WhereExpressionBuilder<MealPlanFoodTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MealPlanFoodTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MealPlanFoodTable>? orderByList,
    MealPlanFoodInclude? include,
  }) {
    return MealPlanFoodIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MealPlanFood.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(MealPlanFood.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MealPlanFoodImpl extends MealPlanFood {
  _MealPlanFoodImpl({
    int? id,
    required int mealPlanId,
    _i2.MealPlan? mealPlan,
    required int foodId,
    _i3.Food? food,
    required int servingSizeId,
    _i4.FoodServingSize? servingSize,
    required double servingQuantity,
    required double quantityGrams,
    bool? isUserModified,
    bool? wasUserDeleted,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    int? deletedById,
    _i5.UserProfile? deletedBy,
  }) : super._(
         id: id,
         mealPlanId: mealPlanId,
         mealPlan: mealPlan,
         foodId: foodId,
         food: food,
         servingSizeId: servingSizeId,
         servingSize: servingSize,
         servingQuantity: servingQuantity,
         quantityGrams: quantityGrams,
         isUserModified: isUserModified,
         wasUserDeleted: wasUserDeleted,
         createdAt: createdAt,
         updatedAt: updatedAt,
         deletedAt: deletedAt,
         deletedById: deletedById,
         deletedBy: deletedBy,
       );

  /// Returns a shallow copy of this [MealPlanFood]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MealPlanFood copyWith({
    Object? id = _Undefined,
    int? mealPlanId,
    Object? mealPlan = _Undefined,
    int? foodId,
    Object? food = _Undefined,
    int? servingSizeId,
    Object? servingSize = _Undefined,
    double? servingQuantity,
    double? quantityGrams,
    bool? isUserModified,
    bool? wasUserDeleted,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? deletedAt = _Undefined,
    Object? deletedById = _Undefined,
    Object? deletedBy = _Undefined,
  }) {
    return MealPlanFood(
      id: id is int? ? id : this.id,
      mealPlanId: mealPlanId ?? this.mealPlanId,
      mealPlan: mealPlan is _i2.MealPlan?
          ? mealPlan
          : this.mealPlan?.copyWith(),
      foodId: foodId ?? this.foodId,
      food: food is _i3.Food? ? food : this.food?.copyWith(),
      servingSizeId: servingSizeId ?? this.servingSizeId,
      servingSize: servingSize is _i4.FoodServingSize?
          ? servingSize
          : this.servingSize?.copyWith(),
      servingQuantity: servingQuantity ?? this.servingQuantity,
      quantityGrams: quantityGrams ?? this.quantityGrams,
      isUserModified: isUserModified ?? this.isUserModified,
      wasUserDeleted: wasUserDeleted ?? this.wasUserDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
      deletedById: deletedById is int? ? deletedById : this.deletedById,
      deletedBy: deletedBy is _i5.UserProfile?
          ? deletedBy
          : this.deletedBy?.copyWith(),
    );
  }
}

class MealPlanFoodUpdateTable extends _i1.UpdateTable<MealPlanFoodTable> {
  MealPlanFoodUpdateTable(super.table);

  _i1.ColumnValue<int, int> mealPlanId(int value) => _i1.ColumnValue(
    table.mealPlanId,
    value,
  );

  _i1.ColumnValue<int, int> foodId(int value) => _i1.ColumnValue(
    table.foodId,
    value,
  );

  _i1.ColumnValue<int, int> servingSizeId(int value) => _i1.ColumnValue(
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

  _i1.ColumnValue<bool, bool> isUserModified(bool value) => _i1.ColumnValue(
    table.isUserModified,
    value,
  );

  _i1.ColumnValue<bool, bool> wasUserDeleted(bool value) => _i1.ColumnValue(
    table.wasUserDeleted,
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

  _i1.ColumnValue<DateTime, DateTime> deletedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.deletedAt,
        value,
      );

  _i1.ColumnValue<int, int> deletedById(int? value) => _i1.ColumnValue(
    table.deletedById,
    value,
  );
}

class MealPlanFoodTable extends _i1.Table<int?> {
  MealPlanFoodTable({super.tableRelation})
    : super(tableName: 'meal_plan_foods') {
    updateTable = MealPlanFoodUpdateTable(this);
    mealPlanId = _i1.ColumnInt(
      'mealPlanId',
      this,
    );
    foodId = _i1.ColumnInt(
      'foodId',
      this,
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
    isUserModified = _i1.ColumnBool(
      'isUserModified',
      this,
      hasDefault: true,
    );
    wasUserDeleted = _i1.ColumnBool(
      'wasUserDeleted',
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
    deletedAt = _i1.ColumnDateTime(
      'deletedAt',
      this,
    );
    deletedById = _i1.ColumnInt(
      'deletedById',
      this,
    );
  }

  late final MealPlanFoodUpdateTable updateTable;

  late final _i1.ColumnInt mealPlanId;

  _i2.MealPlanTable? _mealPlan;

  late final _i1.ColumnInt foodId;

  _i3.FoodTable? _food;

  late final _i1.ColumnInt servingSizeId;

  _i4.FoodServingSizeTable? _servingSize;

  late final _i1.ColumnDouble servingQuantity;

  late final _i1.ColumnDouble quantityGrams;

  late final _i1.ColumnBool isUserModified;

  late final _i1.ColumnBool wasUserDeleted;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnDateTime deletedAt;

  late final _i1.ColumnInt deletedById;

  _i5.UserProfileTable? _deletedBy;

  _i2.MealPlanTable get mealPlan {
    if (_mealPlan != null) return _mealPlan!;
    _mealPlan = _i1.createRelationTable(
      relationFieldName: 'mealPlan',
      field: MealPlanFood.t.mealPlanId,
      foreignField: _i2.MealPlan.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.MealPlanTable(tableRelation: foreignTableRelation),
    );
    return _mealPlan!;
  }

  _i3.FoodTable get food {
    if (_food != null) return _food!;
    _food = _i1.createRelationTable(
      relationFieldName: 'food',
      field: MealPlanFood.t.foodId,
      foreignField: _i3.Food.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.FoodTable(tableRelation: foreignTableRelation),
    );
    return _food!;
  }

  _i4.FoodServingSizeTable get servingSize {
    if (_servingSize != null) return _servingSize!;
    _servingSize = _i1.createRelationTable(
      relationFieldName: 'servingSize',
      field: MealPlanFood.t.servingSizeId,
      foreignField: _i4.FoodServingSize.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.FoodServingSizeTable(tableRelation: foreignTableRelation),
    );
    return _servingSize!;
  }

  _i5.UserProfileTable get deletedBy {
    if (_deletedBy != null) return _deletedBy!;
    _deletedBy = _i1.createRelationTable(
      relationFieldName: 'deletedBy',
      field: MealPlanFood.t.deletedById,
      foreignField: _i5.UserProfile.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.UserProfileTable(tableRelation: foreignTableRelation),
    );
    return _deletedBy!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    mealPlanId,
    foodId,
    servingSizeId,
    servingQuantity,
    quantityGrams,
    isUserModified,
    wasUserDeleted,
    createdAt,
    updatedAt,
    deletedAt,
    deletedById,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'mealPlan') {
      return mealPlan;
    }
    if (relationField == 'food') {
      return food;
    }
    if (relationField == 'servingSize') {
      return servingSize;
    }
    if (relationField == 'deletedBy') {
      return deletedBy;
    }
    return null;
  }
}

class MealPlanFoodInclude extends _i1.IncludeObject {
  MealPlanFoodInclude._({
    _i2.MealPlanInclude? mealPlan,
    _i3.FoodInclude? food,
    _i4.FoodServingSizeInclude? servingSize,
    _i5.UserProfileInclude? deletedBy,
  }) {
    _mealPlan = mealPlan;
    _food = food;
    _servingSize = servingSize;
    _deletedBy = deletedBy;
  }

  _i2.MealPlanInclude? _mealPlan;

  _i3.FoodInclude? _food;

  _i4.FoodServingSizeInclude? _servingSize;

  _i5.UserProfileInclude? _deletedBy;

  @override
  Map<String, _i1.Include?> get includes => {
    'mealPlan': _mealPlan,
    'food': _food,
    'servingSize': _servingSize,
    'deletedBy': _deletedBy,
  };

  @override
  _i1.Table<int?> get table => MealPlanFood.t;
}

class MealPlanFoodIncludeList extends _i1.IncludeList {
  MealPlanFoodIncludeList._({
    _i1.WhereExpressionBuilder<MealPlanFoodTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MealPlanFood.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => MealPlanFood.t;
}

class MealPlanFoodRepository {
  const MealPlanFoodRepository._();

  final attachRow = const MealPlanFoodAttachRowRepository._();

  final detachRow = const MealPlanFoodDetachRowRepository._();

  /// Returns a list of [MealPlanFood]s matching the given query parameters.
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
  Future<List<MealPlanFood>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MealPlanFoodTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MealPlanFoodTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MealPlanFoodTable>? orderByList,
    _i1.Transaction? transaction,
    MealPlanFoodInclude? include,
  }) async {
    return session.db.find<MealPlanFood>(
      where: where?.call(MealPlanFood.t),
      orderBy: orderBy?.call(MealPlanFood.t),
      orderByList: orderByList?.call(MealPlanFood.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [MealPlanFood] matching the given query parameters.
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
  Future<MealPlanFood?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MealPlanFoodTable>? where,
    int? offset,
    _i1.OrderByBuilder<MealPlanFoodTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MealPlanFoodTable>? orderByList,
    _i1.Transaction? transaction,
    MealPlanFoodInclude? include,
  }) async {
    return session.db.findFirstRow<MealPlanFood>(
      where: where?.call(MealPlanFood.t),
      orderBy: orderBy?.call(MealPlanFood.t),
      orderByList: orderByList?.call(MealPlanFood.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [MealPlanFood] by its [id] or null if no such row exists.
  Future<MealPlanFood?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    MealPlanFoodInclude? include,
  }) async {
    return session.db.findById<MealPlanFood>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [MealPlanFood]s in the list and returns the inserted rows.
  ///
  /// The returned [MealPlanFood]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<MealPlanFood>> insert(
    _i1.Session session,
    List<MealPlanFood> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<MealPlanFood>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [MealPlanFood] and returns the inserted row.
  ///
  /// The returned [MealPlanFood] will have its `id` field set.
  Future<MealPlanFood> insertRow(
    _i1.Session session,
    MealPlanFood row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<MealPlanFood>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [MealPlanFood]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<MealPlanFood>> update(
    _i1.Session session,
    List<MealPlanFood> rows, {
    _i1.ColumnSelections<MealPlanFoodTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<MealPlanFood>(
      rows,
      columns: columns?.call(MealPlanFood.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MealPlanFood]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MealPlanFood> updateRow(
    _i1.Session session,
    MealPlanFood row, {
    _i1.ColumnSelections<MealPlanFoodTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<MealPlanFood>(
      row,
      columns: columns?.call(MealPlanFood.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MealPlanFood] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<MealPlanFood?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<MealPlanFoodUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<MealPlanFood>(
      id,
      columnValues: columnValues(MealPlanFood.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [MealPlanFood]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<MealPlanFood>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<MealPlanFoodUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<MealPlanFoodTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MealPlanFoodTable>? orderBy,
    _i1.OrderByListBuilder<MealPlanFoodTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<MealPlanFood>(
      columnValues: columnValues(MealPlanFood.t.updateTable),
      where: where(MealPlanFood.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MealPlanFood.t),
      orderByList: orderByList?.call(MealPlanFood.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [MealPlanFood]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<MealPlanFood>> delete(
    _i1.Session session,
    List<MealPlanFood> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<MealPlanFood>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [MealPlanFood].
  Future<MealPlanFood> deleteRow(
    _i1.Session session,
    MealPlanFood row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MealPlanFood>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<MealPlanFood>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<MealPlanFoodTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<MealPlanFood>(
      where: where(MealPlanFood.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MealPlanFoodTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<MealPlanFood>(
      where: where?.call(MealPlanFood.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class MealPlanFoodAttachRowRepository {
  const MealPlanFoodAttachRowRepository._();

  /// Creates a relation between the given [MealPlanFood] and [MealPlan]
  /// by setting the [MealPlanFood]'s foreign key `mealPlanId` to refer to the [MealPlan].
  Future<void> mealPlan(
    _i1.Session session,
    MealPlanFood mealPlanFood,
    _i2.MealPlan mealPlan, {
    _i1.Transaction? transaction,
  }) async {
    if (mealPlanFood.id == null) {
      throw ArgumentError.notNull('mealPlanFood.id');
    }
    if (mealPlan.id == null) {
      throw ArgumentError.notNull('mealPlan.id');
    }

    var $mealPlanFood = mealPlanFood.copyWith(mealPlanId: mealPlan.id);
    await session.db.updateRow<MealPlanFood>(
      $mealPlanFood,
      columns: [MealPlanFood.t.mealPlanId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [MealPlanFood] and [Food]
  /// by setting the [MealPlanFood]'s foreign key `foodId` to refer to the [Food].
  Future<void> food(
    _i1.Session session,
    MealPlanFood mealPlanFood,
    _i3.Food food, {
    _i1.Transaction? transaction,
  }) async {
    if (mealPlanFood.id == null) {
      throw ArgumentError.notNull('mealPlanFood.id');
    }
    if (food.id == null) {
      throw ArgumentError.notNull('food.id');
    }

    var $mealPlanFood = mealPlanFood.copyWith(foodId: food.id);
    await session.db.updateRow<MealPlanFood>(
      $mealPlanFood,
      columns: [MealPlanFood.t.foodId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [MealPlanFood] and [FoodServingSize]
  /// by setting the [MealPlanFood]'s foreign key `servingSizeId` to refer to the [FoodServingSize].
  Future<void> servingSize(
    _i1.Session session,
    MealPlanFood mealPlanFood,
    _i4.FoodServingSize servingSize, {
    _i1.Transaction? transaction,
  }) async {
    if (mealPlanFood.id == null) {
      throw ArgumentError.notNull('mealPlanFood.id');
    }
    if (servingSize.id == null) {
      throw ArgumentError.notNull('servingSize.id');
    }

    var $mealPlanFood = mealPlanFood.copyWith(servingSizeId: servingSize.id);
    await session.db.updateRow<MealPlanFood>(
      $mealPlanFood,
      columns: [MealPlanFood.t.servingSizeId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [MealPlanFood] and [UserProfile]
  /// by setting the [MealPlanFood]'s foreign key `deletedById` to refer to the [UserProfile].
  Future<void> deletedBy(
    _i1.Session session,
    MealPlanFood mealPlanFood,
    _i5.UserProfile deletedBy, {
    _i1.Transaction? transaction,
  }) async {
    if (mealPlanFood.id == null) {
      throw ArgumentError.notNull('mealPlanFood.id');
    }
    if (deletedBy.id == null) {
      throw ArgumentError.notNull('deletedBy.id');
    }

    var $mealPlanFood = mealPlanFood.copyWith(deletedById: deletedBy.id);
    await session.db.updateRow<MealPlanFood>(
      $mealPlanFood,
      columns: [MealPlanFood.t.deletedById],
      transaction: transaction,
    );
  }
}

class MealPlanFoodDetachRowRepository {
  const MealPlanFoodDetachRowRepository._();

  /// Detaches the relation between this [MealPlanFood] and the [UserProfile] set in `deletedBy`
  /// by setting the [MealPlanFood]'s foreign key `deletedById` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> deletedBy(
    _i1.Session session,
    MealPlanFood mealPlanFood, {
    _i1.Transaction? transaction,
  }) async {
    if (mealPlanFood.id == null) {
      throw ArgumentError.notNull('mealPlanFood.id');
    }

    var $mealPlanFood = mealPlanFood.copyWith(deletedById: null);
    await session.db.updateRow<MealPlanFood>(
      $mealPlanFood,
      columns: [MealPlanFood.t.deletedById],
      transaction: transaction,
    );
  }
}
