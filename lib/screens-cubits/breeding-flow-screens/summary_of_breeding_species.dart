// ignore_for_file: avoid_print

import 'package:capef/assets.dart';
import 'package:capef/global_cubits/add_breeding_cubit/add_breeding_cubit.dart';
import 'package:capef/global_cubits/get_offline_cubit/get_offline_cubit.dart';
import 'package:capef/global_cubits/remove_category_cubit/remove_category_cubit.dart';
import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/breeding-flow-screens/cubit/breeding_cubit.dart';
import 'package:capef/screens-cubits/breeding-flow-screens/model/add_breeding_member_model.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/widgets/appbar.dart';
import 'package:capef/widgets/button.dart';
import 'package:capef/widgets/circled_green_icon.dart';
import 'package:capef/widgets/modify_delete_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class SummaryOfBreedingSpeciesScreen extends StatefulWidget {
  const SummaryOfBreedingSpeciesScreen({super.key});

  @override
  State<SummaryOfBreedingSpeciesScreen> createState() =>
      _SummaryOfBreedingSpeciesScreenState();
}

class _SummaryOfBreedingSpeciesScreenState
    extends State<SummaryOfBreedingSpeciesScreen> {
  Future<void> openEditDeleteBottomSheet(BuildContext context,
      {required String? title, required Breedings? breedings}) async {
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
                  var br = context.read<BreedingCubit>().breedings;
                  print(br);
                  Navigator.pop(context);
                  context.read<BreedingCubit>().breedingToBeEdited = breedings;
                  context.read<BreedingCubit>().breedings.removeWhere(
                      (element) => element.speciesid == breedings?.speciesid);
                  Navigator.of(context)
                      .pushReplacementNamed(Routes.breedingStep3Screen);
                  context.read<BreedingCubit>().showBackInStep3Screen = false;
                  print(br);

                  setState(() {});

                  //  Navigator.pop(context);
                  // context.read<FishingCubit>().fishingsToBeEdited = fishings;
                  // context.read<FishingCubit>().fishings.removeWhere(
                  //     (element) => element.speciesid == fishings.speciesid);
                  // Navigator.of(context)
                  //     .pushReplacementNamed(Routes.fishingStep3Screen);
                  // context.read<FishingCubit>().showBackInStep3Screen = false;
                  // setState(() {});
                },
              ),
              SizedBox(height: mqh(context, 10)),
              BuildModifyAndEditContainer(
                title: 'Supprimer',
                assetPath: Assets.icons.trashSvg,
                ontap: () {
                  context
                      .read<BreedingCubit>()
                      .breedings
                      .removeWhere((element) => element == breedings);
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: mqh(context, 20)),
            ],
          ),
        );
      },
    );
  }

  String getSpeciesNameFromId({int? id}) {
    for (var element in context
        .read<GetOfflineCubitCubit>()
        .getOfflineDataModel!
        .breedingdata!
        .breedingspecies!) {
      print(element.id);
      if (id == element.id) {
        return element.name ?? '';
      }
    }
    return '';
  }

  String getLiveStockNameFromId({int? id}) {
    for (var element in context
        .read<GetOfflineCubitCubit>()
        .getOfflineDataModel!
        .breedingdata!
        .breedinglivestock!) {
      print(element.id);
      if (id == element.id) {
        return element.name ?? '';
      }
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    var t = context.read<BreedingCubit>().breedings;
    print(t);
    return SafeArea(
        top: true,
        child: Scaffold(
          bottomNavigationBar: context.read<BreedingCubit>().breedings.isEmpty
              ? const SizedBox()
              : Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                  child: BuildButton(
                      txt: 'SUIVANT',
                      onTap: context.read<BreedingCubit>().fromProfileEdit !=
                              null
                          ? () {
                              // down remove then add cat
                              context
                                      .read<BreedingCubit>()
                                      .addBreedingMemberModel =
                                  AddBreedingMemberModel(
                                      area: context
                                          .read<BreedingCubit>()
                                          .areas
                                          ?.areaid,
                                      region: context
                                          .read<BreedingCubit>()
                                          .regions
                                          ?.regionid,
                                      district: context
                                          .read<BreedingCubit>()
                                          .districts
                                          ?.districtid,
                                      village: context
                                          .read<BreedingCubit>()
                                          .villages
                                          ?.villageid,
                                      id: context.read<BreedingCubit>().offonId,
                                      linkids:
                                          context.read<BreedingCubit>().linkids,
                                      breedings: context
                                          .read<BreedingCubit>()
                                          .breedings);

                              context
                                  .read<RemoveCategoryCubit>()
                                  .removeCategory(
                                      categoryId: int.parse(context
                                              .read<BreedingCubit>()
                                              .fromProfileEdit ??
                                          ''))
                                  .then((value) {
                                context.read<AddBreedingCubit>().addAgriMember(
                                    addBreedingMemberModel: context
                                        .read<BreedingCubit>()
                                        .addBreedingMemberModel);
                              });
                            }
                          : () {
                              context
                                      .read<BreedingCubit>()
                                      .addBreedingMemberModel =
                                  AddBreedingMemberModel(
                                      area: context
                                          .read<BreedingCubit>()
                                          .areas
                                          ?.areaid,
                                      region: context
                                          .read<BreedingCubit>()
                                          .regions
                                          ?.regionid,
                                      district: context
                                          .read<BreedingCubit>()
                                          .districts
                                          ?.districtid,
                                      village: context
                                          .read<BreedingCubit>()
                                          .villages
                                          ?.villageid,
                                      id: context.read<BreedingCubit>().offonId,
                                      linkids:
                                          context.read<BreedingCubit>().linkids,
                                      breedings: context
                                          .read<BreedingCubit>()
                                          .breedings);
                              var a = context
                                  .read<BreedingCubit>()
                                  .addBreedingMemberModel;
                              print(a);
                              context.read<AddBreedingCubit>().addAgriMember(
                                  addBreedingMemberModel: context
                                      .read<BreedingCubit>()
                                      .addBreedingMemberModel);
                            }),
                ),
          appBar: const BuildAppBar(
              title: 'Informations de L’élevage', showBack: false),
          body: KeyboardDismisser(
            child: BlocConsumer<AddBreedingCubit, AddBreedingState>(
              listener: (context, state) {
                if (state is AddBreedingSuccess) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      Routes.addBreedingSuccessScreen, (route) => false);
                }
              },
              builder: (context, state) {
                return Padding(
                    padding: globalScreenPaddings,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              SizedBox(height: mqh(context, 40)),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 80),
                                // width: mqw(context, 137),
                                height: 30,
                                decoration: BoxDecoration(
                                  color:
                                      GlobalColors.purpleColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: mqw(context, 34)),
                                child: Center(
                                  child: Text(
                                    'Éleveurs'.toUpperCase(),
                                    style: const TextStyle(
                                        color: GlobalColors.purpleColor,
                                        fontFamily: GlobalFonts.montserratBold,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                              SizedBox(height: mqh(context, 15)),
                              const Center(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 25.0),
                                  child: Text(
                                    'Récapitulatif des espèces élevées',
                                    style: GlobalTextStyles.ts20montboldGreen,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              SizedBox(height: mqh(context, 40)),
                              ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                        onTap: () {
                                          openEditDeleteBottomSheet(context,
                                              title: getSpeciesNameFromId(
                                                id: context
                                                    .read<BreedingCubit>()
                                                    .breedings[index]
                                                    .speciesid,
                                              ),
                                              breedings: context
                                                  .read<BreedingCubit>()
                                                  .breedings[index]);
                                        },
                                        child: Card(
                                          elevation: 5,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 19.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                            height: mqh(
                                                                context, 10)),
                                                        Text(
                                                          getSpeciesNameFromId(
                                                              id: context
                                                                  .read<
                                                                      BreedingCubit>()
                                                                  .breedings[
                                                                      index]
                                                                  .speciesid),
                                                          style: GlobalTextStyles
                                                              .ts15montboldBlack,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: context
                                                              .read<
                                                                  BreedingCubit>()
                                                              .breedings[index]
                                                              .breedingproducts!
                                                              .map(
                                                                  (e) => Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          const SizedBox(
                                                                              height: 4),
                                                                          Text(
                                                                            getLiveStockNameFromId(id: e.livestockid),
                                                                            style:
                                                                                GlobalTextStyles.ts13montsemiBold30OpaquBlack,
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 4),
                                                                        ],
                                                                      ))
                                                              .toList(),
                                                        ),
                                                      ],
                                                    ),
                                                    Center(
                                                      child: Container(
                                                        width: mqw(context, 37),
                                                        height:
                                                            mqh(context, 37),
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 10),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            color: GlobalColors
                                                                .mainGreenColor
                                                                .withOpacity(
                                                                    0.1)),
                                                        child: Center(
                                                            child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              width: 4,
                                                              height: 4,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: GlobalColors
                                                                    .mainGreenColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 4,
                                                              height: 4,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: GlobalColors
                                                                    .mainGreenColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 4,
                                                              height: 4,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: GlobalColors
                                                                    .mainGreenColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
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
                                          ),
                                        ));
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(height: mqh(context, 15));
                                  },
                                  itemCount: context
                                      .read<BreedingCubit>()
                                      .breedings
                                      .length),
                            ],
                          ),
                          SizedBox(height: mqh(context, 40)),
                          GestureDetector(
                            onTap: () {
                              context.read<BreedingCubit>().breedingToBeEdited =
                                  null;
                              context
                                  .read<BreedingCubit>()
                                  .showBackInStep3Screen = false;
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  Routes.breedingStep3Screen, (route) => false);
                            },
                            child: Center(
                              child: Text(
                                'Ajouter une autre Espèce Élevée'.toUpperCase(),
                                style: GlobalTextStyles
                                    .underlinedViewAllTextButton,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(height: mqh(context, 25)),
                        ],
                      ),
                    ));
              },
            ),
          ),
        ));
  }
}
