import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/forest-flow-screens/cubit/forest_cubit.dart';
import 'package:capef/screens-cubits/forest-flow-screens/model/add_forest_member_model.dart';
import 'package:capef/screens-cubits/forest-flow-screens/widgets/forest_box.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/snackbar.dart';
import 'package:capef/widgets/appbar.dart';
import 'package:capef/widgets/button.dart';
import 'package:capef/widgets/easy_stepper.dart';
import 'package:capef/widgets/forest_species_drop_down.dart';
import 'package:capef/widgets/label_with_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class WildLifeProductsOperatorStep1Screen extends StatefulWidget {
  const WildLifeProductsOperatorStep1Screen({super.key});

  @override
  State<WildLifeProductsOperatorStep1Screen> createState() =>
      _WildLifeProductsOperatorStep1ScreenState();
}

class _WildLifeProductsOperatorStep1ScreenState
    extends State<WildLifeProductsOperatorStep1Screen> {
  // Forestspecies? forestspecies;
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  int? forestSpeciesId;

  @override
  void initState() {
    if (context.read<ForestCubit>().forestsToBeEdited != null) {
      forestSpeciesId = int.parse(
          context.read<ForestCubit>().forestsToBeEdited!.speciesid.toString());
      quantityController = TextEditingController(
          text: context.read<ForestCubit>().forestsToBeEdited?.qty.toString());
      priceController = TextEditingController(
          text: context
              .read<ForestCubit>()
              .forestsToBeEdited
              ?.annualprodfcfa
              .toString());
    }
    super.initState();
  }

  // bool sameSpeciesOccur() {
  //   for (var species in context
  //       .read<ForestCubit>()
  //       .filterAllForestsAccordingToLinkId(linkId: 3)) {
  //     if (species.speciesid == forestSpeciesId) {
  //       return true;
  //     }
  //   }
  //   return false;
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
                  if (forestSpeciesId == null ||
                      quantityController.text == '' ||
                      priceController.text == '') {
                    GlobalSnackbar.showFailureToast(
                        context, 'remplissez tous les champs s\'il vous plaît');
                  } else {
                    // if (sameSpeciesOccur() == true) {
                    //   GlobalSnackbar.showFailureToast(context, 'espèce déjà ajoutée');
                    // } else {
                    context.read<ForestCubit>().addForestToTheListAndNavigate(
                        context,
                        forests: Forests(
                            linkid: 3,
                            annualprodfcfa: num.parse(priceController.text),
                            qty: num.parse(quantityController.text),
                            cultivatedarea: null,
                            prodid: null,
                            unitid: null,
                            essenceid: null,
                            speciesid: forestSpeciesId,
                            plantationtypeid: null),
                        routeName: Routes.summaryOfwildlifeproductsOperator);
                  }
                  // }
                }),
          ),
          appBar: BuildAppBar(
            title: 'Maillon au sein de la filière',
            ontapp: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.forestStep2Screen, (route) => false);
            },
            showBack: context.read<ForestCubit>().showBackInWildLife == true
                ? true
                : false,
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
                          'Produits De La Faune',
                          style: GlobalTextStyles.ts20montboldGreen,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: mqh(context, 40)),
                    BuildForestSpeciesDropDown(
                      onChange: (p0) {
                        forestSpeciesId = p0.id;
                      },
                    ),
                    SizedBox(height: mqh(context, 30)),
                    BuildLabelWithTextField(
                        passwordTextEditingController: quantityController,
                        hint: 'Quantité',
                        label: 'Quantité (Nb de tètes)',
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
