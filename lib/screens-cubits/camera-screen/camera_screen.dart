// ignore_for_file: avoid_print

import 'dart:io';
import 'package:camera/camera.dart';
import 'package:capef/main.dart';
import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/image-confirmation-screen/image_confirmation_screen.dart';
import 'package:capef/utils/constant.dart';
import 'package:flutter/material.dart';
import '../../widgets/appbar.dart';

class CameraScreen extends StatefulWidget {
  /// Default Constructor
  const CameraScreen({
    super.key,
    // required this.addPhysicalMemberStep1Model,
    required this.photo,
  });
  // final PersonalInformationModel addPhysicalMemberStep1Model;
  final String photo;

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  bool? loading = false;
  late CameraController controller;
  int currentCameraIndex = 0;

  // late List<CameraDescription> _cameras;

  Future<void> getAvailableCameras() async {
    await getAvailableCameras();
  }

  @override
  void initState() {
    // print(widget.addPhysicalMemberStep1Model);
    super.initState();
    print(cameras);
    // getAvailableCameras();
    controller = CameraController(cameras![0], ResolutionPreset.veryHigh);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  Future<void> switchCamera() async {
    final int newCameraIndex = (currentCameraIndex + 1) % cameras!.length;
    final CameraController newController =
        CameraController(cameras![newCameraIndex], ResolutionPreset.veryHigh);

    await controller.dispose();
    await newController.initialize();

    if (mounted) {
      setState(() {
        currentCameraIndex = newCameraIndex;
        controller = newController;
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const BuildAppBar(title: 'Écran de la caméra'),
      body: SizedBox(
        height: mqh(context, 844),
        width: mqw(context, 390),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned.fill(
                child: CameraPreview(
              controller,
            )),
            Transform.translate(
              offset: const Offset(0, -50),
              child: GestureDetector(
                onTap: () async {
                  try {
                    final XFile picture = await controller.takePicture();
                    // Handle the captured picture here (e.g., save it or display it).
                    print('Picture taken: ${picture.path}');
                    // Navigator.pop(context);
                    // ignore: use_build_context_synchronously
                    Navigator.of(context)
                        .pushNamed(Routes.imageConfirmationScreen,
                            arguments: ImageConfirmationScreen(
                              imageFile: File(picture.path),
                              photo: widget.photo,
                            ));
                  } catch (e) {
                    // Handle picture capture errors here.
                    print('Error taking picture: $e');
                  }
                },
                child: const Icon(
                  Icons.camera,
                  color: Colors.white,
                  size: 80,
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(130, -60),
              child: GestureDetector(
                onTap: () async {
                  await switchCamera();
                },
                child: const Icon(
                  Icons.switch_camera_outlined,
                  color: Colors.white,
                  size: 60,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
