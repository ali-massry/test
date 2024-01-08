// ignore_for_file: avoid_print

import 'package:capef/global_cubits/get_offline_cubit/get_offline_cubit.dart';
import 'package:capef/models/offline_data_response.dart';
import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/agri-flow-screens/cubit/agri_cubit.dart';
import 'package:capef/screens-cubits/agri-flow-screens/widgets/centered_text.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/snackbar.dart';
import 'package:capef/widgets/agri_box.dart';
import 'package:capef/widgets/appbar.dart';
import 'package:capef/widgets/button.dart';
import 'package:capef/widgets/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class AgriStep6Screen extends StatefulWidget {
  const AgriStep6Screen({super.key});

  @override
  State<AgriStep6Screen> createState() => AgriStep6ScreenState();
}

class AgriStep6ScreenState extends State<AgriStep6Screen> {
  List<Cropcategories> cropCategoriesList = [];
  int? selectedIndex = -1;
  @override
  void initState() {
    // if (context.read<FishingCubit>().fishingsToBeEdited == null) {
    //   selectedIndex = -1;
    // } else {
    //   selectedIndex =
    //       context.read<FishingCubit>().fishingsToBeEdited?.speciesid;
    // }

    // if (context.read<AgriCubit>().landOfIndex != null) {
    //   selectedIndex =
    //       context.read<AgriCubit>().landOfIndex?.landparts?[0].cropcatid;
    // } else {}

    agriListAndGet();
    print(selectedIndex);

    super.initState();
  }

  Future<void> agriListAndGet() async {
    cropCategoriesList.clear();
    for (var ele in context
        .read<GetOfflineCubitCubit>()
        .getOfflineDataModel!
        .agridata!
        .cropcategories!) {
      for (var element in ele.links!) {
        for (var link in context.read<AgriCubit>().integersList) {
          if (element.id == link) {
            if (cropCategoriesList.contains(ele)) {
            } else {
              cropCategoriesList.add(ele);
            }
          }
        }
      }
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
                  if (selectedIndex == -1) {
                    GlobalSnackbar.showFailureToast(
                        context, 'Assurez-vous De Sélectionner Une Option');
                  } else {
                    context.read<AgriCubit>().cropCatIdLandPart = selectedIndex;
                    print(context.read<AgriCubit>().cropCatIdLandPart);

                    // context.read<AgriCubit>().cropCategoryId = selectedIndex;
                    Navigator.of(context).pushNamed(Routes.agriStep7Screen);
                  }
                }),
          ),
          appBar: const BuildAppBar(title: 'Maillon au sein de la filière'),
          body: KeyboardDismisser(
            child: Padding(
                padding: globalScreenPaddings,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BuildEasyStepperWidget(length: 8, stepNow: 6),
                      SizedBox(height: mqh(context, 40)),
                      const BuildAgriBox(),
                      SizedBox(height: mqh(context, 15)),
                      const BuildCenteredAgriText(
                          title: 'Catégorie Culture Associée'),
                      SizedBox(height: mqh(context, 40)),
                      Text(
                          'Sélectionner une des options suivantes'
                              .toUpperCase(),
                          style: GlobalTextStyles.ts12montboldGreen),
                      SizedBox(height: mqh(context, 40)),
                      ListView.separated(
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 12);
                        },
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cropCategoriesList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (selectedIndex ==
                                    cropCategoriesList[index].id) {
                                  selectedIndex = -1;
                                } else {
                                  selectedIndex = cropCategoriesList[index].id;
                                }
                              });
                            },
                            child: Row(
                              children: [
                                Icon(
                                    selectedIndex ==
                                            cropCategoriesList[index].id
                                        ? Icons.check_circle
                                        : Icons.circle_outlined,
                                    color: GlobalColors.mainGreenColor),
                                const SizedBox(width: 12),
                                Text(
                                  cropCategoriesList[index].name ?? '',
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
