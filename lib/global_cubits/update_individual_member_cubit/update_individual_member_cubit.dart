// ignore_for_file: avoid_print

import 'package:capef/models/error_response.dart';
import 'package:capef/models/update_individual_member_model.dart';
import 'package:capef/models/user_info_model.dart';
import 'package:capef/models/user_info_to_be_edited_model.dart';
import 'package:capef/repositories/member_repo/member_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'update_individual_member_state.dart';

class UpdateIndividualMemberCubit extends Cubit<UpdateIndividualMemberState> {
  UpdateIndividualMemberCubit() : super(UpdateIndividualMemberInitial());

  Future updateIndividualMember(
      {required String jwtToken,
      required UserInfo? userInfo,
      required UserInfoEdited? userInfoEdited}) async {
    try {
      emit(UpdateIndividualMemberLoading());
      final response = await MemberRepository.updateIndividualMember(
          jwtToken: jwtToken,
          userInfo: userInfo,
          userInfoEdited: userInfoEdited);
      UpdateLIndividualMemberModel updateLIndividualMemberModel =
          UpdateLIndividualMemberModel.fromJson(response);
      if (updateLIndividualMemberModel.status?.code == 0) {
        print(
            'INTERNAL CODE FOR Update Individual member TOKEN API ${updateLIndividualMemberModel.status?.code}');

        emit(UpdateIndividualMemberSucess(
            updateLIndividualMemberModel: updateLIndividualMemberModel));
      } else {
        UpdateLIndividualMemberModel updateLIndividualMemberModel =
            UpdateLIndividualMemberModel.fromJson(response);
        emit(UpdateIndividualMemberFailure(
            updateLIndividualMemberModel: updateLIndividualMemberModel));
      }
    } catch (e) {
      print(e);
      emit(UpdateIndividualMemberFailure(
          updateLIndividualMemberModel: UpdateLIndividualMemberModel(
              status:
                  Status(message: e.toString(), devmessage: e.toString()))));
    }
  }
}
