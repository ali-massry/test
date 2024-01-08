import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/agri-flow-screens/cubit/agri_cubit.dart';
import 'package:capef/screens-cubits/agri-flow-screens/widgets/centered_text.dart';
import 'package:capef/screens-cubits/agri-flow-screens/widgets/get_agri_links_screen.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/snackbar.dart';
import 'package:capef/widgets/agri_box.dart';
import 'package:capef/widgets/appbar.dart';
import 'package:capef/widgets/button.dart';
import 'package:capef/widgets/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class AgriStep2Screen extends StatefulWidget {
  const AgriStep2Screen({super.key});

  @override
  State<AgriStep2Screen> createState() => AgriStep2ScreenState();
}

class AgriStep2ScreenState extends State<AgriStep2Screen> {
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
                  if (context.read<AgriCubit>().integersList.isEmpty) {
                    GlobalSnackbar.showFailureToast(context,
                        'Assurez-vous De Sélectionner Au Moins 1 Option');
                  } else {
                    Navigator.of(context).pushNamed(Routes.agriStep3Screen);
                  }
                }),
          ),
          appBar: const BuildAppBar(title: 'Localisation Géographique'),
          body: KeyboardDismisser(
            child: Padding(
              padding: globalScreenPaddings,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const BuildEasyStepperWidget(length: 5, stepNow: 2),
                    SizedBox(height: mqh(context, 40)),
                    const BuildAgriBox(),
                    SizedBox(height: mqh(context, 15)),
                    const BuildCenteredAgriText(
                        title: 'Maillon Au Sein De La Filière'),
                    SizedBox(height: mqh(context, 40)),
                    const BuildGetAgriLinks(),
                    // const BuildGetFishingLinks(),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
