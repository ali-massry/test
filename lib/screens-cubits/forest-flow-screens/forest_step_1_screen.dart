import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/forest-flow-screens/cubit/forest_cubit.dart';
import 'package:capef/screens-cubits/forest-flow-screens/widgets/forest_box.dart';
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

class ForestStep1Screen extends StatelessWidget {
  const ForestStep1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          appBar: const BuildAppBar(
              title: 'Activité Principale: Forêts Et Faune', showBack: false),
          body: KeyboardDismisser(
            child: Padding(
              padding: globalScreenPaddings,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const BuildEasyStepperWidget(length: 3, stepNow: 1),
                    SizedBox(height: mqh(context, 40)),
                    const BuildForestBox(),
                    SizedBox(height: mqh(context, 15)),
                    const BuildCenteredText(),
                    SizedBox(height: mqh(context, 40)),
                    BuildRegionDropDown(onChange: (p0) {
                      context.read<ForestCubit>().regions = p0;
                    }),
                    SizedBox(height: mqh(context, 20)),
                    BuildDepartmentDropDown(onChange: (p0) {
                      context.read<ForestCubit>().districts = p0;
                    }),
                    SizedBox(height: mqh(context, 20)),
                    BuildAreasDropDown(onChange: (p0) {
                      context.read<ForestCubit>().areas = p0;
                    }),
                    SizedBox(height: mqh(context, 20)),
                    BuildVillagesDropDown(onChange: (p0) {
                      context.read<ForestCubit>().villages = p0;
                    }),
                    SizedBox(height: mqh(context, 50)),
                    BuildButton(
                        txt: 'SUIVANT',
                        onTap: () {
                          if (context.read<ForestCubit>().regions == null ||
                              context.read<ForestCubit>().districts == null ||
                              context.read<ForestCubit>().areas == null ||
                              context.read<ForestCubit>().villages == null) {
                            GlobalSnackbar.showFailureToast(context,
                                'Assurez-vous De Sélectionner Tous Les Champs');
                          } else {
                            Navigator.of(context)
                                .pushNamed(Routes.forestStep2Screen);
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

class BuildCenteredText extends StatelessWidget {
  const BuildCenteredText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Text(
          'Localisation Géographique de l’Activité',
          style: GlobalTextStyles.ts20montboldGreen,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
