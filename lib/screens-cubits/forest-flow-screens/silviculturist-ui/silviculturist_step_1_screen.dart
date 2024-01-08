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
import 'package:capef/widgets/plantation_type_drop_down.dart';
import 'package:capef/widgets/products_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class SylviculturistScreen1 extends StatefulWidget {
  const SylviculturistScreen1({super.key});

  @override
  State<SylviculturistScreen1> createState() => _SylviculturistScreen1State();
}

class _SylviculturistScreen1State extends State<SylviculturistScreen1> {
  Units? units;
  TextEditingController unitEditingController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController areaController = TextEditingController();

  int? plantationTypeId;
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
      areaController = TextEditingController(
          text: context
              .read<ForestCubit>()
              .forestsToBeEdited
              ?.cultivatedarea
              .toString());
      units = getUnitFromId(
          id: int.parse(context
                  .read<ForestCubit>()
                  .forestsToBeEdited
                  ?.unitid
                  .toString() ??
              '1'));



      plantationTypeId = int.parse(
          context.read<ForestCubit>().forestsToBeEdited!.plantationtypeid.toString());
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
                      plantationTypeId == null ||
                      areaController.text == '' ||
                      units == null ||
                      unitEditingController.text == '' ||
                      priceController.text == '') {
                    GlobalSnackbar.showFailureToast(
                        context, 'remplissez tous les champs s\'il vous plaît');
                  } else {
                    context.read<ForestCubit>().addForestToTheListAndNavigate(
                        context,
                        forests: Forests(
                            linkid: 2,
                            unitid: units?.id,
                            prodid: productId,
                            essenceid: essenceId,
                            annualprodfcfa: num.parse(priceController.text),
                            qty: num.parse(unitEditingController.text),
                            cultivatedarea: num.parse(areaController.text),
                            speciesid: null,
                            plantationtypeid: plantationTypeId),
                        routeName: Routes.summaryOfsilviculturer);
                  }
                }),
          ),
          appBar: BuildAppBar(
            title: 'Maillon au sein de la filière',
            showBack:
                context.read<ForestCubit>().showBackInSylviculture == false
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
                          'Principales essences forestières cultivées:',
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

                        essenceId = p0.id;
                      },
                    ),
                    SizedBox(height: mqh(context, 20)),
                    BuildForestProductsDropDown(onChange: (p0) {
                      productId = p0.id;
                    }),
                    SizedBox(height: mqh(context, 30)),
                    BuildUnitsSylvicultureDropDown(
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
                    SizedBox(height: mqh(context, 20)),
                    BuildPlantationTypeDropDown(
                      onChange: (p0) {
                        plantationTypeId = p0.id;
                      },
                    ),
                    SizedBox(height: mqh(context, 20)),
                    BuildLabelWithTextField(
                        passwordTextEditingController: areaController,
                        hint: 'Superficie Cultivée',
                        label: 'Superficie Cultivée',
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




class BuildUnitsSylvicultureDropDown extends StatefulWidget {
  const BuildUnitsSylvicultureDropDown(
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
  State<BuildUnitsSylvicultureDropDown> createState() =>
      _BuildUnitsSylvicultureDropDownState();
}

class _BuildUnitsSylvicultureDropDownState
    extends State<BuildUnitsSylvicultureDropDown> {
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
