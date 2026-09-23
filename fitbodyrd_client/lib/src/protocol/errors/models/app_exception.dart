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

abstract class AppException
    implements _i1.SerializableException, _i1.SerializableModel {
  AppException._({
    required this.module,
    required this.message,
    required this.errorCode,
    required this.httpStatus,
    this.details,
  });

  factory AppException({
    required String module,
    required String message,
    required int errorCode,
    required int httpStatus,
    String? details,
  }) = _AppExceptionImpl;

  factory AppException.fromJson(Map<String, dynamic> jsonSerialization) {
    return AppException(
      module: jsonSerialization['module'] as String,
      message: jsonSerialization['message'] as String,
      errorCode: jsonSerialization['errorCode'] as int,
      httpStatus: jsonSerialization['httpStatus'] as int,
      details: jsonSerialization['details'] as String?,
    );
  }

  String module;

  String message;

  int errorCode;

  int httpStatus;

  String? details;

  /// Returns a shallow copy of this [AppException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AppException copyWith({
    String? module,
    String? message,
    int? errorCode,
    int? httpStatus,
    String? details,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AppException',
      'module': module,
      'message': message,
      'errorCode': errorCode,
      'httpStatus': httpStatus,
      if (details != null) 'details': details,
    };
  }

  @override
  String toString() {
    return 'AppException(module: $module, message: $message, errorCode: $errorCode, httpStatus: $httpStatus, details: $details)';
  }
}

class _Undefined {}

class _AppExceptionImpl extends AppException {
  _AppExceptionImpl({
    required String module,
    required String message,
    required int errorCode,
    required int httpStatus,
    String? details,
  }) : super._(
         module: module,
         message: message,
         errorCode: errorCode,
         httpStatus: httpStatus,
         details: details,
       );

  /// Returns a shallow copy of this [AppException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AppException copyWith({
    String? module,
    String? message,
    int? errorCode,
    int? httpStatus,
    Object? details = _Undefined,
  }) {
    return AppException(
      module: module ?? this.module,
      message: message ?? this.message,
      errorCode: errorCode ?? this.errorCode,
      httpStatus: httpStatus ?? this.httpStatus,
      details: details is String? ? details : this.details,
    );
  }
}
