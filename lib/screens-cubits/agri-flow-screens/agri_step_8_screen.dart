// ignore_for_file: avoid_print

import 'package:capef/global_cubits/get_offline_cubit/get_offline_cubit.dart';
import 'package:capef/models/offline_data_response.dart';
import 'package:capef/screens-cubits/agri-flow-screens/cubit/agri_cubit.dart';
import 'package:capef/screens-cubits/agri-flow-screens/widgets/centered_text.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/snackbar.dart';
import 'package:capef/widgets/agri_box.dart';
import 'package:capef/widgets/appbar.dart';
import 'package:capef/widgets/button.dart';
import 'package:capef/widgets/easy_stepper.dart';
import 'package:capef/widgets/label_with_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class AgriStep8Screen extends StatefulWidget {
  const AgriStep8Screen({super.key});

  @override
  State<AgriStep8Screen> createState() => AgriStep8ScreenState();
}

class AgriStep8ScreenState extends State<AgriStep8Screen> {
  TextEditingController unitEditingController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController percentageController = TextEditingController();

  @override
  void initState() {
    // if (context.read<AgriCubit>().landOfIndex != null) {
    //   unitEditingController = TextEditingController(
    //       text: context
    //           .read<AgriCubit>()
    //           .landOfIndex
    //           ?.landparts?[0]
    //           .annualprodqtt
    //           .toString());
    //   priceController = TextEditingController(
    //       text: context
    //           .read<AgriCubit>()
    //           .landOfIndex
    //           ?.landparts?[0]
    //           .annualprodfcfa
    //           .toString());
    //   percentageController = TextEditingController(
    //       text: context.read<AgriCubit>().landOfIndex?.totalarea.toString());
    // }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          // bottomNavigationBar: Padding(
          //   padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
          //   child: BuildButton(
          //       txt: 'SUIVANT',
          //       onTap: () {
          //         if (unitEditingController.text.isEmpty ||
          //             priceController.text.isEmpty ||
          //             percentageController.text.isEmpty ||
          //             context.read<AgriCubit>().unitIdLandPart == null) {
          // GlobalSnackbar.showFailureToast(context,
          //     'Assurez-vous De Remplir Toutes Les Informations');
          //         } else {

          //         }
          //       }),
          // ),
          appBar: const BuildAppBar(title: 'Maillon au sein de la filière'),
          body: KeyboardDismisser(
            child: Padding(
                padding: globalScreenPaddings,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BuildEasyStepperWidget(length: 8, stepNow: 8),
                      SizedBox(height: mqh(context, 40)),
                      const BuildAgriBox(),
                      SizedBox(height: mqh(context, 15)),
                      const BuildCenteredAgriText(
                          title: 'Informations Culture Associée'),
                      SizedBox(height: mqh(context, 20)),
                      BuildLabelWithTextField(
                          passwordTextEditingController: percentageController,
                          hint: '% De La Parcelle',
                          label: '% De La Parcelle',
                          maxLength: 2,
                          showSuffixIcon: false,
                          keyboardType: TextInputType.number),
                      SizedBox(height: mqh(context, 30)),
                      BuildUnitsAgriDropDown(onChange: (p0) {
                        context.read<AgriCubit>().unitIdLandPart = p0.id;
                      }),
                      BuildLabelWithTextField(
                          passwordTextEditingController: unitEditingController,
                          hint: 'Production Annuelle (Quantité)',
                          label: '',
                          showSuffixIcon: false,
                          keyboardType: TextInputType.number),
                      SizedBox(height: mqh(context, 30)),
                      BuildLabelWithTextField(
                          passwordTextEditingController: priceController,
                          hint: 'Production Annuelle (FCFA)',
                          label: 'Production Annuelle (FCFA)',
                          showSuffixIcon: false,
                          keyboardType: TextInputType.number),
                      SizedBox(height: mqh(context, 70)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              context.read<AgriCubit>().saveLandPart(
                                  annualQnt:
                                      double.parse(unitEditingController.text),
                                  annualPrice:
                                      double.parse(priceController.text),
                                  percentage:
                                      int.parse(percentageController.text),
                                  saveAndAddAnotherLandPart:
                                      'saveAndAddAnotherLandPart',
                                  context: context);
                            },
                            child: Text(
                                'Ajouter une autre culture associée'
                                    .toUpperCase(),
                                style: GlobalTextStyles
                                    .underlinedViewAllTextButton),
                          ),
                          SizedBox(height: mqh(context, 30)),
                          BuildButton(
                            onTap: () {
                              print(percentageController.text);

                              if (unitEditingController.text == '' ||
                                  priceController.text == '' ||
                                  percentageController.text == '') {
                                GlobalSnackbar.showFailureToast(context,
                                    'Assurez-vous de remplir tous les champs');
                              } else {
                                if (int.parse(percentageController.text) > 50) {
                                  GlobalSnackbar.showFailureToast(context,
                                      'Le pourcentage doit être inférieur à 50');
                                } else {
                                  context.read<AgriCubit>().saveLandPart(
                                      annualQnt: double.parse(
                                          unitEditingController.text),
                                      annualPrice:
                                          double.parse(priceController.text),
                                      percentage:
                                          int.parse(percentageController.text),
                                      saveAndAddAnotherLandPart: '',
                                      context: context);
                                }
                              }
                            },
                            txt: 'SUIVANT',
                          ),
                        ],
                      )
                    ],
                  ),
                )),
          ),
        ));
  }
}

class BuildUnitsAgriDropDown extends StatefulWidget {
  const BuildUnitsAgriDropDown({super.key, required this.onChange, this.hint});
  final Function(Units)? onChange;
  final String? hint;

  @override
  State<BuildUnitsAgriDropDown> createState() => _BuildUnitsAgriDropDownState();
}

class _BuildUnitsAgriDropDownState extends State<BuildUnitsAgriDropDown> {
  Units? selectedValue;

  Units getUnitFromId({required int id}) {
    for (var ele
        in context.read<GetOfflineCubitCubit>().getOfflineDataModel!.units!) {
      if (ele.id == id) {
        return ele;
      }
    }
    return Units();
  }

  @override
  void initState() {
    if (context.read<AgriCubit>().landOfIndex != null) {
      selectedValue = getUnitFromId(
          id: context.read<AgriCubit>().landOfIndex!.landparts![0].unitid!);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: mqw(context, 15)),
          child: Text(
            'Production Annuelle'.toUpperCase(),
            style: GlobalTextStyles.ts12ls1montboldGreen,
          ),
        ),
        SizedBox(height: mqh(context, 5)),
        Container(
          height: mqh(context, 50),
          width: mqw(context, 390),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black.withOpacity(0.15)),
              borderRadius: BorderRadius.circular(50)),
          child: DropdownButton<Units>(
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down,
                color: GlobalColors.mainGreenColor),
            underline: const SizedBox(),
            value: null,
            hint: Text(
              selectedValue == null
                  ? '— Choisir unité de mesure —'
                  : selectedValue?.name ?? '',
              style: GlobalTextStyles.ts13montsemiBoldBlack,
            ),
            onChanged: (p0) {
              setState(() {
                selectedValue = p0;
              });
              widget.onChange!(p0!);
            },
            items: context
                .read<GetOfflineCubitCubit>()
                .getOfflineDataModel
                ?.units!
                .map((Units value) {
              return DropdownMenuItem<Units>(
                value: value,
                child: Text(
                  value.name!,
                  style: GlobalTextStyles.ts13montsemiBoldBlack,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
