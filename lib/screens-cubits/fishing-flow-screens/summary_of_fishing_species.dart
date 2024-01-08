// ignore_for_file: avoid_print
import 'package:capef/assets.dart';
import 'package:capef/global_cubits/add_fishing_cubit/addfishingmember_cubit.dart';
import 'package:capef/global_cubits/get_offline_cubit/get_offline_cubit.dart';
import 'package:capef/global_cubits/remove_category_cubit/remove_category_cubit.dart';
import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/fishing-flow-screens/cubit/fishing_cubit.dart';
import 'package:capef/screens-cubits/fishing-flow-screens/model/add_fishing_member_model.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/widgets/appbar.dart';
import 'package:capef/widgets/button.dart';
import 'package:capef/widgets/category_edit_card.dart';
import 'package:capef/widgets/circled_green_icon.dart';
import 'package:capef/widgets/loading_button.dart';
import 'package:capef/widgets/modify_delete_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class SummaryOfFishingSpeciesScreen extends StatefulWidget {
  const SummaryOfFishingSpeciesScreen({super.key});

  @override
  State<SummaryOfFishingSpeciesScreen> createState() =>
      _SummaryOfFishingSpeciesScreenState();
}

class _SummaryOfFishingSpeciesScreenState
    extends State<SummaryOfFishingSpeciesScreen> {
  String? getUnitName({required int unitId}) {
    String? unitName = '';
    for (var element
        in context.read<GetOfflineCubitCubit>().getOfflineDataModel!.units!) {
      if (unitId == element.id) {
        unitName = element.name;
      }
    }
    return unitName;
  }

  Future<void> openEditDeleteBottomSheet(BuildContext context,
      {required String? title, required Fishings? fishings}) async {
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
                      const SizedBox(height: 10),
                      Text(
                          '${fishings?.annualprodqtt} ${getUnitName(unitId: fishings!.unitid!)}',
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
                            color: GlobalColors.mainGreenColor),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: mqh(context, 50)),
              BuildModifyAndEditContainer(
                title: 'Modifier',
                assetPath: Assets.icons.editSvg,
                ontap: () {
                  Navigator.pop(context);
                  context.read<FishingCubit>().fishingsToBeEdited = fishings;
                  context.read<FishingCubit>().fishings.removeWhere(
                      (element) => element.speciesid == fishings.speciesid);
                  Navigator.of(context)
                      .pushReplacementNamed(Routes.fishingStep3Screen);
                  context.read<FishingCubit>().showBackInStep3Screen = false;
                  setState(() {});
                },
              ),
              SizedBox(height: mqh(context, 10)),
              BuildModifyAndEditContainer(
                title: 'Supprimer',
                assetPath: Assets.icons.trashSvg,
                ontap: () {
                  context
                      .read<FishingCubit>()
                      .fishings
                      .removeWhere((element) => element == fishings);
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
        .fishingdata!
        .species!) {
      print(element.id);
      if (id == element.id) {
        return element.name ?? '';
      }
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: BlocConsumer<AddfishingmemberCubit, AddfishingmemberState>(
          listener: (context, state) {
            if (state is AddfishingmemberFailure) {}
            if (state is AddfishingmemberSuccess) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.addFishingSuccessScreen, (route) => false);
            }
          },
          builder: (context, state) {
            return Scaffold(
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                child: context.read<FishingCubit>().fishings.isEmpty
                    ? const SizedBox()
                    : (state is AddfishingmemberLoading)
                        ? BuildLoadingButton()
                        : BuildButton(
                            txt: 'SUIVANT',
                            onTap: context
                                        .read<FishingCubit>()
                                        .fromProfileEdit !=
                                    null
                                ? () {
                                    context
                                        .read<RemoveCategoryCubit>()
                                        .removeCategory(categoryId: int.parse(context.read<FishingCubit>().fromProfileEdit ?? ''))
                                        .then((value) {
                                      context
                                          .read<AddfishingmemberCubit>()
                                          .addFishingMember(
                                              addFishingMemberModel: context
                                                  .read<FishingCubit>()
                                                  .addFishingMemberModel);
                                    });
                                  }
                                : () {
                                    context
                                        .read<AddfishingmemberCubit>()
                                        .addFishingMember(
                                            addFishingMemberModel: context
                                                .read<FishingCubit>()
                                                .addFishingMemberModel);
                                  }),
              ),
              appBar: const BuildAppBar(
                  title: 'Informations espèce de pêche', showBack: false),
              body: KeyboardDismisser(
                child: Padding(
                    padding: globalScreenPaddings,
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
                                color: GlobalColors.blueColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: mqw(context, 34)),
                              child: Center(
                                child: Text(
                                  'PêCHEURS'.toUpperCase(),
                                  style: const TextStyle(
                                      color: GlobalColors.blueColor,
                                      fontFamily: GlobalFonts.montserratBold,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                            SizedBox(height: mqh(context, 15)),
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25.0),
                                child: Text(
                                  'Récapitulatif des espèces de pêche',
                                  style: GlobalTextStyles.ts20montboldGreen,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(height: mqh(context, 40)),
                            ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      openEditDeleteBottomSheet(context,
                                          title: getSpeciesNameFromId(
                                            id: context
                                                .read<FishingCubit>()
                                                .fishings[index]
                                                .speciesid,
                                          ),
                                          fishings: context
                                              .read<FishingCubit>()
                                              .fishings[index]);
                                    },
                                    child: BuildCategoryEditCard(
                                      title: getSpeciesNameFromId(
                                        id: context
                                            .read<FishingCubit>()
                                            .fishings[index]
                                            .speciesid,
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(height: mqh(context, 15));
                                },
                                itemCount: context
                                    .read<FishingCubit>()
                                    .fishings
                                    .length),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<FishingCubit>().fishingsToBeEdited =
                                null;
                            Navigator.of(context).pushReplacementNamed(
                                Routes.fishingStep3Screen);
                            context.read<FishingCubit>().showBackInStep3Screen =
                                false;
                          },
                          child: Center(
                            child: Text(
                              'Ajouter une nouvelle espèce depêche'
                                  .toUpperCase(),
                              style:
                                  GlobalTextStyles.underlinedViewAllTextButton,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            );
          },
        ));
  }
}
