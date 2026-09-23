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

abstract class CreateServingSizeDto
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  CreateServingSizeDto._({
    required this.name,
    required this.grams,
    required this.isDefault,
  });

  factory CreateServingSizeDto({
    required String name,
    required double grams,
    required bool isDefault,
  }) = _CreateServingSizeDtoImpl;

  factory CreateServingSizeDto.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CreateServingSizeDto(
      name: jsonSerialization['name'] as String,
      grams: (jsonSerialization['grams'] as num).toDouble(),
      isDefault: jsonSerialization['isDefault'] as bool,
    );
  }

  String name;

  double grams;

  bool isDefault;

  /// Returns a shallow copy of this [CreateServingSizeDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CreateServingSizeDto copyWith({
    String? name,
    double? grams,
    bool? isDefault,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CreateServingSizeDto',
      'name': name,
      'grams': grams,
      'isDefault': isDefault,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CreateServingSizeDto',
      'name': name,
      'grams': grams,
      'isDefault': isDefault,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _CreateServingSizeDtoImpl extends CreateServingSizeDto {
  _CreateServingSizeDtoImpl({
    required String name,
    required double grams,
    required bool isDefault,
  }) : super._(
         name: name,
         grams: grams,
         isDefault: isDefault,
       );

  /// Returns a shallow copy of this [CreateServingSizeDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CreateServingSizeDto copyWith({
    String? name,
    double? grams,
    bool? isDefault,
  }) {
    return CreateServingSizeDto(
      name: name ?? this.name,
      grams: grams ?? this.grams,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
