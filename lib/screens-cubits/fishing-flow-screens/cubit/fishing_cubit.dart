import 'package:capef/models/offline_data_response.dart';
import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/fishing-flow-screens/model/add_fishing_member_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'fishing_state.dart';

class FishingCubit extends Cubit<FishingCubitState> {
  FishingCubit() : super(FishingCubitInitial());
  AddFishingMemberModel addFishingMemberModel = AddFishingMemberModel();
  String? offOnId;
  int howMany = 0;
  int currentIndex = 0;
  Regions? regions;
  Districts? districts;
  Areas? areas;
  int? unitID;
  int? speciesId = -1;
  Villages? villages;
  List<int> linkids = [];
  List<Fishings> fishings = [];
  List<FishingLinks> fishingLinks = [];
  Fishings? fishingsToBeEdited;
  String? nationalName;
  String? nationalNumber;
  bool? showBackInStep3Screen = true;
  String? fromProfileEdit;

  void resetToInitial() {
    addFishingMemberModel = AddFishingMemberModel();
    offOnId = null;
    howMany = 0;
    currentIndex = 0;
    regions = null;
    districts = null;
    areas = null;
    speciesId = -1;
    villages = null;
    linkids = [];
    fishings = [];
    fishingLinks = [];
    fishingsToBeEdited = null;
    nationalName = null;
    nationalNumber = null;
  }

  // SlipModel? slipOfFishingData;

  int currentIndexOfDetailedDependingOnLink() {
    if (linkids.isNotEmpty) {
      int? indexx = 0;
      indexx = (linkids.length - fishings.length) - 1;
      return indexx;
    } else {
      return 0;
    }
  }

  void clearEveryThingAndGoToHome(BuildContext context) async {
    fishingLinks.clear();
    linkids.clear();
    fishings.clear();
    fishingsToBeEdited = null;

    Navigator.of(context)
        .pushNamedAndRemoveUntil(Routes.homeScreen, (route) => false);
  }
}
