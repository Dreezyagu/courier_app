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
  final List<Tools>? tools;
  final List<BankInformation>? bankInformation;
  final List<Guarantor>? guarantor;
  final int? rating;
  final int? totalRating;
  final int? deliveries;

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
      this.updatedAt,
      this.tools,
      this.bankInformation,
      this.guarantor,
      this.rating,
      this.totalRating,
      this.deliveries);

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
      'tools': tools?.map((x) => x.toMap()).toList(),
      'bankInformation': bankInformation?.map((x) => x.toMap()).toList(),
      'guarantor': guarantor?.map((x) => x.toMap()).toList(),
      'rating': rating,
      'totalRating': totalRating,
      'deliveries': deliveries,
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
      map['isActivated'] != null ? map['isActivated'] as bool : null,
      map['isBanned'] != null ? map['isBanned'] as bool : null,
      map['otpVerified'] != null ? map['otpVerified'] as bool : null,
      map['fcmToken'] != null ? map['fcmToken'] as String : null,
      map['id'] != null ? map['id'] as String : null,
      map['status'] != null ? map['status'] as String : null,
      map['createdAt'] != null ? map['createdAt'] as String : null,
      map['updatedAt'] != null ? map['updatedAt'] as String : null,
      map['tools'] != null
          ? List<Tools>.from(
              (map['tools'] as List<dynamic>).map<Tools?>(
                (x) => Tools.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      map['bankInformation'] != null
          ? List<BankInformation>.from(
              (map['bankInformation'] as List<dynamic>).map<BankInformation?>(
                (x) => BankInformation.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      map['guarantor'] != null
          ? List<Guarantor>.from(
              (map['guarantor'] as List<dynamic>).map<Guarantor?>(
                (x) => Guarantor.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      map['rating'] != null ? map['rating'] as int : null,
      map['totalRating'] != null ? map['totalRating'] as int : null,
      map['deliveries'] != null ? map['deliveries'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Tools {
  final int? id;
  final String? vehicleType;
  final String? proof;
  final String? image;
  final String? createdAt;
  final String? updatedAt;

  Tools(this.id, this.vehicleType, this.proof, this.image, this.createdAt,
      this.updatedAt);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'vehicleType': vehicleType,
      'proof': proof,
      'image': image,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Tools.fromMap(Map<String, dynamic> map) {
    return Tools(
      map['id'] != null ? map['id'] as int : null,
      map['vehicleType'] != null ? map['vehicleType'] as String : null,
      map['proof'] != null ? map['proof'] as String : null,
      map['image'] != null ? map['image'] as String : null,
      map['createdAt'] != null ? map['createdAt'] as String : null,
      map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Tools.fromJson(String source) =>
      Tools.fromMap(json.decode(source) as Map<String, dynamic>);
}

class BankInformation {
  final int? id;
  final String? name;
  final String? code;
  final String? bvn;
  final String? holder;
  final String? number;
  final String? createdAt;
  final String? updatedAt;

  BankInformation(this.id, this.name, this.code, this.bvn, this.holder,
      this.number, this.createdAt, this.updatedAt);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'code': code,
      'bvn': bvn,
      'holder': holder,
      'number': number,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory BankInformation.fromMap(Map<String, dynamic> map) {
    return BankInformation(
      map['id'] != null ? map['id'] as int : null,
      map['name'] != null ? map['name'] as String : null,
      map['code'] != null ? map['code'] as String : null,
      map['bvn'] != null ? map['bvn'] as String : null,
      map['holder'] != null ? map['holder'] as String : null,
      map['number'] != null ? map['number'] as String : null,
      map['createdAt'] != null ? map['createdAt'] as String : null,
      map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BankInformation.fromJson(String source) =>
      BankInformation.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Guarantor {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? relationship;
  final String? occupation;
  final String? address;
  final String? phone;
  final String? email;
  final String? createdAt;
  final String? updatedAt;

  Guarantor(
      this.id,
      this.firstName,
      this.lastName,
      this.relationship,
      this.occupation,
      this.address,
      this.phone,
      this.email,
      this.createdAt,
      this.updatedAt);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'relationship': relationship,
      'occupation': occupation,
      'address': address,
      'phone': phone,
      'email': email,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Guarantor.fromMap(Map<String, dynamic> map) {
    return Guarantor(
      map['id'] != null ? map['id'] as int : null,
      map['firstName'] != null ? map['firstName'] as String : null,
      map['lastName'] != null ? map['lastName'] as String : null,
      map['relationship'] != null ? map['relationship'] as String : null,
      map['occupation'] != null ? map['occupation'] as String : null,
      map['address'] != null ? map['address'] as String : null,
      map['phone'] != null ? map['phone'] as String : null,
      map['email'] != null ? map['email'] as String : null,
      map['createdAt'] != null ? map['createdAt'] as String : null,
      map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Guarantor.fromJson(String source) =>
      Guarantor.fromMap(json.decode(source) as Map<String, dynamic>);
}
