import 'package:capef/models/error_response.dart';
import 'package:capef/repositories/authentication/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitial());

  Future changePassword({
    required String securityQuestionId,
    required String securityQuestionAnswer,
    required String password,
    required String jwtToken,
  }) async {
    try {
      final response = await AuthRepository.setFirstLogin(
        securityId: securityQuestionId,
        password: password,
        securityAnswer: securityQuestionAnswer,
        jwtToken: jwtToken,
      );
      if ((response as Status).code == 0) {
        Hive.box('localStorage').put('loggedIn', true);
        emit(ChangePasswordSuccess(status: response));
      } else {
        emit(ChangePasswordFailure(status: response));
      }
      // if (response is ErrorResponse) {
      // } else {
      // }
    } catch (e) {
      ChangePasswordFailure(status: Status(devmessage: e.toString()));
    }
  }
}
