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
import '../../../features/user/models/app_user.dart' as _i3;
import '../../../features/food/models/food_micronutrient.dart' as _i4;
import '../../../features/food/models/food_serving_size.dart' as _i5;
import 'package:fitbodyrd_server/src/generated/protocol.dart' as _i6;

abstract class Food implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Food._({
    this.id,
    required this.name,
    required this.categoryId,
    this.category,
    required this.calories,
    required this.proteins,
    required this.carbs,
    required this.fats,
    required this.fiber,
    bool? isActive,
    bool? isLocal,
    this.imageUrl,
    this.brand,
    this.barcode,
    bool? isCustom,
    this.createdByUserIdId,
    this.createdByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.micronutrients,
    this.servingSizes,
  }) : isActive = isActive ?? true,
       isLocal = isLocal ?? true,
       isCustom = isCustom ?? false,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Food({
    int? id,
    required String name,
    required int categoryId,
    _i2.FoodCategory? category,
    required double calories,
    required double proteins,
    required double carbs,
    required double fats,
    required double fiber,
    bool? isActive,
    bool? isLocal,
    String? imageUrl,
    String? brand,
    String? barcode,
    bool? isCustom,
    int? createdByUserIdId,
    _i3.UserProfile? createdByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<_i4.FoodMicronutrient>? micronutrients,
    List<_i5.FoodServingSize>? servingSizes,
  }) = _FoodImpl;

  factory Food.fromJson(Map<String, dynamic> jsonSerialization) {
    return Food(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      categoryId: jsonSerialization['categoryId'] as int,
      category: jsonSerialization['category'] == null
          ? null
          : _i6.Protocol().deserialize<_i2.FoodCategory>(
              jsonSerialization['category'],
            ),
      calories: (jsonSerialization['calories'] as num).toDouble(),
      proteins: (jsonSerialization['proteins'] as num).toDouble(),
      carbs: (jsonSerialization['carbs'] as num).toDouble(),
      fats: (jsonSerialization['fats'] as num).toDouble(),
      fiber: (jsonSerialization['fiber'] as num).toDouble(),
      isActive: jsonSerialization['isActive'] as bool,
      isLocal: jsonSerialization['isLocal'] as bool,
      imageUrl: jsonSerialization['imageUrl'] as String?,
      brand: jsonSerialization['brand'] as String?,
      barcode: jsonSerialization['barcode'] as String?,
      isCustom: jsonSerialization['isCustom'] as bool,
      createdByUserIdId: jsonSerialization['createdByUserIdId'] as int?,
      createdByUserId: jsonSerialization['createdByUserId'] == null
          ? null
          : _i6.Protocol().deserialize<_i3.UserProfile>(
              jsonSerialization['createdByUserId'],
            ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
      micronutrients: jsonSerialization['micronutrients'] == null
          ? null
          : _i6.Protocol().deserialize<List<_i4.FoodMicronutrient>>(
              jsonSerialization['micronutrients'],
            ),
      servingSizes: jsonSerialization['servingSizes'] == null
          ? null
          : _i6.Protocol().deserialize<List<_i5.FoodServingSize>>(
              jsonSerialization['servingSizes'],
            ),
    );
  }

  static final t = FoodTable();

  static const db = FoodRepository._();

  @override
  int? id;

  /// Name of the food item
  String name;

  int categoryId;

  /// Category of the food item
  _i2.FoodCategory? category;

  /// Caloric content per 100g
  double calories;

  /// Proteins in grams per 100g
  double proteins;

  /// Carbohydrates in grams per 100g
  double carbs;

  /// Fats in grams per 100g
  double fats;

  /// Fiber in grams per 100g
  double fiber;

  /// Indicates if the food item is active or deprecated
  bool isActive;

  /// Indicates if the food item is locally available
  bool isLocal;

  /// URL of the food image
  String? imageUrl;

  /// Brand of the food item
  String? brand;

  /// Barcode of the food item
  String? barcode;

  /// Indicates if the food item was created by a user
  bool isCustom;

  int? createdByUserIdId;

  /// ID of the user who created the food item (if custom)
  _i3.UserProfile? createdByUserId;

  /// Timestamp when the food item was created
  DateTime createdAt;

  /// Timestamp when the food item was last updated
  DateTime updatedAt;

  /// Micronutrients associated with the food item
  List<_i4.FoodMicronutrient>? micronutrients;

  /// Serving sizes available for the food item
  List<_i5.FoodServingSize>? servingSizes;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Food]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Food copyWith({
    int? id,
    String? name,
    int? categoryId,
    _i2.FoodCategory? category,
    double? calories,
    double? proteins,
    double? carbs,
    double? fats,
    double? fiber,
    bool? isActive,
    bool? isLocal,
    String? imageUrl,
    String? brand,
    String? barcode,
    bool? isCustom,
    int? createdByUserIdId,
    _i3.UserProfile? createdByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<_i4.FoodMicronutrient>? micronutrients,
    List<_i5.FoodServingSize>? servingSizes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Food',
      if (id != null) 'id': id,
      'name': name,
      'categoryId': categoryId,
      if (category != null) 'category': category?.toJson(),
      'calories': calories,
      'proteins': proteins,
      'carbs': carbs,
      'fats': fats,
      'fiber': fiber,
      'isActive': isActive,
      'isLocal': isLocal,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (brand != null) 'brand': brand,
      if (barcode != null) 'barcode': barcode,
      'isCustom': isCustom,
      if (createdByUserIdId != null) 'createdByUserIdId': createdByUserIdId,
      if (createdByUserId != null) 'createdByUserId': createdByUserId?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (micronutrients != null)
        'micronutrients': micronutrients?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (servingSizes != null)
        'servingSizes': servingSizes?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Food',
      if (id != null) 'id': id,
      'name': name,
      'categoryId': categoryId,
      if (category != null) 'category': category?.toJsonForProtocol(),
      'calories': calories,
      'proteins': proteins,
      'carbs': carbs,
      'fats': fats,
      'fiber': fiber,
      'isActive': isActive,
      'isLocal': isLocal,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (brand != null) 'brand': brand,
      if (barcode != null) 'barcode': barcode,
      'isCustom': isCustom,
      if (createdByUserIdId != null) 'createdByUserIdId': createdByUserIdId,
      if (createdByUserId != null)
        'createdByUserId': createdByUserId?.toJsonForProtocol(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (micronutrients != null)
        'micronutrients': micronutrients?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (servingSizes != null)
        'servingSizes': servingSizes?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
    };
  }

  static FoodInclude include({
    _i2.FoodCategoryInclude? category,
    _i3.UserProfileInclude? createdByUserId,
    _i4.FoodMicronutrientIncludeList? micronutrients,
    _i5.FoodServingSizeIncludeList? servingSizes,
  }) {
    return FoodInclude._(
      category: category,
      createdByUserId: createdByUserId,
      micronutrients: micronutrients,
      servingSizes: servingSizes,
    );
  }

  static FoodIncludeList includeList({
    _i1.WhereExpressionBuilder<FoodTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FoodTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FoodTable>? orderByList,
    FoodInclude? include,
  }) {
    return FoodIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Food.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Food.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FoodImpl extends Food {
  _FoodImpl({
    int? id,
    required String name,
    required int categoryId,
    _i2.FoodCategory? category,
    required double calories,
    required double proteins,
    required double carbs,
    required double fats,
    required double fiber,
    bool? isActive,
    bool? isLocal,
    String? imageUrl,
    String? brand,
    String? barcode,
    bool? isCustom,
    int? createdByUserIdId,
    _i3.UserProfile? createdByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<_i4.FoodMicronutrient>? micronutrients,
    List<_i5.FoodServingSize>? servingSizes,
  }) : super._(
         id: id,
         name: name,
         categoryId: categoryId,
         category: category,
         calories: calories,
         proteins: proteins,
         carbs: carbs,
         fats: fats,
         fiber: fiber,
         isActive: isActive,
         isLocal: isLocal,
         imageUrl: imageUrl,
         brand: brand,
         barcode: barcode,
         isCustom: isCustom,
         createdByUserIdId: createdByUserIdId,
         createdByUserId: createdByUserId,
         createdAt: createdAt,
         updatedAt: updatedAt,
         micronutrients: micronutrients,
         servingSizes: servingSizes,
       );

  /// Returns a shallow copy of this [Food]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Food copyWith({
    Object? id = _Undefined,
    String? name,
    int? categoryId,
    Object? category = _Undefined,
    double? calories,
    double? proteins,
    double? carbs,
    double? fats,
    double? fiber,
    bool? isActive,
    bool? isLocal,
    Object? imageUrl = _Undefined,
    Object? brand = _Undefined,
    Object? barcode = _Undefined,
    bool? isCustom,
    Object? createdByUserIdId = _Undefined,
    Object? createdByUserId = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? micronutrients = _Undefined,
    Object? servingSizes = _Undefined,
  }) {
    return Food(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      category: category is _i2.FoodCategory?
          ? category
          : this.category?.copyWith(),
      calories: calories ?? this.calories,
      proteins: proteins ?? this.proteins,
      carbs: carbs ?? this.carbs,
      fats: fats ?? this.fats,
      fiber: fiber ?? this.fiber,
      isActive: isActive ?? this.isActive,
      isLocal: isLocal ?? this.isLocal,
      imageUrl: imageUrl is String? ? imageUrl : this.imageUrl,
      brand: brand is String? ? brand : this.brand,
      barcode: barcode is String? ? barcode : this.barcode,
      isCustom: isCustom ?? this.isCustom,
      createdByUserIdId: createdByUserIdId is int?
          ? createdByUserIdId
          : this.createdByUserIdId,
      createdByUserId: createdByUserId is _i3.UserProfile?
          ? createdByUserId
          : this.createdByUserId?.copyWith(),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      micronutrients: micronutrients is List<_i4.FoodMicronutrient>?
          ? micronutrients
          : this.micronutrients?.map((e0) => e0.copyWith()).toList(),
      servingSizes: servingSizes is List<_i5.FoodServingSize>?
          ? servingSizes
          : this.servingSizes?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class FoodUpdateTable extends _i1.UpdateTable<FoodTable> {
  FoodUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<int, int> categoryId(int value) => _i1.ColumnValue(
    table.categoryId,
    value,
  );

  _i1.ColumnValue<double, double> calories(double value) => _i1.ColumnValue(
    table.calories,
    value,
  );

  _i1.ColumnValue<double, double> proteins(double value) => _i1.ColumnValue(
    table.proteins,
    value,
  );

  _i1.ColumnValue<double, double> carbs(double value) => _i1.ColumnValue(
    table.carbs,
    value,
  );

  _i1.ColumnValue<double, double> fats(double value) => _i1.ColumnValue(
    table.fats,
    value,
  );

  _i1.ColumnValue<double, double> fiber(double value) => _i1.ColumnValue(
    table.fiber,
    value,
  );

  _i1.ColumnValue<bool, bool> isActive(bool value) => _i1.ColumnValue(
    table.isActive,
    value,
  );

  _i1.ColumnValue<bool, bool> isLocal(bool value) => _i1.ColumnValue(
    table.isLocal,
    value,
  );

  _i1.ColumnValue<String, String> imageUrl(String? value) => _i1.ColumnValue(
    table.imageUrl,
    value,
  );

  _i1.ColumnValue<String, String> brand(String? value) => _i1.ColumnValue(
    table.brand,
    value,
  );

  _i1.ColumnValue<String, String> barcode(String? value) => _i1.ColumnValue(
    table.barcode,
    value,
  );

  _i1.ColumnValue<bool, bool> isCustom(bool value) => _i1.ColumnValue(
    table.isCustom,
    value,
  );

  _i1.ColumnValue<int, int> createdByUserIdId(int? value) => _i1.ColumnValue(
    table.createdByUserIdId,
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

class FoodTable extends _i1.Table<int?> {
  FoodTable({super.tableRelation}) : super(tableName: 'foods') {
    updateTable = FoodUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    categoryId = _i1.ColumnInt(
      'categoryId',
      this,
    );
    calories = _i1.ColumnDouble(
      'calories',
      this,
    );
    proteins = _i1.ColumnDouble(
      'proteins',
      this,
    );
    carbs = _i1.ColumnDouble(
      'carbs',
      this,
    );
    fats = _i1.ColumnDouble(
      'fats',
      this,
    );
    fiber = _i1.ColumnDouble(
      'fiber',
      this,
    );
    isActive = _i1.ColumnBool(
      'isActive',
      this,
      hasDefault: true,
    );
    isLocal = _i1.ColumnBool(
      'isLocal',
      this,
      hasDefault: true,
    );
    imageUrl = _i1.ColumnString(
      'imageUrl',
      this,
    );
    brand = _i1.ColumnString(
      'brand',
      this,
    );
    barcode = _i1.ColumnString(
      'barcode',
      this,
    );
    isCustom = _i1.ColumnBool(
      'isCustom',
      this,
      hasDefault: true,
    );
    createdByUserIdId = _i1.ColumnInt(
      'createdByUserIdId',
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

  late final FoodUpdateTable updateTable;

  /// Name of the food item
  late final _i1.ColumnString name;

  late final _i1.ColumnInt categoryId;

  /// Category of the food item
  _i2.FoodCategoryTable? _category;

  /// Caloric content per 100g
  late final _i1.ColumnDouble calories;

  /// Proteins in grams per 100g
  late final _i1.ColumnDouble proteins;

  /// Carbohydrates in grams per 100g
  late final _i1.ColumnDouble carbs;

  /// Fats in grams per 100g
  late final _i1.ColumnDouble fats;

  /// Fiber in grams per 100g
  late final _i1.ColumnDouble fiber;

  /// Indicates if the food item is active or deprecated
  late final _i1.ColumnBool isActive;

  /// Indicates if the food item is locally available
  late final _i1.ColumnBool isLocal;

  /// URL of the food image
  late final _i1.ColumnString imageUrl;

  /// Brand of the food item
  late final _i1.ColumnString brand;

  /// Barcode of the food item
  late final _i1.ColumnString barcode;

  /// Indicates if the food item was created by a user
  late final _i1.ColumnBool isCustom;

  late final _i1.ColumnInt createdByUserIdId;

  /// ID of the user who created the food item (if custom)
  _i3.UserProfileTable? _createdByUserId;

  /// Timestamp when the food item was created
  late final _i1.ColumnDateTime createdAt;

  /// Timestamp when the food item was last updated
  late final _i1.ColumnDateTime updatedAt;

  /// Micronutrients associated with the food item
  _i4.FoodMicronutrientTable? ___micronutrients;

  /// Micronutrients associated with the food item
  _i1.ManyRelation<_i4.FoodMicronutrientTable>? _micronutrients;

  /// Serving sizes available for the food item
  _i5.FoodServingSizeTable? ___servingSizes;

  /// Serving sizes available for the food item
  _i1.ManyRelation<_i5.FoodServingSizeTable>? _servingSizes;

  _i2.FoodCategoryTable get category {
    if (_category != null) return _category!;
    _category = _i1.createRelationTable(
      relationFieldName: 'category',
      field: Food.t.categoryId,
      foreignField: _i2.FoodCategory.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.FoodCategoryTable(tableRelation: foreignTableRelation),
    );
    return _category!;
  }

  _i3.UserProfileTable get createdByUserId {
    if (_createdByUserId != null) return _createdByUserId!;
    _createdByUserId = _i1.createRelationTable(
      relationFieldName: 'createdByUserId',
      field: Food.t.createdByUserIdId,
      foreignField: _i3.UserProfile.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.UserProfileTable(tableRelation: foreignTableRelation),
    );
    return _createdByUserId!;
  }

  _i4.FoodMicronutrientTable get __micronutrients {
    if (___micronutrients != null) return ___micronutrients!;
    ___micronutrients = _i1.createRelationTable(
      relationFieldName: '__micronutrients',
      field: Food.t.id,
      foreignField: _i4.FoodMicronutrient.t.foodId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.FoodMicronutrientTable(tableRelation: foreignTableRelation),
    );
    return ___micronutrients!;
  }

  _i5.FoodServingSizeTable get __servingSizes {
    if (___servingSizes != null) return ___servingSizes!;
    ___servingSizes = _i1.createRelationTable(
      relationFieldName: '__servingSizes',
      field: Food.t.id,
      foreignField: _i5.FoodServingSize.t.foodId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.FoodServingSizeTable(tableRelation: foreignTableRelation),
    );
    return ___servingSizes!;
  }

  _i1.ManyRelation<_i4.FoodMicronutrientTable> get micronutrients {
    if (_micronutrients != null) return _micronutrients!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'micronutrients',
      field: Food.t.id,
      foreignField: _i4.FoodMicronutrient.t.foodId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.FoodMicronutrientTable(tableRelation: foreignTableRelation),
    );
    _micronutrients = _i1.ManyRelation<_i4.FoodMicronutrientTable>(
      tableWithRelations: relationTable,
      table: _i4.FoodMicronutrientTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _micronutrients!;
  }

  _i1.ManyRelation<_i5.FoodServingSizeTable> get servingSizes {
    if (_servingSizes != null) return _servingSizes!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'servingSizes',
      field: Food.t.id,
      foreignField: _i5.FoodServingSize.t.foodId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.FoodServingSizeTable(tableRelation: foreignTableRelation),
    );
    _servingSizes = _i1.ManyRelation<_i5.FoodServingSizeTable>(
      tableWithRelations: relationTable,
      table: _i5.FoodServingSizeTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _servingSizes!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    name,
    categoryId,
    calories,
    proteins,
    carbs,
    fats,
    fiber,
    isActive,
    isLocal,
    imageUrl,
    brand,
    barcode,
    isCustom,
    createdByUserIdId,
    createdAt,
    updatedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'category') {
      return category;
    }
    if (relationField == 'createdByUserId') {
      return createdByUserId;
    }
    if (relationField == 'micronutrients') {
      return __micronutrients;
    }
    if (relationField == 'servingSizes') {
      return __servingSizes;
    }
    return null;
  }
}

class FoodInclude extends _i1.IncludeObject {
  FoodInclude._({
    _i2.FoodCategoryInclude? category,
    _i3.UserProfileInclude? createdByUserId,
    _i4.FoodMicronutrientIncludeList? micronutrients,
    _i5.FoodServingSizeIncludeList? servingSizes,
  }) {
    _category = category;
    _createdByUserId = createdByUserId;
    _micronutrients = micronutrients;
    _servingSizes = servingSizes;
  }

  _i2.FoodCategoryInclude? _category;

  _i3.UserProfileInclude? _createdByUserId;

  _i4.FoodMicronutrientIncludeList? _micronutrients;

  _i5.FoodServingSizeIncludeList? _servingSizes;

  @override
  Map<String, _i1.Include?> get includes => {
    'category': _category,
    'createdByUserId': _createdByUserId,
    'micronutrients': _micronutrients,
    'servingSizes': _servingSizes,
  };

  @override
  _i1.Table<int?> get table => Food.t;
}

class FoodIncludeList extends _i1.IncludeList {
  FoodIncludeList._({
    _i1.WhereExpressionBuilder<FoodTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Food.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Food.t;
}

class FoodRepository {
  const FoodRepository._();

  final attach = const FoodAttachRepository._();

  final attachRow = const FoodAttachRowRepository._();

  final detach = const FoodDetachRepository._();

  final detachRow = const FoodDetachRowRepository._();

  /// Returns a list of [Food]s matching the given query parameters.
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
  Future<List<Food>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FoodTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FoodTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FoodTable>? orderByList,
    _i1.Transaction? transaction,
    FoodInclude? include,
  }) async {
    return session.db.find<Food>(
      where: where?.call(Food.t),
      orderBy: orderBy?.call(Food.t),
      orderByList: orderByList?.call(Food.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [Food] matching the given query parameters.
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
  Future<Food?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FoodTable>? where,
    int? offset,
    _i1.OrderByBuilder<FoodTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FoodTable>? orderByList,
    _i1.Transaction? transaction,
    FoodInclude? include,
  }) async {
    return session.db.findFirstRow<Food>(
      where: where?.call(Food.t),
      orderBy: orderBy?.call(Food.t),
      orderByList: orderByList?.call(Food.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [Food] by its [id] or null if no such row exists.
  Future<Food?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    FoodInclude? include,
  }) async {
    return session.db.findById<Food>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [Food]s in the list and returns the inserted rows.
  ///
  /// The returned [Food]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Food>> insert(
    _i1.Session session,
    List<Food> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Food>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Food] and returns the inserted row.
  ///
  /// The returned [Food] will have its `id` field set.
  Future<Food> insertRow(
    _i1.Session session,
    Food row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Food>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Food]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Food>> update(
    _i1.Session session,
    List<Food> rows, {
    _i1.ColumnSelections<FoodTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Food>(
      rows,
      columns: columns?.call(Food.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Food]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Food> updateRow(
    _i1.Session session,
    Food row, {
    _i1.ColumnSelections<FoodTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Food>(
      row,
      columns: columns?.call(Food.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Food] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Food?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<FoodUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Food>(
      id,
      columnValues: columnValues(Food.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Food]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Food>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<FoodUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<FoodTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FoodTable>? orderBy,
    _i1.OrderByListBuilder<FoodTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Food>(
      columnValues: columnValues(Food.t.updateTable),
      where: where(Food.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Food.t),
      orderByList: orderByList?.call(Food.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Food]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Food>> delete(
    _i1.Session session,
    List<Food> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Food>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Food].
  Future<Food> deleteRow(
    _i1.Session session,
    Food row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Food>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Food>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<FoodTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Food>(
      where: where(Food.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FoodTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Food>(
      where: where?.call(Food.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class FoodAttachRepository {
  const FoodAttachRepository._();

  /// Creates a relation between this [Food] and the given [FoodMicronutrient]s
  /// by setting each [FoodMicronutrient]'s foreign key `foodId` to refer to this [Food].
  Future<void> micronutrients(
    _i1.Session session,
    Food food,
    List<_i4.FoodMicronutrient> foodMicronutrient, {
    _i1.Transaction? transaction,
  }) async {
    if (foodMicronutrient.any((e) => e.id == null)) {
      throw ArgumentError.notNull('foodMicronutrient.id');
    }
    if (food.id == null) {
      throw ArgumentError.notNull('food.id');
    }

    var $foodMicronutrient = foodMicronutrient
        .map((e) => e.copyWith(foodId: food.id))
        .toList();
    await session.db.update<_i4.FoodMicronutrient>(
      $foodMicronutrient,
      columns: [_i4.FoodMicronutrient.t.foodId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Food] and the given [FoodServingSize]s
  /// by setting each [FoodServingSize]'s foreign key `foodId` to refer to this [Food].
  Future<void> servingSizes(
    _i1.Session session,
    Food food,
    List<_i5.FoodServingSize> foodServingSize, {
    _i1.Transaction? transaction,
  }) async {
    if (foodServingSize.any((e) => e.id == null)) {
      throw ArgumentError.notNull('foodServingSize.id');
    }
    if (food.id == null) {
      throw ArgumentError.notNull('food.id');
    }

    var $foodServingSize = foodServingSize
        .map((e) => e.copyWith(foodId: food.id))
        .toList();
    await session.db.update<_i5.FoodServingSize>(
      $foodServingSize,
      columns: [_i5.FoodServingSize.t.foodId],
      transaction: transaction,
    );
  }
}

class FoodAttachRowRepository {
  const FoodAttachRowRepository._();

  /// Creates a relation between the given [Food] and [FoodCategory]
  /// by setting the [Food]'s foreign key `categoryId` to refer to the [FoodCategory].
  Future<void> category(
    _i1.Session session,
    Food food,
    _i2.FoodCategory category, {
    _i1.Transaction? transaction,
  }) async {
    if (food.id == null) {
      throw ArgumentError.notNull('food.id');
    }
    if (category.id == null) {
      throw ArgumentError.notNull('category.id');
    }

    var $food = food.copyWith(categoryId: category.id);
    await session.db.updateRow<Food>(
      $food,
      columns: [Food.t.categoryId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Food] and [UserProfile]
  /// by setting the [Food]'s foreign key `createdByUserIdId` to refer to the [UserProfile].
  Future<void> createdByUserId(
    _i1.Session session,
    Food food,
    _i3.UserProfile createdByUserId, {
    _i1.Transaction? transaction,
  }) async {
    if (food.id == null) {
      throw ArgumentError.notNull('food.id');
    }
    if (createdByUserId.id == null) {
      throw ArgumentError.notNull('createdByUserId.id');
    }

    var $food = food.copyWith(createdByUserIdId: createdByUserId.id);
    await session.db.updateRow<Food>(
      $food,
      columns: [Food.t.createdByUserIdId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Food] and the given [FoodMicronutrient]
  /// by setting the [FoodMicronutrient]'s foreign key `foodId` to refer to this [Food].
  Future<void> micronutrients(
    _i1.Session session,
    Food food,
    _i4.FoodMicronutrient foodMicronutrient, {
    _i1.Transaction? transaction,
  }) async {
    if (foodMicronutrient.id == null) {
      throw ArgumentError.notNull('foodMicronutrient.id');
    }
    if (food.id == null) {
      throw ArgumentError.notNull('food.id');
    }

    var $foodMicronutrient = foodMicronutrient.copyWith(foodId: food.id);
    await session.db.updateRow<_i4.FoodMicronutrient>(
      $foodMicronutrient,
      columns: [_i4.FoodMicronutrient.t.foodId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Food] and the given [FoodServingSize]
  /// by setting the [FoodServingSize]'s foreign key `foodId` to refer to this [Food].
  Future<void> servingSizes(
    _i1.Session session,
    Food food,
    _i5.FoodServingSize foodServingSize, {
    _i1.Transaction? transaction,
  }) async {
    if (foodServingSize.id == null) {
      throw ArgumentError.notNull('foodServingSize.id');
    }
    if (food.id == null) {
      throw ArgumentError.notNull('food.id');
    }

    var $foodServingSize = foodServingSize.copyWith(foodId: food.id);
    await session.db.updateRow<_i5.FoodServingSize>(
      $foodServingSize,
      columns: [_i5.FoodServingSize.t.foodId],
      transaction: transaction,
    );
  }
}

class FoodDetachRepository {
  const FoodDetachRepository._();

  /// Detaches the relation between this [Food] and the given [FoodMicronutrient]
  /// by setting the [FoodMicronutrient]'s foreign key `foodId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> micronutrients(
    _i1.Session session,
    List<_i4.FoodMicronutrient> foodMicronutrient, {
    _i1.Transaction? transaction,
  }) async {
    if (foodMicronutrient.any((e) => e.id == null)) {
      throw ArgumentError.notNull('foodMicronutrient.id');
    }

    var $foodMicronutrient = foodMicronutrient
        .map((e) => e.copyWith(foodId: null))
        .toList();
    await session.db.update<_i4.FoodMicronutrient>(
      $foodMicronutrient,
      columns: [_i4.FoodMicronutrient.t.foodId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [Food] and the given [FoodServingSize]
  /// by setting the [FoodServingSize]'s foreign key `foodId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> servingSizes(
    _i1.Session session,
    List<_i5.FoodServingSize> foodServingSize, {
    _i1.Transaction? transaction,
  }) async {
    if (foodServingSize.any((e) => e.id == null)) {
      throw ArgumentError.notNull('foodServingSize.id');
    }

    var $foodServingSize = foodServingSize
        .map((e) => e.copyWith(foodId: null))
        .toList();
    await session.db.update<_i5.FoodServingSize>(
      $foodServingSize,
      columns: [_i5.FoodServingSize.t.foodId],
      transaction: transaction,
    );
  }
}

class FoodDetachRowRepository {
  const FoodDetachRowRepository._();

  /// Detaches the relation between this [Food] and the [UserProfile] set in `createdByUserId`
  /// by setting the [Food]'s foreign key `createdByUserIdId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> createdByUserId(
    _i1.Session session,
    Food food, {
    _i1.Transaction? transaction,
  }) async {
    if (food.id == null) {
      throw ArgumentError.notNull('food.id');
    }

    var $food = food.copyWith(createdByUserIdId: null);
    await session.db.updateRow<Food>(
      $food,
      columns: [Food.t.createdByUserIdId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [Food] and the given [FoodMicronutrient]
  /// by setting the [FoodMicronutrient]'s foreign key `foodId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> micronutrients(
    _i1.Session session,
    _i4.FoodMicronutrient foodMicronutrient, {
    _i1.Transaction? transaction,
  }) async {
    if (foodMicronutrient.id == null) {
      throw ArgumentError.notNull('foodMicronutrient.id');
    }

    var $foodMicronutrient = foodMicronutrient.copyWith(foodId: null);
    await session.db.updateRow<_i4.FoodMicronutrient>(
      $foodMicronutrient,
      columns: [_i4.FoodMicronutrient.t.foodId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [Food] and the given [FoodServingSize]
  /// by setting the [FoodServingSize]'s foreign key `foodId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> servingSizes(
    _i1.Session session,
    _i5.FoodServingSize foodServingSize, {
    _i1.Transaction? transaction,
  }) async {
    if (foodServingSize.id == null) {
      throw ArgumentError.notNull('foodServingSize.id');
    }

    var $foodServingSize = foodServingSize.copyWith(foodId: null);
    await session.db.updateRow<_i5.FoodServingSize>(
      $foodServingSize,
      columns: [_i5.FoodServingSize.t.foodId],
      transaction: transaction,
    );
  }
}
