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

class SummaryOfForestryOperator extends StatefulWidget {
  const SummaryOfForestryOperator({super.key});

  @override
  State<SummaryOfForestryOperator> createState() =>
      _SummaryOfForestryOperatorState();
}

class _SummaryOfForestryOperatorState extends State<SummaryOfForestryOperator> {
  String? findFirstDuplicate(List<num?> numbers) {
    // ignore: prefer_collection_literals
    Set<num?> uniqueNumbers = Set<num>();

    for (var number in numbers) {
      if (!uniqueNumbers.add(number)) {
        for (var ele in context
            .read<GetOfflineCubitCubit>()
            .getOfflineDataModel!
            .forestandwilddata!
            .forestproducts!) {
          if (ele.id == number) {
            return ele.name;
          }
        }
        // Set.add returns false if the element is already in the set
        // return number;
      }
    }

    return null; // No duplicates found
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          appBar: const BuildAppBar(
              title: 'Principales essences forestières', showBack: false),
          body: BlocConsumer<AddForestCubit, AddForestState>(
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
              return KeyboardDismisser(
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
                                    'Récapitulatif des essences forestières ligneuses exploitées et Produits obtenus',
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
                                      onTap: () async {
                                        context
                                            .read<ForestCubit>()
                                            .openEditDeleteBottomSheet(context,
                                                forest: context
                                                    .read<ForestCubit>()
                                                    .filterAllForestsAccordingToLinkId(
                                                        linkId: 1)[index],
                                                index: index,
                                                linkId: 1);
                                      },
                                      child: BuildCategoryEditCard(
                                        title:
                                            '${context.read<ForestCubit>().forestessences?.name} | ${context.read<ForestCubit>().filterAllForestsAccordingToLinkId(linkId: 1)[index].prodid}',
                                        columnWidget: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: mqh(context, 20)),
                                            Text(
                                              '${context.read<ForestCubit>().forestessences?.name} | ${context.read<ForestCubit>().productNameFromId(context, productId: int.parse(context.read<ForestCubit>().filterAllForestsAccordingToLinkId(linkId: 1)[index].prodid.toString()))}',
                                              style: GlobalTextStyles
                                                  .ts15montboldBlack,
                                            ),
                                            SizedBox(height: mqh(context, 15)),
                                            Text(
                                              '${context.read<ForestCubit>().filterAllForestsAccordingToLinkId(linkId: 1)[index].qty} / ${context.read<ForestCubit>().unitNameFromId(context, unitId: int.parse(context.read<ForestCubit>().filterAllForestsAccordingToLinkId(linkId: 1)[index].unitid.toString()))}',
                                              style: GlobalTextStyles
                                                  .ts13montsemiBold30OpaquBlack,
                                            ),
                                            SizedBox(height: mqh(context, 8)),
                                            Text(
                                              '${context.read<ForestCubit>().filterAllForestsAccordingToLinkId(linkId: 1)[index].annualprodfcfa} FCFA',
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
                                          linkId: 1)
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
                                      .showBackInForestry = false;
                                  context
                                      .read<ForestCubit>()
                                      .forestsToBeEdited = null;
                                  Navigator.of(context).pushReplacementNamed(
                                      Routes.forestryOperatorStep1Screen);
                                },
                                child: Center(
                                  child: Text(
                                    'Ajouter une autre essence forestière ligneuse exploitée'
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
                                          linkId: 1)
                                      .isEmpty
                                  ? const SizedBox()
                                  : BuildButton(
                                      txt: 'SUIVANT',
                                      onTap: () {
                                        List<num?> productIdsList = context
                                            .read<ForestCubit>()
                                            .filterAllForestsAccordingToLinkId(
                                                linkId: 1)
                                            .map((e) => e.prodid)
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
              );
            },
          ),
        ));
  }
}
