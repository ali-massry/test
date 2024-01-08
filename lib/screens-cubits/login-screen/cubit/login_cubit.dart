import 'dart:convert';
import 'package:capef/models/error_response.dart';
import 'package:capef/models/success_login_model.dart';
import 'package:capef/repositories/authentication/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future loginAgent({
    required String username,
    required String password,
    required String language,
  }) async {
    try {
      emit(LoginLoading());
      final response = await AuthRepository.agentLogin(
          userName: username, password: password, language: language);
      if ((response as SuccessLoginResponse).status?.code == 0) {
        Hive.box('localStorage').put('auth', jsonEncode(response));
        Hive.box('offlineData').put('agent', jsonEncode(response));
        // var h = jsonDecode(Hive.box('localStorage').get('model'));
        // print(h);
        emit(LoginSuccess(successLoginResponse: response));
      } else {
        emit(LoginFailure(status: response.status));
      }
      // if (response is ErrorResponse) {
      // } else {
      // }
    } catch (e) {
      emit(LoginFailure(status: Status(devmessage: e.toString())));
    }
  }
}
