part of 'logout_cubit.dart';

sealed class LogoutState {}

final class LogoutInitial extends LogoutState {}

final class LogoutLoading extends LogoutState {}

final class LogoutFailure extends LogoutState {
  final String? message;
  LogoutFailure({this.message});
}

final class LogoutSuccess extends LogoutState {
  final Status status;
  LogoutSuccess({required this.status});
}
