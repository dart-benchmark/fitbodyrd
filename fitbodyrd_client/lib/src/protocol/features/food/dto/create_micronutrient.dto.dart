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

abstract class CreateMicronutrientDto implements _i1.SerializableModel {
  CreateMicronutrientDto._({
    required this.name,
    required this.amount,
    required this.unit,
  });

  factory CreateMicronutrientDto({
    required String name,
    required double amount,
    required String unit,
  }) = _CreateMicronutrientDtoImpl;

  factory CreateMicronutrientDto.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CreateMicronutrientDto(
      name: jsonSerialization['name'] as String,
      amount: (jsonSerialization['amount'] as num).toDouble(),
      unit: jsonSerialization['unit'] as String,
    );
  }

  String name;

  double amount;

  String unit;

  /// Returns a shallow copy of this [CreateMicronutrientDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CreateMicronutrientDto copyWith({
    String? name,
    double? amount,
    String? unit,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CreateMicronutrientDto',
      'name': name,
      'amount': amount,
      'unit': unit,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _CreateMicronutrientDtoImpl extends CreateMicronutrientDto {
  _CreateMicronutrientDtoImpl({
    required String name,
    required double amount,
    required String unit,
  }) : super._(
         name: name,
         amount: amount,
         unit: unit,
       );

  /// Returns a shallow copy of this [CreateMicronutrientDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CreateMicronutrientDto copyWith({
    String? name,
    double? amount,
    String? unit,
  }) {
    return CreateMicronutrientDto(
      name: name ?? this.name,
      amount: amount ?? this.amount,
      unit: unit ?? this.unit,
    );
  }
}
