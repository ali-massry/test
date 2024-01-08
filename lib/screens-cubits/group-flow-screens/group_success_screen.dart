import 'package:capef/assets.dart';
import 'package:capef/global_cubits/activities_cubit/activities_cubit.dart';
import 'package:capef/global_cubits/get_offline_cubit/get_offline_cubit.dart';
import 'package:capef/global_cubits/is_online_cubit/is_online_cubit.dart';
import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/agri-flow-screens/cubit/agri_cubit.dart';
import 'package:capef/screens-cubits/breeding-flow-screens/cubit/breeding_cubit.dart';
import 'package:capef/screens-cubits/fishing-flow-screens/cubit/fishing_cubit.dart';
import 'package:capef/screens-cubits/forest-flow-screens/cubit/forest_cubit.dart';
import 'package:capef/screens-cubits/group-flow-screens/cubit/group_flow_cubit.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/functions.dart';
import 'package:capef/utils/svg_builder.dart';
import 'package:capef/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GroupSuccessScreen extends StatefulWidget {
  const GroupSuccessScreen(
      {super.key, this.onlineOrOfllineId, this.transactionIDD});
  final String? onlineOrOfllineId;
  final String? transactionIDD;

  @override
  State<GroupSuccessScreen> createState() => _GroupSuccessScreenState();
}

class _GroupSuccessScreenState extends State<GroupSuccessScreen> {
  Uint8List? bytesImage;
  // final GlobalKey qrkey = GlobalKey();
  // String? offlineId;
  Uint8List? capturedScreenshot;

  @override
  void initState() {
    super.initState();
  }


  // Future<void> _captureAndSavePng() async {
  //   try {
  //     print('fettt hun');
  //     RenderRepaintBoundary boundary =
  //         qrkey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  //     var image = await boundary.toImage(pixelRatio: 3.0);

  //     // Drawing White Background because the Qr Code is Black
  //     final whitePaint = Paint()..color = Colors.white;
  //     final recorder = PictureRecorder();
  //     final canvas = Canvas(recorder,
  //         Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()));
  //     canvas.drawRect(
  //         Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
  //         whitePaint);
  //     canvas.drawImage(image, Offset.zero, Paint());
  //     final picture = recorder.endRecording();
  //     final img = await picture.toImage(image.width, image.height);
  //     ByteData? byteData = await img.toByteData(format: ImageByteFormat.png);
  //     Uint8List pngBytes = byteData!.buffer.asUint8List();

  //     print(pngBytes);

  //     try {
  //       platform.invokeMethod('myJavaFunc', {
  //         'data': pngBytes,
  //         'id': offlineId,
  //         'title': GlobalFunctions.principleFromId(
  //           // ignore: use_build_context_synchronously
  //           list: context
  //               .read<GetOfflineCubitCubit>()
  //               .getOfflineDataModel
  //               ?.categories,
  //           id: widget.addPhysicalMemberStep6Model?.step5model?.step4model
  //                   ?.proncipleId ??
  //               0,
  //         ),
  //         'answer':
  //             '${widget.addPhysicalMemberStep6Model?.step5model?.step4model?.step3model?.addPhysicalMemberStep2Model?.addPhysicalMemberStep1Model?.fname} ${widget.addPhysicalMemberStep6Model?.step5model?.step4model?.step3model?.addPhysicalMemberStep2Model?.addPhysicalMemberStep1Model?.lname}',
  //       
  //         'agentName': 'agentNmae',
  //         'inscription':
  //             '${widget.addPhysicalMemberStep6Model?.step5model?.inscription} FCFA',
  //         'cotisation':
  //             '${widget.addPhysicalMemberStep6Model?.step5model?.cotisation} FCFA',
  //       });
  //     } on PlatformException catch (e) {
  //       print(e);
  //     }

  //     if (!mounted) return;
  //     const snackBar = SnackBar(content: Text('QR code saved to gallery'));
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   } catch (e) {
  //     if (!mounted) return;
  //     print('Something went wrong!!! $e');
  //     const snackBar = SnackBar(content: Text('Something went wrong!!!'));
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   }
  // }

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
                    child: Center(
                      child: SvgBuilder(asset: Assets.icons.checkSvg),
                    ),
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
                  child: QrImageView(
                    data: widget.onlineOrOfllineId.toString(),
                    version: QrVersions.auto,
                    // ignore: deprecated_member_use
                    foregroundColor: GlobalColors.greyColor,
                    size: 200.0,
                    // key: qrkey,
                  ),
                ),
                // QrImageView(
                //   data: offlineId.toString(),
                //   version: QrVersions.auto,
                //   foregroundColor: GlobalColors.greyColor,
                //   size: 200.0,
                // ),
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
                      id: int.parse(
                          context.read<GroupFlowCubit>().mainactivityid!),
                    ),
                    answer: '${context.read<GroupFlowCubit>().name}'),
                SizedBox(height: mqh(context, 30)),
                BuildTitleWithAnswer(
                    title: 'Nom de l\'agent', answer: agentNameLocall),
                SizedBox(height: mqh(context, 30)),
                BuildTitleWithAnswer(
                    title: 'TRIX ID NUMBER',
                    answer: context.read<IsOnlineCubit>().isOnline == true
                        ? 'p${widget.onlineOrOfllineId}'
                        : widget.transactionIDD),
                SizedBox(height: mqh(context, 30)),
                BuildTitleWithAnswer(
                    title: 'INSCRIPTION PAYÉE',
                    answer:
                        '${context.read<GroupFlowCubit>().seasonpayment} FCFA'),
                SizedBox(height: mqh(context, 30)),
                BuildTitleWithAnswer(
                    title: 'COTISATION PAYÉE',
                    answer:
                        '${context.read<GroupFlowCubit>().subscriptionpayment} FCFA'),
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
                            context.read<GroupFlowCubit>().name;
                        context.read<AgriCubit>().nationalNumber =
                            context.read<GroupFlowCubit>().phone1;
                      }
                      if (context.read<ActivitiesCubit>().principleActivityId ==
                          2) {
      context.read<FishingCubit>().fromProfileEdit == null;

                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Routes.fishingStep1Screen, (route) => false);
                        context.read<FishingCubit>().offOnId =
                            widget.onlineOrOfllineId;
                        context.read<FishingCubit>().nationalName =
                            context.read<GroupFlowCubit>().name;
                        context.read<FishingCubit>().nationalNumber =
                            context.read<GroupFlowCubit>().phone1;
                      }
                      if (context.read<ActivitiesCubit>().principleActivityId ==
                          3) {
      context.read<BreedingCubit>().fromProfileEdit == null;

                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Routes.breedingStep1Screen, (route) => false);
                        context.read<BreedingCubit>().offonId =
                            widget.onlineOrOfllineId;
                        context.read<BreedingCubit>().nationalName =
                            context.read<GroupFlowCubit>().name;
                        context.read<BreedingCubit>().nationalNumber =
                            context.read<GroupFlowCubit>().phone1;
                      }
                      if (context.read<ActivitiesCubit>().principleActivityId ==
                          4) {
                        context.read<ForestCubit>().offOnId =
                            widget.onlineOrOfllineId;
                        context.read<ForestCubit>().nationalName =
                            context.read<GroupFlowCubit>().name;
                        context.read<ForestCubit>().nationalNumber =
                            context.read<GroupFlowCubit>().phone1;


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
