// ignore_for_file: avoid_print

import 'package:capef/assets.dart';
import 'package:capef/models/offline_data_response.dart';
import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/agri-flow-screens/model/add_agri_member_model.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/widgets/circled_green_icon.dart';
import 'package:capef/widgets/modify_delete_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'agri_state.dart';

class AgriCubit extends Cubit<AgriState> {
  AgriCubit() : super(AgriInitial());

  AddAgriMemberModel addAgriMemberModel = AddAgriMemberModel();
  String? offOnId;
  Regions? regions;
  Districts? districts;
  Areas? areas;
  Villages? villages;
  List<int> integersList = [];
  int? cropCategoryId;
  int? cropId;
  Units? unit;
  String? typeOfCulture;
  Lands? landOfIndex;
  bool? addAnotherLand = false;
  Landpartss? landPartsToBeAdded;
  dynamic principalPercentage;
  int? cropCatIdLandPart;
  int? cropIdLandPart;
  int? unitIdLandPart;
  int? percentageLandPart;
  int? quantityLandPart;
  int? priceLandPart;
  double? totalAreaCubit;
  int? lastLandIndex;
  List<int?> cropCategoriesSelected = [];
  bool showBackInAddAnotherAgriCulture = true;
  String? nationalName;
  String? nationalNumber;
  List<int?> cropsExisting = [];
  List<Lands> landsList = [];
  String? fromProfileEdit;

  int? numberOfCropsInEdit;

  void resetToInitial() {
    addAgriMemberModel = AddAgriMemberModel();
    offOnId = null;
    regions = null;
    districts = null;
    areas = null;
    villages = null;
    integersList = [];
    cropCategoryId = null;
    cropId = null;
    unit = null;
    typeOfCulture = null;
    landOfIndex = null;
    addAnotherLand = false;
    landPartsToBeAdded = null;
    cropCatIdLandPart = null;
    cropIdLandPart = null;
    unitIdLandPart = null;
    percentageLandPart = null;
    quantityLandPart = null;
    priceLandPart = null;
    totalAreaCubit = null;
    lastLandIndex = null;
    cropCategoriesSelected = [];
    showBackInAddAnotherAgriCulture = true;
    nationalName = null;
    nationalNumber = null;
  }

  Future<void> openEditDeleteBottomSheet(
    BuildContext context, {
    required Lands? lands,
    required String? title,
    required int? index,
    // required Fishings? fishings,
  }) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // backgroundColor: Colors.white,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
          child: Wrap(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title ?? '',
                          style: GlobalTextStyles.ts15montboldBlack),
                      SizedBox(height: mqh(context, 15)),
                      Text('${lands?.totalarea} Ha',
                          style: GlobalTextStyles.ts13montsemiBold30OpaquBlack)
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: BuildCircledGreenIcon(
                        widget: Transform.translate(
                            offset: const Offset(-5, 0),
                            child: const Icon(Icons.close,
                                color: GlobalColors.mainGreenColor))),
                  ),
                ],
              ),
              SizedBox(height: mqh(context, 50)),
              BuildModifyAndEditContainer(
                  title: 'Modifier',
                  assetPath: Assets.icons.editSvg,
                  ontap: () {
                    landOfIndex = addAgriMemberModel.lands![index!];
                    addAgriMemberModel.lands!.removeAt(index);
                    print(landOfIndex);
                    // landOfIndex = Add;
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.agriStep3Screen, (route) => false);
                  }),
              SizedBox(height: mqh(context, 10)),
              BuildModifyAndEditContainer(
                title: 'Supprimer',
                assetPath: Assets.icons.trashSvg,
                ontap: () {
                  addAgriMemberModel.lands!.removeAt(index!);

                  if (addAgriMemberModel.lands!.isEmpty) {
                    context.read<AgriCubit>().landOfIndex = null;
                  }
                  // context.read<AgriCubit>().addAgriMemberModel.lands?.clear();
                  Navigator.of(context)
                      .pushReplacementNamed(Routes.summaryOfAgriSpeciesScreen);

                  // emit(AgriEmpty());
                },
              ),
              SizedBox(height: mqh(context, 20)),
            ],
          ),
        );
      },
    );
  }

  void addLand(
      {required double? annualQnt,
      required double? annualPrice,
      required BuildContext context}) async {
    if (typeOfCulture == 'Pure') {
      saveLand(annualQnt, annualPrice, context);
    } else {
      saveLand(annualQnt, annualPrice, context);
    }
  }

  void saveLand(double? anualQtt, double? anualPrice, BuildContext context) {
    List<Lands> landsList = [];
    if (addAgriMemberModel.lands != null) {
      for (var ele in addAgriMemberModel.lands!) {
        landsList.add(ele);
      }
    }

    landsList.add(Lands(
        isshared: (typeOfCulture == 'Pure') ? false : true,
        totalarea: totalAreaCubit,
        landparts: [
          Landpartss(
            cropid: cropId,
            cropcatid: cropCategoryId,
            landpartpercentage:
                (typeOfCulture == 'Pure') ? 100 : principalPercentage,
            unitid: unit?.id,
            annualprodqtt: anualQtt,
            annualprodfcfa: anualPrice,
          )
        ]));

    addAgriMemberModel = AddAgriMemberModel(
        id: offOnId,
        areaid: areas?.areaid,
        districtid: districts?.districtid,
        villageid: villages?.villageid,
        regionid: regions?.regionid,
        linkids: integersList,
        lands: landsList);

    print(addAgriMemberModel);

    lastLandIndex = landsList.length - 1;

    print(lastLandIndex);

    Navigator.of(context).pushNamedAndRemoveUntil(
        (typeOfCulture == 'Pure')
            ? Routes.summaryOfAgriSpeciesScreen
            : Routes.agriStep6Screen,
        (route) => false);
  }

  void saveLandPart(
      {required double? annualQnt,
      required double? annualPrice,
      required int? percentage,
      required String? saveAndAddAnotherLandPart,
      required BuildContext context}) {
    if (saveAndAddAnotherLandPart == 'saveAndAddAnotherLandPart') {
      List<Landpartss> landPartssList = [];
      for (var ele in addAgriMemberModel.lands![lastLandIndex!].landparts!) {
        landPartssList.add(ele);
        print(landPartssList);
      }
      landPartssList.add(Landpartss(
        annualprodfcfa: annualPrice,
        annualprodqtt: annualQnt,
        unitid: unitIdLandPart,
        cropid: cropIdLandPart,
        cropcatid: cropCatIdLandPart,
        landpartpercentage: percentage,
      ));

      List<Lands> existingLands = [];
      for (var land in addAgriMemberModel.lands!) {
        if (land.landparts != null) {
          existingLands.add(land);
        }
      }

      existingLands[lastLandIndex!] = Lands(
        isshared: true,
        totalarea: totalAreaCubit,
        landparts: landPartssList,
      );

      addAgriMemberModel = AddAgriMemberModel(
        //!FIXME member id down
        id: offOnId,
        areaid: areas?.areaid,
        districtid: districts?.districtid,
        villageid: villages?.villageid,
        regionid: regions?.regionid,
        linkids: integersList,
        lands: existingLands,
      );

      Navigator.of(context)
          .pushNamedAndRemoveUntil(Routes.agriStep6Screen, (route) => false);

      // landPartssList = addAgriMemberModel.lands![lastLandIndex!].landparts!;

      print(addAgriMemberModel);
    } else {
      List<Landpartss> landPartsList = [];
      if (addAgriMemberModel.lands != null) {
        for (var ele in addAgriMemberModel.lands![lastLandIndex!].landparts!) {
          landPartsList.add(ele);
        }

        print(landPartsList);
      }

      landPartsList.add(Landpartss(
          annualprodfcfa: annualPrice,
          annualprodqtt: annualQnt,
          unitid: unitIdLandPart,
          cropid: cropIdLandPart,
          cropcatid: cropCatIdLandPart,
          landpartpercentage: percentage));
      print(landPartsList);

      addAgriMemberModel.lands?[lastLandIndex!].landparts = landPartsList;

      if (addAgriMemberModel.lands![lastLandIndex!].isshared == true) {
        int sumOfOthers = 0;
        for (var i = 1; i < landPartsList.length; i++) {
          sumOfOthers += landPartsList[i].landpartpercentage ?? 0;
        }
        addAgriMemberModel.lands?[lastLandIndex!].landparts?[0]
            .landpartpercentage = 100 - sumOfOthers;
      }

      // List<Lands> existingLands = [];
      // for (var land in addAgriMemberModel.lands!) {
      //   if (land.landparts != null) {
      //     existingLands.add(land);
      //   }
      // }
      // existingLands[lastLandIndex!] = Lands(
      //   isshared: true,
      //   totalarea: totalAreaCubit,
      //   landparts: landPartsList,
      // );

      // addAgriMemberModel = AddAgriMemberModel(
      //   id: offOnId,
      //   areaid: areas?.areaid,
      //   districtid: districts?.districtid,
      //   villageid: villages?.villageid,
      //   regionid: regions?.regionid,
      //   linkids: integersList,
      //   lands: existingLands,
      // );

      print(addAgriMemberModel);

      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.summaryOfAgriSpeciesScreen, (route) => false);
    }
  }

  // AddAgriMemberModel addAgriMemberModell() {
  //   AddAgriMemberModel addAgriMemberModelHere = AddAgriMemberModel();

  //   List<Lands> landsList = [];
  //   List<Landparts> landPartsList = [];

  //   for (var land in addAgriMemberModel.lands!) {
  //     if (land.isshared == true) {
  //       int sumOfOthers = 0;
  //       if (land.landparts != null) {
  //         for (var i = 1; i < land.landparts!.length; i++) {
  //           sumOfOthers += land.landparts![i].landpartpercentage ?? 0;
  //         }
  //       }

  //       if (land.landparts != null && land.landparts!.isNotEmpty) {
  //         land.landparts![0].landpartpercentage = 100 - sumOfOthers;
  //       }
  //       print(land.landparts![0].landpartpercentage);
  //     } else {
  //     }
  //   }
  //   return addAgriMemberModelHere;
  // }
}
