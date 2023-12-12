// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? phone;
  final String? role;
  final String? profilePhoto;
  final String? address;
  final String? idType;
  final String? idImageFront;
  final String? idNumber;
  final String? idImageBack;
  final String? electricityBill;
  final bool? registrationFeeStatus;
  final bool? isActivated;
  final bool? isBanned;
  final bool? otpVerified;
  final String? fcmToken;
  final String? id;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  UserModel(
      this.username,
      this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.phone,
      this.role,
      this.profilePhoto,
      this.address,
      this.idType,
      this.idImageFront,
      this.idNumber,
      this.idImageBack,
      this.electricityBill,
      this.registrationFeeStatus,
      this.isActivated,
      this.isBanned,
      this.otpVerified,
      this.fcmToken,
      this.id,
      this.status,
      this.createdAt,
      this.updatedAt);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'phone': phone,
      'role': role,
      'profilePhoto': profilePhoto,
      'address': address,
      'idType': idType,
      'idImageFront': idImageFront,
      'idNumber': idNumber,
      'idImageBack': idImageBack,
      'electricityBill': electricityBill,
      'registrationFeeStatus': registrationFeeStatus,
      'isActivated': isActivated,
      'isBanned': isBanned,
      'otpVerified': otpVerified,
      'fcmToken': fcmToken,
      'id': id,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      map['username'] != null ? map['username'] as String : null,
      map['firstName'] != null ? map['firstName'] as String : null,
      map['lastName'] != null ? map['lastName'] as String : null,
      map['email'] != null ? map['email'] as String : null,
      map['password'] != null ? map['password'] as String : null,
      map['phone'] != null ? map['phone'] as String : null,
      map['role'] != null ? map['role'] as String : null,
      map['profilePhoto'] != null ? map['profilePhoto'] as String : null,
      map['address'] != null ? map['address'] as String : null,
      map['idType'] != null ? map['idType'] as String : null,
      map['idImageFront'] != null ? map['idImageFront'] as String : null,
      map['idNumber'] != null ? map['idNumber'] as String : null,
      map['idImageBack'] != null ? map['idImageBack'] as String : null,
      map['electricityBill'] != null ? map['electricityBill'] as String : null,
      map['registrationFeeStatus'] != null
          ? map['registrationFeeStatus'] as bool
          : null,
      map['isActivated'] != null ? map['isActivated'] as bool : false,
      map['isBanned'] != null ? map['isBanned'] as bool : null,
      map['otpVerified'] != null ? map['otpVerified'] as bool : null,
      map['fcmToken'] != null ? map['fcmToken'] as String : null,
      map['id'] != null ? map['id'] as String : null,
      map['status'] != null ? map['status'] as String : null,
      map['createdAt'] != null ? map['createdAt'] as String : null,
      map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
