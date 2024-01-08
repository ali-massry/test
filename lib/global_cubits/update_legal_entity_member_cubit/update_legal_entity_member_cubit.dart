// ignore_for_file: avoid_print

import 'package:capef/models/error_response.dart';
import 'package:capef/models/legal_entity_info.dart';
import 'package:capef/models/update_legal_entity_model.dart';
import 'package:capef/repositories/member_repo/member_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'update_legal_entity_member_state.dart';

class UpdateLegalEntityMemberCubit extends Cubit<UpdateLegalEntityMemberState> {
  UpdateLegalEntityMemberCubit() : super(UpdateLegalEntityMemberInitial());

  Future updateLegalEntityMember(
      {required String jwtToken,
      required LegalEntityInfo legalEntityInfo}) async {
    try {
      emit(UpdateLegalEntityMemberLoading());
      final response = await MemberRepository.updateLegalEntityMember(
          jwtToken: jwtToken, legalEntityInfo: legalEntityInfo);
      UpdateLegalEntityMemberModel updateLegalEntityMemberModel =
          UpdateLegalEntityMemberModel.fromJson(response);
      if (updateLegalEntityMemberModel.status?.code == 0) {
        print(
            'INTERNAL CODE FOR Update LegalENtity TOKEN API ${updateLegalEntityMemberModel.status?.code}');

        emit(UpdateLegalEntityMemberSucess(
            updateLegalEntityMemberModel: updateLegalEntityMemberModel));
      } else if (updateLegalEntityMemberModel.status?.code != 0) {
        UpdateLegalEntityMemberModel updateLIndividualMemberModel =
            UpdateLegalEntityMemberModel.fromJson(response);
        emit(UpdateLegalEntityMemberFailure(
            updateLegalEntityMemberModel: updateLIndividualMemberModel));
      }
    } catch (e) {
      print(e);
      emit(UpdateLegalEntityMemberFailure(
          updateLegalEntityMemberModel: UpdateLegalEntityMemberModel(
              status: Status(
                  message: 'Something went wrong',
                  devmessage: 'Something went wrong'))));
    }
  }
}
