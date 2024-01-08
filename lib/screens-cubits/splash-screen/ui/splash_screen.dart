// ignore_for_file: avoid_print

import 'package:capef/global_cubits/get_security_questions_cubit/get_security_questions_cubit.dart';
import 'package:capef/global_cubits/location_cubit/location_cubit.dart';
import 'package:capef/global_cubits/refresh_token_cubit/refresh_token_cubit.dart';
import 'package:capef/hive/hive_boxes.dart';
import 'package:capef/main.dart';
import 'package:capef/routes/routes.dart';
import 'package:capef/utils/functions.dart';
import 'package:capef/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> refreshToken() async {
    await context.read<RefreshTokenCubit>().refreshToken(
        jwtToken: GlobalFunctions.getLocalJWTToken(),
        refreshToken: GlobalFunctions.getLocalRefreshToken());
    // getSecurityQuestions();
  }

  Future<void> getSecurityQuestions() async {
    await context
        .read<GetSecurityQuestionsCubit>()
        .getSecurityQuestions(jwttoken: GlobalFunctions.getLocalJWTToken());
  }

  @override
  void initState() {
    context.read<LocationCubit>().getNowLocation();

    // if (Hive.box('localStorage').get('auth') != null) {
    //   if (context.read<IsOnlineCubit>().isOnline != false) {
    //     refreshToken();
    //   }
    // }
    print('FEE INTERNET $hasInternetNow');

    // if (hasInternetNow == true) {
    // refreshToken();
    // }
    // context.read<RefreshTokenCubit>().stream.listen(
    //   (event) {
    //     if (event is RefreshTokenSuccess) {
    //       getSecurityQuestions();
    //     }
    //   },
    // );
    // getSecurityQuestions();
    print('LOGGED IN ${Hive.box(ofllineDataBox).get('agent')}');
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.of(context).pushNamed(
            Hive.box(ofllineDataBox).get('agent') != null
                ? Routes.homeScreen
                : Routes.chooseLanguageScreen);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        top: true,
        child: Scaffold(
          body: Center(child: BuildLogoWidget()),
        ));
  }
}
