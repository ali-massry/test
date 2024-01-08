// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:capef/models/error_response.dart';
import 'package:capef/repositories/authentication/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/success_login_model.dart';
part 'refresh_token_state.dart';

class RefreshTokenCubit extends Cubit<RefreshTokenState> {
  RefreshTokenCubit() : super(RefreshTokenInitial());

  Future refreshToken(
      {required String jwtToken, required String refreshToken}) async {
    try {
      emit(RefreshTokenLoading());
      final response = await AuthRepository.refreshToken(
          jwtToken: jwtToken, refreshToken: refreshToken);
      if ((response as SuccessLoginResponse).status?.code == 0) {
        print('INTERNAL CODE FOR REFRESH TOKEN API ${response.status?.code}');
        Hive.box('localStorage').put('auth', jsonEncode(response));
        Hive.box('offlineData').put('agent', jsonEncode(response));
        emit(RefreshTokenSuccess(successRefreshTokenResponse: response));
      } else {
        print('INTERNAL CODE FOR REFRESH TOKEN API ${response.status?.code}');
        Hive.box('offlineData').delete('agent');
        Hive.box('localStorage').clear();
        emit(RefreshTokenFailureApi(status: response.status));
      }
    } catch (e) {
      emit(RefreshTokenFailure(status: Status(devmessage: e.toString())));
    }
  }
}
