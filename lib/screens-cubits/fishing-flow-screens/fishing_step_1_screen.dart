// ignore_for_file: avoid_print

import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/fishing-flow-screens/cubit/fishing_cubit.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/snackbar.dart';
import 'package:capef/widgets/appbar.dart';
import 'package:capef/widgets/areas_drop_down.dart';
import 'package:capef/widgets/button.dart';
import 'package:capef/widgets/department_drop_down.dart';
import 'package:capef/widgets/easy_stepper.dart';
import 'package:capef/widgets/region_drop_down.dart';
import 'package:capef/widgets/villages_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class FishingStep1Screen extends StatefulWidget {
  const FishingStep1Screen({super.key});

  @override
  State<FishingStep1Screen> createState() => _FishingStep1ScreenState();
}

class _FishingStep1ScreenState extends State<FishingStep1Screen> {
  @override
  Widget build(BuildContext context) {
    print('OFF ON ID ${context.read<FishingCubit>().offOnId}');
    return SafeArea(
        top: true,
        child: Scaffold(
          appBar: const BuildAppBar(
              title: 'Activité Principale: Pêcheurs', showBack: false),
          body: KeyboardDismisser(
            child: Padding(
              padding: globalScreenPaddings,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const BuildEasyStepperWidget(length: 4, stepNow: 1),
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
                          'Localisation Géographique de l’Activité',
                          style: GlobalTextStyles.ts20montboldGreen,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: mqh(context, 40)),
                    BuildRegionDropDown(onChange: (p0) {
                      context.read<FishingCubit>().regions = p0;
                      print(context.read<FishingCubit>().regions?.regionname);
                    }),
                    SizedBox(height: mqh(context, 20)),
                    BuildDepartmentDropDown(onChange: (p0) {
                      context.read<FishingCubit>().districts = p0;
                    }),
                    SizedBox(height: mqh(context, 20)),
                    BuildAreasDropDown(onChange: (p0) {
                      context.read<FishingCubit>().areas = p0;
                    }),
                    SizedBox(height: mqh(context, 20)),
                    BuildVillagesDropDown(onChange: (p0) {
                      context.read<FishingCubit>().villages = p0;
                    }),
                    SizedBox(height: mqh(context, 50)),
                    BuildButton(
                        txt: 'SUIVANT',
                        onTap: () {
                          if (context.read<FishingCubit>().regions == null ||
                              context.read<FishingCubit>().districts == null ||
                              context.read<FishingCubit>().areas == null ||
                              context.read<FishingCubit>().villages == null) {
                            GlobalSnackbar.showFailureToast(context,
                                'Assurez-vous De Sélectionner Tous Les Champs');
                          } else {
                            Navigator.of(context)
                                .pushNamed(Routes.fishingStep2Screen);
                          }
                        })
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
