// ignore_for_file: avoid_print

import 'package:capef/global_cubits/get_offline_cubit/get_offline_cubit.dart';
import 'package:capef/models/offline_data_response.dart';
import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/breeding-flow-screens/breeding_step_4_screen.dart';
import 'package:capef/screens-cubits/breeding-flow-screens/cubit/breeding_cubit.dart';
import 'package:capef/screens-cubits/breeding-flow-screens/widgets/breeding_box.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/widgets/appbar.dart';
import 'package:capef/widgets/button.dart';
import 'package:capef/widgets/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class BreedingStep3Screen extends StatefulWidget {
  const BreedingStep3Screen({super.key});

  @override
  State<BreedingStep3Screen> createState() => _BreedingStep3ScreenState();
}

class _BreedingStep3ScreenState extends State<BreedingStep3Screen> {
  List<Breedingtypes> breedingTypes = [];
  int? selectedIndex = -1;
  @override
  void initState() {
    if (context.read<BreedingCubit>().breedingToBeEdited == null) {
      selectedIndex = -1;
    } else {
      selectedIndex =
          context.read<BreedingCubit>().breedingToBeEdited?.typeid;
    }

    breedingListAndGet();
    print(selectedIndex);

    super.initState();
  }

  Future<void> breedingListAndGet() async {
    for (var ele in context
        .read<GetOfflineCubitCubit>()
        .getOfflineDataModel!
        .breedingdata!
        .breedingtypes!) {
      for (var element in ele.links!) {
        print('Feeha nfs shee');
        for (var id in context.read<BreedingCubit>().linkids) {
          if (element.id == id) {
            if (!(breedingTypes.contains(ele))) {
              breedingTypes.add(ele);
            }
          }
        }
      }
    }

    for (var breeding in context.read<BreedingCubit>().breedings) {
      breedingTypes.removeWhere((element) => element.id == breeding.speciesid);
    }

    print(breedingTypes);

    // if (context.read<FishingCubit>().fishingLinks.isEmpty) {

    // } else {}
  }

  bool? isDifferentThanTheOneSelectedBeforeInEdit() {
    if (context.read<BreedingCubit>().breedingTypeId ==
        context.read<BreedingCubit>().breedingToBeEdited?.typeid) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
            child: BuildButton(
                txt: 'SUIVANT',
                onTap: () {
                  Navigator.of(context).pushNamed(Routes.breedingStep4Screen,
                      arguments: BreedingStep4Screen(
                        resetAllValues:
                            isDifferentThanTheOneSelectedBeforeInEdit(),
                      ));
                }),
          ),
          appBar: BuildAppBar(
            title: 'Maillon au sein de la filière',
            showBack:
                context.read<BreedingCubit>().showBackInStep3Screen == false
                    ? false
                    : true,
            ontapp: () {
              Navigator.pop(context);
            },
          ),
          body: KeyboardDismisser(
            child: Padding(
                padding: globalScreenPaddings,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BuildEasyStepperWidget(length: 4, stepNow: 3),
                      SizedBox(height: mqh(context, 40)),
                      const BuildBreedingBox(),
                      SizedBox(height: mqh(context, 15)),
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text(
                            'Type L’élevage',
                            style: GlobalTextStyles.ts20montboldGreen,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(height: mqh(context, 40)),
                      const Text(
                        'Sélectionner une des options suivantes',
                        style: GlobalTextStyles.ts12montboldGreen,
                      ),
                      SizedBox(height: mqh(context, 40)),
                      ListView.separated(
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 12);
                        },
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: breedingTypes.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (selectedIndex == breedingTypes[index].id) {
                                  selectedIndex = -1;
                                } else {
                                  selectedIndex = breedingTypes[index].id;
                                  context.read<BreedingCubit>().breedingTypeId =
                                      breedingTypes[index].id;
                                }
                              });
                              print(
                                  context.read<BreedingCubit>().breedingTypeId);
                            },
                            child: Row(
                              children: [
                                Icon(
                                    selectedIndex == breedingTypes[index].id
                                        ? Icons.check_circle
                                        : Icons.circle_outlined,
                                    color: GlobalColors.mainGreenColor),
                                // Container(
                                //   width: 17,
                                //   height: 17,
                                //   decoration: BoxDecoration(
                                //       color: Colors.white,
                                //       border: Border.all(
                                //           color: GlobalColors.mainGreenColor,
                                //           width: 2),
                                //       borderRadius: BorderRadius.circular(100)),
                                // ),
                                const SizedBox(width: 12),
                                Text(
                                  breedingTypes[index].name ?? '',
                                  style: GlobalTextStyles.ts13montsemiBoldBlack,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )),
          ),
        ));
  }
}
