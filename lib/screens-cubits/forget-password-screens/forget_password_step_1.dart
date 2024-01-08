import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/choose-language-screen/ui/body-components/button_with_assistance.dart';
import 'package:capef/screens-cubits/forget-password-screens/forget_password_step_2.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/widgets/back_button.dart';
import 'package:capef/widgets/label_with_textfield.dart';
import 'package:capef/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class ForgetPasswordFirstStep extends StatefulWidget {
  const ForgetPasswordFirstStep({super.key});

  @override
  State<ForgetPasswordFirstStep> createState() =>
      _ForgetPasswordFirstStepState();
}

class _ForgetPasswordFirstStepState extends State<ForgetPasswordFirstStep> {
  TextEditingController userNameTextEditingController = TextEditingController();
  // String? username;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: KeyboardDismisser(
            child: Scaffold(
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
                            userNameTextEditingController,
                        hint: 'Nom d’utilisateur',
                        label: 'Saisissez votre nom d’utilisateur',
                        onChanged: (p0) {
                          // username = p0;
                          userNameTextEditingController.text = p0 ?? '';
                        },
                        showSuffixIcon: false,
                      ),
                      SizedBox(height: mqh(context, 240)),
                      BuildNextButtonWithAssistance(
                        ontap: () {
                          if (userNameTextEditingController.text == '') {
                          } else {}
                          // context.read<AuthfieldsCubit>().username = username;
                          // print(context.read<AuthfieldsCubit>().username);
                          Navigator.of(context).pushNamed(
                              Routes.forgetPasswordStep2Screen,
                              arguments: ForgetPasswordSecondStep(
                                  userName:
                                      userNameTextEditingController.text));
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        )));
  }
}
