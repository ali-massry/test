import 'package:capef/screens-cubits/choose-language-screen/ui/choose_language_body.dart';
import 'package:capef/utils/constant.dart';
import 'package:flutter/material.dart';

class ChooseLanguageScreen extends StatelessWidget {
  const ChooseLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: SizedBox(
            width: mqw(context, 390), child: const ChooseLanguageBody()),
      )),
    );
  }
}
