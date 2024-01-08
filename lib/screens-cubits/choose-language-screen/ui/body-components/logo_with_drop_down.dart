import 'package:capef/utils/constant.dart';
import 'package:capef/widgets/language_drop_down.dart';
import 'package:capef/widgets/logo.dart';
import 'package:flutter/material.dart';

class BuildLogoWithDropDown extends StatelessWidget {
  const BuildLogoWithDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const BuildLogoWidget(),
        SizedBox(height: mqh(context, 51)),
        const Text(
          'Choisissez Votre Langue Préférée',
          style: GlobalTextStyles.ts17montboldGreen,
        ),
        SizedBox(height: mqh(context, 10)),
        Text(
          'Choose Your Preferred Language',
          style: TextStyle(
            fontSize: 17,
            color: Colors.black.withOpacity(0.5),
            fontFamily: GlobalFonts.montserratBold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: mqh(context, 40)),
        const BuildLanguageDropDownWidget()
      ],
    );
  }
}
