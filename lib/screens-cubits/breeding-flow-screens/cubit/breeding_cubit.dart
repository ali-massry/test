// ignore_for_file: avoid_print

import 'package:capef/models/offline_data_response.dart';
import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/breeding-flow-screens/model/add_breeding_member_model.dart';
import 'package:capef/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'breeding_state.dart';

class BreedingCubit extends Cubit<BreedingCubitState> {
  BreedingCubit() : super(BreedingCubitInitial());
  AddBreedingMemberModel addBreedingMemberModel = AddBreedingMemberModel();
  List<Breedinglivestock> breedingLiveStockkk = [];
  String? offonId;
  Regions? regions;
  Districts? districts;
  Areas? areas;
  Villages? villages;
  List<int> linkids = [];
  Breedings? breedingToBeEdited;
  bool? showBackInStep3Screen = true;

  int? breedingTypeId = -1;
  int? breedingSpeciess = -1;
  Breedingspecies? breedingSpecies;
  String? nationalName;
  String? nationalNumber;
  String? fromProfileEdit;


  List<Breedings> breedings = [];
  List<BreedingLinks> breedingLinks = [];
  List<Breedinglivestock> breedingLiveStockk = [];
  Breedinglivestock? selectedValue;

  void resetToInitial() {
    addBreedingMemberModel = AddBreedingMemberModel();
    breedingLiveStockkk = [];
    offonId = null;
    regions = null;
    districts = null;
    areas = null;
    villages = null;
    linkids = [];
    breedingTypeId = -1;
    breedingSpeciess = -1;
    breedingSpecies = null;
    nationalName = null;
    nationalNumber = null;
    breedings = [];
    breedingLinks = [];
    breedingLiveStockk = [];
    selectedValue = null;
  }

  // Fishings? fishingsToBeEdited;

  void navigateToStep3(BuildContext context) async {
    if (breedingLinks.isEmpty) {
      GlobalSnackbar.showFailureToast(
          context, 'Sélectionnez Au Moins Une Option');
    } else {
      Navigator.of(context).pushNamed(Routes.breedingStep3Screen);
      showBackInStep3Screen = true;
    }
  }

  Future<void> changeBreedingSpecies({
    required Breedingspecies p0,
    required List<Breedinglivestock> breedingLiveStock,
  }) async {
    breedingLiveStockk.clear();
    selectedValue = null;
    breedingSpecies = p0;
    for (var element in breedingLiveStock) {
      if (p0.id == element.speciesid) {
        if (!breedingLiveStockk.contains(element)) {
          breedingLiveStockk.add(element);
        } else {
          print('object');
        }
      }
    }
    emit(UpdateBreedingLiveStockDropDownSuccess(
        breedingLiveStock: breedingLiveStockk));
    print(breedingSpecies?.id);
  }

  // int currentIndexOfDetailedDependingOnLink() {
  //   if (linkids.isNotEmpty) {
  //     int? indexx = 0;
  //     indexx = (linkids.length - fishings.length) - 1;
  //     return indexx;
  //   } else {
  //     return 0;
  //   }
  // }

  // void clearEveryThingAndGoToHome(BuildContext context) async {
  //   fishingLinks.clear();
  //   linkids.clear();
  //   fishings.clear();
  //   fishingsToBeEdited = null;

  //   Navigator.of(context)
  //       .pushNamedAndRemoveUntil(Routes.homeScreen, (route) => false);
  // }
}
