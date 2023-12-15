// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BanksModel {
  final int? id;
  final String? name;
  final String? code;

  BanksModel(this.id, this.name, this.code);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'code': code,
    };
  }

  factory BanksModel.fromMap(Map<String, dynamic> map) {
    return BanksModel(
      map['id'] != null ? map['id'] as int : null,
      map['name'] != null ? map['name'] as String : null,
      map['code'] != null ? map['code'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BanksModel.fromJson(String source) =>
      BanksModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
