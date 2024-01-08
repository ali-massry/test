import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/agri-flow-screens/cubit/agri_cubit.dart';
import 'package:capef/screens-cubits/agri-flow-screens/widgets/centered_text.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/snackbar.dart';
import 'package:capef/widgets/agri_box.dart';
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

class AgriStep1Screen extends StatefulWidget {
  const AgriStep1Screen({super.key});

  @override
  State<AgriStep1Screen> createState() => _AgriStep1ScreenState();
}

class _AgriStep1ScreenState extends State<AgriStep1Screen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          appBar: const BuildAppBar(
              title: 'Activité Principale: Agriculture', showBack: false),
          body: KeyboardDismisser(
            child: Padding(
              padding: globalScreenPaddings,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const BuildEasyStepperWidget(length: 5, stepNow: 1),
                    SizedBox(height: mqh(context, 40)),
                    const BuildAgriBox(),
                    SizedBox(height: mqh(context, 15)),
                    const BuildCenteredAgriText(
                        title: 'Localisation Géographique de l’Activité'),
                    SizedBox(height: mqh(context, 40)),
                    BuildRegionDropDown(onChange: (p0) {
                      context.read<AgriCubit>().regions = p0;
                    }),
                    SizedBox(height: mqh(context, 20)),
                    BuildDepartmentDropDown(onChange: (p0) {
                      context.read<AgriCubit>().districts = p0;
                    }),
                    SizedBox(height: mqh(context, 20)),
                    BuildAreasDropDown(onChange: (p0) {
                      context.read<AgriCubit>().areas = p0;
                    }),
                    SizedBox(height: mqh(context, 20)),
                    BuildVillagesDropDown(onChange: (p0) {
                      context.read<AgriCubit>().villages = p0;
                    }),
                    SizedBox(height: mqh(context, 50)),
                    BuildButton(
                        txt: 'SUIVANT',
                        onTap: () {
                          if (context.read<AgriCubit>().regions == null ||
                              context.read<AgriCubit>().districts == null ||
                              context.read<AgriCubit>().areas == null ||
                              context.read<AgriCubit>().villages == null) {
                            GlobalSnackbar.showFailureToast(context,
                                'Assurez-vous De Sélectionner Tous Les Champs');
                          } else {
                            Navigator.of(context)
                                .pushNamed(Routes.agriStep2Screen);
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
