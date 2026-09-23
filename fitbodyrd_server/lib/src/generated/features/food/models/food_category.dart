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
import '../../../features/food/models/food_category.dart' as _i2;
import '../../../features/food/models/food.dart' as _i3;
import 'package:fitbodyrd_server/src/generated/protocol.dart' as _i4;

abstract class FoodCategory
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  FoodCategory._({
    this.id,
    required this.name,
    required this.slug,
    required this.iconName,
    this.parentCategoryId,
    this.parentCategory,
    this.subCategories,
    required this.colorHex,
    int? displayOrder,
    this.foods,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : displayOrder = displayOrder ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory FoodCategory({
    int? id,
    required String name,
    required String slug,
    required String iconName,
    int? parentCategoryId,
    _i2.FoodCategory? parentCategory,
    List<_i2.FoodCategory>? subCategories,
    required String colorHex,
    int? displayOrder,
    List<_i3.Food>? foods,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _FoodCategoryImpl;

  factory FoodCategory.fromJson(Map<String, dynamic> jsonSerialization) {
    return FoodCategory(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      slug: jsonSerialization['slug'] as String,
      iconName: jsonSerialization['iconName'] as String,
      parentCategoryId: jsonSerialization['parentCategoryId'] as int?,
      parentCategory: jsonSerialization['parentCategory'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.FoodCategory>(
              jsonSerialization['parentCategory'],
            ),
      subCategories: jsonSerialization['subCategories'] == null
          ? null
          : _i4.Protocol().deserialize<List<_i2.FoodCategory>>(
              jsonSerialization['subCategories'],
            ),
      colorHex: jsonSerialization['colorHex'] as String,
      displayOrder: jsonSerialization['displayOrder'] as int,
      foods: jsonSerialization['foods'] == null
          ? null
          : _i4.Protocol().deserialize<List<_i3.Food>>(
              jsonSerialization['foods'],
            ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = FoodCategoryTable();

  static const db = FoodCategoryRepository._();

  @override
  int? id;

  String name;

  String slug;

  String iconName;

  int? parentCategoryId;

  _i2.FoodCategory? parentCategory;

  List<_i2.FoodCategory>? subCategories;

  String colorHex;

  int displayOrder;

  List<_i3.Food>? foods;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [FoodCategory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FoodCategory copyWith({
    int? id,
    String? name,
    String? slug,
    String? iconName,
    int? parentCategoryId,
    _i2.FoodCategory? parentCategory,
    List<_i2.FoodCategory>? subCategories,
    String? colorHex,
    int? displayOrder,
    List<_i3.Food>? foods,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FoodCategory',
      if (id != null) 'id': id,
      'name': name,
      'slug': slug,
      'iconName': iconName,
      if (parentCategoryId != null) 'parentCategoryId': parentCategoryId,
      if (parentCategory != null) 'parentCategory': parentCategory?.toJson(),
      if (subCategories != null)
        'subCategories': subCategories?.toJson(valueToJson: (v) => v.toJson()),
      'colorHex': colorHex,
      'displayOrder': displayOrder,
      if (foods != null) 'foods': foods?.toJson(valueToJson: (v) => v.toJson()),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FoodCategory',
      if (id != null) 'id': id,
      'name': name,
      'slug': slug,
      'iconName': iconName,
      if (parentCategoryId != null) 'parentCategoryId': parentCategoryId,
      if (parentCategory != null)
        'parentCategory': parentCategory?.toJsonForProtocol(),
      if (subCategories != null)
        'subCategories': subCategories?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      'colorHex': colorHex,
      'displayOrder': displayOrder,
      if (foods != null)
        'foods': foods?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static FoodCategoryInclude include({
    _i2.FoodCategoryInclude? parentCategory,
    _i2.FoodCategoryIncludeList? subCategories,
    _i3.FoodIncludeList? foods,
  }) {
    return FoodCategoryInclude._(
      parentCategory: parentCategory,
      subCategories: subCategories,
      foods: foods,
    );
  }

  static FoodCategoryIncludeList includeList({
    _i1.WhereExpressionBuilder<FoodCategoryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FoodCategoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FoodCategoryTable>? orderByList,
    FoodCategoryInclude? include,
  }) {
    return FoodCategoryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FoodCategory.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(FoodCategory.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FoodCategoryImpl extends FoodCategory {
  _FoodCategoryImpl({
    int? id,
    required String name,
    required String slug,
    required String iconName,
    int? parentCategoryId,
    _i2.FoodCategory? parentCategory,
    List<_i2.FoodCategory>? subCategories,
    required String colorHex,
    int? displayOrder,
    List<_i3.Food>? foods,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         name: name,
         slug: slug,
         iconName: iconName,
         parentCategoryId: parentCategoryId,
         parentCategory: parentCategory,
         subCategories: subCategories,
         colorHex: colorHex,
         displayOrder: displayOrder,
         foods: foods,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [FoodCategory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FoodCategory copyWith({
    Object? id = _Undefined,
    String? name,
    String? slug,
    String? iconName,
    Object? parentCategoryId = _Undefined,
    Object? parentCategory = _Undefined,
    Object? subCategories = _Undefined,
    String? colorHex,
    int? displayOrder,
    Object? foods = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FoodCategory(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      iconName: iconName ?? this.iconName,
      parentCategoryId: parentCategoryId is int?
          ? parentCategoryId
          : this.parentCategoryId,
      parentCategory: parentCategory is _i2.FoodCategory?
          ? parentCategory
          : this.parentCategory?.copyWith(),
      subCategories: subCategories is List<_i2.FoodCategory>?
          ? subCategories
          : this.subCategories?.map((e0) => e0.copyWith()).toList(),
      colorHex: colorHex ?? this.colorHex,
      displayOrder: displayOrder ?? this.displayOrder,
      foods: foods is List<_i3.Food>?
          ? foods
          : this.foods?.map((e0) => e0.copyWith()).toList(),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class FoodCategoryUpdateTable extends _i1.UpdateTable<FoodCategoryTable> {
  FoodCategoryUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> slug(String value) => _i1.ColumnValue(
    table.slug,
    value,
  );

  _i1.ColumnValue<String, String> iconName(String value) => _i1.ColumnValue(
    table.iconName,
    value,
  );

  _i1.ColumnValue<int, int> parentCategoryId(int? value) => _i1.ColumnValue(
    table.parentCategoryId,
    value,
  );

  _i1.ColumnValue<String, String> colorHex(String value) => _i1.ColumnValue(
    table.colorHex,
    value,
  );

  _i1.ColumnValue<int, int> displayOrder(int value) => _i1.ColumnValue(
    table.displayOrder,
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

class FoodCategoryTable extends _i1.Table<int?> {
  FoodCategoryTable({super.tableRelation})
    : super(tableName: 'food_categories') {
    updateTable = FoodCategoryUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    slug = _i1.ColumnString(
      'slug',
      this,
    );
    iconName = _i1.ColumnString(
      'iconName',
      this,
    );
    parentCategoryId = _i1.ColumnInt(
      'parentCategoryId',
      this,
    );
    colorHex = _i1.ColumnString(
      'colorHex',
      this,
    );
    displayOrder = _i1.ColumnInt(
      'displayOrder',
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

  late final FoodCategoryUpdateTable updateTable;

  late final _i1.ColumnString name;

  late final _i1.ColumnString slug;

  late final _i1.ColumnString iconName;

  late final _i1.ColumnInt parentCategoryId;

  _i2.FoodCategoryTable? _parentCategory;

  _i2.FoodCategoryTable? ___subCategories;

  _i1.ManyRelation<_i2.FoodCategoryTable>? _subCategories;

  late final _i1.ColumnString colorHex;

  late final _i1.ColumnInt displayOrder;

  _i3.FoodTable? ___foods;

  _i1.ManyRelation<_i3.FoodTable>? _foods;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  _i2.FoodCategoryTable get parentCategory {
    if (_parentCategory != null) return _parentCategory!;
    _parentCategory = _i1.createRelationTable(
      relationFieldName: 'parentCategory',
      field: FoodCategory.t.parentCategoryId,
      foreignField: _i2.FoodCategory.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.FoodCategoryTable(tableRelation: foreignTableRelation),
    );
    return _parentCategory!;
  }

  _i2.FoodCategoryTable get __subCategories {
    if (___subCategories != null) return ___subCategories!;
    ___subCategories = _i1.createRelationTable(
      relationFieldName: '__subCategories',
      field: FoodCategory.t.id,
      foreignField: _i2.FoodCategory.t.parentCategoryId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.FoodCategoryTable(tableRelation: foreignTableRelation),
    );
    return ___subCategories!;
  }

  _i3.FoodTable get __foods {
    if (___foods != null) return ___foods!;
    ___foods = _i1.createRelationTable(
      relationFieldName: '__foods',
      field: FoodCategory.t.id,
      foreignField: _i3.Food.t.categoryId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.FoodTable(tableRelation: foreignTableRelation),
    );
    return ___foods!;
  }

  _i1.ManyRelation<_i2.FoodCategoryTable> get subCategories {
    if (_subCategories != null) return _subCategories!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'subCategories',
      field: FoodCategory.t.id,
      foreignField: _i2.FoodCategory.t.parentCategoryId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.FoodCategoryTable(tableRelation: foreignTableRelation),
    );
    _subCategories = _i1.ManyRelation<_i2.FoodCategoryTable>(
      tableWithRelations: relationTable,
      table: _i2.FoodCategoryTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _subCategories!;
  }

  _i1.ManyRelation<_i3.FoodTable> get foods {
    if (_foods != null) return _foods!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'foods',
      field: FoodCategory.t.id,
      foreignField: _i3.Food.t.categoryId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.FoodTable(tableRelation: foreignTableRelation),
    );
    _foods = _i1.ManyRelation<_i3.FoodTable>(
      tableWithRelations: relationTable,
      table: _i3.FoodTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _foods!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    name,
    slug,
    iconName,
    parentCategoryId,
    colorHex,
    displayOrder,
    createdAt,
    updatedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'parentCategory') {
      return parentCategory;
    }
    if (relationField == 'subCategories') {
      return __subCategories;
    }
    if (relationField == 'foods') {
      return __foods;
    }
    return null;
  }
}

class FoodCategoryInclude extends _i1.IncludeObject {
  FoodCategoryInclude._({
    _i2.FoodCategoryInclude? parentCategory,
    _i2.FoodCategoryIncludeList? subCategories,
    _i3.FoodIncludeList? foods,
  }) {
    _parentCategory = parentCategory;
    _subCategories = subCategories;
    _foods = foods;
  }

  _i2.FoodCategoryInclude? _parentCategory;

  _i2.FoodCategoryIncludeList? _subCategories;

  _i3.FoodIncludeList? _foods;

  @override
  Map<String, _i1.Include?> get includes => {
    'parentCategory': _parentCategory,
    'subCategories': _subCategories,
    'foods': _foods,
  };

  @override
  _i1.Table<int?> get table => FoodCategory.t;
}

class FoodCategoryIncludeList extends _i1.IncludeList {
  FoodCategoryIncludeList._({
    _i1.WhereExpressionBuilder<FoodCategoryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FoodCategory.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => FoodCategory.t;
}

class FoodCategoryRepository {
  const FoodCategoryRepository._();

  final attach = const FoodCategoryAttachRepository._();

  final attachRow = const FoodCategoryAttachRowRepository._();

  final detach = const FoodCategoryDetachRepository._();

  final detachRow = const FoodCategoryDetachRowRepository._();

  /// Returns a list of [FoodCategory]s matching the given query parameters.
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
  Future<List<FoodCategory>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FoodCategoryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FoodCategoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FoodCategoryTable>? orderByList,
    _i1.Transaction? transaction,
    FoodCategoryInclude? include,
  }) async {
    return session.db.find<FoodCategory>(
      where: where?.call(FoodCategory.t),
      orderBy: orderBy?.call(FoodCategory.t),
      orderByList: orderByList?.call(FoodCategory.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [FoodCategory] matching the given query parameters.
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
  Future<FoodCategory?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FoodCategoryTable>? where,
    int? offset,
    _i1.OrderByBuilder<FoodCategoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FoodCategoryTable>? orderByList,
    _i1.Transaction? transaction,
    FoodCategoryInclude? include,
  }) async {
    return session.db.findFirstRow<FoodCategory>(
      where: where?.call(FoodCategory.t),
      orderBy: orderBy?.call(FoodCategory.t),
      orderByList: orderByList?.call(FoodCategory.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [FoodCategory] by its [id] or null if no such row exists.
  Future<FoodCategory?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    FoodCategoryInclude? include,
  }) async {
    return session.db.findById<FoodCategory>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [FoodCategory]s in the list and returns the inserted rows.
  ///
  /// The returned [FoodCategory]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<FoodCategory>> insert(
    _i1.Session session,
    List<FoodCategory> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<FoodCategory>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [FoodCategory] and returns the inserted row.
  ///
  /// The returned [FoodCategory] will have its `id` field set.
  Future<FoodCategory> insertRow(
    _i1.Session session,
    FoodCategory row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<FoodCategory>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [FoodCategory]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<FoodCategory>> update(
    _i1.Session session,
    List<FoodCategory> rows, {
    _i1.ColumnSelections<FoodCategoryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<FoodCategory>(
      rows,
      columns: columns?.call(FoodCategory.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FoodCategory]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FoodCategory> updateRow(
    _i1.Session session,
    FoodCategory row, {
    _i1.ColumnSelections<FoodCategoryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<FoodCategory>(
      row,
      columns: columns?.call(FoodCategory.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FoodCategory] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FoodCategory?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<FoodCategoryUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<FoodCategory>(
      id,
      columnValues: columnValues(FoodCategory.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FoodCategory]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<FoodCategory>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<FoodCategoryUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<FoodCategoryTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FoodCategoryTable>? orderBy,
    _i1.OrderByListBuilder<FoodCategoryTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<FoodCategory>(
      columnValues: columnValues(FoodCategory.t.updateTable),
      where: where(FoodCategory.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FoodCategory.t),
      orderByList: orderByList?.call(FoodCategory.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [FoodCategory]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<FoodCategory>> delete(
    _i1.Session session,
    List<FoodCategory> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<FoodCategory>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [FoodCategory].
  Future<FoodCategory> deleteRow(
    _i1.Session session,
    FoodCategory row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FoodCategory>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<FoodCategory>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<FoodCategoryTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<FoodCategory>(
      where: where(FoodCategory.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FoodCategoryTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<FoodCategory>(
      where: where?.call(FoodCategory.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class FoodCategoryAttachRepository {
  const FoodCategoryAttachRepository._();

  /// Creates a relation between this [FoodCategory] and the given [FoodCategory]s
  /// by setting each [FoodCategory]'s foreign key `parentCategoryId` to refer to this [FoodCategory].
  Future<void> subCategories(
    _i1.Session session,
    FoodCategory foodCategory,
    List<_i2.FoodCategory> nestedFoodCategory, {
    _i1.Transaction? transaction,
  }) async {
    if (nestedFoodCategory.any((e) => e.id == null)) {
      throw ArgumentError.notNull('nestedFoodCategory.id');
    }
    if (foodCategory.id == null) {
      throw ArgumentError.notNull('foodCategory.id');
    }

    var $nestedFoodCategory = nestedFoodCategory
        .map((e) => e.copyWith(parentCategoryId: foodCategory.id))
        .toList();
    await session.db.update<_i2.FoodCategory>(
      $nestedFoodCategory,
      columns: [_i2.FoodCategory.t.parentCategoryId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [FoodCategory] and the given [Food]s
  /// by setting each [Food]'s foreign key `categoryId` to refer to this [FoodCategory].
  Future<void> foods(
    _i1.Session session,
    FoodCategory foodCategory,
    List<_i3.Food> food, {
    _i1.Transaction? transaction,
  }) async {
    if (food.any((e) => e.id == null)) {
      throw ArgumentError.notNull('food.id');
    }
    if (foodCategory.id == null) {
      throw ArgumentError.notNull('foodCategory.id');
    }

    var $food = food
        .map((e) => e.copyWith(categoryId: foodCategory.id))
        .toList();
    await session.db.update<_i3.Food>(
      $food,
      columns: [_i3.Food.t.categoryId],
      transaction: transaction,
    );
  }
}

class FoodCategoryAttachRowRepository {
  const FoodCategoryAttachRowRepository._();

  /// Creates a relation between the given [FoodCategory] and [FoodCategory]
  /// by setting the [FoodCategory]'s foreign key `parentCategoryId` to refer to the [FoodCategory].
  Future<void> parentCategory(
    _i1.Session session,
    FoodCategory foodCategory,
    _i2.FoodCategory parentCategory, {
    _i1.Transaction? transaction,
  }) async {
    if (foodCategory.id == null) {
      throw ArgumentError.notNull('foodCategory.id');
    }
    if (parentCategory.id == null) {
      throw ArgumentError.notNull('parentCategory.id');
    }

    var $foodCategory = foodCategory.copyWith(
      parentCategoryId: parentCategory.id,
    );
    await session.db.updateRow<FoodCategory>(
      $foodCategory,
      columns: [FoodCategory.t.parentCategoryId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [FoodCategory] and the given [FoodCategory]
  /// by setting the [FoodCategory]'s foreign key `parentCategoryId` to refer to this [FoodCategory].
  Future<void> subCategories(
    _i1.Session session,
    FoodCategory foodCategory,
    _i2.FoodCategory nestedFoodCategory, {
    _i1.Transaction? transaction,
  }) async {
    if (nestedFoodCategory.id == null) {
      throw ArgumentError.notNull('nestedFoodCategory.id');
    }
    if (foodCategory.id == null) {
      throw ArgumentError.notNull('foodCategory.id');
    }

    var $nestedFoodCategory = nestedFoodCategory.copyWith(
      parentCategoryId: foodCategory.id,
    );
    await session.db.updateRow<_i2.FoodCategory>(
      $nestedFoodCategory,
      columns: [_i2.FoodCategory.t.parentCategoryId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [FoodCategory] and the given [Food]
  /// by setting the [Food]'s foreign key `categoryId` to refer to this [FoodCategory].
  Future<void> foods(
    _i1.Session session,
    FoodCategory foodCategory,
    _i3.Food food, {
    _i1.Transaction? transaction,
  }) async {
    if (food.id == null) {
      throw ArgumentError.notNull('food.id');
    }
    if (foodCategory.id == null) {
      throw ArgumentError.notNull('foodCategory.id');
    }

    var $food = food.copyWith(categoryId: foodCategory.id);
    await session.db.updateRow<_i3.Food>(
      $food,
      columns: [_i3.Food.t.categoryId],
      transaction: transaction,
    );
  }
}

class FoodCategoryDetachRepository {
  const FoodCategoryDetachRepository._();

  /// Detaches the relation between this [FoodCategory] and the given [FoodCategory]
  /// by setting the [FoodCategory]'s foreign key `parentCategoryId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> subCategories(
    _i1.Session session,
    List<_i2.FoodCategory> foodCategory, {
    _i1.Transaction? transaction,
  }) async {
    if (foodCategory.any((e) => e.id == null)) {
      throw ArgumentError.notNull('foodCategory.id');
    }

    var $foodCategory = foodCategory
        .map((e) => e.copyWith(parentCategoryId: null))
        .toList();
    await session.db.update<_i2.FoodCategory>(
      $foodCategory,
      columns: [_i2.FoodCategory.t.parentCategoryId],
      transaction: transaction,
    );
  }
}

class FoodCategoryDetachRowRepository {
  const FoodCategoryDetachRowRepository._();

  /// Detaches the relation between this [FoodCategory] and the [FoodCategory] set in `parentCategory`
  /// by setting the [FoodCategory]'s foreign key `parentCategoryId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> parentCategory(
    _i1.Session session,
    FoodCategory foodCategory, {
    _i1.Transaction? transaction,
  }) async {
    if (foodCategory.id == null) {
      throw ArgumentError.notNull('foodCategory.id');
    }

    var $foodCategory = foodCategory.copyWith(parentCategoryId: null);
    await session.db.updateRow<FoodCategory>(
      $foodCategory,
      columns: [FoodCategory.t.parentCategoryId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [FoodCategory] and the given [FoodCategory]
  /// by setting the [FoodCategory]'s foreign key `parentCategoryId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> subCategories(
    _i1.Session session,
    _i2.FoodCategory foodCategory, {
    _i1.Transaction? transaction,
  }) async {
    if (foodCategory.id == null) {
      throw ArgumentError.notNull('foodCategory.id');
    }

    var $foodCategory = foodCategory.copyWith(parentCategoryId: null);
    await session.db.updateRow<_i2.FoodCategory>(
      $foodCategory,
      columns: [_i2.FoodCategory.t.parentCategoryId],
      transaction: transaction,
    );
  }
}
