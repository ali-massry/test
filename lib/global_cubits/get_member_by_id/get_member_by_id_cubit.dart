// ignore_for_file: avoid_print

import 'package:capef/models/detailed_member_model.dart';
import 'package:capef/models/error_response.dart';
import 'package:capef/repositories/member_repo/member_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'get_member_by_id_state.dart';

class GetMemberByIdCubit extends Cubit<GetMemberByIdState> {
  GetMemberByIdCubit() : super(GetMemberByIdInitial());

  Future getDetailedMember(
      {required String jwttoken, required String memberId}) async {
    try {
      emit(GetMemberByIdLoading());
      final response = await MemberRepository.getMemberById(
          jwttoken: jwttoken, memberId: memberId);

      if ((response as DetailedMemberModel).status?.code == 0) {
        // securityQuestionsState = response.securityqsts ?? [];
        // print(securityQuestionsState);
        emit(GetMemberByIdSuccess(detailedMemberModel: response));
      } else {
        print(response.status?.code);
        emit(
          GetMemberByIdFailure(status: response.status!),
        );
      }
    } catch (e) {
      print(e);

      emit(
        GetMemberByIdFailure(status: Status(devmessage: e.toString())),
      );
    }
  }
}
