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
import '../../../features/food/models/user_food_preference.dart' as _i2;
import 'package:fitbodyrd_client/src/protocol/protocol.dart' as _i3;

abstract class UserFoodPreferencesResponseDto implements _i1.SerializableModel {
  UserFoodPreferencesResponseDto._({
    required this.preferences,
    required this.excludedFoodIds,
    required this.favoriteFoodIds,
    required this.allergyFoodIds,
    required this.intoleranceFoodIds,
  });

  factory UserFoodPreferencesResponseDto({
    required List<_i2.UserFoodPreference> preferences,
    required List<int> excludedFoodIds,
    required List<int> favoriteFoodIds,
    required List<int> allergyFoodIds,
    required List<int> intoleranceFoodIds,
  }) = _UserFoodPreferencesResponseDtoImpl;

  factory UserFoodPreferencesResponseDto.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return UserFoodPreferencesResponseDto(
      preferences: _i3.Protocol().deserialize<List<_i2.UserFoodPreference>>(
        jsonSerialization['preferences'],
      ),
      excludedFoodIds: _i3.Protocol().deserialize<List<int>>(
        jsonSerialization['excludedFoodIds'],
      ),
      favoriteFoodIds: _i3.Protocol().deserialize<List<int>>(
        jsonSerialization['favoriteFoodIds'],
      ),
      allergyFoodIds: _i3.Protocol().deserialize<List<int>>(
        jsonSerialization['allergyFoodIds'],
      ),
      intoleranceFoodIds: _i3.Protocol().deserialize<List<int>>(
        jsonSerialization['intoleranceFoodIds'],
      ),
    );
  }

  List<_i2.UserFoodPreference> preferences;

  List<int> excludedFoodIds;

  List<int> favoriteFoodIds;

  List<int> allergyFoodIds;

  List<int> intoleranceFoodIds;

  /// Returns a shallow copy of this [UserFoodPreferencesResponseDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserFoodPreferencesResponseDto copyWith({
    List<_i2.UserFoodPreference>? preferences,
    List<int>? excludedFoodIds,
    List<int>? favoriteFoodIds,
    List<int>? allergyFoodIds,
    List<int>? intoleranceFoodIds,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserFoodPreferencesResponseDto',
      'preferences': preferences.toJson(valueToJson: (v) => v.toJson()),
      'excludedFoodIds': excludedFoodIds.toJson(),
      'favoriteFoodIds': favoriteFoodIds.toJson(),
      'allergyFoodIds': allergyFoodIds.toJson(),
      'intoleranceFoodIds': intoleranceFoodIds.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _UserFoodPreferencesResponseDtoImpl
    extends UserFoodPreferencesResponseDto {
  _UserFoodPreferencesResponseDtoImpl({
    required List<_i2.UserFoodPreference> preferences,
    required List<int> excludedFoodIds,
    required List<int> favoriteFoodIds,
    required List<int> allergyFoodIds,
    required List<int> intoleranceFoodIds,
  }) : super._(
         preferences: preferences,
         excludedFoodIds: excludedFoodIds,
         favoriteFoodIds: favoriteFoodIds,
         allergyFoodIds: allergyFoodIds,
         intoleranceFoodIds: intoleranceFoodIds,
       );

  /// Returns a shallow copy of this [UserFoodPreferencesResponseDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserFoodPreferencesResponseDto copyWith({
    List<_i2.UserFoodPreference>? preferences,
    List<int>? excludedFoodIds,
    List<int>? favoriteFoodIds,
    List<int>? allergyFoodIds,
    List<int>? intoleranceFoodIds,
  }) {
    return UserFoodPreferencesResponseDto(
      preferences:
          preferences ?? this.preferences.map((e0) => e0.copyWith()).toList(),
      excludedFoodIds:
          excludedFoodIds ?? this.excludedFoodIds.map((e0) => e0).toList(),
      favoriteFoodIds:
          favoriteFoodIds ?? this.favoriteFoodIds.map((e0) => e0).toList(),
      allergyFoodIds:
          allergyFoodIds ?? this.allergyFoodIds.map((e0) => e0).toList(),
      intoleranceFoodIds:
          intoleranceFoodIds ??
          this.intoleranceFoodIds.map((e0) => e0).toList(),
    );
  }
}
