import 'package:capef/models/error_response.dart';
import 'package:capef/repositories/authentication/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  Future resetPassword({
    required String? userName,
    required String? newPassword,
    required String? securityAnswerr,
    required String? securityqstid,
  }) async {
    try {
      emit(ForgetPasswordLoading());
      final response = await AuthRepository.resetPassword(
        username: userName!,
        newpassword: newPassword!,
        securityAnswer: securityAnswerr!,
        securityqstid: securityqstid ?? '',
      );
      if ((response as Status).code == 0) {
        emit(ForgetPasswordSuccess(status: response));
      } else {
        emit(ForgetPasswordFailure(status: response));
      }
    } catch (e) {
      emit(ForgetPasswordFailure(
        status: Status(devmessage: ''),
      ));
    }
  }
}
