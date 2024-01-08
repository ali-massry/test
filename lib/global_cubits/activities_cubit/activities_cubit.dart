// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:capef/hive/hive_boxes.dart';
import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/agri-flow-screens/cubit/agri_cubit.dart';
import 'package:capef/screens-cubits/breeding-flow-screens/cubit/breeding_cubit.dart';
import 'package:capef/screens-cubits/fishing-flow-screens/cubit/fishing_cubit.dart';
import 'package:capef/screens-cubits/forest-flow-screens/cubit/forest_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'activities_state.dart';

class ActivitiesCubit extends Cubit<ActivitiesState> {
  ActivitiesCubit() : super(ActivitiesInitial());
  int? principleActivityId;
  int? secondaryActivityId = 1;

  void clearSecondaryAndNavigateAccordingle(BuildContext context,
      {required int? currentActivityId}) {
    if (secondaryActivityId == 1) {
      context.read<AgriCubit>().fromProfileEdit == null;
      Navigator.of(context)
          .pushNamedAndRemoveUntil(Routes.agriStep1Screen, (route) => false);

      context.read<AgriCubit>().offOnId =
          context.read<FishingCubit>().offOnId ??
              context.read<BreedingCubit>().offonId ??
              context.read<ForestCubit>().offOnId;

      context.read<AgriCubit>().nationalName =
          context.read<FishingCubit>().nationalName ??
              context.read<BreedingCubit>().nationalName ??
              context.read<ForestCubit>().nationalName;
      context.read<AgriCubit>().nationalNumber =
          context.read<FishingCubit>().nationalNumber ??
              context.read<BreedingCubit>().nationalNumber ??
              context.read<ForestCubit>().nationalNumber;

      print('OFF ON ID ${context.read<AgriCubit>().offOnId}');
    } else if (secondaryActivityId == 2) {
      context.read<FishingCubit>().fromProfileEdit == null;
      Navigator.of(context)
          .pushNamedAndRemoveUntil(Routes.fishingStep1Screen, (route) => false);
      context.read<FishingCubit>().offOnId =
          context.read<AgriCubit>().offOnId ??
              context.read<BreedingCubit>().offonId ??
              context.read<ForestCubit>().offOnId;

      context.read<FishingCubit>().nationalName =
          context.read<AgriCubit>().nationalName ??
              context.read<BreedingCubit>().nationalName ??
              context.read<ForestCubit>().nationalName;
      context.read<FishingCubit>().nationalNumber =
          context.read<AgriCubit>().nationalNumber ??
              context.read<BreedingCubit>().nationalNumber ??
              context.read<ForestCubit>().nationalNumber;

      print('ON OFF ID ${context.read<FishingCubit>().offOnId}');
    } else if (secondaryActivityId == 3) {
      context.read<BreedingCubit>().fromProfileEdit == null;
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.breedingStep1Screen, (route) => false);
      context.read<BreedingCubit>().offonId =
          context.read<AgriCubit>().offOnId ??
              context.read<FishingCubit>().offOnId ??
              context.read<ForestCubit>().offOnId;

      context.read<BreedingCubit>().nationalName =
          context.read<AgriCubit>().nationalName ??
              context.read<FishingCubit>().nationalName ??
              context.read<ForestCubit>().nationalName;
      context.read<BreedingCubit>().nationalNumber =
          context.read<AgriCubit>().nationalNumber ??
              context.read<FishingCubit>().nationalNumber ??
              context.read<ForestCubit>().nationalNumber;

      print('ON OFF ID ${context.read<BreedingCubit>().offonId}');
    } else {
      context.read<ForestCubit>().offOnId = context.read<AgriCubit>().offOnId ??
          context.read<FishingCubit>().offOnId ??
          context.read<BreedingCubit>().offonId;
      context.read<ForestCubit>().nationalName =
          context.read<AgriCubit>().nationalName ??
              context.read<FishingCubit>().nationalName ??
              context.read<BreedingCubit>().nationalName;
      context.read<ForestCubit>().nationalNumber =
          context.read<AgriCubit>().nationalNumber ??
              context.read<FishingCubit>().nationalNumber ??
              context.read<BreedingCubit>().nationalNumber;
      print('ON OFF ID ${context.read<ForestCubit>().offOnId}');
      context.read<ForestCubit>().fromProfileEdit == null;

      Navigator.of(context)
          .pushNamedAndRemoveUntil(Routes.forestStep1Screen, (route) => false);
    }

    secondaryActivityId = null;
    print('SECONDARY ACTIVITY $secondaryActivityId');
  }

  // Map<String, dynamic> getStoredOfflineId(String? offlineId) {
  //   var t = hiveBoxName(boxName: membersBox).get('categories');
  //   List<dynamic> stringList = (t as List).map((e) => jsonDecode(e)).toList();

  //   Map<String, dynamic> theDesiredMap = stringList
  //       .where((element) => element['id'] == offlineId)
  //       .firstWhere((element) => true, orElse: () => <String, dynamic>{});
  //   return theDesiredMap;
  // }

  List<Map<String, dynamic>> getStoredOfflineId(String? offlineId) {
    var t = hiveBoxName(boxName: membersBox).get('categories');

    if (t != null) {
      List<dynamic> stringList = (t as List).map((e) => jsonDecode(e)).toList();

      List<Map<String, dynamic>> castedList =
          stringList.cast<Map<String, dynamic>>();

      List<Map<String, dynamic>> listedMap = castedList
          .where((element) => element['id'] == offlineId)
          .map((e) => e)
          .toList();

      return listedMap;
    } else {
      return [];
    }
  }

  // void getTheStoredOfflineId(BuildContext context, String? offlineId) {
  //   var t = hiveBoxName(boxName: membersBox).get('categories');
  //   List<dynamic> stringList = (t as List).map((e) => jsonDecode(e)).toList();

  //   Map<String, dynamic> theDesiredMap = stringList
  //       .where((element) => element['id'] == offlineId)
  //       .firstWhere((element) => true, orElse: () => null);

  //   print(stringList);
  //   print(theDesiredMap);
  // }
}
