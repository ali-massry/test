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

class AgriStep7Screen extends StatefulWidget {
  const AgriStep7Screen({super.key});

  @override
  State<AgriStep7Screen> createState() => AgriStep7ScreenState();
}

class AgriStep7ScreenState extends State<AgriStep7Screen> {
  List<Crops> cropsList = [];
  int? selectedIndex = -1;

  @override
  void initState() {
   if (context.read<AgriCubit>().addAgriMemberModel.lands  != null) {
       
    checkCrops();
     }
    // if (context.read<AgriCubit>().landOfIndex != null) {
    //   selectedIndex =
    //       context.read<AgriCubit>().landOfIndex?.landparts?[0].cropid;
    // } else {}

    filterCrops();
    super.initState();
  }

  void checkCrops() {
    context.read<AgriCubit>().cropsExisting = [];
    for (var land in context.read<AgriCubit>().addAgriMemberModel.lands!) {
      for (var landPart in land.landparts!) {
        context.read<AgriCubit>().cropsExisting.add(landPart.cropid);
      }
    }
  }

  Future<void> filterCrops() async {
    for (var ele in context
        .read<GetOfflineCubitCubit>()
        .getOfflineDataModel!
        .agridata!
        .crops!) {
      if (ele.cropcategoryid == context.read<AgriCubit>().cropCatIdLandPart) {
        if (cropsList.contains(ele)) {
        } else {
          cropsList.add(ele);
        }
      }
    }

    for (var elementt in context.read<AgriCubit>().cropsExisting) {
      cropsList.removeWhere((element) => element.id == elementt);
    }
    print(cropsList);
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
                    context.read<AgriCubit>().cropIdLandPart = selectedIndex;
                    Navigator.of(context).pushNamed(Routes.agriStep8Screen);
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
                      const BuildEasyStepperWidget(length: 8, stepNow: 7),
                      SizedBox(height: mqh(context, 40)),
                      const BuildAgriBox(),
                      SizedBox(height: mqh(context, 15)),
                      const BuildCenteredAgriText(
                          title: 'La Culture Principale'),
                      SizedBox(height: mqh(context, 40)),
                      Text('Sélectionner la culture principale'.toUpperCase(),
                          style: GlobalTextStyles.ts12montboldGreen),
                      SizedBox(height: mqh(context, 40)),
                      ListView.separated(
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 12);
                        },
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cropsList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (selectedIndex == cropsList[index].id) {
                                  selectedIndex = -1;
                                } else {
                                  selectedIndex = cropsList[index].id;
                                }
                              });
                            },
                            child: Row(
                              children: [
                                Icon(
                                    selectedIndex == cropsList[index].id
                                        ? Icons.check_circle
                                        : Icons.circle_outlined,
                                    color: GlobalColors.mainGreenColor),
                                const SizedBox(width: 12),
                                Text(
                                  cropsList[index].name ?? '',
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
