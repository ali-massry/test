import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/validations.dart';
import 'package:capef/widgets/logo.dart';
import 'package:capef/widgets/text_field.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class BuildLogoWithLoginTextFields extends StatefulWidget {
  BuildLogoWithLoginTextFields(
      {super.key, this.usernameController, this.passwordController});
  TextEditingController? usernameController;
  TextEditingController? passwordController;

  @override
  State<BuildLogoWithLoginTextFields> createState() =>
      _BuildLogoWithLoginTextFieldsState();
}

class _BuildLogoWithLoginTextFieldsState
    extends State<BuildLogoWithLoginTextFields> {
  bool? obscure = false;
  @override
  Widget build(BuildContext context) {
    return Column(
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
              keyboardType: TextInputType.name,
              textEditingController: widget.usernameController,
              onChanged: (username) {
                setState(() {
                  widget.usernameController?.text = username ?? '';
                });
              },
              textCapitalization: TextCapitalization.none,
              textInputAction: TextInputAction.done,
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
              keyboardType: TextInputType.visiblePassword,
              textEditingController: widget.passwordController,
              obscureText: obscure,
              onChanged: (password) {
                setState(() {
                  widget.passwordController?.text = password ?? '';
                });
              },
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
            Align(
              alignment: Alignment.center,
              child: Text(
                AppLocalizations.of(context)!
                    .i_have_forgetten_my_password
                    .toUpperCase(),
                style: GlobalTextStyles.underlinedViewAllTextButton,
              ),
            )
          ],
        ),
      ],
    );
  }
}
