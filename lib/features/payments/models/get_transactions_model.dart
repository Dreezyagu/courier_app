// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TransactionsModel {
  final String? id;
  final String? courierId;
  final String? type;
  final String? amount;
  final String? prevBalance;
  final String? currBalance;
  final String? recordId;
  final String? createdAt;
  final String? updatedAt;

  TransactionsModel(
      {required this.id,
      required this.courierId,
      required this.type,
      required this.amount,
      required this.prevBalance,
      required this.currBalance,
      required this.recordId,
      required this.createdAt,
      required this.updatedAt});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'courierId': courierId,
      'type': type,
      'amount': amount,
      'prevBalance': prevBalance,
      'currBalance': currBalance,
      'recordId': recordId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory TransactionsModel.fromMap(Map<String, dynamic> map) {
    return TransactionsModel(
      id: map['id'] != null ? map['id'] as String : null,
      courierId: map['courierId'] != null ? map['courierId'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      amount: map['amount'] != null ? map['amount'] as String : null,
      prevBalance:
          map['prevBalance'] != null ? map['prevBalance'] as String : null,
      currBalance:
          map['currBalance'] != null ? map['currBalance'] as String : null,
      recordId: map['recordId'] != null ? map['recordId'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionsModel.fromJson(String source) =>
      TransactionsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
