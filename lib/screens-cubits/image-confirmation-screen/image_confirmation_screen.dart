// ignore_for_file: avoid_print

import 'dart:io';
import 'package:capef/global_cubits/physical_person_cubit/add_physical_person_cubit.dart';
import 'package:capef/screens-cubits/group-flow-screens/cubit/group_flow_cubit.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageConfirmationScreen extends StatefulWidget {
  const ImageConfirmationScreen({
    super.key,
    required this.imageFile,
    required this.photo,
    // required this.addPhysicalMemberStep1Model,
  });
  final File imageFile;
  final String photo;

  @override
  State<ImageConfirmationScreen> createState() =>
      _ImageConfirmationScreenState();
}

class _ImageConfirmationScreenState extends State<ImageConfirmationScreen> {
  // final AddPhysicalMemberStep1Model addPhysicalMemberStep1Model;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center the column vertically
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipOval(
                  child: Image.file(
                    widget.imageFile,
                    width: mqw(context, 229),
                    height: mqh(context, 229),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: mqh(context, 40)),
                BuildButton(
                  txt: 'Confirmer la photo',
                  onTap: () {
                    if (widget.photo == 'national') {
                      context
                          .read<AddPhysicalPersonCubit>()
                          .addNationalPhoto(nationalPhotoo: widget.imageFile);
                    } else if (widget.photo == 'recto') {
                      context
                          .read<AddPhysicalPersonCubit>()
                          .addRectoPhoto(rectoPhotoo: widget.imageFile);
                    } else if (widget.photo == 'verso') {
                      context
                          .read<AddPhysicalPersonCubit>()
                          .addVersoPhoto(versoPhotoo: widget.imageFile);
                    } else if (widget.photo == 'group') {
                      context
                          .read<GroupFlowCubit>()
                          .addgroupPhoto(groupPhotoo: widget.imageFile);
                    }

                    print(
                        'ASPPPP NAT ${context.read<AddPhysicalPersonCubit>().nationalPhoto}');
                    print(
                        'ASPPPP VERSO ${context.read<AddPhysicalPersonCubit>().versoCNIPhoto}');
                    print(
                        'ASPPPP RECTO ${context.read<AddPhysicalPersonCubit>().rectoCNIPhoto}');
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
                SizedBox(height: mqh(context, 40)),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Reprendre la photo',
                    style: GlobalTextStyles.underlinedViewAllTextButton,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
