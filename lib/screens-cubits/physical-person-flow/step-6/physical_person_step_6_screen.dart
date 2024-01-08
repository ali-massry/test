// ignore_for_file: avoid_print

import 'package:capef/global_cubits/get_security_questions_cubit/get_security_questions_cubit.dart';
import 'package:capef/global_cubits/is_online_cubit/is_online_cubit.dart';
import 'package:capef/global_cubits/physical_person_cubit/add_physical_person_cubit.dart';
import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/physical-person-flow/physical_person_success_screen.dart';
import 'package:capef/screens-cubits/physical-person-flow/step-5/step_5_model.dart';
import 'package:capef/screens-cubits/physical-person-flow/step-6/step_6_model.dart';
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

class AddPhysicalPersonStep6Screen extends StatefulWidget {
  const AddPhysicalPersonStep6Screen(
      {super.key, this.addPhysicalMemberStep5Model});
  final PersonalInfoWithLocationInfoWithPrinciplesWithNumbersModel?
      addPhysicalMemberStep5Model;

  @override
  State<AddPhysicalPersonStep6Screen> createState() =>
      _AddPhysicalPersonStep6ScreenState();
}

class _AddPhysicalPersonStep6ScreenState
    extends State<AddPhysicalPersonStep6Screen> {
  int? deviceId;
  int? agentId;
  int? timeStamp;
  String? offlineId;
  String? transactionIDD;

  @override
  void initState() {
    offlineId = offlineIdGlobal(agentId: agentIdLocall);
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
        child: BlocConsumer<AddPhysicalPersonCubit, AddPhysicalPersonState>(
          listener: (context, state) {
            if (state is AddPhysicalPersonSucess) {
              context.read<AddPhysicalPersonCubit>().nationalPhoto = null;
              context.read<AddPhysicalPersonCubit>().rectoCNIPhoto = null;
              context.read<AddPhysicalPersonCubit>().versoCNIPhoto = null;

              print(context.read<AddPhysicalPersonCubit>().nationalPhoto);
              print(context.read<AddPhysicalPersonCubit>().rectoCNIPhoto);
              print(context.read<AddPhysicalPersonCubit>().versoCNIPhoto);
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.physicalPersonSuccessScreen, (route) => false,
                  arguments: PhysicalPersonSuccessScreen(
                    addPhysicalMemberStep6Model:
                        WholeUserInfoWithoutPrinciplesDetailsModel(
                            step5model: widget.addPhysicalMemberStep5Model,
                            offlineId: offlineId,
                            questionId: context
                                .read<GetSecurityQuestionsCubit>()
                                .selectedQuestionId,
                            pin: int.parse(pinController.text),
                            response: responseController.text),
                    onlineOrOfllineId:
                        state.addIndividualMemberSuccess?.onlineid == ''
                            ? offlineId
                            : state.addIndividualMemberSuccess?.onlineid,
                    transactionId: transactionIDD,
                  ));
            }
            if (state is AddPhysicalPersonFailure) {
              GlobalSnackbar.showFailureToast(
                  context, state.failureModel?.title);
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: const BuildAppBar(title: 'Inscription et Cotisation'),
              body: KeyboardDismisser(
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
                          hint: 'Code PIN',
                          maxLength: 6,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (p0) {
                            pinController.text = p0 ?? '';
                          },
                          showSuffixIcon: true,
                        ),
                        SizedBox(height: mqh(context, 20)),
                        BuildLabelWithTextField(
                          passwordTextEditingController: confirmPinController,
                          maxLength: 6,
                          label: 'Confirmer le Code PIN',
                          keyboardType: TextInputType.visiblePassword,
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
                          },
                          showSuffixIcon: false,
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
                        (state is AddPhysicalPersonLoading)
                            ? BuildLoadingButton()
                            : BuildButton(
                                onTap: () {
                                  if (pinController.text !=
                                      confirmPinController.text) {
                                    GlobalSnackbar.showFailureToast(
                                        context, 'Confirmez votre code PIN');
                                  } else if (responseController.text !=
                                      confirmresponseController.text) {
                                    GlobalSnackbar.showFailureToast(
                                        context, 'Confirmez votre réponse');
                                  } else if (pinController.text.length != 6 ||
                                      confirmPinController.text.length != 6) {
                                    GlobalSnackbar.showFailureToast(context,
                                        'Le code doit être composé de 6 caractères');
                                  } else if (pinController.text == '' ||
                                      confirmPinController.text == '' ||
                                      responseController.text == '' ||
                                      confirmresponseController.text == '') {
                                    GlobalSnackbar.showFailureToast(context,
                                        'Assurez-vous De Remplir Toutes Les Informations');
                                  } else {
                                    context.read<AddPhysicalPersonCubit>().addIndividualMember(
                                        jwtToken:
                                            GlobalFunctions.getLocalJWTToken(),
                                        wholeUserInfoWithoutPrinciplesDetailsModel:
                                            WholeUserInfoWithoutPrinciplesDetailsModel(
                                                step5model: widget
                                                    .addPhysicalMemberStep5Model,
                                                offlineId: offlineId,
                                                questionId: context
                                                    .read<
                                                        GetSecurityQuestionsCubit>()
                                                    .selectedQuestionId,
                                                pin: int.parse(
                                                    pinController.text),
                                                response:
                                                    responseController.text));
                                  }
                                },
                                txt: 'SAUVEGARDER LE PROFIL',
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
