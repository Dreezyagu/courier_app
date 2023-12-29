// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DeliveryModel {
  final String? id;
  final String? receiverName;
  final String? receiverPhone;
  final String? pickupAddress;
  final String? pickupLat;
  final String? pickupLog;
  final String? deliveryAddress;
  final String? deliveryLandmark;
  final String? pickupLandmark;
  final String? deliveryLat;
  final String? deliveryLog;
  final String? estimatedPickupTime;
  final String? estimatedDeliveryTime;
  final String? actualDeliveryTime;
  final String? status;
  final String? totalCost;
  final String? distance;
  final String? deliveryMode;
  final String? createdAt;
  final String? deletedAt;
  final String? updatedAt;
  final Package? package;
  final Courier? courier;

  DeliveryModel(
      this.id,
      this.receiverName,
      this.receiverPhone,
      this.pickupAddress,
      this.pickupLat,
      this.pickupLog,
      this.deliveryAddress,
      this.deliveryLandmark,
      this.pickupLandmark,
      this.deliveryLat,
      this.deliveryLog,
      this.estimatedPickupTime,
      this.estimatedDeliveryTime,
      this.actualDeliveryTime,
      this.status,
      this.totalCost,
      this.distance,
      this.deliveryMode,
      this.createdAt,
      this.deletedAt,
      this.updatedAt,
      this.package,
      this.courier);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'receiverName': receiverName,
      'receiverPhone': receiverPhone,
      'pickupAddress': pickupAddress,
      'pickupLat': pickupLat,
      'pickupLog': pickupLog,
      'deliveryAddress': deliveryAddress,
      'deliveryLandmark': deliveryLandmark,
      'pickupLandmark': pickupLandmark,
      'deliveryLat': deliveryLat,
      'deliveryLog': deliveryLog,
      'estimatedPickupTime': estimatedPickupTime,
      'estimatedDeliveryTime': estimatedDeliveryTime,
      'actualDeliveryTime': actualDeliveryTime,
      'status': status,
      'totalCost': totalCost,
      'distance': distance,
      'deliveryMode': deliveryMode,
      'createdAt': createdAt,
      'deletedAt': deletedAt,
      'updatedAt': updatedAt,
      'package': package?.toMap(),
      'courier': courier?.toMap(),
    };
  }

  factory DeliveryModel.fromMap(Map<String, dynamic> map) {
    return DeliveryModel(
      map['id'] != null ? map['id'] as String : null,
      map['receiverName'] != null ? map['receiverName'] as String : null,
      map['receiverPhone'] != null ? map['receiverPhone'] as String : null,
      map['pickupAddress'] != null ? map['pickupAddress'] as String : null,
      map['pickupLat'] != null ? map['pickupLat'] as String : null,
      map['pickupLog'] != null ? map['pickupLog'] as String : null,
      map['deliveryAddress'] != null ? map['deliveryAddress'] as String : null,
      map['deliveryLandmark'] != null
          ? map['deliveryLandmark'] as String
          : null,
      map['pickupLandmark'] != null ? map['pickupLandmark'] as String : null,
      map['deliveryLat'] != null ? map['deliveryLat'] as String : null,
      map['deliveryLog'] != null ? map['deliveryLog'] as String : null,
      map['estimatedPickupTime'] != null
          ? map['estimatedPickupTime'] as String
          : null,
      map['estimatedDeliveryTime'] != null
          ? map['estimatedDeliveryTime'] as String
          : null,
      map['actualDeliveryTime'] != null
          ? map['actualDeliveryTime'] as String
          : null,
      map['status'] != null ? map['status'] as String : null,
      map['totalCost'] != null ? map['totalCost'] as String : null,
      map['distance'] != null ? map['distance'] as String : null,
      map['deliveryMode'] != null ? map['deliveryMode'] as String : null,
      map['createdAt'] != null ? map['createdAt'] as String : null,
      map['deletedAt'] != null ? map['deletedAt'] as String : null,
      map['updatedAt'] != null ? map['updatedAt'] as String : null,
      map['package'] != null
          ? Package.fromMap(map['package'] as Map<String, dynamic>)
          : null,
      map['courier'] != null
          ? Courier.fromMap(map['courier'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeliveryModel.fromJson(String source) =>
      DeliveryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Package {
  final String? id;
  final String? description;
  final String? worth;
  final String? weight;
  final bool? fragile;
  final String? status;
  final List<String>? photoUrls;
  final String? instructions;
  final String? pickupDateTime;
  final String? expectedDeliveryDateTime;
  final String? actualDeliveryDateTime;
  final String? receiverName;
  final String? receiverPhone;
  final String? createdAt;
  final String? updatedAt;

  Package(
      this.id,
      this.description,
      this.worth,
      this.weight,
      this.fragile,
      this.status,
      this.photoUrls,
      this.instructions,
      this.pickupDateTime,
      this.expectedDeliveryDateTime,
      this.actualDeliveryDateTime,
      this.receiverName,
      this.receiverPhone,
      this.createdAt,
      this.updatedAt);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
      'worth': worth,
      'weight': weight,
      'fragile': fragile,
      'status': status,
      'photoUrls': photoUrls,
      'instructions': instructions,
      'pickupDateTime': pickupDateTime,
      'expectedDeliveryDateTime': expectedDeliveryDateTime,
      'actualDeliveryDateTime': actualDeliveryDateTime,
      'receiverName': receiverName,
      'receiverPhone': receiverPhone,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Package.fromMap(Map<String, dynamic> map) {
    return Package(
      map['id'] != null ? map['id'] as String : null,
      map['description'] != null ? map['description'] as String : null,
      map['worth'] != null ? map['worth'] as String : null,
      map['weight'] != null ? map['weight'] as String : null,
      map['fragile'] != null ? map['fragile'] as bool : null,
      map['status'] != null ? map['status'] as String : null,
      map['photoUrls'] != null
          ? List<String>.from((map['photoUrls'] as List<dynamic>))
          : null,
      map['instructions'] != null ? map['instructions'] as String : null,
      map['pickupDateTime'] != null ? map['pickupDateTime'] as String : null,
      map['expectedDeliveryDateTime'] != null
          ? map['expectedDeliveryDateTime'] as String
          : null,
      map['actualDeliveryDateTime'] != null
          ? map['actualDeliveryDateTime'] as String
          : null,
      map['receiverName'] != null ? map['receiverName'] as String : null,
      map['receiverPhone'] != null ? map['receiverPhone'] as String : null,
      map['createdAt'] != null ? map['createdAt'] as String : null,
      map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Package.fromJson(String source) =>
      Package.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Courier {
  final String? id;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? profilePhoto;
  final String? phone2;
  final String? address;
  final int? otp;
  final String? otpExpiry;
  final bool? otpVerified;
  final String? role;
  final String? fcmToken;
  final String? status;
  final bool? isActivated;
  final String? idType;
  final String? idImageFront;
  final String? idNumber;
  final String? idImageBack;
  final String? electricityBill;
  final bool? registrationFeeStatus;
  final bool? isBanned;
  final String? bannedIpAddress;
  final String? createdAt;
  final String? updatedAt;

  Courier(
      this.id,
      this.username,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.profilePhoto,
      this.phone2,
      this.address,
      this.otp,
      this.otpExpiry,
      this.otpVerified,
      this.role,
      this.fcmToken,
      this.status,
      this.isActivated,
      this.idType,
      this.idImageFront,
      this.idNumber,
      this.idImageBack,
      this.electricityBill,
      this.registrationFeeStatus,
      this.isBanned,
      this.bannedIpAddress,
      this.createdAt,
      this.updatedAt);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'profilePhoto': profilePhoto,
      'phone2': phone2,
      'address': address,
      'otp': otp,
      'otpExpiry': otpExpiry,
      'otpVerified': otpVerified,
      'role': role,
      'fcmToken': fcmToken,
      'status': status,
      'isActivated': isActivated,
      'idType': idType,
      'idImageFront': idImageFront,
      'idNumber': idNumber,
      'idImageBack': idImageBack,
      'electricityBill': electricityBill,
      'registrationFeeStatus': registrationFeeStatus,
      'isBanned': isBanned,
      'bannedIpAddress': bannedIpAddress,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Courier.fromMap(Map<String, dynamic> map) {
    return Courier(
      map['id'] != null ? map['id'] as String : null,
      map['username'] != null ? map['username'] as String : null,
      map['firstName'] != null ? map['firstName'] as String : null,
      map['lastName'] != null ? map['lastName'] as String : null,
      map['email'] != null ? map['email'] as String : null,
      map['phone'] != null ? map['phone'] as String : null,
      map['profilePhoto'] != null ? map['profilePhoto'] as String : null,
      map['phone2'] != null ? map['phone2'] as String : null,
      map['address'] != null ? map['address'] as String : null,
      map['otp'] != null ? map['otp'] as int : null,
      map['otpExpiry'] != null ? map['otpExpiry'] as String : null,
      map['otpVerified'] != null ? map['otpVerified'] as bool : null,
      map['role'] != null ? map['role'] as String : null,
      map['fcmToken'] != null ? map['fcmToken'] as String : null,
      map['status'] != null ? map['status'] as String : null,
      map['isActivated'] != null ? map['isActivated'] as bool : null,
      map['idType'] != null ? map['idType'] as String : null,
      map['idImageFront'] != null ? map['idImageFront'] as String : null,
      map['idNumber'] != null ? map['idNumber'] as String : null,
      map['idImageBack'] != null ? map['idImageBack'] as String : null,
      map['electricityBill'] != null ? map['electricityBill'] as String : null,
      map['registrationFeeStatus'] != null
          ? map['registrationFeeStatus'] as bool
          : null,
      map['isBanned'] != null ? map['isBanned'] as bool : null,
      map['bannedIpAddress'] != null ? map['bannedIpAddress'] as String : null,
      map['createdAt'] != null ? map['createdAt'] as String : null,
      map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Courier.fromJson(String source) =>
      Courier.fromMap(json.decode(source) as Map<String, dynamic>);
}
