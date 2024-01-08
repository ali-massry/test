import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/breeding-flow-screens/cubit/breeding_cubit.dart';
import 'package:capef/screens-cubits/breeding-flow-screens/widgets/breeding_box.dart';
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

class BreedingStep1Screen extends StatefulWidget {
  const BreedingStep1Screen({super.key});

  @override
  State<BreedingStep1Screen> createState() => _BreedingStep1ScreenState();
}

class _BreedingStep1ScreenState extends State<BreedingStep1Screen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          appBar: const BuildAppBar(
              title: 'Activité Principale: Éleveurs', showBack: false),
          body: KeyboardDismisser(
            child: Padding(
              padding: globalScreenPaddings,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const BuildEasyStepperWidget(length: 4, stepNow: 1),
                    SizedBox(height: mqh(context, 40)),
                    const BuildBreedingBox(),
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
                      context.read<BreedingCubit>().regions = p0;
                    }),
                    SizedBox(height: mqh(context, 20)),
                    BuildDepartmentDropDown(onChange: (p0) {
                      context.read<BreedingCubit>().districts = p0;
                    }),
                    SizedBox(height: mqh(context, 20)),
                    BuildAreasDropDown(onChange: (p0) {
                      context.read<BreedingCubit>().areas = p0;
                    }),
                    SizedBox(height: mqh(context, 20)),
                    BuildVillagesDropDown(onChange: (p0) {
                      context.read<BreedingCubit>().villages = p0;
                    }),
                    SizedBox(height: mqh(context, 50)),
                    BuildButton(
                        txt: 'SUIVANT',
                        onTap: () {
                          if (context.read<BreedingCubit>().regions == null ||
                              context.read<BreedingCubit>().districts == null ||
                              context.read<BreedingCubit>().areas == null ||
                              context.read<BreedingCubit>().villages == null) {
                            GlobalSnackbar.showFailureToast(context,
                                'Assurez-vous De Sélectionner Tous Les Champs');
                          } else {
                            Navigator.of(context)
                                .pushNamed(Routes.breedingStep2Screen);
                          }
                          // Navigator.of(context)
                          //     .pushNamed(Routes.breedingStep2Screen);
                        })
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
