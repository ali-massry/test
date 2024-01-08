import 'package:capef/screens-cubits/national-area-screen/national_area_body.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/widgets/appbar.dart';
import 'package:flutter/material.dart';

class NationalsAreaScreen extends StatelessWidget {
  const NationalsAreaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          appBar: const BuildAppBar(title: 'Page D’accueil'),
          body: Container(
            width: double.infinity,
            padding: globalScreenPaddings,
            child: const NationalAreaBody(),
          ),
        ));
  }
}
