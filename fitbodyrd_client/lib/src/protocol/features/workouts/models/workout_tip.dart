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

abstract class WorkoutTip implements _i1.SerializableModel {
  WorkoutTip._({
    this.id,
    required this.content,
    required this.order,
  });

  factory WorkoutTip({
    int? id,
    required String content,
    required int order,
  }) = _WorkoutTipImpl;

  factory WorkoutTip.fromJson(Map<String, dynamic> jsonSerialization) {
    return WorkoutTip(
      id: jsonSerialization['id'] as int?,
      content: jsonSerialization['content'] as String,
      order: jsonSerialization['order'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String content;

  int order;

  /// Returns a shallow copy of this [WorkoutTip]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WorkoutTip copyWith({
    int? id,
    String? content,
    int? order,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WorkoutTip',
      if (id != null) 'id': id,
      'content': content,
      'order': order,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WorkoutTipImpl extends WorkoutTip {
  _WorkoutTipImpl({
    int? id,
    required String content,
    required int order,
  }) : super._(
         id: id,
         content: content,
         order: order,
       );

  /// Returns a shallow copy of this [WorkoutTip]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WorkoutTip copyWith({
    Object? id = _Undefined,
    String? content,
    int? order,
  }) {
    return WorkoutTip(
      id: id is int? ? id : this.id,
      content: content ?? this.content,
      order: order ?? this.order,
    );
  }
}
