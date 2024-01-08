// ignore_for_file: avoid_print

import 'dart:io';
import 'package:capef/models/add_individual_member_failure_model.dart';
import 'package:capef/models/add_legal_entity_success.dart';
import 'package:capef/models/legal_entity_info.dart';
import 'package:capef/repositories/member_repo/member_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'group_flow_state.dart';

class GroupFlowCubit extends Cubit<GroupFlowState> {
  GroupFlowCubit() : super(GroupFlowInitial());
  File? photo;
  String? offlineId;
  String? legalentitycategoryid;
  String? turnoverid;
  String? name;
  String? regnumber;
  String? certificatedate;
  String? pin;
  String? secanswer;
  String? securityqstid;
  String? phone1;
  String? phone2;
  String? email;
  String? website;
  String? noofmembers;
  String? women;
  String? villageid;
  String? long;
  String? lat;
  String? seasonpayment;
  String? subscriptionpayment;
  String? pobox;
  String? mainactivityid;
  String? secondaryactivityid;
  String? representativesJson;
  LegalEntityInfo? legalEntityInfo;

  void addgroupPhoto({required File? groupPhotoo}) {
    photo = groupPhotoo;

    emit(GroupFlowSuccess());
  }

  Future addLegalEntityMember({required String jwtToken}) async {
    try {
      legalEntityInfo = LegalEntityInfo(
          legalentitycategoryid: legalentitycategoryid,
          turnoverid: turnoverid,
          name: name,
          regnumber: regnumber,
          certificatedate: certificatedate,
          photoRegistration: photo,
          phone1: phone1,
          phone2: phone2,
          email: email,
          website: website,
          noofmembers: noofmembers,
          women: women,
          pobox: pobox,
          villageid: villageid,
          lat: lat,
          long: long,
          representativesJson: representativesJson,
          mainactivityid: mainactivityid,
          secondaryactivityid: secondaryactivityid,
          seasonpayment: seasonpayment,
          subscriptionpayment: subscriptionpayment,
          pin: pin,
          securityqstid: securityqstid,
          secanswer: secanswer,
          offlineId: offlineId);
      emit(AddLegalEntityPersonLoading());
      final response = await MemberRepository.addlegalEntityMember(
          jwtToken: jwtToken, legalEntityInfo: legalEntityInfo);
      AddLegalEntitySuccessModel addLegalEntitySuccessModel =
          AddLegalEntitySuccessModel.fromJson(response);
      if (addLegalEntitySuccessModel.status?.code == 0) {
        print(
            'INTERNAL CODE FOR Add LEGAL ENTITY TOKEN API ${addLegalEntitySuccessModel.status?.code}');

        emit(AddLegalEntitySuccess(
            addLegalEntitySuccessModel: addLegalEntitySuccessModel));
      } else {
        AddIndividualMemberFailureModel addIndividualMemberFailureModel =
            AddIndividualMemberFailureModel.fromJson(response);
        emit(AddLegalEntityPersonFailure(
            failureModel: addIndividualMemberFailureModel));
      }
    } catch (e) {
      print(e);
      emit(AddLegalEntityPersonFailure(
          failureModel: AddIndividualMemberFailureModel(title: e.toString())));
    }
  }
}
