import 'package:happy_tech_mastering_api_with_flutter/core/api/api_keys.dart';

class UserModel {
  final String profilePic;
  final String name;
  final String email;
  final String phone;
  final Map<String, dynamic> address;

  UserModel({
    required this.profilePic,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      profilePic: json['user'][ApiKeys.profilePic],
      name: json['user'][ApiKeys.name],
      email: json['user'][ApiKeys.email],
      phone: json['user'][ApiKeys.phone],
      address: json['user'][ApiKeys.location],
    );
  }
}
