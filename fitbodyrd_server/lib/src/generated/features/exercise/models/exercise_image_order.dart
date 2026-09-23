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

abstract class ExerciseImageOrder
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  ExerciseImageOrder._({
    required this.id,
    required this.orderIndex,
  });

  factory ExerciseImageOrder({
    required int id,
    required int orderIndex,
  }) = _ExerciseImageOrderImpl;

  factory ExerciseImageOrder.fromJson(Map<String, dynamic> jsonSerialization) {
    return ExerciseImageOrder(
      id: jsonSerialization['id'] as int,
      orderIndex: jsonSerialization['orderIndex'] as int,
    );
  }

  int id;

  int orderIndex;

  /// Returns a shallow copy of this [ExerciseImageOrder]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ExerciseImageOrder copyWith({
    int? id,
    int? orderIndex,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ExerciseImageOrder',
      'id': id,
      'orderIndex': orderIndex,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ExerciseImageOrder',
      'id': id,
      'orderIndex': orderIndex,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _ExerciseImageOrderImpl extends ExerciseImageOrder {
  _ExerciseImageOrderImpl({
    required int id,
    required int orderIndex,
  }) : super._(
         id: id,
         orderIndex: orderIndex,
       );

  /// Returns a shallow copy of this [ExerciseImageOrder]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ExerciseImageOrder copyWith({
    int? id,
    int? orderIndex,
  }) {
    return ExerciseImageOrder(
      id: id ?? this.id,
      orderIndex: orderIndex ?? this.orderIndex,
    );
  }
}
