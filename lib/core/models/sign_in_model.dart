import 'package:happy_tech_mastering_api_with_flutter/core/api/api_keys.dart';

class SignInModel {
  final String message;
  final String token;

  SignInModel({required this.message, required this.token});

  factory SignInModel.fromJson(Map<String, dynamic> json) {
    return SignInModel(
      message: json[ApiKeys.message],
      token: json[ApiKeys.token],
    );
  }
}
