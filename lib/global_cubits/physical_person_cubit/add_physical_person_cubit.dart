// ignore_for_file: avoid_print

import 'dart:io';
import 'package:capef/models/add_individual_member_failure_model.dart';
import 'package:capef/models/add_individual_member_success.dart';
import 'package:capef/models/user_info_model.dart';
import 'package:capef/repositories/member_repo/member_repository.dart';
import 'package:capef/screens-cubits/physical-person-flow/step-1/personal_info.dart';
import 'package:capef/screens-cubits/physical-person-flow/step-6/step_6_model.dart';
import 'package:capef/utils/functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'add_physical_person_state.dart';

class AddPhysicalPersonCubit extends Cubit<AddPhysicalPersonState> {
  AddPhysicalPersonCubit() : super(AddPhysicalPersonInitial());
  PersonalInformationModel? addPhysicalMemberStep1Model;
  File? nationalPhoto;
  File? rectoCNIPhoto;
  File? versoCNIPhoto;
  int? categoryId;

  void addNationalPhoto({required File? nationalPhotoo}) {
    nationalPhoto = nationalPhotoo;
    emit(AddNationalPhotoSuccess());
    emit(AddPhotosSuccess());
  }

  void addRectoPhoto({required File? rectoPhotoo}) {
    rectoCNIPhoto = rectoPhotoo;
    emit(AddPhotosSuccess());
  }

  void addVersoPhoto({required File? versoPhotoo}) {
    versoCNIPhoto = versoPhotoo;
    emit(AddPhotosSuccess());
  }

  UserInfo returnUserInfo(
      {required WholeUserInfoWithoutPrinciplesDetailsModel
          wholeUserInfoWithoutPrinciplesDetailsModel}) {
    return UserInfo(
      civilityid: wholeUserInfoWithoutPrinciplesDetailsModel
          .step5model!
          .step4model!
          .step3model!
          .addPhysicalMemberStep2Model!
          .addPhysicalMemberStep1Model!
          .civilityId
          .toString(),
      firstname: wholeUserInfoWithoutPrinciplesDetailsModel
          .step5model!
          .step4model!
          .step3model!
          .addPhysicalMemberStep2Model!
          .addPhysicalMemberStep1Model!
          .fname
          .toString(),
      lastname: wholeUserInfoWithoutPrinciplesDetailsModel
          .step5model!
          .step4model!
          .step3model!
          .addPhysicalMemberStep2Model!
          .addPhysicalMemberStep1Model!
          .lname
          .toString(),
      genderid: wholeUserInfoWithoutPrinciplesDetailsModel
          .step5model!
          .step4model!
          .step3model!
          .addPhysicalMemberStep2Model!
          .addPhysicalMemberStep1Model!
          .genderId
          .toString(),
      meterialStatusid: wholeUserInfoWithoutPrinciplesDetailsModel
          .step5model!
          .step4model!
          .step3model!
          .addPhysicalMemberStep2Model!
          .addPhysicalMemberStep1Model!
          .maternalSituationId
          .toString(),
      dob: GlobalFunctions.formatDateToAFormat(
          wholeUserInfoWithoutPrinciplesDetailsModel
              .step5model!
              .step4model!
              .step3model!
              .addPhysicalMemberStep2Model!
              .addPhysicalMemberStep1Model!
              .dateOfBirth!),
      placeofbirth: wholeUserInfoWithoutPrinciplesDetailsModel
          .step5model!
          .step4model!
          .step3model!
          .addPhysicalMemberStep2Model!
          .addPhysicalMemberStep1Model!
          .placeOfBorth
          .toString(),
      phone1: wholeUserInfoWithoutPrinciplesDetailsModel
          .step5model!
          .step4model!
          .step3model!
          .addPhysicalMemberStep2Model!
          .addPhysicalMemberStep1Model!
          .phone1
          .toString(),
      phone2: wholeUserInfoWithoutPrinciplesDetailsModel
          .step5model!
          .step4model!
          .step3model!
          .addPhysicalMemberStep2Model!
          .addPhysicalMemberStep1Model!
          .phone2
          .toString(),
      email: wholeUserInfoWithoutPrinciplesDetailsModel
          .step5model!
          .step4model!
          .step3model!
          .addPhysicalMemberStep2Model!
          .addPhysicalMemberStep1Model!
          .email
          .toString(),
      op: wholeUserInfoWithoutPrinciplesDetailsModel
          .step5model!
          .step4model!
          .step3model!
          .addPhysicalMemberStep2Model!
          .addPhysicalMemberStep1Model!
          .opOfBelonging
          .toString(),
      cni: wholeUserInfoWithoutPrinciplesDetailsModel
          .step5model!
          .step4model!
          .step3model!
          .addPhysicalMemberStep2Model!
          .addPhysicalMemberStep1Model!
          .cniNumber
          .toString(),
      photocniback: wholeUserInfoWithoutPrinciplesDetailsModel.step5model!
          .step4model!.step3model!.addPhysicalMemberStep2Model!.versoPhoto!,
      photocnifront: wholeUserInfoWithoutPrinciplesDetailsModel.step5model!
          .step4model!.step3model!.addPhysicalMemberStep2Model!.rectoPhoto!,
      photomember: wholeUserInfoWithoutPrinciplesDetailsModel.step5model!
          .step4model!.step3model!.addPhysicalMemberStep2Model!.nationalPhoto!,
      villageid: wholeUserInfoWithoutPrinciplesDetailsModel
          .step5model!.step4model!.step3model!.villageId
          .toString(),
      offlineId:
          wholeUserInfoWithoutPrinciplesDetailsModel.offlineId.toString(),
      latitude: wholeUserInfoWithoutPrinciplesDetailsModel
              .step5model!.step4model!.step3model?.latLng?.latitude
              .toString() ??
          '',
      longitude: wholeUserInfoWithoutPrinciplesDetailsModel
              .step5model!.step4model?.step3model?.latLng?.longitude
              .toString() ??
          '',
      pobox: wholeUserInfoWithoutPrinciplesDetailsModel
          .step5model!.step4model!.step3model!.mailBox
          .toString(),
      mainactivityid: wholeUserInfoWithoutPrinciplesDetailsModel
          .step5model!.step4model!.proncipleId
          .toString(),
      secondaryactivityid: wholeUserInfoWithoutPrinciplesDetailsModel
          .step5model!.step4model!.secondaryId
          .toString(),
      seasonpayment: wholeUserInfoWithoutPrinciplesDetailsModel
          .step5model!.inscription
          .toString(),
      subscriptionpayment: wholeUserInfoWithoutPrinciplesDetailsModel
          .step5model!.cotisation
          .toString(),
      securityqstid:
          wholeUserInfoWithoutPrinciplesDetailsModel.questionId.toString(),
      pin: wholeUserInfoWithoutPrinciplesDetailsModel.pin.toString(),
      secanswer: wholeUserInfoWithoutPrinciplesDetailsModel.response.toString(),
    );
  }

  Future addIndividualMember(
      {required String jwtToken,
      required WholeUserInfoWithoutPrinciplesDetailsModel
          wholeUserInfoWithoutPrinciplesDetailsModel,
      UserInfo? userInfoo}) async {
    try {
      emit(AddPhysicalPersonLoading());
      final response = await MemberRepository.addIndividualMember(
          jwtToken: jwtToken,
          userInfo: userInfoo ??
              returnUserInfo(
                  wholeUserInfoWithoutPrinciplesDetailsModel:
                      wholeUserInfoWithoutPrinciplesDetailsModel));
      AddIndividualMemberSuccess addIndividualMemberSuccess =
          AddIndividualMemberSuccess.fromJson(response);
      if (addIndividualMemberSuccess.status?.code == 0) {
        print(
            'INTERNAL CODE FOR Add Individual TOKEN API ${addIndividualMemberSuccess.status?.code}');

        emit(AddPhysicalPersonSucess(
            addIndividualMemberSuccess: addIndividualMemberSuccess));
      } else {
        AddIndividualMemberFailureModel addIndividualMemberFailureModel =
            AddIndividualMemberFailureModel.fromJson(response);
        emit(AddPhysicalPersonFailure(
            failureModel: addIndividualMemberFailureModel));
      }
    } catch (e) {
      print(e);
      emit(AddPhysicalPersonFailure(
          failureModel: AddIndividualMemberFailureModel(title: e.toString())));
    }
  }
}
