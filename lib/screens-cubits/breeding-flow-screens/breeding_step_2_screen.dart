import 'package:capef/screens-cubits/breeding-flow-screens/cubit/breeding_cubit.dart';
import 'package:capef/screens-cubits/breeding-flow-screens/widgets/breeding_box.dart';
import 'package:capef/screens-cubits/breeding-flow-screens/widgets/get_breeding_links_screen.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/widgets/appbar.dart';
import 'package:capef/widgets/button.dart';
import 'package:capef/widgets/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class BreedingStep2Screen extends StatefulWidget {
  const BreedingStep2Screen({super.key});

  @override
  State<BreedingStep2Screen> createState() => _BreedingStep2ScreenState();
}

class _BreedingStep2ScreenState extends State<BreedingStep2Screen> {
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
                  context.read<BreedingCubit>().navigateToStep3(context);
                }),
          ),
          appBar: const BuildAppBar(title: 'Localisation Géographique'),
          body: KeyboardDismisser(
            child: Padding(
              padding: globalScreenPaddings,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const BuildEasyStepperWidget(length: 4, stepNow: 2),
                    SizedBox(height: mqh(context, 40)),
                    const BuildBreedingBox(),
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
                    const BuildGetBreedingLinks(),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
