import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/api/api_consumer.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/api/api_keys.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/api/end_points.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/databases/cache/cache_helper.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/error/exception.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/functions/upload_image_to_api.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/models/sign_in_model.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/models/sign_up_model.dart';
import 'package:happy_tech_mastering_api_with_flutter/cubit/user_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class UserCubit extends Cubit<UserState> {
  final ApiConsumer api;
  UserCubit(this.api) : super(UserInitial());
  //Sign in Form key
  GlobalKey<FormState> signInFormKey = GlobalKey();
  //Sign in email
  TextEditingController signInEmail = TextEditingController();
  //Sign in password
  TextEditingController signInPassword = TextEditingController();
  //Sign Up Form key
  GlobalKey<FormState> signUpFormKey = GlobalKey();
  //Profile Pic
  XFile? profilePic;
  //Sign up name
  TextEditingController signUpName = TextEditingController();
  //Sign up phone number
  TextEditingController signUpPhoneNumber = TextEditingController();
  //Sign up email
  TextEditingController signUpEmail = TextEditingController();
  //Sign up password
  TextEditingController signUpPassword = TextEditingController();
  //Sign up confirm password
  TextEditingController confirmPassword = TextEditingController();

  upLoadProfilPicture(XFile image) {
    profilePic = image;
    emit(UpLoadProfilePicture());
  }

  //Sign up
  signUp() async {
    try {
      emit(SignUpLoading());
      final response = await api.post(
        EndPoints.signUp,
        isFormData: true,
        data: {
          ApiKeys.name: signUpName.text,
          ApiKeys.phone: signUpPhoneNumber.text,
          ApiKeys.email: signUpEmail.text,
          ApiKeys.password: signUpPassword.text,
          ApiKeys.confirmPassword: confirmPassword,
          ApiKeys.location: {
            "name": "methalfa",
            "address": "meet halfa",
            "coordinates": [30.1572709, 31.224779]
          },
          ApiKeys.profilePic: await uploadImageToApi(profilePic!),
        },
      );
      final signUpModel = SignUpModel.fromJson(response);
      emit(SignUpSuccess(message: signUpModel.message));
    } on ServerException catch (e) {
      emit(SignUpFailure(message: e.errorModel.errorMessage));
    }
  }

  SignInModel? user;
  signIn() async {
    try {
      emit(SignInLoading());
      final response = await api.post(
        EndPoints.signIn,
        data: {
          ApiKeys.email: signInEmail.text,
          ApiKeys.password: signInPassword.text,
        },
      );
      user = SignInModel.fromJson(response);
      final Map<String, dynamic> decodedToken = JwtDecoder.decode(user!.token);
      print(decodedToken[ApiKeys.id]);
      // local storage
      CacheHelper().setString(ApiKeys.id, decodedToken[ApiKeys.id]);
      CacheHelper().setString(ApiKeys.token, user!.token);
      //
      emit(SignInSuccess());
    } on ServerException catch (e) {
      emit(SignInFailure(message: e.errorModel.errorMessage));
    }
  }
}
