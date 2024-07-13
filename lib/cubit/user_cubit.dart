import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/models/user_model.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/reposetry/user_repo.dart';
import 'package:happy_tech_mastering_api_with_flutter/cubit/user_state.dart';
import 'package:image_picker/image_picker.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepo userRepo;
  UserCubit({required this.userRepo}) : super(UserInitial());
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
  // update
  GlobalKey<FormState> updateFormKey = GlobalKey();
  //update name
  TextEditingController? updateName = TextEditingController();
  //update phone number
  TextEditingController? updatePhoneNumber = TextEditingController();
  //update email
  TextEditingController? updateEmail = TextEditingController();

  getUserProfileData() async {
    emit(GetUserProfileDataLoading());
    final response = await userRepo.getUserProfileData();
    response.fold(
      (errorMessage) => emit(GetUserProfileDataFailure(message: errorMessage)),
      (userModel) => emit(GetUserProfileDataSuccess(userModel: userModel)),
    );
  }

  upLoadProfilPicture(XFile image) {
    profilePic = image;
    emit(UpLoadProfilePicture());
  }

  //Sign up
  signUp() async {
    emit(SignUpLoading());
    final response = await userRepo.signUp(
      signUpName: signUpName,
      signUpPhoneNumber: signUpPhoneNumber,
      signUpEmail: signUpEmail,
      signUpPassword: signUpPassword,
      confirmPassword: confirmPassword,
      profilePic: profilePic!,
    );
    response.fold(
      (erroeMessage) => emit(SignUpFailure(message: erroeMessage)),
      (signUpModel) => emit(SignUpSuccess(message: signUpModel.message)),
    );
  }

  signIn() async {
    emit(SignInLoading());
    final response = await userRepo.signIn(
        signInEmail: signInEmail, signInPassword: signInPassword);
    response.fold(
      (errorMessage) => emit(SignInFailure(message: errorMessage)),
      (signInModel) => emit(SignInSuccess()),
    );
  }

  //Sign up
  updateUser(UserModel user) async {
    final response = await userRepo.updateUser(
        user: user,
        updateName: updateName!,
        updatePhoneNumber: updatePhoneNumber!,
        profilePic: profilePic);
    response.fold(
      (errorMessage) => emit(UpdateFailure(message: errorMessage)),
      (signInModel) => emit(UpdateSuccess(message: signInModel.message)),
    );
  }

  deleteUser() async {
    emit(DeletingLoading());
    final response = await userRepo.deleteUser();
    response.fold(
      (errorMessage) => emit(DeletingFailure(message: errorMessage)),
      (signUpModel) => emit(DeletingSuccess(message: signUpModel.message)),
    );
  }
}
