 class UserState {}

final class UserInitial extends UserState {}
final class SignInSuccess extends UserState {}
final class SignInFailure extends UserState {
  final String message;
  SignInFailure({required this.message});
}
final class SignInLoading extends UserState {}
