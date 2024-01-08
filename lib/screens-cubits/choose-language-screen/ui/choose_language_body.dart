import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/choose-language-screen/ui/body-components/button_with_assistance.dart';
import 'package:capef/screens-cubits/choose-language-screen/ui/body-components/logo_with_drop_down.dart';
import 'package:flutter/material.dart';

class ChooseLanguageBody extends StatelessWidget {
  const ChooseLanguageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const BuildLogoWithDropDown(),
        BuildNextButtonWithAssistance(
          ontap: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(Routes.loginScreen, (route) => false);
          },
        ),
      ],
    );
  }
}
