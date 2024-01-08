import 'package:capef/screens-cubits/synchronise-nationals-screen/synchronise_national_body.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/widgets/appbar.dart';
import 'package:flutter/material.dart';

class SynchroniseNationalsScreen extends StatelessWidget {
  const SynchroniseNationalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          appBar: const BuildAppBar(title: 'Zone Ressortissants'),
          body: Container(
            width: double.infinity,
            padding: globalScreenPaddings,
            child: const SynchroniseNationalsBody(),
          ),
        ));
  }
}
