part of 'change_password_cubit.dart';

sealed class ChangePasswordState {}

final class ChangePasswordInitial extends ChangePasswordState {}

final class ChangePasswordLoading extends ChangePasswordState {}

final class ChangePasswordSuccess extends ChangePasswordState {
  final Status? status;
  ChangePasswordSuccess({required this.status});
}

final class ChangePasswordFailure extends ChangePasswordState {
  final Status? status;
  ChangePasswordFailure({required this.status});
}
