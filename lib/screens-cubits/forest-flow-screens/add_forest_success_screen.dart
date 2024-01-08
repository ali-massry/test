// ignore_for_file: use_build_context_synchronously, avoid_print, deprecated_member_use

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:capef/assets.dart';
import 'package:capef/global_cubits/activities_cubit/activities_cubit.dart';
import 'package:capef/global_cubits/get_offline_cubit/get_offline_cubit.dart';
import 'package:capef/models/slip_model.dart';
import 'package:capef/screens-cubits/forest-flow-screens/cubit/forest_cubit.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/functions.dart';
import 'package:capef/utils/svg_builder.dart';
import 'package:capef/widgets/secondary_questionaire_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AddForestSuccessScreen extends StatefulWidget {
  const AddForestSuccessScreen({super.key});

  @override
  State<AddForestSuccessScreen> createState() => _AddForestSuccessScreenState();
}

class _AddForestSuccessScreenState extends State<AddForestSuccessScreen> {
  final GlobalKey _qrkeyy = GlobalKey();

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

      await file.writeAsBytes(pngBytes);

      // print(file.path);

      GlobalFunctions.executeJavaCode(
          qrkeyy: _qrkeyy,
          file: file,
          slipModel: SlipModel(
              agentName: agentNameLocall,
              identificationId: context.read<ForestCubit>().offOnId,
              qrCode: context.read<ForestCubit>().offOnId,
              type: 'Forêts Et Faune'.toUpperCase(),
              nationalName: context.read<ForestCubit>().nationalName,
              nationalPhoneNumber: context.read<ForestCubit>().nationalNumber,
              regionAndDepartment:
                  '${context.read<ForestCubit>().regions?.regionname} / ${context.read<ForestCubit>().districts?.districtname}',
              telephoneNumber: context
                  .read<GetOfflineCubitCubit>()
                  .getOfflineDataModel
                  ?.supportNumber));

      setState(() {});

      // await executeJavaCode(file: file);

      // await Share.file(_dataString, '$_dataString.png', pngBytes, 'image/png');
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 1), () {
        _captureAndSharePng(imageData: context.read<ForestCubit>().offOnId);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: mqw(context, 83),
              height: mqh(context, 83),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: GlobalColors.mainGreenColor.withOpacity(0.1)),
              child: Center(
                child: SvgBuilder(asset: Assets.icons.checkSvg),
              ),
            ),
          ),
          SizedBox(height: mqh(context, 15)),
          RepaintBoundary(
            key: _qrkeyy,
            child: GestureDetector(
              onTap: () {
                _captureAndSharePng(
                    imageData: context.read<ForestCubit>().offOnId);
              },
              child: QrImageView(
                data: context.read<ForestCubit>().offOnId ?? '',
                version: QrVersions.auto,
                foregroundColor: GlobalColors.greyColor,
                size: 200.0,
              ),
            ),
          ),
          SizedBox(height: mqh(context, 35)),
          Container(
            // margin: const EdgeInsets.symmetric(horizontal: 100),
            width: mqw(context, 137),
            height: 30,
            decoration: BoxDecoration(
              color: GlobalColors.forestGreenColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(horizontal: mqw(context, 0)),
            child: Center(
              child: Text(
                'Forêts Et Faune'.toUpperCase(),
                style: const TextStyle(
                    color: GlobalColors.forestGreenColor,
                    fontFamily: GlobalFonts.montserratBold,
                    fontSize: 12),
              ),
            ),
          ),
          SizedBox(height: mqh(context, 15)),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.0),
            child: Text(
              'Activité Principale Ajoutée avec succès',
              style: GlobalTextStyles.ts20montboldGreen,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: mqh(context, 60)),
          context.read<ActivitiesCubit>().secondaryActivityId == null
              ? const SizedBox()
              : const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: BuildQuestionaireButton(activityId: 4)),
          SizedBox(height: mqh(context, 30)),
          GestureDetector(
            onTap: () {
              context.read<ForestCubit>().clearEveryThingAndGoToHome(context);
              GlobalFunctions.clearCategoriesCubit(context);
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('Quitter',
                  style: GlobalTextStyles.underlinedViewAllTextButton),
            ),
          )
        ],
      )),
    );
  }
}
