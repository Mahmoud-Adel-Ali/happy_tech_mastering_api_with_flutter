import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/api/api_consumer.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/api/api_keys.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/api/end_points.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/databases/cache/cache_helper.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/error/exception.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/functions/upload_image_to_api.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/models/sign_in_model.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/models/sign_up_model.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/models/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class UserRepo {
  final ApiConsumer api;

  UserRepo({required this.api});

  Future<Either<String, SignUpModel>> signUp({
    required TextEditingController signUpName,
    required TextEditingController signUpPhoneNumber,
    required TextEditingController signUpEmail,
    required TextEditingController signUpPassword,
    required TextEditingController confirmPassword,
    required XFile profilePic,
  }) async {
    try {
      final response = await api.post(
        EndPoints.signUp,
        isFormData: true,
        data: {
          ApiKeys.name: signUpName.text,
          ApiKeys.phone: signUpPhoneNumber.text,
          ApiKeys.email: signUpEmail.text,
          ApiKeys.password: signUpPassword.text,
          ApiKeys.confirmPassword: confirmPassword.text,
          ApiKeys.location:
              '{"name":"methalfa","address":"meet halfa","coordinates":[30.1572709,31.224779]}',
          ApiKeys.profilePic: await uploadImageToApi(profilePic),
        },
      );
      final signUpModel = SignUpModel.fromJson(response);
      return Right(signUpModel);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, SignInModel>> signIn({
    required TextEditingController signInEmail,
    required TextEditingController signInPassword,
  }) async {
    try {
      final response = await api.post(
        EndPoints.signIn,
        data: {
          ApiKeys.email: signInEmail.text,
          ApiKeys.password: signInPassword.text,
        },
      );
      var user = SignInModel.fromJson(response);
      final Map<String, dynamic> decodedToken = JwtDecoder.decode(user.token);
      // local storage
      CacheHelper().setString(ApiKeys.id, decodedToken[ApiKeys.id]);
      CacheHelper().setString(ApiKeys.token, user.token);
      //
      return Right(user);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, UserModel>> getUserProfileData() async {
    try {
      final response = await api.get(
        EndPoints.getUserDataEndPoint(CacheHelper().getString(ApiKeys.id)!),
      );
      // print(response.toString());
      final userModel = UserModel.fromJson(response);
      return Right(userModel);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, SignUpModel>> updateUser({
    required UserModel user,
    required TextEditingController updateName,
    required TextEditingController updatePhoneNumber,
    required XFile? profilePic,
  }) async {
    try {
      final response = await api.patch(
        EndPoints.update,
        isFormData: true,
        data: {
          ApiKeys.name: updateName.text != '' ? updateName.text : user.name,
          ApiKeys.phone: updatePhoneNumber.text != ''
              ? updatePhoneNumber.text
              : user.phone,
          ApiKeys.profilePic: profilePic != null
              ? await uploadImageToApi(profilePic)
              : user.profilePic,
          ApiKeys.location:
              '{"name":"/Egypt","address":"meet halfa","coordinates":[1214451511,12541845]}',
        },
      );
      final signUpModel = SignUpModel.fromJson(response);
      return Right(signUpModel);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, SignUpModel>> deleteUser() async {
    try {
      final response = await api.delete(
          EndPoints.getUserDataEndPoint(CacheHelper().getString(ApiKeys.id)!));
      SignUpModel signUpModel = SignUpModel.fromJson(response);
      return Right(signUpModel);
    } on ServerException catch (e) {
      return left(e.errorModel.errorMessage);
    }
  }
}
