// ignore_for_file: avoid_print

import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/choose-language-screen/ui/body-components/button_with_assistance.dart';
import 'package:capef/screens-cubits/forget-password-screens/cubit/get_agent_by_username/get_agent_by_user_name_cubit.dart';
import 'package:capef/screens-cubits/forget-password-screens/forget_password_step_3.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/widgets/back_button.dart';
import 'package:capef/widgets/label_with_textfield.dart';
import 'package:capef/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class ForgetPasswordSecondStep extends StatefulWidget {
  const ForgetPasswordSecondStep({super.key, this.userName});
  final String? userName;

  @override
  State<ForgetPasswordSecondStep> createState() =>
      _ForgetPasswordSecondStepState();
}

class _ForgetPasswordSecondStepState extends State<ForgetPasswordSecondStep> {
  TextEditingController answerTextEditingController = TextEditingController();

  @override
  void initState() {
    context.read<GetAgentByUserNameCubit>().getAgentByUserName(
          userName: widget.userName ?? '',
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: KeyboardDismisser(child: Scaffold(
          body: BlocBuilder<GetAgentByUserNameCubit, GetAgentByUserNameState>(
            builder: (context, state) {
              if (state is GetAgentByUserNameFailure) {
                Navigator.pop(context);
              }
              if (state is GetAgentByUserNameLoading) {
                return const Center(
                    child: CircularProgressIndicator(
                        color: GlobalColors.mainGreenColor));
              }
              if (state is GetAgentByUserNameSuccess) {
                return SingleChildScrollView(
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
                                  answerTextEditingController,
                              label:
                                  state.getQuestionByUserNameModel.securityqst,
                              hint: 'Saisissez votre réponse',
                              onChanged: (p0) {
                                answerTextEditingController.text = p0 ?? '';
                                print(answerTextEditingController.text);
                                // answer = p0;
                              },
                              showSuffixIcon: false,
                            ),
                          ],
                        ),
                        SizedBox(height: mqh(context, 230)),
                        BuildNextButtonWithAssistance(
                          ontap: () {
                            Navigator.of(context).pushNamed(
                                Routes.forgetPasswordStep3Screen,
                                arguments: ForgetPasswordThirdStep(
                                    answer: answerTextEditingController.text,
                                    userName: widget.userName));
                          },
                        )
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        )));
  }
}
