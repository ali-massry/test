import 'package:capef/utils/constant.dart';
import 'package:capef/widgets/button.dart';
import 'package:capef/widgets/demand_assistance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class BuildNextButtonWithAssistance extends StatelessWidget {
  BuildNextButtonWithAssistance({
    super.key,
    required this.ontap,
    this.btnLabel,
  });
  VoidCallback? ontap;
  String? btnLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BuildButton(
          txt: btnLabel ?? AppLocalizations.of(context)!.next,
          onTap: ontap,
        ),
        SizedBox(height: mqh(context, 30)),
        BuildDemandAssistanceWidget(),
      ],
    );
  }
}
