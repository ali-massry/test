import 'package:capef/global_cubits/get_offline_cubit/get_offline_cubit.dart';
import 'package:capef/models/offline_data_response.dart';
import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/fishing-flow-screens/cubit/fishing_cubit.dart';
import 'package:capef/screens-cubits/fishing-flow-screens/model/add_fishing_member_model.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/snackbar.dart';
import 'package:capef/widgets/appbar.dart';
import 'package:capef/widgets/button.dart';
import 'package:capef/widgets/easy_stepper.dart';
import 'package:capef/widgets/label_with_textfield.dart';
import 'package:capef/widgets/unit_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class FishingStep4Screen extends StatefulWidget {
  const FishingStep4Screen({super.key});

  @override
  State<FishingStep4Screen> createState() => _FishingStep4ScreenState();
}

class _FishingStep4ScreenState extends State<FishingStep4Screen> {
  Units? units;
  TextEditingController unitEditingController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  String? hintt;

  @override
  void initState() {
    if (context.read<FishingCubit>().fishingsToBeEdited == null) {
    } else {
      units = getUnitFromId(id: context.read<FishingCubit>().fishingsToBeEdited!.unitid!);
      unitEditingController = TextEditingController(
          text: context
              .read<FishingCubit>()
              .fishingsToBeEdited
              ?.annualprodqtt
              .toString());
      priceController = TextEditingController(
          text: context
              .read<FishingCubit>()
              .fishingsToBeEdited
              ?.annualprodfcfa
              .toString());

      // print(units);
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
                  if (units == null ||
                      priceController.text == '' ||
                      unitEditingController.text == '') {
                    GlobalSnackbar.showFailureToast(
                        context, 'assurez-vous de remplir tous les champs');
                  } else {
                    setState(() {
                      context.read<FishingCubit>().fishings.add(Fishings(
                          speciesid: context.read<FishingCubit>().speciesId,
                          annualprodfcfa: num.parse(priceController.text),
                          unitid: units?.id,
                          annualprodqtt:
                              num.parse(unitEditingController.text)));
                    });
                    context.read<FishingCubit>().addFishingMemberModel =
                        AddFishingMemberModel(
                            areaId: context.read<FishingCubit>().areas?.areaid,
                            districtId: context
                                .read<FishingCubit>()
                                .districts
                                ?.districtid,
                            linkids: context.read<FishingCubit>().linkids,
                            offOnId: context.read<FishingCubit>().offOnId,
                            regionId:
                                context.read<FishingCubit>().regions?.regionid,
                            villageId: context
                                .read<FishingCubit>()
                                .villages
                                ?.villageid,
                            fishings: context.read<FishingCubit>().fishings);

                    Navigator.of(context).pushNamedAndRemoveUntil(
                      Routes.summaryOfFishingSpeciesScreen,
                      (route) => false,
                    );
                  }
                }),
          ),
          appBar: const BuildAppBar(title: 'Espèces de Pêche Principale'),
          body: KeyboardDismisser(
            child: Padding(
                padding: globalScreenPaddings,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BuildEasyStepperWidget(length: 4, stepNow: 4),
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
                            'Informations espèce de pêche principale',
                            style: GlobalTextStyles.ts20montboldGreen,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(height: mqh(context, 40)),
                      BuildUnitsDropDown(
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
                )),
          ),
        ));
  }
}
