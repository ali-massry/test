// ignore_for_file: avoid_print

import 'package:capef/assets.dart';
import 'package:capef/global_cubits/activities_cubit/activities_cubit.dart';
import 'package:capef/global_cubits/get_offline_cubit/get_offline_cubit.dart';
import 'package:capef/global_cubits/is_online_cubit/is_online_cubit.dart';
import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/agri-flow-screens/cubit/agri_cubit.dart';
import 'package:capef/screens-cubits/breeding-flow-screens/cubit/breeding_cubit.dart';
import 'package:capef/screens-cubits/fishing-flow-screens/cubit/fishing_cubit.dart';
import 'package:capef/screens-cubits/forest-flow-screens/cubit/forest_cubit.dart';
import 'package:capef/screens-cubits/physical-person-flow/step-6/step_6_model.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/functions.dart';
import 'package:capef/utils/svg_builder.dart';
import 'package:capef/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PhysicalPersonSuccessScreen extends StatefulWidget {
  const PhysicalPersonSuccessScreen(
      {super.key,
      required this.addPhysicalMemberStep6Model,
      this.onlineOrOfllineId,
      this.transactionId});
  final WholeUserInfoWithoutPrinciplesDetailsModel? addPhysicalMemberStep6Model;
  final String? onlineOrOfllineId;
  final String? transactionId;
  @override
  State<PhysicalPersonSuccessScreen> createState() =>
      _PhysicalPersonSuccessScreenState();
}

class _PhysicalPersonSuccessScreenState
    extends State<PhysicalPersonSuccessScreen> {
  // String? offlineId;
  // BigInt? deviceIDD;

  // void printDeviceId() async {
  //   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  //   try {
  //     if (Platform.isAndroid) {
  //       AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  //       print(androidInfo.androidId);
  //       BigInt? deviceId = BigInt.parse(androidInfo.androidId, radix: 16);
  //       deviceIDD = deviceId;
  //       print(deviceIDD);
  //       // androidId = int.parse(androidInfo.id);
  //       // print('Android Device ID: ${androidInfo.id}');
  //     } else if (Platform.isIOS) {
  //       IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
  //       print('iOS Device ID: ${iosInfo.identifierForVendor}');
  //     }
  //   } catch (e) {
  //     print('Error getting device ID: $e');
  //   }
  // }

  final GlobalKey _qrkeyy = GlobalKey();

  // Future<void> _captureAndSavePng() async {
  //   try {
  // RenderRepaintBoundary? boundary =
  //     _qrkeyy.currentContext?.findRenderObject() as RenderRepaintBoundary?;

  //     print('fett 111');
  //     if (boundary != null) {
  //       print('fett');
  //       var image = await boundary.toImage(pixelRatio: 3.0);

  //       // Drawing White Background because the Qr Code is Black
  // final whitePaint = Paint()..color = Colors.white;
  // final recorder = PictureRecorder();
  // final canvas = Canvas(
  //     recorder,
  //     Rect.fromLTWH(
  //         0, 0, image.width.toDouble(), image.height.toDouble()));
  // canvas.drawRect(
  //     Rect.fromLTWH(
  //         0, 0, image.width.toDouble(), image.height.toDouble()),
  //     whitePaint);
  // canvas.drawImage(image, Offset.zero, Paint());
  // final picture = recorder.endRecording();
  // final img = await picture.toImage(image.width, image.height);
  // ByteData? byteData = await img.toByteData(format: ImageByteFormat.png);
  // Uint8List pngBytes = byteData!.buffer.asUint8List();

  //       print(pngBytes);

  //       try {
  //         platform.invokeMethod('myJavaFunc', {
  //           'data': pngBytes,
  //           'id': widget.onlineOrOfllineId,
  //           'title': GlobalFunctions.principleFromId(
  //             // ignore: use_build_context_synchronously
  //             list: context
  //                 .read<GetOfflineCubitCubit>()
  //                 .getOfflineDataModel
  //                 ?.categories,
  //             id: widget.addPhysicalMemberStep6Model?.step5model?.step4model
  //                     ?.proncipleId ??
  //                 0,
  //           ),
  //           'answer':
  //               '${widget.addPhysicalMemberStep6Model?.step5model?.step4model?.step3model?.addPhysicalMemberStep2Model?.addPhysicalMemberStep1Model?.fname} ${widget.addPhysicalMemberStep6Model?.step5model?.step4model?.step3model?.addPhysicalMemberStep2Model?.addPhysicalMemberStep1Model?.lname}',
  //          
  //           'agentName': 'agentNmae',
  //           'inscription':
  //               '${widget.addPhysicalMemberStep6Model?.step5model?.inscription} FCFA',
  //           'cotisation':
  //               '${widget.addPhysicalMemberStep6Model?.step5model?.cotisation} FCFA',
  //         });
  //       } on PlatformException catch (e) {
  //         print(e);
  //       }

  //       if (!mounted) return;
  //       const snackBar = SnackBar(content: Text('QR code saved to gallery'));
  //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //     }
  //   } catch (e) {
  //     print('Issue $e');
  //     if (!mounted) return;
  //     const snackBar = SnackBar(content: Text('Something went wrong!!!'));
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   }
  // }

  @override
  void initState() {
    // offlineId = offlineIdGlobal(agentId: agentIdLocall);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Add a post-frame callback to ensure that the widget is built and rendered
      // before capturing the screenshot.
      // _captureAndSavePng();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: globalScreenPaddings,
          child: SizedBox(
            width: mqw(context, 390),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    width: mqw(context, 83),
                    height: mqh(context, 83),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: GlobalColors.mainGreenColor.withOpacity(0.1)),
                    child:
                        Center(child: SvgBuilder(asset: Assets.icons.checkSvg)),
                  ),
                ),
                SizedBox(height: mqh(context, 10)),
                const Center(
                  child: Text(
                    'Ressortissant Enregistré Avec Succès',
                    style: GlobalTextStyles.ts20montboldGreen,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: mqh(context, 20)),
                RepaintBoundary(
                  key: _qrkeyy,
                  child: QrImageView(
                    data: widget.onlineOrOfllineId.toString(),
                    version: QrVersions.auto,
                    // ignore: deprecated_member_use
                    foregroundColor: GlobalColors.greyColor,
                    size: 200.0,
                  ),
                ),
                SizedBox(height: mqh(context, 20)),
                Text(
                  'ID: ${widget.onlineOrOfllineId}',
                  style: const TextStyle(
                      color: GlobalColors.greyColor,
                      fontFamily: GlobalFonts.montserratBold,
                      fontWeight: FontWeight.w800,
                      fontSize: 16),
                ),
                SizedBox(height: mqh(context, 26)),
                BuildTitleWithAnswer(
                    title: GlobalFunctions.principleFromId(
                      list: context
                          .read<GetOfflineCubitCubit>()
                          .getOfflineDataModel
                          ?.categories,
                      id: widget.addPhysicalMemberStep6Model?.step5model
                              ?.step4model?.proncipleId ??
                          0,
                    ),
                    answer:
                        '${widget.addPhysicalMemberStep6Model?.step5model?.step4model?.step3model?.addPhysicalMemberStep2Model?.addPhysicalMemberStep1Model?.fname} ${widget.addPhysicalMemberStep6Model?.step5model?.step4model?.step3model?.addPhysicalMemberStep2Model?.addPhysicalMemberStep1Model?.lname}'),
                SizedBox(height: mqh(context, 30)),
                BuildTitleWithAnswer(
                    title: 'Nom de l\'agent', answer: agentNameLocall),
                SizedBox(height: mqh(context, 30)),
                BuildTitleWithAnswer(
                    title: 'TRIX ID NUMBER',
                    answer: context.read<IsOnlineCubit>().isOnline == true
                        ? 'p${widget.onlineOrOfllineId}'
                        : widget.transactionId),
                SizedBox(height: mqh(context, 30)),
                BuildTitleWithAnswer(
                    title: 'INSCRIPTION PAYÉE',
                    answer:
                        '${widget.addPhysicalMemberStep6Model?.step5model?.inscription} FCFA'),
                SizedBox(height: mqh(context, 30)),
                BuildTitleWithAnswer(
                    title: 'COTISATION PAYÉE',
                    answer:
                        '${widget.addPhysicalMemberStep6Model?.step5model?.cotisation} FCFA'),
                SizedBox(height: mqh(context, 30)),
                BuildButton(
                    txt: 'Procéder Au Questionnaire Activité',
                    onTap: () {
                      if (context.read<ActivitiesCubit>().principleActivityId ==
                          1) {
                        context.read<AgriCubit>().fromProfileEdit == null;

                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Routes.agriStep1Screen, (route) => false);
                        context.read<AgriCubit>().offOnId =
                            widget.onlineOrOfllineId;
                        context.read<AgriCubit>().nationalName =
                            '${widget.addPhysicalMemberStep6Model?.step5model?.step4model?.step3model?.addPhysicalMemberStep2Model?.addPhysicalMemberStep1Model?.fname} ${widget.addPhysicalMemberStep6Model?.step5model?.step4model?.step3model?.addPhysicalMemberStep2Model?.addPhysicalMemberStep1Model?.lname}';
                        context.read<AgriCubit>().nationalNumber =
                            '${widget.addPhysicalMemberStep6Model?.step5model?.step4model?.step3model?.addPhysicalMemberStep2Model?.addPhysicalMemberStep1Model?.phone1}';
                      }
                      if (context.read<ActivitiesCubit>().principleActivityId ==
                          2) {
                        context.read<FishingCubit>().fromProfileEdit == null;
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Routes.fishingStep1Screen, (route) => false);
                        context.read<FishingCubit>().offOnId =
                            widget.onlineOrOfllineId;

                        context.read<FishingCubit>().nationalName =
                            '${widget.addPhysicalMemberStep6Model?.step5model?.step4model?.step3model?.addPhysicalMemberStep2Model?.addPhysicalMemberStep1Model?.fname} ${widget.addPhysicalMemberStep6Model?.step5model?.step4model?.step3model?.addPhysicalMemberStep2Model?.addPhysicalMemberStep1Model?.lname}';
                        context.read<FishingCubit>().nationalNumber =
                            '${widget.addPhysicalMemberStep6Model?.step5model?.step4model?.step3model?.addPhysicalMemberStep2Model?.addPhysicalMemberStep1Model?.phone1}';
                      }
                      if (context.read<ActivitiesCubit>().principleActivityId ==
                          3) {
                        context.read<BreedingCubit>().fromProfileEdit == null;

                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Routes.breedingStep1Screen, (route) => false);
                        context.read<BreedingCubit>().offonId =
                            widget.onlineOrOfllineId;
                        context.read<BreedingCubit>().nationalName =
                            '${widget.addPhysicalMemberStep6Model?.step5model?.step4model?.step3model?.addPhysicalMemberStep2Model?.addPhysicalMemberStep1Model?.fname} ${widget.addPhysicalMemberStep6Model?.step5model?.step4model?.step3model?.addPhysicalMemberStep2Model?.addPhysicalMemberStep1Model?.lname}';
                        context.read<BreedingCubit>().nationalNumber =
                            '${widget.addPhysicalMemberStep6Model?.step5model?.step4model?.step3model?.addPhysicalMemberStep2Model?.addPhysicalMemberStep1Model?.phone1}';
                      }
                      if (context.read<ActivitiesCubit>().principleActivityId ==
                          4) {
                        context.read<ForestCubit>().offOnId =
                            widget.onlineOrOfllineId;
                        context.read<ForestCubit>().nationalName =
                            '${widget.addPhysicalMemberStep6Model?.step5model?.step4model?.step3model?.addPhysicalMemberStep2Model?.addPhysicalMemberStep1Model?.fname} ${widget.addPhysicalMemberStep6Model?.step5model?.step4model?.step3model?.addPhysicalMemberStep2Model?.addPhysicalMemberStep1Model?.lname}';
                        context.read<ForestCubit>().nationalNumber =
                            '${widget.addPhysicalMemberStep6Model?.step5model?.step4model?.step3model?.addPhysicalMemberStep2Model?.addPhysicalMemberStep1Model?.phone1}';

                        var t = context.read<ForestCubit>().offOnId;

                        print(t);

                        context.read<ForestCubit>().fromProfileEdit == null;

                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Routes.forestStep1Screen, (route) => false);
                      }
                    }),
                SizedBox(height: mqh(context, 30)),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        Routes.homeScreen, (route) => false);
                  },
                  child: const Text(
                    'Quitter',
                    style: GlobalTextStyles.underlinedViewAllTextButton,
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}

class BuildTitleWithAnswer extends StatelessWidget {
  const BuildTitleWithAnswer({
    super.key,
    required this.title,
    required this.answer,
  });
  final String? title;
  final String? answer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title?.toUpperCase() ?? '',
          style: GlobalTextStyles.ts12montBold50opaqueBlack,
        ),
        SizedBox(height: mqh(context, 5)),
        Text(
          answer ?? '',
          style: GlobalTextStyles.ts16montBoldGreen,
        ),
      ],
    );
  }
}
