// ignore_for_file: avoid_print

import 'package:capef/models/error_response.dart';
import 'package:capef/models/get_security_by_username_model.dart';
import 'package:capef/repositories/authentication/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'get_agent_by_user_name_state.dart';

class GetAgentByUserNameCubit extends Cubit<GetAgentByUserNameState> {
  GetAgentByUserNameCubit() : super(GetAgentByUserNameInitial());

  Future getAgentByUserName({required String userName}) async {
    try {
      emit(GetAgentByUserNameLoading());
      final response =
          await AuthRepository.getAgentByUserName(userName: userName);
      if (response.status?.code == 0) {
        emit(GetAgentByUserNameSuccess(getQuestionByUserNameModel: response));
      } else {
        emit(GetAgentByUserNameFailure(status: response.status!));
      }
    } catch (e) {
      print(e.toString());
      emit(GetAgentByUserNameFailure(
        status: Status(devmessage: e.toString()),
      ));
    }
  }
}
