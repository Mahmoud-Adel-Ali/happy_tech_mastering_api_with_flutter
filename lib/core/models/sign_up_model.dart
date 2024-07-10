import 'package:happy_tech_mastering_api_with_flutter/core/api/api_keys.dart';

class SignUpModel {
  final String message;

  SignUpModel({required this.message});

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      message: json[ApiKeys.message],
    );
  }
}
