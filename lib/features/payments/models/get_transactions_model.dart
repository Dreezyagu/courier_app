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
  final String? proof;
  final String? status;
  final String? approvalDate;
  final String? approvedById;
  final String? createdAt;
  final String? updatedAt;

  TransactionsModel(
      this.id,
      this.courierId,
      this.type,
      this.amount,
      this.prevBalance,
      this.currBalance,
      this.recordId,
      this.proof,
      this.status,
      this.approvalDate,
      this.approvedById,
      this.createdAt,
      this.updatedAt);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'courierId': courierId,
      'type': type,
      'amount': amount,
      'prevBalance': prevBalance,
      'currBalance': currBalance,
      'recordId': recordId,
      'proof': proof,
      'status': status,
      'approvalDate': approvalDate,
      'approvedById': approvedById,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory TransactionsModel.fromMap(Map<String, dynamic> map) {
    return TransactionsModel(
      map['id'] != null ? map['id'] as String : null,
      map['courierId'] != null ? map['courierId'] as String : null,
      map['type'] != null ? map['type'] as String : null,
      map['amount'] != null ? map['amount'] as String : null,
      map['prevBalance'] != null ? map['prevBalance'] as String : null,
      map['currBalance'] != null ? map['currBalance'] as String : null,
      map['recordId'] != null ? map['recordId'] as String : null,
      map['proof'] != null ? map['proof'] as String : null,
      map['status'] != null ? map['status'] as String : null,
      map['approvalDate'] != null ? map['approvalDate'] as String : null,
      map['approvedById'] != null ? map['approvedById'] as String : null,
      map['createdAt'] != null ? map['createdAt'] as String : null,
      map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionsModel.fromJson(String source) =>
      TransactionsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
