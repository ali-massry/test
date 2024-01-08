import 'package:capef/models/get_security_questions.dart';
import 'package:capef/repositories/security_questions/get_security_questions_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'get_security_questions_state.dart';

class GetSecurityQuestionsCubit extends Cubit<GetSecurityQuestionsState> {
  GetSecurityQuestionsCubit() : super(GetSecurityQuestionsInitial());
  int? selectedQuestionId;

  // List<Securityqsts> securityQuestionsState = [];

  Future getSecurityQuestions({required String jwttoken}) async {
    try {
      emit(GetSecurityQuestionsLoading());
      final response =
          await SecurityQuestionsRepo.getSecurityQuestions(jwttoken: jwttoken);
      if ((response as GetSecurityQuestions).status?.code == 0) {
       

        // securityQuestionsState = response.securityqsts ?? [];
        // print(securityQuestionsState);
        emit(GetSecurityQuestionsSuccess(getSecurityQuestions: response));
      } else {
        emit(
          GetSecurityQuestionsFailure(message: 'Échec'),
        );
      }
    } catch (e) {
      emit(
        GetSecurityQuestionsFailure(message: e.toString()),
      );
    }
  }
}
