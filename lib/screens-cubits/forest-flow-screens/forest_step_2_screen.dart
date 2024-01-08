// ignore_for_file: avoid_print

import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/forest-flow-screens/cubit/forest_cubit.dart';
import 'package:capef/screens-cubits/forest-flow-screens/widgets/forest_box.dart';
import 'package:capef/screens-cubits/forest-flow-screens/widgets/get_forests_links_screen.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/snackbar.dart';
import 'package:capef/widgets/appbar.dart';
import 'package:capef/widgets/button.dart';
import 'package:capef/widgets/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class ForestStep2Screen extends StatefulWidget {
  const ForestStep2Screen({super.key});

  @override
  State<ForestStep2Screen> createState() => _ForestStep2ScreenState();
}

class _ForestStep2ScreenState extends State<ForestStep2Screen> {
  @override
  void initState() {
    // openScreen();
    super.initState();
  }

  // Future<void> openScreen() async {
  //   context.read<ForestCubit>().linkIds.clear();
  //   context.read<ForestCubit>().constantLinkedIdsToBeSentToApi.clear();
  //   print(context.read<ForestCubit>().constantLinkedIdsToBeSentToApi);

  //   setState(() {});
  // }

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
                  if (context
                      .read<ForestCubit>()
                      .constantLinkedIdsToBeSentToApi
                      .isEmpty) {
                    GlobalSnackbar.showFailureToast(
                        context, 'Sélectionnez au moins 1 option');
                  } else {
                    if (context
                            .read<ForestCubit>()
                            .constantLinkedIdsToBeSentToApi[0] ==
                        1) {
                      context.read<ForestCubit>().showBackInForestry = true;
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          Routes.forestryOperatorStep1Screen, (route) => false);
                    }
                    if (context
                            .read<ForestCubit>()
                            .constantLinkedIdsToBeSentToApi[0] ==
                        2) {
                      context.read<ForestCubit>().showBackInForestry = true;
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          Routes.silviculturistStep1Screen, (route) => false);
                    }
                    if (context
                            .read<ForestCubit>()
                            .constantLinkedIdsToBeSentToApi[0] ==
                        3) {
                      context.read<ForestCubit>().showBackInWildLife = true;
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          Routes.wildLifeProductsOperatorStep1Screen,
                          (route) => false);
                    }
                    if (context
                            .read<ForestCubit>()
                            .constantLinkedIdsToBeSentToApi[0] ==
                        4) {
                      context.read<ForestCubit>().showBackInPNFL = true;
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          Routes.pnflOperatorStep1Screen, (route) => false);
                    }
                  }
                  // context.read<ForestCubit>().navigateTo(context);
                }),
          ),
          appBar: const BuildAppBar(title: 'Localisation Géographique'),
          body: KeyboardDismisser(
            child: Padding(
              padding: globalScreenPaddings,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const BuildEasyStepperWidget(length: 3, stepNow: 2),
                    SizedBox(height: mqh(context, 40)),
                    const BuildForestBox(),
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
                    const BuildGetForestsLinks(),
                    // const BuildGetFishingLinks(),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
