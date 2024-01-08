import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/change-password-screen/cubit/change_password_cubit.dart';
import 'package:capef/screens-cubits/change-password-screen/ui/change_password_body.dart';
import 'package:capef/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: KeyboardDismisser(
        child: Scaffold(
          body: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
            listener: (context, state) {
              if (state is ChangePasswordSuccess) {
                Navigator.of(context).pushNamed(Routes.homeScreen);
                GlobalSnackbar.showSuccessToast(
                    context, 'Mot de passe modifié avec succès');
              }
              if (state is ChangePasswordFailure) {
                GlobalSnackbar.showFailureToast(
                    context, 'Quelque chose s\'est mal passé');
              }
            },
            builder: (context, state) {
              return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
                  child: ChangePasswordBody());
            },
          ),
        ),
      ),
    );
  }
}
