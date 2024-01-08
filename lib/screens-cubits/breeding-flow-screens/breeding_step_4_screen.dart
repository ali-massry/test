// ignore_for_file: avoid_print

import 'package:capef/global_cubits/get_offline_cubit/get_offline_cubit.dart';
import 'package:capef/models/offline_data_response.dart';
import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/breeding-flow-screens/cubit/breeding_cubit.dart';
import 'package:capef/screens-cubits/breeding-flow-screens/model/add_breeding_member_model.dart';
import 'package:capef/screens-cubits/breeding-flow-screens/widgets/breeding_box.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/functions.dart';
import 'package:capef/utils/snackbar.dart';
import 'package:capef/widgets/appbar.dart';
import 'package:capef/widgets/breeding_products_drop_down.dart';
import 'package:capef/widgets/breeding_species_drop_down.dart';
import 'package:capef/widgets/button.dart';
import 'package:capef/widgets/easy_stepper.dart';
import 'package:capef/widgets/label_with_textfield.dart';
import 'package:capef/widgets/unit_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class BreedingStep4Screen extends StatefulWidget {
  const BreedingStep4Screen({super.key, this.resetAllValues});
  final bool? resetAllValues;

  @override
  State<BreedingStep4Screen> createState() => _BreedingStep4ScreenState();
}

class _BreedingStep4ScreenState extends State<BreedingStep4Screen> {
  TextEditingController liveStockSizeController = TextEditingController();
  String? hintt;
  List<Widget> productsToBeAddedWidget = [const BuildProductToBeAdded()];
  List<Breedingproducts> breedingProducts = [Breedingproducts()];

  int? speciesId = -1;

  @override
  void initState() {
    print('THE RESET ${widget.resetAllValues}');
    if (context.read<BreedingCubit>().breedingToBeEdited == null) {
    } else {
      if (widget.resetAllValues == false) {
          productsToBeAddedWidget = [const BuildProductToBeAdded()];
   breedingProducts = [Breedingproducts()];
      } else {
        speciesId = context.read<BreedingCubit>().breedingToBeEdited?.speciesid;
        print('Species IDDD without alter $speciesId');
        liveStockSizeController = TextEditingController(
            text: context
                .read<BreedingCubit>()
                .breedingToBeEdited
                ?.sizelivestock
                .toString());
        productsToBeAddedWidget = List.generate(
            context
                .read<BreedingCubit>()
                .breedingToBeEdited!
                .breedingproducts!
                .length,
            (index) => const BuildProductToBeAdded());
        breedingProducts = List.generate(
            context
                .read<BreedingCubit>()
                .breedingToBeEdited!
                .breedingproducts!
                .length,
            (index) => context
                .read<BreedingCubit>()
                .breedingToBeEdited!
                .breedingproducts![index]);
      }
    }
    super.initState();
  }

  // Units getUnitFromId({required int id}) {
  //   for (var ele
  //       in context.read<GetOfflineCubitCubit>().getOfflineDataModel!.units!) {
  //     if (ele.id == id) {
  //       return ele;
  //     }
  //   }
  //   return Units();
  // }

  Breedingspecies breedingspeciesFromOffline() {
    for (var element in context
        .read<GetOfflineCubitCubit>()
        .getOfflineDataModel!
        .breedingdata!
        .breedingspecies!) {
      if (element.id ==
          context.read<BreedingCubit>().breedingToBeEdited?.speciesid) {
        return element;
      }
    }
    return Breedingspecies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          appBar: const BuildAppBar(title: 'Type L’élevage'),
          body: KeyboardDismisser(
            child: Padding(
                padding: globalScreenPaddings,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BuildEasyStepperWidget(length: 4, stepNow: 4),
                      SizedBox(height: mqh(context, 40)),
                      const BuildBreedingBox(),
                      SizedBox(height: mqh(context, 15)),
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text(
                            'Informations de L’élevage',
                            style: GlobalTextStyles.ts20montboldGreen,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(height: mqh(context, 40)),
                      BuildBreedingSpeciesDropDown(
                        resetAllValues: widget.resetAllValues,
                        onChange: (p0) {
                          context.read<BreedingCubit>().changeBreedingSpecies(
                              p0: p0,
                              breedingLiveStock: context
                                  .read<GetOfflineCubitCubit>()
                                  .getOfflineDataModel!
                                  .breedingdata!
                                  .breedinglivestock!);
                          context.read<BreedingCubit>().breedingSpeciess =
                              p0.id;
                          for (var breedingLiveStock in context
                              .read<GetOfflineCubitCubit>()
                              .getOfflineDataModel!
                              .breedingdata!
                              .breedinglivestock!) {
                            if (breedingLiveStock.speciesid == p0.id) {
                              if (!context
                                  .read<BreedingCubit>()
                                  .breedingLiveStockkk
                                  .contains(breedingLiveStock)) {
                                context
                                    .read<BreedingCubit>()
                                    .breedingLiveStockkk
                                    .add(breedingLiveStock);
                              }
                            }
                          }
                          setState(() {
                            speciesId = p0.id;
                          });
                        },
                      ),
                      SizedBox(height: mqh(context, 20)),
                      BuildLabelWithTextField(
                          passwordTextEditingController:
                              liveStockSizeController,
                          hint: 'Taille du cheptel (Nb de tètes)',
                          label: 'Taille du cheptel (Nb de tètes)',
                          showSuffixIcon: false,
                          keyboardType: TextInputType.number),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return BuildProductToBeAdded(
                                breedingProductsList: breedingProducts,
                                index: index,
                                resetAllValues: widget.resetAllValues);
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: mqh(context, 5));
                          },
                          itemCount: productsToBeAddedWidget.length),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (breedingProducts.length < 5) {
                              productsToBeAddedWidget
                                  .add(const BuildProductToBeAdded());
                              breedingProducts.add(Breedingproducts());
                            }
                          });
                        },
                        child: Text(
                          'Ajouter un autre produit d’élevage'.toUpperCase(),
                          style: GlobalTextStyles.underlinedViewAllTextButton,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: mqh(context, 30)),
                      BuildButton(
                          txt: 'SUIVANT',
                          onTap: () {
                            bool breedingsAdded = false;

                            print(breedingProducts);
                            List<int?> integersListt = breedingProducts
                                .map((e) => e.livestockid)
                                .toList();

                            if (GlobalFunctions.containsDuplicate(
                                integersListt)) {
                              GlobalSnackbar.showFailureToast(context,
                                  'assurez-vous d\'avoir des produits différents');
                            } else {
                              for (var breedingProductHere
                                  in breedingProducts) {
                                if (breedingProductHere.annualprodfcfa ==
                                        null ||
                                    breedingProductHere.annualprodqtt == null ||
                                    breedingProductHere.livestockid == null ||
                                    breedingProductHere.unitid == null) {
                                  GlobalSnackbar.showFailureToast(context,
                                      'assurez-vous de remplir toutes les informations');
                                } else {
                                  if (!breedingsAdded) {
                                    List<Breedings> breedingsList = [];
                                    breedingsList.add(Breedings(
                                        typeid: context
                                            .read<BreedingCubit>()
                                            .breedingTypeId,
                                        speciesid: speciesId,
                                        sizelivestock: int.parse(
                                            liveStockSizeController.text),
                                        breedingproducts: breedingProducts));

                                    for (var ele in context
                                        .read<BreedingCubit>()
                                        .breedings) {
                                      breedingsList.add(ele);
                                    }

                                    context.read<BreedingCubit>().breedings =
                                        breedingsList;

                                    var a =
                                        context.read<BreedingCubit>().breedings;

                                    print(a);

                                    breedingsAdded = true;

                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                      Routes.summaryOfBreedingSpeciesScreen,
                                      (route) => false,
                                    );
                                  }
                                }
                              }
                            }

                            // setState(() {
                            //   context.read<BreedingCubit>().addBreedingMemberModel =
                            //       AddBreedingMemberModel(
                            //           areas: context.read<BreedingCubit>().areas,
                            //           districts: context.read<BreedingCubit>().districts,
                            //           linkids: context.read<BreedingCubit>().linkids,
                            //           regions: context.read<BreedingCubit>().regions,
                            //           villages: context.read<BreedingCubit>().villages,
                            //           memberid: 1,
                            //           breedings: [
                            //         Breedings(
                            //           unitid: units?.id,
                            //           typeid:
                            //               context.read<BreedingCubit>().breedingTypeId,
                            //           speciesid: context
                            //               .read<BreedingCubit>()
                            //               .breedingSpecies
                            //               ?.id,
                            //           livestockid:
                            //               context.read<BreedingCubit>().selectedValue?.id,
                            //               annualprodfcfa: priceController
                            //         ),
                            //       ]);
                            // });
                            // context.read<FishingCubit>().addFishingMemberModel =
                            //     AddFishingMemberModel(
                            //         areas: context.read<FishingCubit>().areas,
                            //         districts: context.read<FishingCubit>().districts,
                            //         linkids: context.read<FishingCubit>().linkids,
                            //         memberid: 0,
                            //         regions: context.read<FishingCubit>().regions,
                            //         villages: context.read<FishingCubit>().villages,
                            //         fishings: context.read<FishingCubit>().fishings);
                          }),
                    ],
                  ),
                )),
          ),
        ));
  }
}

class BuildProductToBeAdded extends StatefulWidget {
  const BuildProductToBeAdded(
      {super.key, this.breedingProductsList, this.index, this.resetAllValues});
  final List<Breedingproducts>? breedingProductsList;
  final int? index;
  final bool? resetAllValues;

  @override
  State<BuildProductToBeAdded> createState() => _BuildProductToBeAddedState();
}

class _BuildProductToBeAddedState extends State<BuildProductToBeAdded> {
  Units? units;
  TextEditingController unitEditingController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    print('RESET ${widget.resetAllValues}');
    // var t = context.read<BreedingCubit>().breedingToBeEdited;
    // print(t);
    if (context.read<BreedingCubit>().breedingToBeEdited == null) {
    } else if (context.read<BreedingCubit>().breedingToBeEdited != null &&
        widget.resetAllValues == true) {
      unitEditingController = TextEditingController(
          text: context
              .read<BreedingCubit>()
              .breedingToBeEdited
              ?.breedingproducts?[widget.index!]
              .annualprodqtt
              .toString());
      priceController = TextEditingController(
          text: context
              .read<BreedingCubit>()
              .breedingToBeEdited
              ?.breedingproducts?[widget.index!]
              .annualprodfcfa
              .toString());

      // context
      //     .read<BreedingCubit>()
      //     .breedingToBeEdited!
      //     .breedingproducts!
      //     .asMap()
      //     .forEach((index, value) {
      // unitEditingController =
      //     TextEditingController(text: value.annualprodqtt.toString());
      //   priceController =
      //       TextEditingController(text: value.annualprodfcfa.toString());
      //   print('${value.livestockid} $index');
      // });
      // for (var element in context
      //     .read<BreedingCubit>()
      //     .breedingToBeEdited!
      //     .breedingproducts!) {
      //   print(element);
      // }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.breedingProductsList![widget.index!].livestockid);
    // print(widget.breedingProductsList![widget.index!].livestockid);
    return Column(
      children: [
        SizedBox(height: mqh(context, 20)),
        BuildBreedingLiveStockDropDown(
          onChange: (p0) {
            // context.read<BreedingCubit>().selectedValue = p0;
            widget.breedingProductsList![widget.index!].livestockid = p0.id;
          },
          resetAllValues: widget.resetAllValues,
          index: widget.index,
        ),
        SizedBox(height: mqh(context, 40)),
        BuildUnitsDropDown(
          onChange: (p0) {
            units = p0;
            setState(() {
              widget.breedingProductsList![widget.index!].unitid = p0.id;
            });
          },
          index: widget.index,
          resetAllValuesInBreeding: widget.resetAllValues,

        ),
        BuildLabelWithTextField(
            passwordTextEditingController: unitEditingController,
            onChanged: (p0) {
              setState(() {
                widget.breedingProductsList![widget.index!].annualprodqtt =
                    int.parse(p0!);
              });
            },
            hint: 'Production Annuelle (Quantité)',
            label: '',
            showSuffixIcon: false,
            keyboardType: TextInputType.number),
        SizedBox(height: mqh(context, 30)),
        BuildLabelWithTextField(
            passwordTextEditingController: priceController,
            hint: 'Production Annuelle (FCFA)',
            onChanged: (p0) {
              setState(() {
                widget.breedingProductsList![widget.index!].annualprodfcfa =
                    int.parse(p0!);
              });
            },
            label: 'Production Annuelle (FCFA)',
            showSuffixIcon: false,
            keyboardType: TextInputType.number),
        SizedBox(height: mqh(context, 70)),
      ],
    );
  }
}
