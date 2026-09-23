/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import '../../../features/user/models/app_user.dart' as _i2;
import '../../../features/food/models/food.dart' as _i3;
import '../../../features/food/models/user_food_preference_type.dart' as _i4;
import 'package:fitbodyrd_client/src/protocol/protocol.dart' as _i5;

abstract class UserFoodPreference implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userProfileId;

  _i2.UserProfile? userProfile;

  int foodId;

  _i3.Food? food;

  _i4.UserFoodPreferenceType preferenceType;

  String? note;

  DateTime createdAt;

  DateTime updatedAt;

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
