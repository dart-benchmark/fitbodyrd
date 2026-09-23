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
import '../../../common/models/status.dart' as _i3;
import '../../../features/nutrition_plan/models/meal_plan.dart' as _i4;
import 'package:fitbodyrd_client/src/protocol/protocol.dart' as _i5;

abstract class NutritionPlan implements _i1.SerializableModel {
  NutritionPlan._({
    this.id,
    required this.userProfileId,
    this.userProfile,
    required this.startDate,
    required this.endDate,
    required this.dailyCalories,
    required this.dailyProteins,
    required this.dailyCarbs,
    required this.dailyFats,
    required this.status,
    this.notes,
    this.mealPlans,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory NutritionPlan({
    int? id,
    required int userProfileId,
    _i2.UserProfile? userProfile,
    required DateTime startDate,
    required DateTime endDate,
    required double dailyCalories,
    required double dailyProteins,
    required double dailyCarbs,
    required double dailyFats,
    required _i3.Status status,
    String? notes,
    List<_i4.MealPlan>? mealPlans,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _NutritionPlanImpl;

  factory NutritionPlan.fromJson(Map<String, dynamic> jsonSerialization) {
    return NutritionPlan(
      id: jsonSerialization['id'] as int?,
      userProfileId: jsonSerialization['userProfileId'] as int,
      userProfile: jsonSerialization['userProfile'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.UserProfile>(
              jsonSerialization['userProfile'],
            ),
      startDate: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startDate'],
      ),
      endDate: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endDate']),
      dailyCalories: (jsonSerialization['dailyCalories'] as num).toDouble(),
      dailyProteins: (jsonSerialization['dailyProteins'] as num).toDouble(),
      dailyCarbs: (jsonSerialization['dailyCarbs'] as num).toDouble(),
      dailyFats: (jsonSerialization['dailyFats'] as num).toDouble(),
      status: _i3.Status.fromJson((jsonSerialization['status'] as String)),
      notes: jsonSerialization['notes'] as String?,
      mealPlans: jsonSerialization['mealPlans'] == null
          ? null
          : _i5.Protocol().deserialize<List<_i4.MealPlan>>(
              jsonSerialization['mealPlans'],
            ),
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

  DateTime startDate;

  DateTime endDate;

  double dailyCalories;

  double dailyProteins;

  double dailyCarbs;

  double dailyFats;

  _i3.Status status;

  String? notes;

  List<_i4.MealPlan>? mealPlans;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [NutritionPlan]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  NutritionPlan copyWith({
    int? id,
    int? userProfileId,
    _i2.UserProfile? userProfile,
    DateTime? startDate,
    DateTime? endDate,
    double? dailyCalories,
    double? dailyProteins,
    double? dailyCarbs,
    double? dailyFats,
    _i3.Status? status,
    String? notes,
    List<_i4.MealPlan>? mealPlans,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'NutritionPlan',
      if (id != null) 'id': id,
      'userProfileId': userProfileId,
      if (userProfile != null) 'userProfile': userProfile?.toJson(),
      'startDate': startDate.toJson(),
      'endDate': endDate.toJson(),
      'dailyCalories': dailyCalories,
      'dailyProteins': dailyProteins,
      'dailyCarbs': dailyCarbs,
      'dailyFats': dailyFats,
      'status': status.toJson(),
      if (notes != null) 'notes': notes,
      if (mealPlans != null)
        'mealPlans': mealPlans?.toJson(valueToJson: (v) => v.toJson()),
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

class _NutritionPlanImpl extends NutritionPlan {
  _NutritionPlanImpl({
    int? id,
    required int userProfileId,
    _i2.UserProfile? userProfile,
    required DateTime startDate,
    required DateTime endDate,
    required double dailyCalories,
    required double dailyProteins,
    required double dailyCarbs,
    required double dailyFats,
    required _i3.Status status,
    String? notes,
    List<_i4.MealPlan>? mealPlans,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         userProfileId: userProfileId,
         userProfile: userProfile,
         startDate: startDate,
         endDate: endDate,
         dailyCalories: dailyCalories,
         dailyProteins: dailyProteins,
         dailyCarbs: dailyCarbs,
         dailyFats: dailyFats,
         status: status,
         notes: notes,
         mealPlans: mealPlans,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [NutritionPlan]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  NutritionPlan copyWith({
    Object? id = _Undefined,
    int? userProfileId,
    Object? userProfile = _Undefined,
    DateTime? startDate,
    DateTime? endDate,
    double? dailyCalories,
    double? dailyProteins,
    double? dailyCarbs,
    double? dailyFats,
    _i3.Status? status,
    Object? notes = _Undefined,
    Object? mealPlans = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return NutritionPlan(
      id: id is int? ? id : this.id,
      userProfileId: userProfileId ?? this.userProfileId,
      userProfile: userProfile is _i2.UserProfile?
          ? userProfile
          : this.userProfile?.copyWith(),
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      dailyCalories: dailyCalories ?? this.dailyCalories,
      dailyProteins: dailyProteins ?? this.dailyProteins,
      dailyCarbs: dailyCarbs ?? this.dailyCarbs,
      dailyFats: dailyFats ?? this.dailyFats,
      status: status ?? this.status,
      notes: notes is String? ? notes : this.notes,
      mealPlans: mealPlans is List<_i4.MealPlan>?
          ? mealPlans
          : this.mealPlans?.map((e0) => e0.copyWith()).toList(),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
