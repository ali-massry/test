import 'package:capef/models/error_response.dart';
import 'package:capef/repositories/authentication/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial());

  Future logoutAgent({required String jwtToken}) async {
    try {
      emit(LogoutLoading());
      final response = await AuthRepository.logout(jwtToken: jwtToken);
      if ((response as Status).code == 0) {
        emit(LogoutSuccess(status: response));
      } else {
        emit(LogoutFailure(message: 'Quelque chose s\'est mal passé'));
      }
      // if (response is ErrorResponse) {
      // } else {
      // }
    } catch (e) {
      emit(LogoutFailure(message: e.toString()));
    }
  }
}
