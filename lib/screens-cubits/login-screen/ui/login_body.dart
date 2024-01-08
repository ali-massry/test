// ignore_for_file: avoid_print

import 'package:capef/global_cubits/localization_cubit/localization_cubit.dart';
import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/login-screen/cubit/login_cubit.dart';
import 'package:capef/screens-cubits/login-screen/ui/body-components/login_button_with_assistance.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/snackbar.dart';
import 'package:capef/utils/validations.dart';
import 'package:capef/widgets/logo.dart';
import 'package:capef/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({
    super.key,
    required this.state,
  });
  final LoginState? state;

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  TextEditingController? usernameController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  bool? obscure = true;

  @override
  Widget build(BuildContext context) {
    print('Language ${context.read<LocalizationCubit>().state.locale}');
    return SingleChildScrollView(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const BuildLogoWidget(),
            SizedBox(height: mqh(context, 51)),
            Text(
              AppLocalizations.of(context)!.kyc_agent_login,
              style: GlobalTextStyles.ts20montboldGreen,
            ),
            SizedBox(height: mqh(context, 40)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: mqw(context, 15)),
                  child: Text(
                    AppLocalizations.of(context)!.username.toUpperCase(),
                    style: GlobalTextStyles.ts12ls1montboldGreen,
                  ),
                ),
                SizedBox(height: mqh(context, 5)),
                CustomMainTextField(
                  validator: Validations.validatePassword,
                  hintText: AppLocalizations.of(context)?.username,
                  textEditingController: usernameController,
                  keyboardType: TextInputType.name,
                  onChanged: (username) {},
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.next,
                ),
              ],
            ),
            SizedBox(height: mqh(context, 20)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: mqw(context, 15)),
                  child: Text(
                    AppLocalizations.of(context)!.password.toUpperCase(),
                    style: GlobalTextStyles.ts12ls1montboldGreen,
                  ),
                ),
                SizedBox(height: mqh(context, 5)),
                CustomMainTextField(
                  validator: Validations.validatePassword,
                  hintText: AppLocalizations.of(context)?.password,
                  textEditingController: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: obscure,
                  onChanged: (password) {},
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        obscure = !obscure!;
                      });
                    },
                    child: Icon(
                      obscure! ? Icons.visibility_off : Icons.visibility,
                      color: GlobalColors.mainGreenColor,
                    ),
                  ),
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(height: mqh(context, 15)),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(Routes.forgetPasswordStep1Screen);
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)!
                          .i_have_forgetten_my_password
                          .toUpperCase(),
                      style: GlobalTextStyles.underlinedViewAllTextButton,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        SizedBox(height: mqh(context, 140)),
        BuildLoginButtonWithAssistance(
          onTap: () async {
            if (usernameController!.text != '' ||
                passwordController!.text != '') {
              await context.read<LoginCubit>().loginAgent(
                  username: usernameController!.text,
                  password: passwordController!.text,
                  language: context.read<LocalizationCubit>().state.locale);
              Hive.box('localStorage')
                  .put('username', usernameController!.text);
            } else {
              await GlobalSnackbar.showInfoToast(
                  context,
                  AppLocalizations.of(context)!
                      .make_sure_to_fill_missing_fields);
            }
          },
          loginState: widget.state,
        ),
      ],
    ));
  }
}
