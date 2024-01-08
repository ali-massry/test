import 'package:capef/models/detailed_member_model.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/widgets/back_button.dart';
import 'package:capef/widgets/member_personal_information.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class NationalDetailScreen extends StatelessWidget {
  const NationalDetailScreen({super.key, this.detailedMemberModel});
  final DetailedMemberModel? detailedMemberModel;

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
                              child: BuildPersonalInfromation(
                                  detailedMemberModel: detailedMemberModel))),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )));
  }
}
