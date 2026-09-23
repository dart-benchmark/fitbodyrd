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
import '../../../features/nutrition/dto/meal_distribution.dto.dart' as _i2;
import 'package:fitbodyrd_client/src/protocol/protocol.dart' as _i3;

abstract class MacrosResponseDto implements _i1.SerializableModel {
  MacrosResponseDto._({
    required this.bmr,
    required this.tdee,
    required this.targetCalories,
    required this.caloricAdjustment,
    required this.dailyProteins,
    required this.dailyCarbs,
    required this.dailyFats,
    required this.proteinPercentage,
    required this.carbsPercentage,
    required this.fatsPercentage,
    required this.proteinGramsPerKg,
    required this.mealDistribution,
  });

  factory MacrosResponseDto({
    required double bmr,
    required double tdee,
    required double targetCalories,
    required double caloricAdjustment,
    required double dailyProteins,
    required double dailyCarbs,
    required double dailyFats,
    required double proteinPercentage,
    required double carbsPercentage,
    required double fatsPercentage,
    required double proteinGramsPerKg,
    required _i2.MealDistributionDto mealDistribution,
  }) = _MacrosResponseDtoImpl;

  factory MacrosResponseDto.fromJson(Map<String, dynamic> jsonSerialization) {
    return MacrosResponseDto(
      bmr: (jsonSerialization['bmr'] as num).toDouble(),
      tdee: (jsonSerialization['tdee'] as num).toDouble(),
      targetCalories: (jsonSerialization['targetCalories'] as num).toDouble(),
      caloricAdjustment: (jsonSerialization['caloricAdjustment'] as num)
          .toDouble(),
      dailyProteins: (jsonSerialization['dailyProteins'] as num).toDouble(),
      dailyCarbs: (jsonSerialization['dailyCarbs'] as num).toDouble(),
      dailyFats: (jsonSerialization['dailyFats'] as num).toDouble(),
      proteinPercentage: (jsonSerialization['proteinPercentage'] as num)
          .toDouble(),
      carbsPercentage: (jsonSerialization['carbsPercentage'] as num).toDouble(),
      fatsPercentage: (jsonSerialization['fatsPercentage'] as num).toDouble(),
      proteinGramsPerKg: (jsonSerialization['proteinGramsPerKg'] as num)
          .toDouble(),
      mealDistribution: _i3.Protocol().deserialize<_i2.MealDistributionDto>(
        jsonSerialization['mealDistribution'],
      ),
    );
  }

  double bmr;

  double tdee;

  double targetCalories;

  double caloricAdjustment;

  double dailyProteins;

  double dailyCarbs;

  double dailyFats;

  double proteinPercentage;

  double carbsPercentage;

  double fatsPercentage;

  double proteinGramsPerKg;

  _i2.MealDistributionDto mealDistribution;

  /// Returns a shallow copy of this [MacrosResponseDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MacrosResponseDto copyWith({
    double? bmr,
    double? tdee,
    double? targetCalories,
    double? caloricAdjustment,
    double? dailyProteins,
    double? dailyCarbs,
    double? dailyFats,
    double? proteinPercentage,
    double? carbsPercentage,
    double? fatsPercentage,
    double? proteinGramsPerKg,
    _i2.MealDistributionDto? mealDistribution,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MacrosResponseDto',
      'bmr': bmr,
      'tdee': tdee,
      'targetCalories': targetCalories,
      'caloricAdjustment': caloricAdjustment,
      'dailyProteins': dailyProteins,
      'dailyCarbs': dailyCarbs,
      'dailyFats': dailyFats,
      'proteinPercentage': proteinPercentage,
      'carbsPercentage': carbsPercentage,
      'fatsPercentage': fatsPercentage,
      'proteinGramsPerKg': proteinGramsPerKg,
      'mealDistribution': mealDistribution.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _MacrosResponseDtoImpl extends MacrosResponseDto {
  _MacrosResponseDtoImpl({
    required double bmr,
    required double tdee,
    required double targetCalories,
    required double caloricAdjustment,
    required double dailyProteins,
    required double dailyCarbs,
    required double dailyFats,
    required double proteinPercentage,
    required double carbsPercentage,
    required double fatsPercentage,
    required double proteinGramsPerKg,
    required _i2.MealDistributionDto mealDistribution,
  }) : super._(
         bmr: bmr,
         tdee: tdee,
         targetCalories: targetCalories,
         caloricAdjustment: caloricAdjustment,
         dailyProteins: dailyProteins,
         dailyCarbs: dailyCarbs,
         dailyFats: dailyFats,
         proteinPercentage: proteinPercentage,
         carbsPercentage: carbsPercentage,
         fatsPercentage: fatsPercentage,
         proteinGramsPerKg: proteinGramsPerKg,
         mealDistribution: mealDistribution,
       );

  /// Returns a shallow copy of this [MacrosResponseDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MacrosResponseDto copyWith({
    double? bmr,
    double? tdee,
    double? targetCalories,
    double? caloricAdjustment,
    double? dailyProteins,
    double? dailyCarbs,
    double? dailyFats,
    double? proteinPercentage,
    double? carbsPercentage,
    double? fatsPercentage,
    double? proteinGramsPerKg,
    _i2.MealDistributionDto? mealDistribution,
  }) {
    return MacrosResponseDto(
      bmr: bmr ?? this.bmr,
      tdee: tdee ?? this.tdee,
      targetCalories: targetCalories ?? this.targetCalories,
      caloricAdjustment: caloricAdjustment ?? this.caloricAdjustment,
      dailyProteins: dailyProteins ?? this.dailyProteins,
      dailyCarbs: dailyCarbs ?? this.dailyCarbs,
      dailyFats: dailyFats ?? this.dailyFats,
      proteinPercentage: proteinPercentage ?? this.proteinPercentage,
      carbsPercentage: carbsPercentage ?? this.carbsPercentage,
      fatsPercentage: fatsPercentage ?? this.fatsPercentage,
      proteinGramsPerKg: proteinGramsPerKg ?? this.proteinGramsPerKg,
      mealDistribution: mealDistribution ?? this.mealDistribution.copyWith(),
    );
  }
}
