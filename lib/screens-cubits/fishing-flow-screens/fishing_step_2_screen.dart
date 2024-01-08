import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/fishing-flow-screens/cubit/fishing_cubit.dart';
import 'package:capef/screens-cubits/fishing-flow-screens/widgets/get_fishing_links_screen.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/widgets/appbar.dart';
import 'package:capef/widgets/button.dart';
import 'package:capef/widgets/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class FishingStep2Screen extends StatefulWidget {
  const FishingStep2Screen({super.key});

  @override
  State<FishingStep2Screen> createState() => _FishingStep2ScreenState();
}

class _FishingStep2ScreenState extends State<FishingStep2Screen> {
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
                  Navigator.of(context).pushNamed(Routes.fishingStep3Screen);
                  context.read<FishingCubit>().showBackInStep3Screen = true;

                  context.read<FishingCubit>().howMany =
                      context.read<FishingCubit>().fishingLinks.length;
                  // ignore: avoid_print
                  print(context.read<FishingCubit>().howMany);
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
                    const BuildGetFishingLinks(),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
