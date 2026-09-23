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
import '../../../features/user/models/auth_method.dart' as _i2;
import '../../../features/food/models/dietary_restriction.dart' as _i3;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i4;
import '../../../common/models/sex.dart' as _i5;
import '../../../common/models/weight_category.dart' as _i6;
import '../../../common/models/body_goal.dart' as _i7;
import '../../../common/models/activity_level.dart' as _i8;
import '../../../common/models/exercise_difficulty.dart' as _i9;
import 'package:fitbodyrd_client/src/protocol/protocol.dart' as _i10;

/// Basic user profile information.
abstract class UserProfile implements _i1.SerializableModel {
  UserProfile._({
    this.id,
    required this.userInfoId,
    this.userInfo,
    required this.fullName,
    required this.email,
    required this.birthDate,
    this.age,
    required this.sex,
    required this.weightKgs,
    required this.heightMs,
    this.bmi,
    this.weightCategory,
    required this.bodyGoal,
    required this.activityLevel,
    required this.daysPerWeekExercise,
    required this.timePerExerciseSessionMinutes,
    required this.experienceLevel,
    _i2.AuthMethod? authMethod,
    bool? hasEquipment,
    _i3.DietaryRestriction? dietaryRestrictions,
    this.deletedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : authMethod = authMethod ?? _i2.AuthMethod.google,
       hasEquipment = hasEquipment ?? true,
       dietaryRestrictions = dietaryRestrictions ?? _i3.DietaryRestriction.none,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory UserProfile({
    int? id,
    required int userInfoId,
    _i4.UserInfo? userInfo,
    required String fullName,
    required String email,
    required DateTime birthDate,
    int? age,
    required _i5.Sex sex,
    required double weightKgs,
    required double heightMs,
    double? bmi,
    _i6.WeightCategory? weightCategory,
    required _i7.BodyGoal bodyGoal,
    required _i8.ActivityLevel activityLevel,
    required int daysPerWeekExercise,
    required int timePerExerciseSessionMinutes,
    required _i9.ExerciseDifficulty experienceLevel,
    _i2.AuthMethod? authMethod,
    bool? hasEquipment,
    _i3.DietaryRestriction? dietaryRestrictions,
    DateTime? deletedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserProfileImpl;

  factory UserProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserProfile(
      id: jsonSerialization['id'] as int?,
      userInfoId: jsonSerialization['userInfoId'] as int,
      userInfo: jsonSerialization['userInfo'] == null
          ? null
          : _i10.Protocol().deserialize<_i4.UserInfo>(
              jsonSerialization['userInfo'],
            ),
      fullName: jsonSerialization['fullName'] as String,
      email: jsonSerialization['email'] as String,
      birthDate: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['birthDate'],
      ),
      age: jsonSerialization['age'] as int?,
      sex: _i5.Sex.fromJson((jsonSerialization['sex'] as String)),
      weightKgs: (jsonSerialization['weightKgs'] as num).toDouble(),
      heightMs: (jsonSerialization['heightMs'] as num).toDouble(),
      bmi: (jsonSerialization['bmi'] as num?)?.toDouble(),
      weightCategory: jsonSerialization['weightCategory'] == null
          ? null
          : _i6.WeightCategory.fromJson(
              (jsonSerialization['weightCategory'] as String),
            ),
      bodyGoal: _i7.BodyGoal.fromJson(
        (jsonSerialization['bodyGoal'] as String),
      ),
      activityLevel: _i8.ActivityLevel.fromJson(
        (jsonSerialization['activityLevel'] as String),
      ),
      daysPerWeekExercise: jsonSerialization['daysPerWeekExercise'] as int,
      timePerExerciseSessionMinutes:
          jsonSerialization['timePerExerciseSessionMinutes'] as int,
      experienceLevel: _i9.ExerciseDifficulty.fromJson(
        (jsonSerialization['experienceLevel'] as String),
      ),
      authMethod: jsonSerialization['authMethod'] == null
          ? null
          : _i2.AuthMethod.fromJson(
              (jsonSerialization['authMethod'] as String),
            ),
      hasEquipment: jsonSerialization['hasEquipment'] as bool,
      dietaryRestrictions: _i3.DietaryRestriction.fromJson(
        (jsonSerialization['dietaryRestrictions'] as String),
      ),
      deletedAt: jsonSerialization['deletedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['deletedAt']),
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

  int userInfoId;

  /// Reference to the associated user information.
  _i4.UserInfo? userInfo;

  /// The user's full name.
  String fullName;

  /// The user's email address.
  String email;

  /// The user's date of birth.
  DateTime birthDate;

  /// The user's age.
  int? age;

  /// The user's sex.
  _i5.Sex sex;

  /// The user's weight in kgs.
  double weightKgs;

  /// The user's height in meters.
  double heightMs;

  /// The user's BMI (Body Mass Index).
  double? bmi;

  /// The user's weight category.
  _i6.WeightCategory? weightCategory;

  /// The user's goal regarding their body.
  _i7.BodyGoal bodyGoal;

  /// The user's activity level.
  _i8.ActivityLevel activityLevel;

  /// Number of days per week the user plans to exercise.
  int daysPerWeekExercise;

  /// Time in minutes the user plans to spend per exercise session.
  int timePerExerciseSessionMinutes;

  /// The user's experience level with exercise.
  _i9.ExerciseDifficulty experienceLevel;

  /// Auth method used by the user.
  _i2.AuthMethod? authMethod;

  /// Whether the user has equipment for exercising.
  bool hasEquipment;

  /// Dietary restrictions of the user.
  _i3.DietaryRestriction dietaryRestrictions;

  DateTime? deletedAt;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [UserProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserProfile copyWith({
    int? id,
    int? userInfoId,
    _i4.UserInfo? userInfo,
    String? fullName,
    String? email,
    DateTime? birthDate,
    int? age,
    _i5.Sex? sex,
    double? weightKgs,
    double? heightMs,
    double? bmi,
    _i6.WeightCategory? weightCategory,
    _i7.BodyGoal? bodyGoal,
    _i8.ActivityLevel? activityLevel,
    int? daysPerWeekExercise,
    int? timePerExerciseSessionMinutes,
    _i9.ExerciseDifficulty? experienceLevel,
    _i2.AuthMethod? authMethod,
    bool? hasEquipment,
    _i3.DietaryRestriction? dietaryRestrictions,
    DateTime? deletedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserProfile',
      if (id != null) 'id': id,
      'userInfoId': userInfoId,
      if (userInfo != null) 'userInfo': userInfo?.toJson(),
      'fullName': fullName,
      'email': email,
      'birthDate': birthDate.toJson(),
      if (age != null) 'age': age,
      'sex': sex.toJson(),
      'weightKgs': weightKgs,
      'heightMs': heightMs,
      if (bmi != null) 'bmi': bmi,
      if (weightCategory != null) 'weightCategory': weightCategory?.toJson(),
      'bodyGoal': bodyGoal.toJson(),
      'activityLevel': activityLevel.toJson(),
      'daysPerWeekExercise': daysPerWeekExercise,
      'timePerExerciseSessionMinutes': timePerExerciseSessionMinutes,
      'experienceLevel': experienceLevel.toJson(),
      if (authMethod != null) 'authMethod': authMethod?.toJson(),
      'hasEquipment': hasEquipment,
      'dietaryRestrictions': dietaryRestrictions.toJson(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
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

class _UserProfileImpl extends UserProfile {
  _UserProfileImpl({
    int? id,
    required int userInfoId,
    _i4.UserInfo? userInfo,
    required String fullName,
    required String email,
    required DateTime birthDate,
    int? age,
    required _i5.Sex sex,
    required double weightKgs,
    required double heightMs,
    double? bmi,
    _i6.WeightCategory? weightCategory,
    required _i7.BodyGoal bodyGoal,
    required _i8.ActivityLevel activityLevel,
    required int daysPerWeekExercise,
    required int timePerExerciseSessionMinutes,
    required _i9.ExerciseDifficulty experienceLevel,
    _i2.AuthMethod? authMethod,
    bool? hasEquipment,
    _i3.DietaryRestriction? dietaryRestrictions,
    DateTime? deletedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         userInfoId: userInfoId,
         userInfo: userInfo,
         fullName: fullName,
         email: email,
         birthDate: birthDate,
         age: age,
         sex: sex,
         weightKgs: weightKgs,
         heightMs: heightMs,
         bmi: bmi,
         weightCategory: weightCategory,
         bodyGoal: bodyGoal,
         activityLevel: activityLevel,
         daysPerWeekExercise: daysPerWeekExercise,
         timePerExerciseSessionMinutes: timePerExerciseSessionMinutes,
         experienceLevel: experienceLevel,
         authMethod: authMethod,
         hasEquipment: hasEquipment,
         dietaryRestrictions: dietaryRestrictions,
         deletedAt: deletedAt,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [UserProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserProfile copyWith({
    Object? id = _Undefined,
    int? userInfoId,
    Object? userInfo = _Undefined,
    String? fullName,
    String? email,
    DateTime? birthDate,
    Object? age = _Undefined,
    _i5.Sex? sex,
    double? weightKgs,
    double? heightMs,
    Object? bmi = _Undefined,
    Object? weightCategory = _Undefined,
    _i7.BodyGoal? bodyGoal,
    _i8.ActivityLevel? activityLevel,
    int? daysPerWeekExercise,
    int? timePerExerciseSessionMinutes,
    _i9.ExerciseDifficulty? experienceLevel,
    Object? authMethod = _Undefined,
    bool? hasEquipment,
    _i3.DietaryRestriction? dietaryRestrictions,
    Object? deletedAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserProfile(
      id: id is int? ? id : this.id,
      userInfoId: userInfoId ?? this.userInfoId,
      userInfo: userInfo is _i4.UserInfo?
          ? userInfo
          : this.userInfo?.copyWith(),
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      birthDate: birthDate ?? this.birthDate,
      age: age is int? ? age : this.age,
      sex: sex ?? this.sex,
      weightKgs: weightKgs ?? this.weightKgs,
      heightMs: heightMs ?? this.heightMs,
      bmi: bmi is double? ? bmi : this.bmi,
      weightCategory: weightCategory is _i6.WeightCategory?
          ? weightCategory
          : this.weightCategory,
      bodyGoal: bodyGoal ?? this.bodyGoal,
      activityLevel: activityLevel ?? this.activityLevel,
      daysPerWeekExercise: daysPerWeekExercise ?? this.daysPerWeekExercise,
      timePerExerciseSessionMinutes:
          timePerExerciseSessionMinutes ?? this.timePerExerciseSessionMinutes,
      experienceLevel: experienceLevel ?? this.experienceLevel,
      authMethod: authMethod is _i2.AuthMethod? ? authMethod : this.authMethod,
      hasEquipment: hasEquipment ?? this.hasEquipment,
      dietaryRestrictions: dietaryRestrictions ?? this.dietaryRestrictions,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
