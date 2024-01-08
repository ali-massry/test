// ignore_for_file: avoid_print

import 'package:capef/global_cubits/get_offline_cubit/get_offline_cubit.dart';
import 'package:capef/models/offline_data_response.dart';
import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/fishing-flow-screens/cubit/fishing_cubit.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/widgets/appbar.dart';
import 'package:capef/widgets/button.dart';
import 'package:capef/widgets/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class FishingStep3Screen extends StatefulWidget {
  const FishingStep3Screen({super.key});

  @override
  State<FishingStep3Screen> createState() => _FishingStep3ScreenState();
}

class _FishingStep3ScreenState extends State<FishingStep3Screen> {
  List<Species> speciesList = [];
  int? selectedIndex = -1;
  @override
  void initState() {
    if (context.read<FishingCubit>().fishingsToBeEdited == null) {
      selectedIndex = -1;
    } else {
      selectedIndex =
          context.read<FishingCubit>().fishingsToBeEdited?.speciesid;
    }

    fishingsListAndGet();
    print(selectedIndex);

    super.initState();
  }

  Future<void> fishingsListAndGet() async {
    for (var ele in context
        .read<GetOfflineCubitCubit>()
        .getOfflineDataModel!
        .fishingdata!
        .species!) {
      for (var element in ele.links!) {
        print('Feeha nfs shee');
        for (var id in context.read<FishingCubit>().linkids) {
          if (element.id == id) {
            if (!(speciesList.contains(ele))) {
              speciesList.add(ele);
            }
          }
        }
      }
    }

    print(speciesList);

    for (var fishing in context.read<FishingCubit>().fishings) {
      speciesList.removeWhere((element) => element.id == fishing.speciesid);
    }

    print(speciesList);
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
                  Navigator.of(context).pushNamed(Routes.fishingStep4Screen);
                }),
          ),
          appBar: BuildAppBar(
              title: 'Maillon au sein de la filière',
              ontapp: () {
                Navigator.pop(context);
              },
              showBack:
                  context.read<FishingCubit>().showBackInStep3Screen == false
                      ? false
                      : true),
          body: KeyboardDismisser(
            child: Padding(
                padding: globalScreenPaddings,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BuildEasyStepperWidget(length: 4, stepNow: 3),
                      SizedBox(height: mqh(context, 40)),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 80),
                        // width: mqw(context, 137),
                        height: 30,

                        decoration: BoxDecoration(
                          color: GlobalColors.blueColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: mqw(context, 34)),
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
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text(
                            'Maillon au sein de la filière',
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
                        itemCount: speciesList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (selectedIndex == speciesList[index].id) {
                                  selectedIndex = -1;
                                } else {
                                  selectedIndex = speciesList[index].id;
                                  context.read<FishingCubit>().speciesId =
                                      speciesList[index].id;
                                }
                              });
                            },
                            child: Row(
                              children: [
                                Icon(
                                    selectedIndex == speciesList[index].id
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
                                  speciesList[index].name ?? '',
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
