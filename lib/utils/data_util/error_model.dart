// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class ErrorModel {
  final int? status;
  final String? message;
  final String? error_message;

  ErrorModel(this.status, this.message, this.error_message);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'message': message,
      'error_message': error_message,
    };
  }

  factory ErrorModel.fromMap(Map<String, dynamic> map) {
    return ErrorModel(map['status'] != null ? map['status'] as int : null,
        map['message']?.toString(), map['error_message']?.toString());
  }

  String toJson() => json.encode(toMap());

  factory ErrorModel.fromJson(String source) =>
      ErrorModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
