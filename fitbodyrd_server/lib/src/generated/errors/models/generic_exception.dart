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

abstract class GenericException
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  GenericException._({required this.code});

  factory GenericException({required int code}) = _GenericExceptionImpl;

  factory GenericException.fromJson(Map<String, dynamic> jsonSerialization) {
    return GenericException(code: jsonSerialization['code'] as int);
  }

  int code;

  /// Returns a shallow copy of this [GenericException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  GenericException copyWith({int? code});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GenericException',
      'code': code,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'GenericException',
      'code': code,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _GenericExceptionImpl extends GenericException {
  _GenericExceptionImpl({required int code}) : super._(code: code);

  /// Returns a shallow copy of this [GenericException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  GenericException copyWith({int? code}) {
    return GenericException(code: code ?? this.code);
  }
}
