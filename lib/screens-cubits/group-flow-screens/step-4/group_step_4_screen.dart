// ignore_for_file: avoid_print

import 'package:capef/global_cubits/activities_cubit/activities_cubit.dart';
import 'package:capef/global_cubits/get_offline_cubit/get_offline_cubit.dart';
import 'package:capef/global_cubits/physical_person_cubit/add_physical_person_cubit.dart';
import 'package:capef/models/offline_data_response.dart';
import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/group-flow-screens/cubit/group_flow_cubit.dart';
import 'package:capef/screens-cubits/physical-person-flow/step-3/step_3_model.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/snackbar.dart';
import 'package:capef/widgets/appbar.dart';
import 'package:capef/widgets/button.dart';
import 'package:capef/widgets/category_drop_down.dart';
import 'package:capef/widgets/easy_stepper.dart';
import 'package:capef/widgets/pick_secondary_activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class AddGroupStep4Screen extends StatefulWidget {
  const AddGroupStep4Screen({super.key, this.addPhysicalMemberStep3Model});
  final PersonalInfoWithLocationInfoModel? addPhysicalMemberStep3Model;

  @override
  State<AddGroupStep4Screen> createState() => _AddGroupStep4ScreenState();
}

class _AddGroupStep4ScreenState extends State<AddGroupStep4Screen> {
  List<Categories> categoriesNotSelected = [];
  Categories? categories;
  bool? showList = false;
  int? secondaryCategoryId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          appBar: const BuildAppBar(title: 'Représentant'),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
            child: BuildButton(
              onTap: () {
                if (context.read<GroupFlowCubit>().mainactivityid == null) {
                  GlobalSnackbar.showFailureToast(context,
                      'assurez-vous de remplir toutes les informations');
                } else {
                  if (secondaryCategoryId == -1) {
                    context.read<GroupFlowCubit>().secondaryactivityid = null;
                  }
                  Navigator.of(context).pushNamed(Routes.addgroupScreen5);
                  context.read<ActivitiesCubit>().principleActivityId =
                      categories?.id;
                  context.read<ActivitiesCubit>().secondaryActivityId =
                      secondaryCategoryId;
                  print(
                      'IF NO ONE IS SELECTED ${context.read<GroupFlowCubit>().secondaryactivityid}');
                }
                // Navigator.of(context).pushNamed(Routes.addPhysicalPersonScreen5,
                //     arguments: AddPhysicalPersonStep5Screen(
                //       addPhysicalMemberStep4Model:
                //           PersonalInfoWithLocationInfoWithPrinciplesModel(
                //         step3model: widget.addPhysicalMemberStep3Model,
                //         proncipleId: categories?.id,
                //         secondaryId: secondaryCategoryId,
                //       ),
                //     ));
              },
              txt: 'SUIVANT',
            ),
          ),
          body: KeyboardDismisser(
            child: Padding(
              padding: globalScreenPaddings,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: mqh(context, 30)),
                  const BuildEasyStepperWidget(length: 6, stepNow: 4),
                  SizedBox(height: mqh(context, 40)),
                  const Center(
                    child: Text('Activité Principale',
                        style: GlobalTextStyles.ts20montboldGreen),
                  ),
                  SizedBox(height: mqh(context, 40)),
                  BuildCategoryDropDown(onChange: (p0) {
                    categories = p0;
                    context.read<GroupFlowCubit>().mainactivityid =
                        p0.id.toString();

                    categoriesNotSelected.clear();
                    for (var element in context
                        .read<GetOfflineCubitCubit>()
                        .getOfflineDataModel!
                        .categories!) {
                      if (element != p0) {
                        print(p0.name);
                        categoriesNotSelected.add(element);
                      }

                      setState(() {});
                      print('Catgs Not Selected $categoriesNotSelected');
                    }
                    print(context.read<AddPhysicalPersonCubit>().categoryId);
                  }),
                  SizedBox(height: mqh(context, 30)),
                  showList == true
                      ? BuildPickSecondaryActivity(
                          restCategories: categoriesNotSelected,
                          onTap: (p0) {
                            context.read<GroupFlowCubit>().secondaryactivityid =
                                p0.toString();
                            print(context
                                .read<GroupFlowCubit>()
                                .secondaryactivityid);
                            secondaryCategoryId = p0;
                            print('SSSSS $secondaryCategoryId');
                          },
                        )
                      : Center(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                showList = true;
                              });
                            },
                            child: Text(
                              'Ajoutez une activité Secondaire'.toUpperCase(),
                              style:
                                  GlobalTextStyles.underlinedViewAllTextButton,
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ));
  }
}
