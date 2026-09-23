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
import '../../../features/food/models/food.dart' as _i3;
import '../../../features/food/models/user_food_preference_type.dart' as _i4;
import 'package:fitbodyrd_server/src/generated/protocol.dart' as _i5;

abstract class UserFoodPreference
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  UserFoodPreference._({
    this.id,
    required this.userProfileId,
    this.userProfile,
    required this.foodId,
    this.food,
    required this.preferenceType,
    this.note,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory UserFoodPreference({
    int? id,
    required int userProfileId,
    _i2.UserProfile? userProfile,
    required int foodId,
    _i3.Food? food,
    required _i4.UserFoodPreferenceType preferenceType,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserFoodPreferenceImpl;

  factory UserFoodPreference.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserFoodPreference(
      id: jsonSerialization['id'] as int?,
      userProfileId: jsonSerialization['userProfileId'] as int,
      userProfile: jsonSerialization['userProfile'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.UserProfile>(
              jsonSerialization['userProfile'],
            ),
      foodId: jsonSerialization['foodId'] as int,
      food: jsonSerialization['food'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.Food>(jsonSerialization['food']),
      preferenceType: _i4.UserFoodPreferenceType.fromJson(
        (jsonSerialization['preferenceType'] as String),
      ),
      note: jsonSerialization['note'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = UserFoodPreferenceTable();

  static const db = UserFoodPreferenceRepository._();

  @override
  int? id;

  int userProfileId;

  _i2.UserProfile? userProfile;

  int foodId;

  _i3.Food? food;

  _i4.UserFoodPreferenceType preferenceType;

  String? note;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [UserFoodPreference]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserFoodPreference copyWith({
    int? id,
    int? userProfileId,
    _i2.UserProfile? userProfile,
    int? foodId,
    _i3.Food? food,
    _i4.UserFoodPreferenceType? preferenceType,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserFoodPreference',
      if (id != null) 'id': id,
      'userProfileId': userProfileId,
      if (userProfile != null) 'userProfile': userProfile?.toJson(),
      'foodId': foodId,
      if (food != null) 'food': food?.toJson(),
      'preferenceType': preferenceType.toJson(),
      if (note != null) 'note': note,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserFoodPreference',
      if (id != null) 'id': id,
      'userProfileId': userProfileId,
      if (userProfile != null) 'userProfile': userProfile?.toJsonForProtocol(),
      'foodId': foodId,
      if (food != null) 'food': food?.toJsonForProtocol(),
      'preferenceType': preferenceType.toJson(),
      if (note != null) 'note': note,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static UserFoodPreferenceInclude include({
    _i2.UserProfileInclude? userProfile,
    _i3.FoodInclude? food,
  }) {
    return UserFoodPreferenceInclude._(
      userProfile: userProfile,
      food: food,
    );
  }

  static UserFoodPreferenceIncludeList includeList({
    _i1.WhereExpressionBuilder<UserFoodPreferenceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserFoodPreferenceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserFoodPreferenceTable>? orderByList,
    UserFoodPreferenceInclude? include,
  }) {
    return UserFoodPreferenceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserFoodPreference.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(UserFoodPreference.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserFoodPreferenceImpl extends UserFoodPreference {
  _UserFoodPreferenceImpl({
    int? id,
    required int userProfileId,
    _i2.UserProfile? userProfile,
    required int foodId,
    _i3.Food? food,
    required _i4.UserFoodPreferenceType preferenceType,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         userProfileId: userProfileId,
         userProfile: userProfile,
         foodId: foodId,
         food: food,
         preferenceType: preferenceType,
         note: note,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [UserFoodPreference]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserFoodPreference copyWith({
    Object? id = _Undefined,
    int? userProfileId,
    Object? userProfile = _Undefined,
    int? foodId,
    Object? food = _Undefined,
    _i4.UserFoodPreferenceType? preferenceType,
    Object? note = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserFoodPreference(
      id: id is int? ? id : this.id,
      userProfileId: userProfileId ?? this.userProfileId,
      userProfile: userProfile is _i2.UserProfile?
          ? userProfile
          : this.userProfile?.copyWith(),
      foodId: foodId ?? this.foodId,
      food: food is _i3.Food? ? food : this.food?.copyWith(),
      preferenceType: preferenceType ?? this.preferenceType,
      note: note is String? ? note : this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class UserFoodPreferenceUpdateTable
    extends _i1.UpdateTable<UserFoodPreferenceTable> {
  UserFoodPreferenceUpdateTable(super.table);

  _i1.ColumnValue<int, int> userProfileId(int value) => _i1.ColumnValue(
    table.userProfileId,
    value,
  );

  _i1.ColumnValue<int, int> foodId(int value) => _i1.ColumnValue(
    table.foodId,
    value,
  );

  _i1.ColumnValue<_i4.UserFoodPreferenceType, _i4.UserFoodPreferenceType>
  preferenceType(_i4.UserFoodPreferenceType value) => _i1.ColumnValue(
    table.preferenceType,
    value,
  );

  _i1.ColumnValue<String, String> note(String? value) => _i1.ColumnValue(
    table.note,
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

class UserFoodPreferenceTable extends _i1.Table<int?> {
  UserFoodPreferenceTable({super.tableRelation})
    : super(tableName: 'user_food_preferences') {
    updateTable = UserFoodPreferenceUpdateTable(this);
    userProfileId = _i1.ColumnInt(
      'userProfileId',
      this,
    );
    foodId = _i1.ColumnInt(
      'foodId',
      this,
    );
    preferenceType = _i1.ColumnEnum(
      'preferenceType',
      this,
      _i1.EnumSerialization.byName,
    );
    note = _i1.ColumnString(
      'note',
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

  late final UserFoodPreferenceUpdateTable updateTable;

  late final _i1.ColumnInt userProfileId;

  _i2.UserProfileTable? _userProfile;

  late final _i1.ColumnInt foodId;

  _i3.FoodTable? _food;

  late final _i1.ColumnEnum<_i4.UserFoodPreferenceType> preferenceType;

  late final _i1.ColumnString note;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  _i2.UserProfileTable get userProfile {
    if (_userProfile != null) return _userProfile!;
    _userProfile = _i1.createRelationTable(
      relationFieldName: 'userProfile',
      field: UserFoodPreference.t.userProfileId,
      foreignField: _i2.UserProfile.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.UserProfileTable(tableRelation: foreignTableRelation),
    );
    return _userProfile!;
  }

  _i3.FoodTable get food {
    if (_food != null) return _food!;
    _food = _i1.createRelationTable(
      relationFieldName: 'food',
      field: UserFoodPreference.t.foodId,
      foreignField: _i3.Food.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.FoodTable(tableRelation: foreignTableRelation),
    );
    return _food!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    userProfileId,
    foodId,
    preferenceType,
    note,
    createdAt,
    updatedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'userProfile') {
      return userProfile;
    }
    if (relationField == 'food') {
      return food;
    }
    return null;
  }
}

class UserFoodPreferenceInclude extends _i1.IncludeObject {
  UserFoodPreferenceInclude._({
    _i2.UserProfileInclude? userProfile,
    _i3.FoodInclude? food,
  }) {
    _userProfile = userProfile;
    _food = food;
  }

  _i2.UserProfileInclude? _userProfile;

  _i3.FoodInclude? _food;

  @override
  Map<String, _i1.Include?> get includes => {
    'userProfile': _userProfile,
    'food': _food,
  };

  @override
  _i1.Table<int?> get table => UserFoodPreference.t;
}

class UserFoodPreferenceIncludeList extends _i1.IncludeList {
  UserFoodPreferenceIncludeList._({
    _i1.WhereExpressionBuilder<UserFoodPreferenceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserFoodPreference.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => UserFoodPreference.t;
}

class UserFoodPreferenceRepository {
  const UserFoodPreferenceRepository._();

  final attachRow = const UserFoodPreferenceAttachRowRepository._();

  /// Returns a list of [UserFoodPreference]s matching the given query parameters.
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
  Future<List<UserFoodPreference>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserFoodPreferenceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserFoodPreferenceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserFoodPreferenceTable>? orderByList,
    _i1.Transaction? transaction,
    UserFoodPreferenceInclude? include,
  }) async {
    return session.db.find<UserFoodPreference>(
      where: where?.call(UserFoodPreference.t),
      orderBy: orderBy?.call(UserFoodPreference.t),
      orderByList: orderByList?.call(UserFoodPreference.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [UserFoodPreference] matching the given query parameters.
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
  Future<UserFoodPreference?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserFoodPreferenceTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserFoodPreferenceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserFoodPreferenceTable>? orderByList,
    _i1.Transaction? transaction,
    UserFoodPreferenceInclude? include,
  }) async {
    return session.db.findFirstRow<UserFoodPreference>(
      where: where?.call(UserFoodPreference.t),
      orderBy: orderBy?.call(UserFoodPreference.t),
      orderByList: orderByList?.call(UserFoodPreference.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [UserFoodPreference] by its [id] or null if no such row exists.
  Future<UserFoodPreference?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    UserFoodPreferenceInclude? include,
  }) async {
    return session.db.findById<UserFoodPreference>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [UserFoodPreference]s in the list and returns the inserted rows.
  ///
  /// The returned [UserFoodPreference]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<UserFoodPreference>> insert(
    _i1.Session session,
    List<UserFoodPreference> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<UserFoodPreference>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [UserFoodPreference] and returns the inserted row.
  ///
  /// The returned [UserFoodPreference] will have its `id` field set.
  Future<UserFoodPreference> insertRow(
    _i1.Session session,
    UserFoodPreference row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserFoodPreference>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [UserFoodPreference]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<UserFoodPreference>> update(
    _i1.Session session,
    List<UserFoodPreference> rows, {
    _i1.ColumnSelections<UserFoodPreferenceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<UserFoodPreference>(
      rows,
      columns: columns?.call(UserFoodPreference.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserFoodPreference]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserFoodPreference> updateRow(
    _i1.Session session,
    UserFoodPreference row, {
    _i1.ColumnSelections<UserFoodPreferenceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserFoodPreference>(
      row,
      columns: columns?.call(UserFoodPreference.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserFoodPreference] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<UserFoodPreference?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<UserFoodPreferenceUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<UserFoodPreference>(
      id,
      columnValues: columnValues(UserFoodPreference.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [UserFoodPreference]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<UserFoodPreference>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<UserFoodPreferenceUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<UserFoodPreferenceTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserFoodPreferenceTable>? orderBy,
    _i1.OrderByListBuilder<UserFoodPreferenceTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<UserFoodPreference>(
      columnValues: columnValues(UserFoodPreference.t.updateTable),
      where: where(UserFoodPreference.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserFoodPreference.t),
      orderByList: orderByList?.call(UserFoodPreference.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [UserFoodPreference]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<UserFoodPreference>> delete(
    _i1.Session session,
    List<UserFoodPreference> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<UserFoodPreference>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [UserFoodPreference].
  Future<UserFoodPreference> deleteRow(
    _i1.Session session,
    UserFoodPreference row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserFoodPreference>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<UserFoodPreference>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<UserFoodPreferenceTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<UserFoodPreference>(
      where: where(UserFoodPreference.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserFoodPreferenceTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<UserFoodPreference>(
      where: where?.call(UserFoodPreference.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class UserFoodPreferenceAttachRowRepository {
  const UserFoodPreferenceAttachRowRepository._();

  /// Creates a relation between the given [UserFoodPreference] and [UserProfile]
  /// by setting the [UserFoodPreference]'s foreign key `userProfileId` to refer to the [UserProfile].
  Future<void> userProfile(
    _i1.Session session,
    UserFoodPreference userFoodPreference,
    _i2.UserProfile userProfile, {
    _i1.Transaction? transaction,
  }) async {
    if (userFoodPreference.id == null) {
      throw ArgumentError.notNull('userFoodPreference.id');
    }
    if (userProfile.id == null) {
      throw ArgumentError.notNull('userProfile.id');
    }

    var $userFoodPreference = userFoodPreference.copyWith(
      userProfileId: userProfile.id,
    );
    await session.db.updateRow<UserFoodPreference>(
      $userFoodPreference,
      columns: [UserFoodPreference.t.userProfileId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [UserFoodPreference] and [Food]
  /// by setting the [UserFoodPreference]'s foreign key `foodId` to refer to the [Food].
  Future<void> food(
    _i1.Session session,
    UserFoodPreference userFoodPreference,
    _i3.Food food, {
    _i1.Transaction? transaction,
  }) async {
    if (userFoodPreference.id == null) {
      throw ArgumentError.notNull('userFoodPreference.id');
    }
    if (food.id == null) {
      throw ArgumentError.notNull('food.id');
    }

    var $userFoodPreference = userFoodPreference.copyWith(foodId: food.id);
    await session.db.updateRow<UserFoodPreference>(
      $userFoodPreference,
      columns: [UserFoodPreference.t.foodId],
      transaction: transaction,
    );
  }
}
