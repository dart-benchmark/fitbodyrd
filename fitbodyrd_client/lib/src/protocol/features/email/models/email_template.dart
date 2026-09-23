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
import '../../../features/email/models/email_templates_enum.dart' as _i2;

abstract class EmailTemplate implements _i1.SerializableModel {
  EmailTemplate._({
    this.id,
    required this.type,
    required this.content,
    required this.subject,
    required this.plainTextContent,
  });

  factory EmailTemplate({
    int? id,
    required _i2.EmailTemplatesEnum type,
    required String content,
    required String subject,
    required String plainTextContent,
  }) = _EmailTemplateImpl;

  factory EmailTemplate.fromJson(Map<String, dynamic> jsonSerialization) {
    return EmailTemplate(
      id: jsonSerialization['id'] as int?,
      type: _i2.EmailTemplatesEnum.fromJson(
        (jsonSerialization['type'] as String),
      ),
      content: jsonSerialization['content'] as String,
      subject: jsonSerialization['subject'] as String,
      plainTextContent: jsonSerialization['plainTextContent'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i2.EmailTemplatesEnum type;

  String content;

  String subject;

  String plainTextContent;

  /// Returns a shallow copy of this [EmailTemplate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EmailTemplate copyWith({
    int? id,
    _i2.EmailTemplatesEnum? type,
    String? content,
    String? subject,
    String? plainTextContent,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EmailTemplate',
      if (id != null) 'id': id,
      'type': type.toJson(),
      'content': content,
      'subject': subject,
      'plainTextContent': plainTextContent,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EmailTemplateImpl extends EmailTemplate {
  _EmailTemplateImpl({
    int? id,
    required _i2.EmailTemplatesEnum type,
    required String content,
    required String subject,
    required String plainTextContent,
  }) : super._(
         id: id,
         type: type,
         content: content,
         subject: subject,
         plainTextContent: plainTextContent,
       );

  /// Returns a shallow copy of this [EmailTemplate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EmailTemplate copyWith({
    Object? id = _Undefined,
    _i2.EmailTemplatesEnum? type,
    String? content,
    String? subject,
    String? plainTextContent,
  }) {
    return EmailTemplate(
      id: id is int? ? id : this.id,
      type: type ?? this.type,
      content: content ?? this.content,
      subject: subject ?? this.subject,
      plainTextContent: plainTextContent ?? this.plainTextContent,
    );
  }
}
