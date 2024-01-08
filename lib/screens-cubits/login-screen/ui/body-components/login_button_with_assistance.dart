import 'package:capef/screens-cubits/login-screen/cubit/login_cubit.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/widgets/button.dart';
import 'package:capef/widgets/demand_assistance.dart';
import 'package:capef/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class BuildLoginButtonWithAssistance extends StatelessWidget {
  BuildLoginButtonWithAssistance({
    super.key,
    this.onTap,
    required this.loginState,
  });
  VoidCallback? onTap;
  LoginState? loginState;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        (loginState is LoginLoading)
            ? BuildLoadingButton(
                onTap: () {},
              )
            : BuildButton(
                onTap: onTap,
                txt: AppLocalizations.of(context)!.to_login,
              ),
        SizedBox(height: mqh(context, 30)),
        BuildDemandAssistanceWidget(),
      ],
    );
  }
}
