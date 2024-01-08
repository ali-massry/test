// ignore_for_file: avoid_print

import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/choose-language-screen/ui/body-components/button_with_assistance.dart';
import 'package:capef/screens-cubits/forget-password-screens/cubit/forget_password_cubit.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/snackbar.dart';
import 'package:capef/widgets/back_button.dart';
import 'package:capef/widgets/label_with_textfield.dart';
import 'package:capef/widgets/loading_button.dart';
import 'package:capef/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class ForgetPasswordThirdStep extends StatefulWidget {
  const ForgetPasswordThirdStep({
    super.key,
    required this.answer,
    required this.userName,
  });
  final String? userName;
  final String? answer;

  @override
  State<ForgetPasswordThirdStep> createState() =>
      _ForgetPasswordThirdStepState();
}

class _ForgetPasswordThirdStepState extends State<ForgetPasswordThirdStep> {
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();
  // String? password;
  // String? confirmPassword;
  @override
  Widget build(BuildContext context) {
    print(widget.answer);
    print(widget.userName);
    return SafeArea(
        top: true,
        child: KeyboardDismisser(
            child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
          listener: (context, state) {
            if (state is ForgetPasswordFailure) {
              GlobalSnackbar.showFailureToast(
                  context, state.status?.devmessage);
            }
            if (state is ForgetPasswordSuccess) {
              GlobalSnackbar.showSuccessToast(context, state.status.devmessage);

              Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.loginScreen, (route) => false);
            }
          },
          builder: (context, state) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                  padding: globalScreenPaddings,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const Align(
                              alignment: Alignment.centerLeft,
                              child: BuildBackButton()),
                          Center(
                              child: Transform.translate(
                                  offset: const Offset(0, -20),
                                  child: const BuildLogoWidget())),
                          SizedBox(height: mqh(context, 50)),
                          const Text(
                            'Réinitialisation du Mot de Passe',
                            style: GlobalTextStyles.ts20montboldGreen,
                          ),
                          SizedBox(height: mqh(context, 40)),
                          BuildLabelWithTextField(
                            passwordTextEditingController:
                                passwordTextEditingController,
                            label: 'Nouveau mot de passe',
                            hint: 'Nouveau mot de passe',
                            onChanged: (p0) {
                              passwordTextEditingController.text = p0 ?? '';
                            },
                            showSuffixIcon: true,
                          ),
                          SizedBox(height: mqh(context, 20)),
                          BuildLabelWithTextField(
                            passwordTextEditingController:
                                confirmPasswordTextEditingController,
                            label: 'Confirmer mot de passe',
                            hint: 'Confirmer mot de passe',
                            onChanged: (p0) {
                              confirmPasswordTextEditingController.text =
                                  p0 ?? '';
                            },
                            showSuffixIcon: true,
                          ),
                        ],
                      ),
                      SizedBox(height: mqh(context, 150)),
                      (state is ForgetPasswordLoading)
                          ? BuildLoadingButton()
                          : BuildNextButtonWithAssistance(
                              btnLabel: 'Sauvegarder',
                              ontap: () {
                                if (passwordTextEditingController.text == '' ||
                                    confirmPasswordTextEditingController.text ==
                                        '') {
                                  GlobalSnackbar.showFailureToast(context,
                                      'le mot de passe est vide'.toUpperCase());
                                } else {
                                  if (passwordTextEditingController.text ==
                                      confirmPasswordTextEditingController
                                          .text) {
                                    context
                                        .read<ForgetPasswordCubit>()
                                        .resetPassword(
                                            securityqstid: '1',
                                            newPassword:
                                                passwordTextEditingController
                                                    .text,
                                            securityAnswerr: widget.answer,
                                            userName: widget.userName);
                                  } else {
                                    GlobalSnackbar.showFailureToast(context,
                                        'le mot de passe et confirmez que le mot de passe que vous avez entré ne correspond pas');
                                  }
                                }
                              },
                            )
                    ],
                  ),
                ),
              ),
            );
          },
        )));
  }
}
