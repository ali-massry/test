// ignore_for_file: avoid_print

import 'package:capef/assets.dart';
import 'package:capef/global_cubits/add_agri_cubit/add_agri_cubit.dart';
import 'package:capef/global_cubits/get_offline_cubit/get_offline_cubit.dart';
import 'package:capef/global_cubits/remove_category_cubit/remove_category_cubit.dart';
import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/agri-flow-screens/cubit/agri_cubit.dart';
import 'package:capef/screens-cubits/agri-flow-screens/model/add_agri_member_model.dart';
import 'package:capef/screens-cubits/agri-flow-screens/widgets/centered_text.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/functions.dart';
import 'package:capef/utils/snackbar.dart';
import 'package:capef/widgets/agri_box.dart';
import 'package:capef/widgets/appbar.dart';
import 'package:capef/widgets/button.dart';
import 'package:capef/widgets/circled_green_icon.dart';
import 'package:capef/widgets/loading_button.dart';
import 'package:capef/widgets/modify_delete_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class SummaryOfAgriSpeciesScreen extends StatefulWidget {
  const SummaryOfAgriSpeciesScreen({super.key});

  @override
  State<SummaryOfAgriSpeciesScreen> createState() =>
      _SummaryOfAgriSpeciesScreenState();
}

class _SummaryOfAgriSpeciesScreenState
    extends State<SummaryOfAgriSpeciesScreen> {
  // String getSpeciesNameFromId({int? id}) {
  //   for (var element in context
  //       .read<GetOfflineCubitCubit>()
  //       .getOfflineDataModel!
  //       .fishingdata!
  //       .species!) {
  //     print(element.id);
  //     if (id == element.id) {
  //       return element.name ?? '';
  //     }
  //   }
  //   return '';
  // }

// This to check cropcat id in agri step 4

  bool? hasCropRepition() {
    List<int?> idsss = [];
    for (var land in context.read<AgriCubit>().addAgriMemberModel.lands!) {
      for (var landPart in land.landparts!) {
        idsss.add(landPart.cropid);
      }
    }

    print(idsss);

    return GlobalFunctions.containsDuplicate(idsss);
  }

// This to check cropcat id in agri step 3
  bool? hasCropCatRepition() {
    List<int?> idsss = [];
    for (var land in context.read<AgriCubit>().addAgriMemberModel.lands!) {
      for (var landPart in land.landparts!) {
        idsss.add(landPart.cropcatid);
      }
    }
    return GlobalFunctions.containsDuplicate(idsss);
  }

  @override
  Widget build(BuildContext context) {
    var t = context.read<AgriCubit>().addAgriMemberModel.lands;
    print(t);
    return SafeArea(
        top: true,
        child: BlocConsumer<AddAgriCubit, AddAgriState>(
          listener: (context, state) {
            if (state is AddAgriSuccess) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.addAgriSuccessScreen, (route) => false);
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: const BuildAppBar(
                  title: 'Informations Culture Associée', showBack: false),
              body: KeyboardDismisser(
                child: Padding(
                    padding: globalScreenPaddings,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const BuildAgriBox(),
                            SizedBox(height: mqh(context, 15)),
                            const BuildCenteredAgriText(
                                title: 'Récapitulatif des Cultures'),
                            SizedBox(height: mqh(context, 40)),
                          ],
                        ),
                        const BuildAgriLandsList(),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context.read<AgriCubit>().landOfIndex == null;
                                  context.read<AgriCubit>().addAnotherLand =
                                      true;
                                  print(
                                      'SHOW BACK ${context.read<AgriCubit>().showBackInAddAnotherAgriCulture}');
                                  context
                                      .read<AgriCubit>()
                                      .showBackInAddAnotherAgriCulture = false;

                                  print(
                                      'SHOW BACK ${context.read<AgriCubit>().showBackInAddAnotherAgriCulture}');

                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      Routes.agriStep3Screen, (route) => false);
                                },
                                child: Center(
                                  child: Text(
                                      'Ajouter une autre culture'.toUpperCase(),
                                      style: GlobalTextStyles
                                          .underlinedViewAllTextButton),
                                ),
                              ),
                              SizedBox(height: mqh(context, 30)),
                              context
                                      .read<AgriCubit>()
                                      .addAgriMemberModel
                                      .lands!
                                      .isEmpty
                                  ? const SizedBox()
                                  : (state is AddAgriLoading)
                                      ? BuildLoadingButton()
                                      : BuildButton(
                                          txt: 'SUIVANT',
                                          onTap: () {
                                            // print(hasCropCatRepition());
                                            if (hasCropRepition() == true) {
                                              GlobalSnackbar.showFailureToast(
                                                  context,
                                                  'la culture existe déjà');
                                            } else {
                                              if (context
                                                      .read<AgriCubit>()
                                                      .fromProfileEdit !=
                                                  null) {
                                                context
                                                    .read<RemoveCategoryCubit>()
                                                    .removeCategory(
                                                        categoryId: int.parse(context
                                                                .read<
                                                                    AgriCubit>()
                                                                .fromProfileEdit ??
                                                            ''))
                                                    .then((value) {
                                                  context
                                                      .read<AddAgriCubit>()
                                                      .addAgriMember(
                                                          addAgriMemberModel: context
                                                              .read<AgriCubit>()
                                                              .addAgriMemberModel);
                                                });
                                              } else {
                                                context
                                                    .read<AddAgriCubit>()
                                                    .addAgriMember(
                                                        addAgriMemberModel: context
                                                            .read<AgriCubit>()
                                                            .addAgriMemberModel);
                                              }
                                            }
                                          }),
                            ]),
                      ],
                    )),
              ),
            );
          },
        ));
  }
}

class BuildAgriLandsList extends StatelessWidget {
  const BuildAgriLandsList({super.key});

  @override
  Widget build(BuildContext context) {
    var t = context.read<AgriCubit>().addAgriMemberModel.lands;
    print(t);
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return SizedBox(height: mqh(context, 15));
        },
        itemBuilder: (context, index) {
          return BuildAgricultureCard(
            lands: context.read<AgriCubit>().addAgriMemberModel.lands![index],
            index: index,
          );
        },
        itemCount: context.read<AgriCubit>().addAgriMemberModel.lands!.length,
      ),
    );
  }
}

class BuildAgricultureCard extends StatefulWidget {
  const BuildAgricultureCard({
    super.key,
    required this.lands,
    required this.index,
  });
  final Lands lands;
  final int index;

  @override
  State<BuildAgricultureCard> createState() => _BuildAgricultureCardState();
}

class _BuildAgricultureCardState extends State<BuildAgricultureCard> {
  @override
  void initState() {
    super.initState();
  }

  String? getCropCategoryFromId({required int? cropCategoryId}) {
    for (var element in context
        .read<GetOfflineCubitCubit>()
        .getOfflineDataModel!
        .agridata!
        .cropcategories!) {
      if (cropCategoryId == element.id) {
        return element.name;
      }
    }
    return '';
  }

  String? getCropFromId({required int? cropId}) {
    for (var element in context
        .read<GetOfflineCubitCubit>()
        .getOfflineDataModel!
        .agridata!
        .crops!) {
      if (cropId == element.id) {
        return element.name;
      }
    }
    return '';
  }

  String getTitleFromCropIdAndCropCategoryId({int? cropCatId, int? cropId}) {
    return '${getCropCategoryFromId(cropCategoryId: cropCatId)} | ${getCropFromId(cropId: cropId)}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (context
                .read<AgriCubit>()
                .addAgriMemberModel
                .lands![widget.index]
                .landparts!
                .length ==
            1) {
          context.read<AgriCubit>().openEditDeleteBottomSheet(context,
              lands: widget.lands,
              index: widget.index,
              title:
                  '${getCropCategoryFromId(cropCategoryId: widget.lands.landparts?[0].cropcatid)} | ${getCropFromId(cropId: widget.lands.landparts?[0].cropid)}');
        } else {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
                child: Wrap(
                  children: [
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '${context.read<AgriCubit>().addAgriMemberModel.lands?[widget.index].totalarea} Ha',
                                    style: GlobalTextStyles
                                        .ts13montsemiBold30OpaquBlack),
                                SizedBox(height: mqh(context, 15)),
                                SizedBox(
                                  height: 25,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Text(
                                          getTitleFromCropIdAndCropCategoryId(
                                              cropCatId: context
                                                  .read<AgriCubit>()
                                                  .addAgriMemberModel
                                                  .lands?[widget.index]
                                                  .landparts?[index]
                                                  .cropcatid,
                                              cropId: context
                                                  .read<AgriCubit>()
                                                  .addAgriMemberModel
                                                  .lands?[widget.index]
                                                  .landparts?[index]
                                                  .cropid),
                                          style: GlobalTextStyles
                                              .ts15montboldBlack);
                                    },
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(width: 10);
                                    },
                                    itemCount: context
                                        .read<AgriCubit>()
                                        .addAgriMemberModel
                                        .lands![widget.index]
                                        .landparts!
                                        .length,
                                  ),
                                ),
                                SizedBox(height: mqh(context, 15)),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: BuildCircledGreenIcon(
                              widget: Transform.translate(
                                offset: const Offset(-5, 0),
                                child: const Icon(Icons.close,
                                    color: GlobalColors.mainGreenColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: mqh(context, 50)),
                    BuildModifyAndEditContainer(
                        title: 'Modifier',
                        assetPath: Assets.icons.editSvg,
                        ontap: () {
                          // HERE I ASKED WHAT IF THE LAND HAS MORE THAN ONE CROP WHAT SHOULD I DO
                          context.read<AgriCubit>().numberOfCropsInEdit =
                              widget.lands.landparts?.length;
                          print(context.read<AgriCubit>().numberOfCropsInEdit);
                          // context.read<AgriCubit>().landOfIndex = context
                          //     .read<AgriCubit>()
                          //     .addAgriMemberModel
                          //     .lands![widget.index];
                          // context
                          //     .read<AgriCubit>()
                          //     .addAgriMemberModel
                          //     .lands!
                          //     .removeAt(widget.index);

                          // Navigator.pushNamedAndRemoveUntil(context,
                          //     Routes.agriStep3Screen, (route) => false);
                        }),
                    SizedBox(height: mqh(context, 10)),
                    BuildModifyAndEditContainer(
                      title: 'Supprimer',
                      assetPath: Assets.icons.trashSvg,
                      ontap: () {
                        context
                            .read<AgriCubit>()
                            .addAgriMemberModel
                            .lands!
                            .removeAt(widget.index);
                        // context.read<AgriCubit>().addAgriMemberModel.lands?.clear();
                        Navigator.of(context).pushReplacementNamed(
                            Routes.summaryOfAgriSpeciesScreen);
                        // context.read<AgriCubit>().addAgriMemberModel.lands?.clear();
                        // Navigator.of(context).pushReplacementNamed(
                        //     Routes.summaryOfAgriSpeciesScreen);

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
      },
      child: Card(
        elevation: 5,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Text(
                            '${getCropCategoryFromId(cropCategoryId: widget.lands.landparts?[index].cropcatid)} | ${getCropFromId(cropId: widget.lands.landparts?[index].cropid)}  (${widget.lands.landparts?[index].landpartpercentage}%)',
                            style: GlobalTextStyles.ts15montboldBlack);
                      },
                      itemCount: widget.lands.landparts?.length,
                    ),
                    SizedBox(height: mqh(context, 15)),
                    Text('${widget.lands.totalarea} Ha',
                        style: GlobalTextStyles.ts13montsemiBold30OpaquBlack),
                  ],
                ),
              ),
              Center(
                child: Container(
                  width: mqw(context, 37),
                  height: mqh(context, 37),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: GlobalColors.mainGreenColor.withOpacity(0.1)),
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: GlobalColors.mainGreenColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: GlobalColors.mainGreenColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: GlobalColors.mainGreenColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ],
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
