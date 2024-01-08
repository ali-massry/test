// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:ui';
import 'package:capef/global_cubits/get_security_questions_cubit/get_security_questions_cubit.dart';
import 'package:capef/hive/hive_boxes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:capef/models/slip_model.dart';
import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/login-screen/cubit/login_cubit.dart';
import 'package:capef/screens-cubits/login-screen/ui/login_body.dart';
import 'package:capef/utils/functions.dart';
import 'package:capef/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:path_provider/path_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey _qrkeyy = GlobalKey();
  Uint8List? bytes;

  File? fileShow;

  // Future<void> executeJavaCode({required File file}) async {
  //   RenderRepaintBoundary? boundary =
  //       _qrkeyy.currentContext?.findRenderObject() as RenderRepaintBoundary?;
  //   try {
  //     var imaggge = await boundary?.toImage(pixelRatio: 3);
  //     final whitePaint = Paint()..color = Colors.white;
  //     final recorder = PictureRecorder();
  //     final canvas = Canvas(
  //         recorder,
  //         Rect.fromLTWH(
  //             0, 0, imaggge!.width.toDouble(), imaggge.height.toDouble()));
  //     canvas.drawRect(
  //         Rect.fromLTWH(
  //             0, 0, imaggge.width.toDouble(), imaggge.height.toDouble()),
  //         whitePaint);
  //     canvas.drawImage(imaggge, Offset.zero, Paint());

  //     final picture = recorder.endRecording();
  //     final img = await picture.toImage(imaggge.width, imaggge.height);
  //     ByteData? byteData = await img.toByteData(format: ImageByteFormat.png);
  //     Uint8List pngBytes = byteData!.buffer.asUint8List();

  //     // final ByteData byteData = await rootBundle.load(Assets.images.qrPNG);
  //     // var bytess = byteData.buffer.asUint8List();

  //     String backVal =
  //         await platform.invokeMethod('myJavaFunc', {'data': pngBytes});
  //     print('the result back: $backVal');
  //   } on PlatformException catch (e) {
  //     print('something wrong: $e');
  //   }
  //   setState(() {});
  // }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        _captureAndSharePng(imageData: 'kajg');
      });
    });

    super.initState();
  }

  Future<void> _captureAndSharePng({required String? imageData}) async {
    Future.delayed(const Duration(seconds: 1));
    try {
      RenderRepaintBoundary? boundary =
          _qrkeyy.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      var image = await boundary?.toImage();
      ByteData? byteData = await image?.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/$imageData.png').create();

      fileShow = file;
      await file.writeAsBytes(pngBytes);

      print(file.path);

      GlobalFunctions.executeJavaCode(
          qrkeyy: _qrkeyy,
          file: file,
          slipModel: SlipModel(
              agentName: 'agentNameLocall',
              identificationId: 'iddd',
              qrCode: 'qrtest',
              type: 'Pêche',
              nationalName: 'name',
              nationalPhoneNumber: '71861264',
              regionAndDepartment: 'baalback/hortaala',
              telephoneNumber: '71861634'));

      setState(() {});

      // await executeJavaCode(file: file);

      // await Share.file(_dataString, '$_dataString.png', pngBytes, 'image/png');
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: KeyboardDismisser(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
            child: BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoginFailure) {
                  GlobalSnackbar.showFailureToast(
                      context, state.status?.devmessage);
                }
                if (state is LoginSuccess) {
                  print('LOGGED IN ${Hive.box(ofllineDataBox).get('agent')}');
                  GlobalSnackbar.showSuccessToast(
                      context,
                      state.successLoginResponse?.status?.devmessage == ""
                          ? AppLocalizations.of(context)?.success.toUpperCase()
                          : state.successLoginResponse?.status?.devmessage);
                  if (state.successLoginResponse?.isfirstlogin == true) {
                    Navigator.of(context)
                        .pushNamed(Routes.changePasswordScreen);
                  } else {
                    Navigator.of(context).pushNamed(Routes.homeScreen);
                  }

                  context
                      .read<GetSecurityQuestionsCubit>()
                      .getSecurityQuestions(
                          jwttoken: GlobalFunctions.getLocalJWTToken());

                  print('JWT ${GlobalFunctions.getLocalJWTToken()}');
                  print('REFRESH ${GlobalFunctions.getLocalRefreshToken()}');
                }
              },
              builder: (context, state) {
                return LoginBody(state: state);
              },
            ),
          ),
        ),
      ),
    );
  }
}
