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
import 'package:serverpod/serverpod.dart' as _i1;
import '../../../common/models/stream_status.dart' as _i2;

abstract class GenerateWorkoutPlanProgressDto
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  GenerateWorkoutPlanProgressDto._({
    required this.success,
    required this.progressPercentage,
    required this.currentDay,
    required this.totalDays,
    required this.status,
    required this.message,
    required this.updatedAt,
  });

  factory GenerateWorkoutPlanProgressDto({
    required bool success,
    required double progressPercentage,
    required int currentDay,
    required int totalDays,
    required _i2.StreamStatus status,
    required String message,
    required DateTime updatedAt,
  }) = _GenerateWorkoutPlanProgressDtoImpl;

  factory GenerateWorkoutPlanProgressDto.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return GenerateWorkoutPlanProgressDto(
      success: jsonSerialization['success'] as bool,
      progressPercentage: (jsonSerialization['progressPercentage'] as num)
          .toDouble(),
      currentDay: jsonSerialization['currentDay'] as int,
      totalDays: jsonSerialization['totalDays'] as int,
      status: _i2.StreamStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      message: jsonSerialization['message'] as String,
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  bool success;

  double progressPercentage;

  int currentDay;

  int totalDays;

  _i2.StreamStatus status;

  String message;

  DateTime updatedAt;

  /// Returns a shallow copy of this [GenerateWorkoutPlanProgressDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  GenerateWorkoutPlanProgressDto copyWith({
    bool? success,
    double? progressPercentage,
    int? currentDay,
    int? totalDays,
    _i2.StreamStatus? status,
    String? message,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GenerateWorkoutPlanProgressDto',
      'success': success,
      'progressPercentage': progressPercentage,
      'currentDay': currentDay,
      'totalDays': totalDays,
      'status': status.toJson(),
      'message': message,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'GenerateWorkoutPlanProgressDto',
      'success': success,
      'progressPercentage': progressPercentage,
      'currentDay': currentDay,
      'totalDays': totalDays,
      'status': status.toJson(),
      'message': message,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _GenerateWorkoutPlanProgressDtoImpl
    extends GenerateWorkoutPlanProgressDto {
  _GenerateWorkoutPlanProgressDtoImpl({
    required bool success,
    required double progressPercentage,
    required int currentDay,
    required int totalDays,
    required _i2.StreamStatus status,
    required String message,
    required DateTime updatedAt,
  }) : super._(
         success: success,
         progressPercentage: progressPercentage,
         currentDay: currentDay,
         totalDays: totalDays,
         status: status,
         message: message,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [GenerateWorkoutPlanProgressDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  GenerateWorkoutPlanProgressDto copyWith({
    bool? success,
    double? progressPercentage,
    int? currentDay,
    int? totalDays,
    _i2.StreamStatus? status,
    String? message,
    DateTime? updatedAt,
  }) {
    return GenerateWorkoutPlanProgressDto(
      success: success ?? this.success,
      progressPercentage: progressPercentage ?? this.progressPercentage,
      currentDay: currentDay ?? this.currentDay,
      totalDays: totalDays ?? this.totalDays,
      status: status ?? this.status,
      message: message ?? this.message,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
