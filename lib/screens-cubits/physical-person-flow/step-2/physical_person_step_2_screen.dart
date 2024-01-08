// ignore_for_file: use_build_context_synchronously

import 'package:capef/assets.dart';
import 'package:capef/global_cubits/physical_person_cubit/add_physical_person_cubit.dart';
import 'package:capef/global_cubits/update_individual_member_cubit/update_individual_member_cubit.dart';
import 'package:capef/models/detailed_member_model.dart';
import 'package:capef/models/user_info_to_be_edited_model.dart';
import 'package:capef/repositories/member_repo/member_repository.dart';
import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/camera-screen/camera_screen.dart';
import 'package:capef/screens-cubits/national-detail-screen/national_detail_screen.dart';
import 'package:capef/screens-cubits/physical-person-flow/step-1/personal_info.dart';
import 'package:capef/screens-cubits/physical-person-flow/step-2/step_2_model.dart';
import 'package:capef/screens-cubits/physical-person-flow/step-3/physical_person_step_3_screen.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/functions.dart';
import 'package:capef/utils/snackbar.dart';
import 'package:capef/utils/svg_builder.dart';
import 'package:capef/widgets/appbar.dart';
import 'package:capef/widgets/button.dart';
import 'package:capef/widgets/easy_stepper.dart';
import 'package:capef/widgets/image_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class AddPhysicalPersonStep2Screen extends StatefulWidget {
  const AddPhysicalPersonStep2Screen(
      {super.key,
      this.addPhysicalMemberStep1Model,
      required this.detailedMemberModel});
  final PersonalInformationModel? addPhysicalMemberStep1Model;
  final DetailedMemberModel? detailedMemberModel;

  @override
  State<AddPhysicalPersonStep2Screen> createState() =>
      _AddPhysicalPersonStep2ScreenState();
}

class _AddPhysicalPersonStep2ScreenState
    extends State<AddPhysicalPersonStep2Screen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          bottomNavigationBar: Container(
            margin: const EdgeInsets.symmetric(horizontal: 19, vertical: 30),
            child: BlocConsumer<UpdateIndividualMemberCubit,
                UpdateIndividualMemberState>(
              listener: (context, state) async {
                if (state is UpdateIndividualMemberSucess) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const CustomLoaderWidget();
                    },
                  );
                  // GlobalFunctions.showLoader(context);
                  DetailedMemberModel detailedMemberModell =
                      await MemberRepository.getMemberById(
                          jwttoken: GlobalFunctions.getLocalJWTToken(),
                          memberId: widget.detailedMemberModel?.onlineid ?? '');

                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacementNamed(Routes.nationalDetailsScreen,
                      arguments: NationalDetailScreen(
                          detailedMemberModel: detailedMemberModell));
                } else if (state is UpdateIndividualMemberFailure) {
                  GlobalSnackbar.showFailureToast(context,
                      state.updateLIndividualMemberModel?.status?.message);
                }
              },
              builder: (context, state) {
                return BuildButton(
                  txt: 'suivant',
                  onTap: widget.detailedMemberModel == null
                      ? () {
                          if (context
                                      .read<AddPhysicalPersonCubit>()
                                      .nationalPhoto ==
                                  null ||
                              context
                                      .read<AddPhysicalPersonCubit>()
                                      .versoCNIPhoto ==
                                  null ||
                              context
                                      .read<AddPhysicalPersonCubit>()
                                      .rectoCNIPhoto ==
                                  null) {
                            GlobalSnackbar.showFailureToast(context,
                                'Assurez-vous de télécharger les 3 images');
                          } else {
                            Navigator.of(context)
                                .pushNamed(Routes.addPhysicalPersonScreen3,
                                    arguments: AddPhysicalPersonStep3Screen(
                                      addPhysicalMemberStep2Model:
                                          PersonalInfoWithPhotoModel(
                                        addPhysicalMemberStep1Model:
                                            widget.addPhysicalMemberStep1Model,
                                        nationalPhoto: context
                                            .read<AddPhysicalPersonCubit>()
                                            .nationalPhoto,
                                        rectoPhoto: context
                                            .read<AddPhysicalPersonCubit>()
                                            .rectoCNIPhoto,
                                        versoPhoto: context
                                            .read<AddPhysicalPersonCubit>()
                                            .versoCNIPhoto,
                                      ),
                                    ));
                          }
                        }
                      : () async {
                          PersonalInfoWithPhotoModel
                              personalInfoWithPhotoModelS =
                              PersonalInfoWithPhotoModel(
                            addPhysicalMemberStep1Model:
                                widget.addPhysicalMemberStep1Model,
                            nationalPhoto: context
                                .read<AddPhysicalPersonCubit>()
                                .nationalPhoto,
                            rectoPhoto: context
                                .read<AddPhysicalPersonCubit>()
                                .rectoCNIPhoto,
                            versoPhoto: context
                                .read<AddPhysicalPersonCubit>()
                                .versoCNIPhoto,
                          );
                          UserInfoEdited userInfoEdited = UserInfoEdited(
                            firstname: personalInfoWithPhotoModelS
                                    .addPhysicalMemberStep1Model?.fname ??
                                '',
                            lastname: personalInfoWithPhotoModelS
                                    .addPhysicalMemberStep1Model?.lname ??
                                '',
                            onlineId:
                                widget.detailedMemberModel?.onlineid ?? '',
                            meterialStatusid: personalInfoWithPhotoModelS
                                    .addPhysicalMemberStep1Model
                                    ?.maternalSituationId
                                    .toString() ??
                                '',
                            civilityid: personalInfoWithPhotoModelS
                                    .addPhysicalMemberStep1Model?.civilityId
                                    .toString() ??
                                '',
                            genderid: personalInfoWithPhotoModelS
                                    .addPhysicalMemberStep1Model?.genderId
                                    .toString() ??
                                '',
                            dob: personalInfoWithPhotoModelS
                                    .addPhysicalMemberStep1Model?.dateOfBirth
                                    .toString()
                                    .substring(0, 10) ??
                                '',
                            placeofbirth: personalInfoWithPhotoModelS
                                    .addPhysicalMemberStep1Model?.placeOfBorth
                                    .toString() ??
                                '',
                            phone1: personalInfoWithPhotoModelS
                                    .addPhysicalMemberStep1Model?.phone1 ??
                                '',
                            phone2: personalInfoWithPhotoModelS
                                    .addPhysicalMemberStep1Model?.phone2 ??
                                '',
                            email: personalInfoWithPhotoModelS
                                    .addPhysicalMemberStep1Model?.email ??
                                '',
                            op: personalInfoWithPhotoModelS
                                    .addPhysicalMemberStep1Model
                                    ?.opOfBelonging ??
                                '',
                            cni: personalInfoWithPhotoModelS
                                    .addPhysicalMemberStep1Model?.cniNumber ??
                                '',
                          );
                          await context
                              .read<UpdateIndividualMemberCubit>()
                              .updateIndividualMember(
                                  jwtToken: GlobalFunctions.getLocalJWTToken(),
                                  userInfo: null,
                                  userInfoEdited: userInfoEdited);
                        },
                );
              },
            ),
          ),
          appBar: const BuildAppBar(title: 'Informations personnelles'),
          body: KeyboardDismisser(
            child: Padding(
              padding: globalScreenPaddings,
              child: SingleChildScrollView(
                child:
                    BlocBuilder<AddPhysicalPersonCubit, AddPhysicalPersonState>(
                  builder: (context, state) {
                    if (state is AddPhotosSuccess) {
                      return Column(
                        children: [
                          const BuildEasyStepperWidget(length: 6, stepNow: 2),
                          SizedBox(height: mqh(context, 40)),
                          const Text('Informations CNI',
                              style: GlobalTextStyles.ts20montboldGreen),
                          SizedBox(height: mqh(context, 40)),
                          GestureDetector(
                            onTap: () async {
                              Navigator.pushNamed(context, Routes.cameraScreen,
                                  arguments: const CameraScreen(
                                    photo: 'national',
                                  ));
                            },
                            child: Card(
                              elevation: 5,
                              child: context
                                          .read<AddPhysicalPersonCubit>()
                                          .nationalPhoto !=
                                      null
                                  ? Image.file(
                                      context
                                          .read<AddPhysicalPersonCubit>()
                                          .nationalPhoto!,
                                      width: double.infinity,
                                      height: mqh(context, 160),
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      width: double.infinity,
                                      height: mqh(context, 160),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20.0),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Center(
                                                child: Container(
                                                  width: mqw(context, 60),
                                                  height: mqh(context, 60),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      color: GlobalColors
                                                          .mainGreenColor
                                                          .withOpacity(0.1)),
                                                  child: Center(
                                                    child: SvgBuilder(
                                                        asset: Assets
                                                            .icons.cameraSvg),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                  height: mqh(context, 15)),
                                              const Text(
                                                  'Photo du Ressortissant',
                                                  style: GlobalTextStyles
                                                      .ts15montboldBlack),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                          SizedBox(height: mqh(context, 15)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.cameraScreen,
                                      arguments: const CameraScreen(
                                        photo: 'recto',
                                      ));
                                },
                                child: Card(
                                  elevation: 5,
                                  child: context
                                              .read<AddPhysicalPersonCubit>()
                                              .rectoCNIPhoto !=
                                          null
                                      ? Image.file(
                                          context
                                              .read<AddPhysicalPersonCubit>()
                                              .rectoCNIPhoto!,
                                          width: mqw(context, 150),
                                          height: mqh(context, 150),
                                          fit: BoxFit.cover,
                                        )
                                      : Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 40),
                                          // width: mqw(context, 168),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.white),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15.0),
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: mqw(context, 63),
                                                    height: mqh(context, 63),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        color: GlobalColors
                                                            .mainGreenColor
                                                            .withOpacity(0.1)),
                                                    child: Center(
                                                      child: SvgBuilder(
                                                          asset: Assets
                                                              .icons.cameraSvg),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height: mqh(context, 15)),
                                                  const Text(
                                                    'Photo CNI',
                                                    style: GlobalTextStyles
                                                        .ts14montboldBlack,
                                                  ),
                                                  SizedBox(
                                                      height: mqh(context, 5)),
                                                  const Text(
                                                    '(Recto)',
                                                    style: GlobalTextStyles
                                                        .ts14montboldBlack,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.cameraScreen,
                                      arguments: const CameraScreen(
                                        photo: 'verso',
                                      ));
                                },
                                child: Card(
                                  elevation: 5,
                                  child: context
                                              .read<AddPhysicalPersonCubit>()
                                              .versoCNIPhoto !=
                                          null
                                      ? Image.file(
                                          context
                                              .read<AddPhysicalPersonCubit>()
                                              .versoCNIPhoto!,
                                          width: mqw(context, 150),
                                          height: mqh(context, 150),
                                          fit: BoxFit.cover,
                                        )
                                      : Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 40),
                                          // width: mqw(context, 168),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.white),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15.0),
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: mqw(context, 63),
                                                    height: mqh(context, 63),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        color: GlobalColors
                                                            .mainGreenColor
                                                            .withOpacity(0.1)),
                                                    child: Center(
                                                      child: SvgBuilder(
                                                          asset: Assets
                                                              .icons.cameraSvg),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height: mqh(context, 15)),
                                                  const Text(
                                                    'Photo CNI',
                                                    style: GlobalTextStyles
                                                        .ts14montboldBlack,
                                                  ),
                                                  SizedBox(
                                                      height: mqh(context, 5)),
                                                  const Text(
                                                    '(Verso)',
                                                    style: GlobalTextStyles
                                                        .ts14montboldBlack,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    }
                    return Column(
                      children: [
                        const BuildEasyStepperWidget(length: 6, stepNow: 2),
                        SizedBox(height: mqh(context, 40)),
                        const Text('Informations CNI',
                            style: GlobalTextStyles.ts20montboldGreen),
                        SizedBox(height: mqh(context, 40)),
                        widget.detailedMemberModel != null
                            ? GestureDetector(
                                onTap: () async {
                                  Navigator.pushNamed(
                                      context, Routes.cameraScreen,
                                      arguments: const CameraScreen(
                                        photo: 'national',
                                      ));
                                },
                                child: Card(
                                    elevation: 5,
                                    child: BuildImageNetwork(
                                      widget.detailedMemberModel
                                              ?.individualmember?.photomember ??
                                          '',
                                      width: double.infinity,
                                      height: mqh(context, 160),
                                      fit: BoxFit.cover,
                                    )),
                              )
                            : GestureDetector(
                                onTap: () async {
                                  Navigator.pushNamed(
                                      context, Routes.cameraScreen,
                                      arguments: const CameraScreen(
                                        photo: 'national',
                                      ));
                                },
                                child: Card(
                                  elevation: 5,
                                  child: (state is AddPhotosSuccess)
                                      ? Image.file(
                                          context
                                              .read<AddPhysicalPersonCubit>()
                                              .nationalPhoto!,
                                          width: double.infinity,
                                          height: mqh(context, 160),
                                          fit: BoxFit.cover,
                                        )
                                      : Container(
                                          width: double.infinity,
                                          height: mqh(context, 160),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.white),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20.0),
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  Center(
                                                    child: Container(
                                                      width: mqw(context, 60),
                                                      height: mqh(context, 60),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                          color: GlobalColors
                                                              .mainGreenColor
                                                              .withOpacity(
                                                                  0.1)),
                                                      child: Center(
                                                        child: SvgBuilder(
                                                            asset: Assets.icons
                                                                .cameraSvg),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height: mqh(context, 15)),
                                                  const Text(
                                                      'Photo du Ressortissant',
                                                      style: GlobalTextStyles
                                                          .ts15montboldBlack),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                        SizedBox(height: mqh(context, 15)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.cameraScreen,
                                    arguments: const CameraScreen(
                                      photo: 'recto',
                                    ));
                              },
                              child: Card(
                                  elevation: 5,
                                  child: BuildImageNetwork(
                                    widget.detailedMemberModel?.individualmember
                                            ?.photofront ??
                                        '',
                                    width: mqw(context, 150),
                                    height: mqh(context, 150),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.cameraScreen,
                                    arguments: const CameraScreen(
                                      photo: 'verso',
                                    ));
                              },
                              child: Card(
                                  elevation: 5,
                                  child: BuildImageNetwork(
                                    widget.detailedMemberModel?.individualmember
                                            ?.photoback ??
                                        '',
                                    width: mqw(context, 150),
                                    height: mqh(context, 150),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          ],
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ));
  }
}
