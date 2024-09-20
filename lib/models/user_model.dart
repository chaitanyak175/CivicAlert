// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String email;
  final String name;
  final String address;
  final String uid;
  final String profilePic;
  final String mobileNo;
  final bool isVerified;
  UserModel({
    required this.email,
    required this.name,
    required this.address,
    required this.uid,
    required this.profilePic,
    required this.mobileNo,
    required this.isVerified,
  });

  UserModel copyWith({
    String? email,
    String? name,
    String? address,
    String? uid,
    String? profilePic,
    String? mobileNo,
    bool? isVerified,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      address: address ?? this.address,
      uid: uid ?? this.uid,
      profilePic: profilePic ?? this.profilePic,
      mobileNo: mobileNo ?? this.mobileNo,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'address': address,
      'profilePic': profilePic,
      'mobileNo': mobileNo,
      'isVerified': isVerified,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      uid: map['_id'] ?? '',
      profilePic: map['profilePic'] ?? '',
      mobileNo: map['mobileNo'] ?? '',
      isVerified: map['isVerified'] ?? false,
    );
  }

  @override
  String toString() {
    return 'UserModel(email: $email, name: $name, address: $address, uid: $uid, profilePic: $profilePic, mobileNo: $mobileNo, isVerified: $isVerified)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.name == name &&
        other.address == address &&
        other.uid == uid &&
        other.profilePic == profilePic &&
        other.mobileNo == mobileNo &&
        other.isVerified == isVerified;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        name.hashCode ^
        address.hashCode ^
        uid.hashCode ^
        profilePic.hashCode ^
        mobileNo.hashCode ^
        isVerified.hashCode;
  }
}
