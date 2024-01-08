part of 'forget_password_cubit.dart';

sealed class ForgetPasswordState {}

final class ForgetPasswordInitial extends ForgetPasswordState {}

final class ForgetPasswordLoading extends ForgetPasswordState {}

final class ForgetPasswordFailure extends ForgetPasswordState {
  final Status? status;
  ForgetPasswordFailure({this.status});
}

final class ForgetPasswordSuccess extends ForgetPasswordState {
  final Status status;
  ForgetPasswordSuccess({required this.status});
}
