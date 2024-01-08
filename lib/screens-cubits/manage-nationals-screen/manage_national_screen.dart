// ignore_for_file: avoid_print
import 'package:capef/global_cubits/get_member_by_id/get_member_by_id_cubit.dart';
import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/manage-nationals-screen/manage_national_body.dart';
import 'package:capef/screens-cubits/national-detail-screen/national_detail_screen.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/functions.dart';
import 'package:capef/utils/snackbar.dart';
import 'package:capef/widgets/appbar.dart';
import 'package:capef/widgets/button.dart';
import 'package:capef/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ManageNationalsScreen extends StatefulWidget {
  const ManageNationalsScreen({super.key});

  @override
  State<ManageNationalsScreen> createState() => _ManageNationalsScreenState();
}

class _ManageNationalsScreenState extends State<ManageNationalsScreen> {
  String? idInput;
  TextEditingController idTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: BlocConsumer<GetMemberByIdCubit, GetMemberByIdState>(
          listener: (context, state) {
            if (state is GetMemberByIdSuccess) {
              print(idTextController.text);
              Navigator.of(context).pushNamed(Routes.nationalDetailsScreen,
                  arguments: NationalDetailScreen(
                      detailedMemberModel: state.detailedMemberModel));
            }
            if (state is GetMemberByIdFailure) {
              GlobalSnackbar.showFailureToast(context, state.status.message);
            }
          },
          builder: (context, state) {
            return KeyboardDismisser(
              child: Scaffold(
                appBar: const BuildAppBar(title: 'Zone Ressortissants'),
                bottomNavigationBar: Padding(
                  padding: const EdgeInsets.only(
                      right: 20.0, left: 20.0, bottom: 30),
                  child: (state is GetMemberByIdLoading)
                      ? BuildLoadingButton()
                      : BuildButton(
                          onTap: () {
                            context
                                .read<GetMemberByIdCubit>()
                                .getDetailedMember(
                                    jwttoken:
                                        GlobalFunctions.getLocalJWTToken(),
                                    memberId: idTextController.text);
                          },
                          txt: 'rechercher',
                        ),
                ),
                body: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    padding: globalScreenPaddings,
                    child: ManageNationalBody(
                      idTestEditingController: idTextController,
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controllerr;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool isRequestInProgress = false; // Add this flag

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BuildAppBar(title: 'Scanner QR'),
      body: BlocConsumer<GetMemberByIdCubit, GetMemberByIdState>(
        listener: (context, state) {
          if (isRequestInProgress) {
            Navigator.of(context).pop();
            isRequestInProgress = false; // Reset the flag
          }

          if (state is GetMemberByIdSuccess) {
            Navigator.of(context).pushNamed(Routes.nationalDetailsScreen,
                arguments: NationalDetailScreen(
                    detailedMemberModel: state.detailedMemberModel));
          }
          if (state is GetMemberByIdFailure) {
            GlobalSnackbar.showFailureToast(
                context, 'Cet identifiant n\'existe pas');
          }
        },
        builder: (context, state) {
          return Column(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: (QRViewController? controller) {
                    setState(() {
                      controllerr = controller;
                    });

                    controllerr?.scannedDataStream.listen((Barcode scanData) {
                      // Check if a request is already in progress
                      if (!isRequestInProgress) {
                        isRequestInProgress = true; // Set the flag
                        context.read<GetMemberByIdCubit>().getDetailedMember(
                            jwttoken: GlobalFunctions.getLocalJWTToken(),
                            memberId: scanData.code ?? '');
                        print('LISTED ${scanData.code}');
                      }
                    });
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
