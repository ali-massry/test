import 'dart:convert';

import 'package:capef/global_cubits/physical_person_cubit/add_physical_person_cubit.dart';
import 'package:capef/hive/hive_boxes.dart';
import 'package:capef/models/legal_entity_info.dart';
import 'package:capef/models/user_info_model.dart';
import 'package:capef/repositories/add_categories_repo/categories_repository.dart';
import 'package:capef/screens-cubits/agri-flow-screens/model/add_agri_member_model.dart';
import 'package:capef/screens-cubits/breeding-flow-screens/model/add_breeding_member_model.dart';
import 'package:capef/screens-cubits/fishing-flow-screens/model/add_fishing_member_model.dart';
import 'package:capef/screens-cubits/group-flow-screens/cubit/group_flow_cubit.dart';
import 'package:capef/screens-cubits/physical-person-flow/step-6/step_6_model.dart';
import 'package:capef/utils/functions.dart';
import 'package:capef/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../global_cubits/activities_cubit/activities_cubit.dart';

void syncGlobalFunction(
  BuildContext context, {
  String? offlineId,
  UserInfo? userInfo,
  LegalEntityInfo? legalEntityInfo,
}) async {
  if (legalEntityInfo == null) {
    await context.read<AddPhysicalPersonCubit>().addIndividualMember(
        jwtToken: GlobalFunctions.getLocalJWTToken(),
        wholeUserInfoWithoutPrinciplesDetailsModel:
            WholeUserInfoWithoutPrinciplesDetailsModel(
                step5model: null, pin: null, response: null, offlineId: null),
        userInfoo: userInfo);
  } else {
    await context
        .read<GroupFlowCubit>()
        .addLegalEntityMember(jwtToken: GlobalFunctions.getLocalJWTToken());
  }
  List<Map<String, dynamic>> dataFroThisOfflineId =
      // ignore: use_build_context_synchronously
      context.read<ActivitiesCubit>().getStoredOfflineId(offlineId);

  for (var element in dataFroThisOfflineId) {
    if (element.containsKey('lands')) {
      AddAgriMemberModel addAgriMemberModel =
          AddAgriMemberModel.fromJson(element);

      await CategoriesRepository.addAgricultureMember(
          addAgriMemberModel: addAgriMemberModel,
          jwtToken: GlobalFunctions.getLocalJWTToken());
    } else if (element.containsKey('breedings')) {
      AddBreedingMemberModel addBreedingMemberModel =
          AddBreedingMemberModel.fromJson(element);

      await CategoriesRepository.addBreedingMember(
          addBreedingMemberModel: addBreedingMemberModel,
          jwtToken: GlobalFunctions.getLocalJWTToken());
    } else if (element.containsKey('fishings')) {
      AddFishingMemberModel addFishingMemberModel =
          AddFishingMemberModel.fromJson(element);

      await CategoriesRepository.addFishingMember(
          addFishingMemberModel: addFishingMemberModel,
          jwtToken: GlobalFunctions.getLocalJWTToken());
    }
  }

  removeItemFromHive(offlineId: offlineId);

  // ignore: use_build_context_synchronously
  GlobalSnackbar.showSuccessToast(context, 'Synchronised Succesfully');
}

void removeItemFromHive({required String? offlineId}) {
  (hiveBoxName(boxName: membersBox).get('members') as List)
      .removeWhere((element) => jsonDecode(element)['offlineId'] == offlineId);

  (hiveBoxName(boxName: membersBox).get('categories') as List)
      .removeWhere((element) => jsonDecode(element)['id'] == offlineId);
}
