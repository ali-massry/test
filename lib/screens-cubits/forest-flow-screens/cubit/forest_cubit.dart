// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:capef/assets.dart';
import 'package:capef/global_cubits/add_forest_cubit/add_forest_cubit.dart';
import 'package:capef/global_cubits/get_offline_cubit/get_offline_cubit.dart';
import 'package:capef/global_cubits/remove_category_cubit/remove_category_cubit.dart';
import 'package:capef/models/offline_data_response.dart';
import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/forest-flow-screens/model/add_forest_member_model.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/widgets/circled_green_icon.dart';
import 'package:capef/widgets/modify_delete_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'forest_state.dart';

class ForestCubit extends Cubit<ForestState> {
  ForestCubit() : super(ForestInitial());
  String? offOnId;
  AddForestMemberModel? addForestMemberModel;
  Regions? regions;
  Districts? districts;
  Areas? areas;
  Villages? villages;
  Forests? forestsToBeEdited;
  List<int> linkIds = [];
  List<int> constantLinkedIdsToBeSentToApi = [];
  List<Forests> forestsList = [];
  Forestessences? forestessences;
  String? nationalName;
  String? nationalNumber;
  bool? showBackInForestry = true;
  bool? showBackInSylviculture = true;
  bool? showBackInWildLife = true;
  bool? showBackInPNFL = true;
  String? fromProfileEdit;

  void resetToInitial() {
    offOnId = null;
    addForestMemberModel = null;
    regions = null;
    districts = null;
    areas = null;
    villages = null;
    linkIds = [];
    constantLinkedIdsToBeSentToApi = [];
    forestsList = [];
    forestessences = null;
    nationalName = null;
    nationalNumber = null;
  }

  void navigateTo(BuildContext context) async {
    List<int> linkss = linkIds;
    linkss.removeAt(0);

    linkIds = linkss;

    if (linkIds.isEmpty) {
      // hit api here of saving forest with all of the above AddForestMemberModel

      addForestMemberModel = AddForestMemberModel(
          id: offOnId,
          areaid: areas?.areaid,
          linkids: constantLinkedIdsToBeSentToApi,
          regionid: regions?.regionid,
          districtid: districts?.districtid,
          villageid: villages?.villageid,
          forests: forestsList);

      var js = jsonEncode(addForestMemberModel?.forests);
      print(js);

      print(addForestMemberModel);
      // CategoriesRepository.addForestMember(
      //     addForestMemberModel: addForestMemberModel!,
      //     jwtToken: GlobalFunctions.getLocalJWTToken());

      if (fromProfileEdit != null) {
        context
            .read<RemoveCategoryCubit>()
            .removeCategory(categoryId: int.parse(fromProfileEdit ?? ''))
            .then((value) {
          context
              .read<AddForestCubit>()
              .addForestMember(addForestMemberModel: addForestMemberModel!);
        });
      } else {
        context
            .read<AddForestCubit>()
            .addForestMember(addForestMemberModel: addForestMemberModel!);
      }
    } else {
      if (linkIds[0] == 1) {
        context.read<ForestCubit>().showBackInForestry = true;

        Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.forestryOperatorStep1Screen, (route) => false);
      }
      if (linkIds[0] == 2) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.silviculturistStep1Screen, (route) => false);
      }
      if (linkIds[0] == 3) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.wildLifeProductsOperatorStep1Screen, (route) => false);
      }
      if (linkIds[0] == 4) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.pnflOperatorStep1Screen, (route) => false);
      }
      // linkedIdSelected = linkIds;

      print(linkIds);
    }
  }

  void renderForestProductsAccordingToEssenceSelected(
      {GetOfflineDataModel? getOfflineDataModel}) async {
    List<Forestproducts> forestProducts = [];
    forestProducts.clear();
    for (var element
        in getOfflineDataModel!.forestandwilddata!.forestproducts!) {
      if (element.essencetypeid == forestessences?.essencetypeid) {
        forestProducts.add(element);
      }
    }

// Remove the Comment down here if i want to remove all options of selected products
    // List<int> productIdsList = [];
    // for (var ele in filterAllForestsAccordingToLinkId(linkId: 1)) {
    //   productIdsList.add(int.parse(ele.prodid.toString()));
    //   print(ele.prodid);
    // }
    // if (productIdsList.isNotEmpty) {

    // for (var id in productIdsList) {
    //   forestProducts.removeWhere((element) => element.id == id);
    // }
    // }
    // print(forestProducts);

    emit(UpdateForestProductsSuccess(forestproducts: forestProducts));
  }

  void clearEveryThingAndGoToHome(BuildContext context) async {
    linkIds.clear();
    constantLinkedIdsToBeSentToApi.clear();
    forestsList.clear();

    Navigator.of(context)
        .pushNamedAndRemoveUntil(Routes.homeScreen, (route) => false);
  }

  void addForestToTheListAndNavigate(BuildContext context,
      {required Forests forests, required String routeName}) {
    print(forests);
    List<Forests> forestsListToBeAdded = [];
    for (var forest in forestsList) {
      forestsListToBeAdded.add(forest);
    }
    forestsListToBeAdded.add(forests);

    forestsList = forestsListToBeAdded;

    print(forestsList);

    Navigator.of(context).pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  List<Forests> filterAllForestsAccordingToLinkId({required int linkId}) {
    List<Forests> forestsToBeShowing = [];

    for (var forestHere in forestsList) {
      if (linkId == forestHere.linkid) {
        forestsToBeShowing.add(forestHere);
      }
    }

    return forestsToBeShowing;
  }

  String productNameFromId(BuildContext context, {required int? productId}) {
    String productName = '';
    for (var product in context
        .read<GetOfflineCubitCubit>()
        .getOfflineDataModel!
        .forestandwilddata!
        .forestproducts!) {
      if (product.id == productId) {
        productName = product.name ?? '';
      }
    }
    return productName;
  }

  String unitNameFromId(BuildContext context, {required int? unitId}) {
    String unitName = '';
    for (var unit
        in context.read<GetOfflineCubitCubit>().getOfflineDataModel!.units!) {
      if (unit.id == unitId) {
        unitName = unit.name ?? '';
      }
    }
    return unitName;
  }

  String plantationNameFromId(BuildContext context,
      {required int? plantationId}) {
    String plantationName = '';
    for (var plantation in context
        .read<GetOfflineCubitCubit>()
        .getOfflineDataModel!
        .plantationtype!) {
      if (plantation.id == plantationId) {
        plantationName = plantation.name ?? '';
      }
    }
    return plantationName;
  }

  String forestSpeciesNameFromId(BuildContext context,
      {required int? forestSpeciesId}) {
    String forestSpeciesName = '';
    for (var forestSpecies in context
        .read<GetOfflineCubitCubit>()
        .getOfflineDataModel!
        .forestandwilddata!
        .forestspecies!) {
      if (forestSpecies.id == forestSpeciesId) {
        forestSpeciesName = forestSpecies.name ?? '';
      }
    }
    return forestSpeciesName;
  }

  void deleteForestFromTheWholeList({required Forests forests}) {
    forestsList.removeWhere((element) => element == forests);
  }

  Future<void> openEditDeleteBottomSheet(
    BuildContext context, {
    required Forests forest,
    required int? index,
    required int? linkId,
    // required Fishings? fishings,
  }) async {
    print(forest);
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
                  forest.speciesid != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: mqh(context, 20)),
                            Text(
                              context
                                  .read<ForestCubit>()
                                  .forestSpeciesNameFromId(context,
                                      forestSpeciesId: int.parse(
                                          forest.speciesid.toString())),
                              style: GlobalTextStyles.ts15montboldBlack,
                            ),
                            SizedBox(height: mqh(context, 15)),
                            Text(
                              '${forest.qty}',
                              style:
                                  GlobalTextStyles.ts13montsemiBold30OpaquBlack,
                            ),
                            SizedBox(height: mqh(context, 8)),
                            Text(
                              '${forest.annualprodfcfa} FCFA',
                              style:
                                  GlobalTextStyles.ts13montsemiBold30OpaquBlack,
                            ),
                            SizedBox(height: mqh(context, 20)),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: mqh(context, 20)),
                            Text(
                              '${forestessences?.name} | ${productNameFromId(context, productId: int.parse(forest.prodid.toString()))}',
                              style: GlobalTextStyles.ts15montboldBlack,
                            ),
                            SizedBox(height: mqh(context, 15)),
                            Text(
                              '${forest.qty} / ${unitNameFromId(context, unitId: int.parse(forest.unitid.toString()))}',
                              style:
                                  GlobalTextStyles.ts13montsemiBold30OpaquBlack,
                            ),
                            SizedBox(height: mqh(context, 8)),
                            Text(
                              '${forest.annualprodfcfa} FCFA',
                              style:
                                  GlobalTextStyles.ts13montsemiBold30OpaquBlack,
                            ),
                            SizedBox(height: mqh(context, 20)),
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
                    Navigator.pop(context);
                    context.read<ForestCubit>().forestsToBeEdited = forest;
                    context
                        .read<ForestCubit>()
                        .forestsList
                        .removeWhere((element) => element == forestsToBeEdited);
                    Navigator.of(context).pushReplacementNamed(linkId == 1
                        ? Routes.forestryOperatorStep1Screen
                        : linkId == 2
                            ? Routes.silviculturistStep1Screen
                            : linkId == 3
                                ? Routes.wildLifeProductsOperatorStep1Screen
                                : Routes.pnflOperatorStep1Screen);
                    context.read<ForestCubit>().showBackInForestry = false;
                    context.read<ForestCubit>().showBackInSylviculture = false;
                    context.read<ForestCubit>().showBackInPNFL = false;
                    context.read<ForestCubit>().showBackInWildLife = false;

                    var tt = context.read<ForestCubit>().forestsToBeEdited;
                    print(tt);
                  }),
              SizedBox(height: mqh(context, 10)),
              BuildModifyAndEditContainer(
                title: 'Supprimer',
                assetPath: Assets.icons.trashSvg,
                ontap: () {
                  forestsList.removeWhere((element) => element == forest);

                  // context.read<AgriCubit>().addAgriMemberModel.lands?.clear();
                  Navigator.of(context).pushReplacementNamed(linkId == 1
                      ? Routes.summaryOfforestryOperator
                      : linkId == 2
                          ? Routes.summaryOfsilviculturer
                          : linkId == 3
                              ? Routes.summaryOfwildlifeproductsOperator
                              : Routes.summaryOfpnflOperator);

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
}
