// ignore_for_file: prefer_collection_literals

import 'package:capef/global_cubits/add_forest_cubit/add_forest_cubit.dart';
import 'package:capef/global_cubits/get_offline_cubit/get_offline_cubit.dart';
import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/forest-flow-screens/cubit/forest_cubit.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/functions.dart';
import 'package:capef/utils/snackbar.dart';
import 'package:capef/widgets/appbar.dart';
import 'package:capef/widgets/button.dart';
import 'package:capef/widgets/category_edit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class SummaryOfWildLifeProductsOperator extends StatefulWidget {
  const SummaryOfWildLifeProductsOperator({super.key});

  @override
  State<SummaryOfWildLifeProductsOperator> createState() =>
      _SummaryOfWildLifeProductsOperatorState();
}

class _SummaryOfWildLifeProductsOperatorState
    extends State<SummaryOfWildLifeProductsOperator> {
  String? findFirstDuplicate(List<num?> numbers) {
    Set<num?> uniqueNumbers = Set<num>();

    for (var number in numbers) {
      if (!uniqueNumbers.add(number)) {
        for (var ele in context
            .read<GetOfflineCubitCubit>()
            .getOfflineDataModel!
            .forestandwilddata!
            .forestspecies!) {
          if (ele.id == number) {
            return ele.name;
          }
        }
        // Set.add returns false if the element is already in the set
        // return number;
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: BlocConsumer<AddForestCubit, AddForestState>(
          listener: (context, state) {
            if (state is AddForestSuccess) {
              GlobalSnackbar.showSuccessToast(context, 'Ajouté avec succès');
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.addForestSuccessScreen, (route) => false);
            }
            if (state is AddForestFailure) {
              GlobalSnackbar.showFailureToast(context, state.status?.message);
              // Navigator.of(context).pushNamedAndRemoveUntil(
              //     Routes.forestStep1Screen, (route) => false);
            }
          },
          builder: (context, state) {
            return Scaffold(
              // bottomNavigationBar: Padding(
              //   padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
              //   child: BuildButton(txt: 'SUIVANT', onTap: () {}),
              // ),
              appBar: const BuildAppBar(
                  title: 'Produits de la faune', showBack: false),
              body: KeyboardDismisser(
                child: Padding(
                    padding: globalScreenPaddings,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              // SizedBox(height: mqh(context, 40)),
                              SizedBox(height: mqh(context, 15)),
                              const Center(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 25.0),
                                  child: Text(
                                    'Récapitulatif des Produits de la faune',
                                    style: GlobalTextStyles.ts20montboldGreen,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              SizedBox(height: mqh(context, 40)),
                              ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        context
                                            .read<ForestCubit>()
                                            .openEditDeleteBottomSheet(context,
                                                forest: context
                                                    .read<ForestCubit>()
                                                    .filterAllForestsAccordingToLinkId(
                                                        linkId: 3)[index],
                                                linkId: 3,
                                                index: index);
                                      },
                                      child: BuildCategoryEditCard(
                                        title: '',
                                        columnWidget: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: mqh(context, 20)),
                                            Text(
                                              context
                                                  .read<ForestCubit>()
                                                  .forestSpeciesNameFromId(
                                                      context,
                                                      forestSpeciesId:
                                                          int.parse(context
                                                              .read<
                                                                  ForestCubit>()
                                                              .filterAllForestsAccordingToLinkId(
                                                                  linkId:
                                                                      3)[index]
                                                              .speciesid
                                                              .toString())),
                                              style: GlobalTextStyles
                                                  .ts15montboldBlack,
                                            ),
                                            SizedBox(height: mqh(context, 15)),
                                            Text(
                                              '${context.read<ForestCubit>().filterAllForestsAccordingToLinkId(linkId: 3)[index].qty}',
                                              style: GlobalTextStyles
                                                  .ts13montsemiBold30OpaquBlack,
                                            ),
                                            SizedBox(height: mqh(context, 8)),
                                            Text(
                                              '${context.read<ForestCubit>().filterAllForestsAccordingToLinkId(linkId: 3)[index].annualprodfcfa} FCFA',
                                              style: GlobalTextStyles
                                                  .ts13montsemiBold30OpaquBlack,
                                            ),
                                            SizedBox(height: mqh(context, 20)),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(height: mqh(context, 15));
                                  },
                                  itemCount: context
                                      .read<ForestCubit>()
                                      .filterAllForestsAccordingToLinkId(
                                          linkId: 3)
                                      .length),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(height: mqh(context, 40)),
                              GestureDetector(
                                onTap: () {
                                  context
                                      .read<ForestCubit>()
                                      .showBackInWildLife = false;
                                  context
                                      .read<ForestCubit>()
                                      .forestsToBeEdited = null;
                                  Navigator.of(context).pushReplacementNamed(
                                      Routes
                                          .wildLifeProductsOperatorStep1Screen);
                                },
                                child: Center(
                                  child: Text(
                                    'Ajouter un autre produit de la faune'
                                        .toUpperCase(),
                                    style: GlobalTextStyles
                                        .underlinedViewAllTextButton,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              SizedBox(height: mqh(context, 30)),
                              context
                                      .read<ForestCubit>()
                                      .filterAllForestsAccordingToLinkId(
                                          linkId: 3)
                                      .isEmpty
                                  ? const SizedBox()
                                  : BuildButton(
                                      txt: 'SUIVANT',
                                      onTap: () {
                                        List<num?> productIdsList = context
                                            .read<ForestCubit>()
                                            .filterAllForestsAccordingToLinkId(
                                                linkId: 3)
                                            .map((e) => e.speciesid)
                                            .toList();

                                        findFirstDuplicate(productIdsList);
                                        if (GlobalFunctions.containsDuplicate(
                                                productIdsList) ==
                                            true) {
                                          GlobalSnackbar.showFailureToast(
                                              context,
                                              'Le produit ${findFirstDuplicate(productIdsList)} existe déjà');
                                        } else {
                                          context
                                              .read<ForestCubit>()
                                              .forestsToBeEdited = null;
                                          context
                                              .read<ForestCubit>()
                                              .navigateTo(context);
                                        }
                                      }),
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
            );
          },
        ));
  }
}
