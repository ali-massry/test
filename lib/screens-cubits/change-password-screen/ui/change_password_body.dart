// ignore_for_file: avoid_print

import 'package:capef/global_cubits/get_security_questions_cubit/get_security_questions_cubit.dart';
import 'package:capef/screens-cubits/change-password-screen/cubit/change_password_cubit.dart';
import 'package:capef/screens-cubits/choose-language-screen/ui/body-components/button_with_assistance.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/functions.dart';
import 'package:capef/utils/snackbar.dart';
import 'package:capef/widgets/back_button.dart';
import 'package:capef/widgets/logo.dart';
import 'package:capef/widgets/question_drop_down.dart';
import 'package:capef/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordBody extends StatefulWidget {
  const ChangePasswordBody({super.key});

  @override
  State<ChangePasswordBody> createState() => _ChangePasswordBodyState();
}

class _ChangePasswordBodyState extends State<ChangePasswordBody> {
  bool? obscurePassword = false;
  bool? obscureConfirmPassword = false;
  String? passwordState;
  String? confirmPasswordState;
  String? responseState;
  String? confirmResponseState;
  // TextEditingController? passwordTextEditingController =
  //     TextEditingController();
  // TextEditingController? confirmPasswordTextEditingController =
  //     TextEditingController();
  // TextEditingController? responseTextEditingController =
  //     TextEditingController();
  // TextEditingController? confirmresponseTextEditingController =
  //     TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Align(
              alignment: Alignment.centerLeft, child: BuildBackButton()),
          Center(
              child: Transform.translate(
                  offset: const Offset(0, -20),
                  child: const BuildLogoWidget())),
          SizedBox(height: mqh(context, 40)),
          const Text(
            'Changer votre Mot de Passe',
            style: GlobalTextStyles.ts20montboldGreen,
          ),
          SizedBox(height: mqh(context, 40)),
          // BuildLabelWithTextField(
          //   passwordTextEditingController: passwordTextEditingController,
          //   label: 'Nouveau mot de passe',
          //   hint: 'Nouveau mot de passe',
          //   showSuffixIcon: true,
          // ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: mqw(context, 15)),
                child: Text(
                  'Nouveau mot de passe'.toUpperCase(),
                  style: GlobalTextStyles.ts12ls1montboldGreen,
                ),
              ),
              SizedBox(height: mqh(context, 5)),
              CustomMainTextField(
                hintText: 'Nouveau mot de passe',
                // textEditingController: passwordTextEditingController,
                obscureText: obscurePassword,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      obscurePassword = !obscurePassword!;
                    });
                  },
                  child: Icon(
                    obscurePassword! ? Icons.visibility_off : Icons.visibility,
                    color: GlobalColors.mainGreenColor,
                  ),
                ),
                keyboardType: TextInputType.name,
                onChanged: (password) {
                  setState(() {
                    passwordState = password!;
                  });
                },
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.done,
              ),
            ],
          ),
          SizedBox(height: mqh(context, 20)),
          // BuildLabelWithTextField(
          //   passwordTextEditingController: confirmPasswordTextEditingController,
          //   label: 'Confirmer mot de passe',
          //   hint: 'Confirmer mot de passe',
          //   showSuffixIcon: true,
          // ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: mqw(context, 15)),
                child: Text(
                  'Confirmer mot de passe'.toUpperCase(),
                  style: GlobalTextStyles.ts12ls1montboldGreen,
                ),
              ),
              SizedBox(height: mqh(context, 5)),
              CustomMainTextField(
                hintText: 'Confirmer mot de passe',
                obscureText: obscureConfirmPassword,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      obscureConfirmPassword = !obscureConfirmPassword!;
                    });
                  },
                  child: Icon(
                    obscureConfirmPassword!
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: GlobalColors.mainGreenColor,
                  ),
                ),
                keyboardType: TextInputType.name,
                onChanged: (confirmPassword) {
                  setState(() {
                    confirmPasswordState = confirmPassword;
                  });
                },
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.done,
              ),
            ],
          ),
          SizedBox(height: mqh(context, 20)),
          const BuildSecurityQuestionDropDownWidget(),
          SizedBox(height: mqh(context, 20)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: mqw(context, 15)),
                child: Text(
                  'Réponse'.toUpperCase(),
                  style: GlobalTextStyles.ts12ls1montboldGreen,
                ),
              ),
              SizedBox(height: mqh(context, 5)),
              CustomMainTextField(
                hintText: 'Réponse',
                keyboardType: TextInputType.name,
                onChanged: (response) {
                  setState(() {
                    responseState = response;
                  });
                },
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.done,
              ),
            ],
          ),
          // BuildLabelWithTextField(
          //   passwordTextEditingController: responseTextEditingController,
          //   label: 'Réponse',
          //   hint: 'Réponse',
          //   showSuffixIcon: false,
          // ),
          SizedBox(height: mqh(context, 20)),
          // BuildLabelWithTextField(
          //   passwordTextEditingController: confirmresponseTextEditingController,
          //   label: 'Confirmer mot de passe',
          //   hint: 'Confirmer mot de passe',
          //   showSuffixIcon: false,
          // ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: mqw(context, 15)),
                child: Text(
                  'Confirmer la Réponse'.toUpperCase(),
                  style: GlobalTextStyles.ts12ls1montboldGreen,
                ),
              ),
              SizedBox(height: mqh(context, 5)),
              CustomMainTextField(
                hintText: 'Confirmer la Réponse',
                keyboardType: TextInputType.name,
                onChanged: (confirmResponse) {
                  setState(() {
                    confirmResponseState = confirmResponse!;
                  });
                },
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.done,
              ),
            ],
          ),
          SizedBox(height: mqh(context, 40)),
          BuildNextButtonWithAssistance(
            ontap: () async {
              print(passwordState);
              print(confirmPasswordState);
              // await AuthRepository.setFirstLogin(
              //     securityId: "1",
              //     securityAnswer: "bmw",
              //     password: "changeme",
              //     jwtToken: GlobalFunctions.getLocalJWTToken());
              if (passwordState != confirmPasswordState) {
                GlobalSnackbar.showFailureToast(
                    context, 'Confirmer Votre Mot De Passe');
              } else if (responseState != confirmResponseState) {
                GlobalSnackbar.showFailureToast(context, 'Confirme Ta Réponse');
              } else if (context
                      .read<GetSecurityQuestionsCubit>()
                      .selectedQuestionId ==
                  null) {
                GlobalSnackbar.showFailureToast(
                    context, 'Choisissez une Question de Sécurité');
              } else {
                await context.read<ChangePasswordCubit>().changePassword(
                    securityQuestionId: context
                        .read<GetSecurityQuestionsCubit>()
                        .selectedQuestionId
                        .toString(),
                    securityQuestionAnswer: responseState ?? '',
                    password: passwordState ?? '',
                    jwtToken: GlobalFunctions.getLocalJWTToken());
              }
              // Navigator.of(context).pushNamed(Routes.homeScreen);
            },
          ),
        ],
      ),
    );
  }
}
