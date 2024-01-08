// ignore_for_file: avoid_print

import 'package:capef/global_cubits/get_offline_cubit/get_offline_cubit.dart';
import 'package:capef/models/offline_data_response.dart';
import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/forest-flow-screens/cubit/forest_cubit.dart';
import 'package:capef/screens-cubits/forest-flow-screens/model/add_forest_member_model.dart';
import 'package:capef/screens-cubits/forest-flow-screens/widgets/forest_box.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/snackbar.dart';
import 'package:capef/widgets/appbar.dart';
import 'package:capef/widgets/button.dart';
import 'package:capef/widgets/easy_stepper.dart';
import 'package:capef/widgets/essences_drop_down.dart';
import 'package:capef/widgets/label_with_textfield.dart';
import 'package:capef/widgets/products_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class ForestryOperatorScreen1 extends StatefulWidget {
  const ForestryOperatorScreen1({super.key});

  @override
  State<ForestryOperatorScreen1> createState() =>
      _ForestryOperatorScreen1State();
}

class _ForestryOperatorScreen1State extends State<ForestryOperatorScreen1> {
  Units? units;
  TextEditingController unitEditingController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  int? essenceId;
  int? productId;

  @override
  void initState() {
    if (context.read<ForestCubit>().forestsToBeEdited != null) {
      unitEditingController = TextEditingController(
          text: context.read<ForestCubit>().forestsToBeEdited?.qty.toString());
      priceController = TextEditingController(
          text: context
              .read<ForestCubit>()
              .forestsToBeEdited
              ?.annualprodfcfa
              .toString());
      units = getUnitFromId(
          id: int.parse(context
                  .read<ForestCubit>()
                  .forestsToBeEdited
                  ?.unitid
                  .toString() ??
              '1'));

      productId = int.parse(
          context.read<ForestCubit>().forestsToBeEdited!.prodid.toString());
      essenceId = int.parse(
          context.read<ForestCubit>().forestsToBeEdited!.essenceid.toString());
    }
    super.initState();
  }

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
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
            child: BuildButton(
                txt: 'SUIVANT',
                onTap: () {
                  if (productId == null ||
                      essenceId == null ||
                      units == null ||
                      unitEditingController.text == '' ||
                      priceController.text == '') {
                    GlobalSnackbar.showFailureToast(
                        context, 'remplissez tous les champs s\'il vous plaît');
                  } else {
                    context.read<ForestCubit>().addForestToTheListAndNavigate(
                        context,
                        forests: Forests(
                            linkid: 1,
                            unitid: units?.id,
                            essenceid: essenceId,
                            prodid: productId,
                            annualprodfcfa: num.parse(priceController.text),
                            qty: num.parse(unitEditingController.text),
                            cultivatedarea: null,
                            speciesid: null,
                            plantationtypeid: null),
                        routeName: Routes.summaryOfforestryOperator);
                  }
                }),
          ),
          appBar: BuildAppBar(
            title: 'Maillon au sein de la filière',
            showBack: context.read<ForestCubit>().showBackInForestry == false
                ? false
                : true,
            ontapp: () {
              Navigator.of(context)
                  .pushReplacementNamed(Routes.forestStep2Screen);
            },
          ),
          body: KeyboardDismisser(
            child: Padding(
              padding: globalScreenPaddings,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const BuildEasyStepperWidget(length: 3, stepNow: 3),
                    SizedBox(height: mqh(context, 40)),
                    const BuildForestBox(),
                    SizedBox(height: mqh(context, 15)),
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0.0),
                        child: Text(
                          'Principales Essences Forestières Ligneuses Exploitées Et Produits Obtenus:',
                          style: GlobalTextStyles.ts20montboldGreen,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: mqh(context, 40)),
                    BuildEssencesDropDown(
                      onChange: (p0) {
                        context.read<ForestCubit>().forestessences = p0;
                        context
                            .read<ForestCubit>()
                            .renderForestProductsAccordingToEssenceSelected(
                                getOfflineDataModel: context
                                    .read<GetOfflineCubitCubit>()
                                    .getOfflineDataModel);
                        print(context.read<ForestCubit>().forestessences);

                        essenceId = p0.id;
                      },
                    ),
                    SizedBox(height: mqh(context, 20)),
                    BuildForestProductsDropDown(onChange: (p0) {
                      productId = p0.id;
                    }),
                    SizedBox(height: mqh(context, 30)),
                    BuildUnitsForestrtDropDown(
                      onChange: (p0) {
                        units = p0;
                      },
                    ),
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
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class BuildUnitsForestrtDropDown extends StatefulWidget {
  const BuildUnitsForestrtDropDown(
      {super.key,
      required this.onChange,
      this.hint,
      this.index,
      this.resetAllValuesInBreeding});
  final Function(Units)? onChange;
  final String? hint;
  final int? index;
  final bool? resetAllValuesInBreeding;

  @override
  State<BuildUnitsForestrtDropDown> createState() =>
      _BuildUnitsForestrtDropDownState();
}

class _BuildUnitsForestrtDropDownState
    extends State<BuildUnitsForestrtDropDown> {
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
    if (context.read<ForestCubit>().forestsToBeEdited != null) {
      selectedValue = getUnitFromId(
          id: int.parse(context
              .read<ForestCubit>()
              .forestsToBeEdited!
              .unitid
              .toString()));
    }
    print('RESETTT ${widget.resetAllValuesInBreeding}');

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
