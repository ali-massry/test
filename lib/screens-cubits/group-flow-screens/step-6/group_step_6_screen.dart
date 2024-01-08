// ignore_for_file: avoid_print

import 'package:capef/global_cubits/get_security_questions_cubit/get_security_questions_cubit.dart';
import 'package:capef/global_cubits/is_online_cubit/is_online_cubit.dart';
import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/group-flow-screens/cubit/group_flow_cubit.dart';
import 'package:capef/screens-cubits/group-flow-screens/group_success_screen.dart';
import 'package:capef/screens-cubits/physical-person-flow/step-5/step_5_model.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/functions.dart';
import 'package:capef/utils/snackbar.dart';
import 'package:capef/widgets/appbar.dart';
import 'package:capef/widgets/button.dart';
import 'package:capef/widgets/easy_stepper.dart';
import 'package:capef/widgets/label_with_textfield.dart';
import 'package:capef/widgets/loading_button.dart';
import 'package:capef/widgets/question_drop_down.dart';
// import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class AddGroupStep6Screen extends StatefulWidget {
  const AddGroupStep6Screen({super.key, this.addPhysicalMemberStep5Model});
  final PersonalInfoWithLocationInfoWithPrinciplesWithNumbersModel?
      addPhysicalMemberStep5Model;

  @override
  State<AddGroupStep6Screen> createState() => _AddGroupStep6ScreenState();
}

class _AddGroupStep6ScreenState extends State<AddGroupStep6Screen> {
  // int? agentId;
  int? timeStamp;
  String? transactionIDD;

  @override
  void initState() {
    context.read<GroupFlowCubit>().offlineId =
        offlineIdGlobal(agentId: agentIdLocall);
    print('OFFLINE ${context.read<GroupFlowCubit>().offlineId}');

    transactionIDD = transactionId(
        agentId: agentIdLocall,
        onlineOrOffline:
            context.read<IsOnlineCubit>().isOnline == true ? 1 : 2);
    super.initState();
  }

  TextEditingController pinController = TextEditingController();
  TextEditingController confirmPinController = TextEditingController();
  TextEditingController responseController = TextEditingController();
  TextEditingController confirmresponseController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          appBar: const BuildAppBar(title: 'Inscription et Cotisation'),
          body: BlocConsumer<GroupFlowCubit, GroupFlowState>(
            listener: (context, state) {
              if (state is AddLegalEntitySuccess) {
                GlobalSnackbar.showSuccessToast(context, 'Success');
                Navigator.of(context).pushNamed(Routes.groupSuccessScreen,
                    arguments: GroupSuccessScreen(
                      onlineOrOfllineId:
                          state.addLegalEntitySuccessModel?.onlineid == ''
                              ? context.read<GroupFlowCubit>().offlineId
                              : state.addLegalEntitySuccessModel?.onlineid,
                      transactionIDD: transactionIDD,
                    ));
              } else if (state is AddLegalEntityPersonFailure) {
                GlobalSnackbar.showFailureToast(
                    context, state.failureModel?.title);
              }
            },
            builder: (context, state) {
              return KeyboardDismisser(
                child: Padding(
                  padding: globalScreenPaddings,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: mqh(context, 30)),
                        const BuildEasyStepperWidget(length: 6, stepNow: 6),
                        SizedBox(height: mqh(context, 40)),
                        const Center(
                          child: Text('Code Pin du Ressortissant',
                              style: GlobalTextStyles.ts20montboldGreen),
                        ),
                        SizedBox(height: mqh(context, 40)),
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0.0),
                            child: Text(
                              'Demandez au ressortissant de choisir un code PIN personnel de 6 chiffres et le sauvegarder pour utilisation ultérieure.',
                              style: GlobalTextStyles.ts13montsemiBoldBlack,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(height: mqh(context, 30)),
                        BuildLabelWithTextField(
                          passwordTextEditingController: pinController,
                          label: 'Code PIN',
                          keyboardType: TextInputType.number,
                          maxLength: 6,
                          hint: 'Code PIN',
                          onChanged: (p0) {
                            pinController.text = p0 ?? '';
                            context.read<GroupFlowCubit>().pin = p0;
                            print(context.read<GroupFlowCubit>().pin);
                          },
                          showSuffixIcon: false,
                        ),
                        SizedBox(height: mqh(context, 20)),
                        BuildLabelWithTextField(
                          passwordTextEditingController: confirmPinController,
                          label: 'Confirmer le Code PIN',
                          keyboardType: TextInputType.number,
                          maxLength: 6,
                          hint: 'Confirmer le Code PIN',
                          onChanged: (p0) {
                            confirmPinController.text = p0 ?? '';
                          },
                          showSuffixIcon: true,
                        ),
                        SizedBox(height: mqh(context, 20)),
                        const BuildSecurityQuestionDropDownWidget(),
                        SizedBox(height: mqh(context, 20)),
                        BuildLabelWithTextField(
                          passwordTextEditingController: responseController,
                          label: 'Réponse',
                          hint: 'Réponse',
                          onChanged: (p0) {
                            responseController.text = p0 ?? '';
                            context.read<GroupFlowCubit>().secanswer = p0;
                          },
                          showSuffixIcon: true,
                        ),
                        SizedBox(height: mqh(context, 20)),
                        BuildLabelWithTextField(
                          passwordTextEditingController:
                              confirmresponseController,
                          label: 'Confirmer la Réponse',
                          hint: 'Confirmer la Réponse',
                          onChanged: (p0) {
                            confirmresponseController.text = p0 ?? '';
                          },
                          showSuffixIcon: false,
                        ),
                        SizedBox(height: mqh(context, 40)),
                        (state is AddLegalEntityPersonLoading)
                            ? BuildLoadingButton()
                            : BuildButton(
                                onTap: () {
                                  context.read<GroupFlowCubit>().securityqstid =
                                      context
                                          .read<GetSecurityQuestionsCubit>()
                                          .selectedQuestionId
                                          .toString();
                                  if (pinController.text !=
                                      confirmPinController.text) {
                                    GlobalSnackbar.showFailureToast(
                                        context, 'Confirmez votre code PIN');
                                  } else if (responseController.text !=
                                      confirmresponseController.text) {
                                    GlobalSnackbar.showFailureToast(
                                        context, 'Confirmez votre réponse');
                                  } else if (pinController.text.length != 6) {
                                    GlobalSnackbar.showFailureToast(context,
                                        'Le code PIN doit comporter 6 caractères');
                                  } else {
                                    context
                                        .read<GroupFlowCubit>()
                                        .addLegalEntityMember(
                                            jwtToken: GlobalFunctions
                                                .getLocalJWTToken());
                                  }
                                },
                                txt: 'SAUVEGARDER LE PROFIL',
                              ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
