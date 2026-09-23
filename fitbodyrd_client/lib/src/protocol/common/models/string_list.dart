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
import 'package:fitbodyrd_client/src/protocol/protocol.dart' as _i2;

abstract class StringList implements _i1.SerializableModel {
  StringList._({required this.items});

  factory StringList({required List<String> items}) = _StringListImpl;

  factory StringList.fromJson(Map<String, dynamic> jsonSerialization) {
    return StringList(
      items: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['items'],
      ),
    );
  }

  List<String> items;

  /// Returns a shallow copy of this [StringList]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StringList copyWith({List<String>? items});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StringList',
      'items': items.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _StringListImpl extends StringList {
  _StringListImpl({required List<String> items}) : super._(items: items);

  /// Returns a shallow copy of this [StringList]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StringList copyWith({List<String>? items}) {
    return StringList(items: items ?? this.items.map((e0) => e0).toList());
  }
}
