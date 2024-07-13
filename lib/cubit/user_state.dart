import 'package:happy_tech_mastering_api_with_flutter/core/models/user_model.dart';

class UserState {}

final class UserInitial extends UserState {}

final class SignInSuccess extends UserState {}

final class SignInFailure extends UserState {
  final String message;
  SignInFailure({required this.message});
}

final class SignInLoading extends UserState {}

final class UpLoadProfilePicture extends UserState {}

final class SignUpLoading extends UserState {}

final class SignUpSuccess extends UserState {
  final String message;
  SignUpSuccess({required this.message});
}

final class SignUpFailure extends UserState {
  final String message;
  SignUpFailure({required this.message});
}

class GetUserProfileDataLoading extends UserState {}

class GetUserProfileDataFailure extends UserState {
  final String message;
  GetUserProfileDataFailure({required this.message});
}

class GetUserProfileDataSuccess extends UserState {
  final UserModel userModel;
  GetUserProfileDataSuccess({required this.userModel});
}

class UpdateLoading extends UserState {}

class UpdateSuccess extends UserState {
  final String message;
  UpdateSuccess({required this.message});
}

class UpdateFailure extends UserState {
  final String message;
  UpdateFailure({required this.message});
}

class DeletingLoading extends UserState{}
class DeletingSuccess extends UserState{
  final String message;
  DeletingSuccess({required this.message});
}
class DeletingFailure extends UserState{
  final String message;
  DeletingFailure({required this.message});
}
