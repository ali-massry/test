part of 'login_cubit.dart';

sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final SuccessLoginResponse? successLoginResponse;
  LoginSuccess({required this.successLoginResponse});
}

final class LoginFailure extends LoginState {
  final Status? status;
  LoginFailure({required this.status});
}
