import 'package:capef/global_cubits/get_security_questions_cubit/get_security_questions_cubit.dart';
import 'package:capef/global_cubits/is_online_cubit/is_online_cubit.dart';
import 'package:capef/global_cubits/refresh_token_cubit/refresh_token_cubit.dart';
import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/home-screen/ui/home_body.dart';
import 'package:capef/utils/functions.dart';
// import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../global_cubits/get_offline_cubit/get_offline_cubit.dart';
import '../../../utils/constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? androidId;
  Future<void> refreshToken() async {
    if (context.read<IsOnlineCubit>().isOnline == true) {
      await context
          .read<RefreshTokenCubit>()
          .refreshToken(
              jwtToken: GlobalFunctions.getLocalJWTToken(),
              refreshToken: GlobalFunctions.getLocalRefreshToken())
          .then((_) {
        context
            .read<GetOfflineCubitCubit>()
            .getOfflineData(jwttoken: GlobalFunctions.getLocalJWTToken());
        context
            .read<GetSecurityQuestionsCubit>()
            .getSecurityQuestions(jwttoken: GlobalFunctions.getLocalJWTToken());
      });
    } else {
      context
          .read<GetOfflineCubitCubit>()
          .getOfflineData(jwttoken: GlobalFunctions.getLocalJWTToken());
      context
          .read<GetSecurityQuestionsCubit>()
          .getSecurityQuestions(jwttoken: GlobalFunctions.getLocalJWTToken());
    }
  }

  @override
  void initState() {
    refreshToken();

    context.read<RefreshTokenCubit>().stream.listen((event) {
      if (event is RefreshTokenFailureApi) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Routes.loginScreen, (route) => false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: Colors.white,
          body: Padding(padding: globalScreenPaddings, child: HomeBody())),
    );
  }
}
