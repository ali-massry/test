part of 'refresh_token_cubit.dart';

sealed class RefreshTokenState {}

final class RefreshTokenInitial extends RefreshTokenState {}

final class RefreshTokenLoading extends RefreshTokenState {}

final class RefreshTokenSuccess extends RefreshTokenState {
  final SuccessLoginResponse? successRefreshTokenResponse;
  RefreshTokenSuccess({required this.successRefreshTokenResponse});
}

final class RefreshTokenFailure extends RefreshTokenState {
  final Status? status;
  RefreshTokenFailure({required this.status});
}

final class RefreshTokenFailureApi extends RefreshTokenState {
  final Status? status;
  RefreshTokenFailureApi({required this.status});
}
