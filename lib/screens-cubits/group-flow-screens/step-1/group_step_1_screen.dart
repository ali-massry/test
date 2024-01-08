// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:io';

import 'package:capef/assets.dart';
import 'package:capef/global_cubits/get_offline_cubit/get_offline_cubit.dart';
import 'package:capef/global_cubits/update_legal_entity_member_cubit/update_legal_entity_member_cubit.dart';
import 'package:capef/models/detailed_member_model.dart';
import 'package:capef/models/legal_entity_info.dart';
import 'package:capef/models/offline_data_response.dart';
import 'package:capef/repositories/member_repo/member_repository.dart';
import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/camera-screen/camera_screen.dart';
import 'package:capef/screens-cubits/group-flow-screens/cubit/group_flow_cubit.dart';
import 'package:capef/screens-cubits/group-flow-screens/step-2/group_step_2_screen.dart';
import 'package:capef/screens-cubits/national-detail-screen/national_detail_screen.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/functions.dart';
import 'package:capef/utils/snackbar.dart';
import 'package:capef/utils/svg_builder.dart';
import 'package:capef/utils/validations.dart';
import 'package:capef/widgets/appbar.dart';
import 'package:capef/widgets/button.dart';
import 'package:capef/widgets/easy_stepper.dart';
import 'package:capef/widgets/image_network.dart';
import 'package:capef/widgets/intl_phone_field.dart';
import 'package:capef/widgets/label_with_date_picker.dart';
import 'package:capef/widgets/label_with_textfield.dart';
import 'package:capef/widgets/legal_entity_drop_down.dart';
import 'package:capef/widgets/turnover_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class AddGroupStep1Screen extends StatefulWidget {
  const AddGroupStep1Screen({super.key, required this.detailedMemberModel});
  final DetailedMemberModel? detailedMemberModel;

  @override
  State<AddGroupStep1Screen> createState() => _AddGroupStep1ScreenState();
}

class _AddGroupStep1ScreenState extends State<AddGroupStep1Screen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController certificateNumberController = TextEditingController();
  TextEditingController includingWomenController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController nationalsNumberController = TextEditingController();
  TextEditingController tel1Controller = TextEditingController();
  TextEditingController tel2Controller = TextEditingController();
  LegalEntityCategories? legalEntityCategories;
  Genders? genders;
  Civilities? civility;
  Turnovers? turnovers;
  // Titles? titles;
  DateTime? dateTime;
  File? fileDownloaded;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    print(context.read<GroupFlowCubit>().turnoverid);
    if (widget.detailedMemberModel != null) {
      context.read<GroupFlowCubit>().name =
          widget.detailedMemberModel?.legalentitymember?.name;
      context.read<GroupFlowCubit>().regnumber =
          widget.detailedMemberModel?.legalentitymember?.registrationnumber;
      context.read<GroupFlowCubit>().women =
          widget.detailedMemberModel?.legalentitymember?.women;

      context.read<GroupFlowCubit>().email =
          widget.detailedMemberModel?.legalentitymember?.email;
      context.read<GroupFlowCubit>().website =
          widget.detailedMemberModel?.legalentitymember?.website;

      context.read<GroupFlowCubit>().noofmembers =
          widget.detailedMemberModel?.legalentitymember?.numberofmembers;

      context.read<GroupFlowCubit>().legalentitycategoryid = widget
          .detailedMemberModel?.legalentitymember?.legalentitycategoryid
          .toString();
      context.read<GroupFlowCubit>().phone1 =
          widget.detailedMemberModel?.legalentitymember?.telephone1;
      context.read<GroupFlowCubit>().phone2 =
          widget.detailedMemberModel?.legalentitymember?.telephone2;
      if (context.read<GroupFlowCubit>().turnoverid != null) {
        context.read<GroupFlowCubit>().turnoverid = widget
            .detailedMemberModel?.legalentitymember?.turnoverid
            .toString();
      }
      
      legalEntityCategories = getLegalEntityCategory();
      context.read<GroupFlowCubit>().legalentitycategoryid =
          getLegalEntityCategory().id.toString();

      dateTime = parseDate();
      context.read<GroupFlowCubit>().certificatedate =
          dateTime.toString().substring(0, 10);
      print(context.read<GroupFlowCubit>().turnoverid);
      print(dateTime);
      print('NAME ${context.read<GroupFlowCubit>().name}');

      nameController =
          TextEditingController(text: context.read<GroupFlowCubit>().name);
      includingWomenController =
          TextEditingController(text: context.read<GroupFlowCubit>().women);
      certificateNumberController =
          TextEditingController(text: context.read<GroupFlowCubit>().regnumber);
      emailController =
          TextEditingController(text: context.read<GroupFlowCubit>().email);
      websiteController =
          TextEditingController(text: context.read<GroupFlowCubit>().website);
      nationalsNumberController = TextEditingController(
          text: context.read<GroupFlowCubit>().noofmembers);
      tel1Controller =
          TextEditingController(text: context.read<GroupFlowCubit>().phone1);
      tel2Controller =
          TextEditingController(text: context.read<GroupFlowCubit>().phone2);

//  TextEditingController certificateNumberController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController websiteController = TextEditingController();
//   TextEditingController nationalsNumberController = TextEditingController();
//   TextEditingController tel1Controller = TextEditingController();
//   TextEditingController tel2Controller = TextEditingController();
    }
    super.initState();
  }

  DateTime parseDate() {
    List<String> dateParts =
        widget.detailedMemberModel?.legalentitymember?.certdate?.split('-') ??
            [];
    int day = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int year = int.parse(dateParts[2]);

    return DateTime(year, month, day);
  }

  LegalEntityCategories getLegalEntityCategory() {
    for (var elemnt in context
        .read<GetOfflineCubitCubit>()
        .getOfflineDataModel!
        .legalEntityCategories!) {
      if (elemnt.id ==
          widget
              .detailedMemberModel?.legalentitymember?.legalentitycategoryid) {
        return elemnt;
      }
    }
    return LegalEntityCategories();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: BlocBuilder<GroupFlowCubit, GroupFlowState>(
          builder: (context, state) {
            return Scaffold(
              appBar: const BuildAppBar(title: 'Personne Morale'),
              body: KeyboardDismisser(
                child: Padding(
                  padding: globalScreenPaddings,
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 1,
                              child: const BuildEasyStepperWidget(
                                  length: 6, stepNow: 1)),
                          SizedBox(height: mqh(context, 40)),
                          const Text('Informations Générales',
                              style: GlobalTextStyles.ts20montboldGreen),
                          SizedBox(height: mqh(context, 40)),
                          BuildLegalEntityDropDownDropDown(
                            onChange: (p0) {
                              setState(() {
                                context
                                    .read<GroupFlowCubit>()
                                    .legalentitycategoryid = p0.id.toString();
                                print(context
                                    .read<GroupFlowCubit>()
                                    .legalentitycategoryid);
                              });
                            },
                            detailedMemberModel: widget.detailedMemberModel,
                          ),
                          SizedBox(height: mqh(context, 20)),
                          context
                                      .read<GroupFlowCubit>()
                                      .legalentitycategoryid !=
                                  '5'
                              ? const SizedBox()
                              : BuildTurnoverDropDown(
                                  onChange: (p0) {
                                    context.read<GroupFlowCubit>().turnoverid =
                                        p0.id.toString();
                                    print(context
                                        .read<GroupFlowCubit>()
                                        .turnoverid);
                                  },
                                  detailedMemberModel:
                                      widget.detailedMemberModel,
                                ),
                          SizedBox(
                              height: context
                                          .read<GroupFlowCubit>()
                                          .legalentitycategoryid !=
                                      '5'
                                  ? 0
                                  : mqh(context, 20)),
                          BuildLabelWithTextField(
                              passwordTextEditingController: nameController,
                              hint: 'Nom',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez entrer votre nom de famille';
                                }
                                return '';
                              },
                              onChanged: (p0) {
                                setState(() {
                                  nameController.text = p0!;
                                });
                                print(nameController.text);
                                context.read<GroupFlowCubit>().name = p0;
                              },
                              showSuffixIcon: false,
                              label: 'Nom'),
                          SizedBox(height: mqh(context, 20)),
                          BuildLabelWithTextField(
                              passwordTextEditingController:
                                  certificateNumberController,
                              hint: 'Numéro du certificat d’inscription',
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Entrez votre numéro de certificat d\'immatriculation';
                                }
                                return '';
                              },
                              onChanged: (p0) {
                                setState(() {
                                  certificateNumberController.text = p0!;
                                });
                                print(certificateNumberController.text);
                                context.read<GroupFlowCubit>().regnumber = p0;
                              },
                              showSuffixIcon: false,
                              label: 'Numéro du certificat d’inscription'),
                          SizedBox(height: mqh(context, 20)),
                          BuildLabelWithDatePicker(
                            label: 'Date du certificat d’inscription',
                            dateTime: DateTime.now(),
                            hint: widget.detailedMemberModel == null
                                ? 'DD / MM / YYYY'
                                : parseDate().toString().substring(0, 10),
                            onDateSelected: (p0) {
                              dateTime = p0;
                              print(dateTime);
                              context.read<GroupFlowCubit>().certificatedate =
                                  p0.toString().substring(0, 10);
                              print(context
                                  .read<GroupFlowCubit>()
                                  .certificatedate);
                            },
                          ),
                          SizedBox(height: mqh(context, 20)),
                          GestureDetector(
                            onTap: () async {
                              Navigator.pushNamed(context, Routes.cameraScreen,
                                  arguments:
                                      const CameraScreen(photo: 'group'));
                            },
                            child: widget.detailedMemberModel != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: BuildImageNetwork(
                                      widget.detailedMemberModel
                                          ?.legalentitymember?.photocertificate,
                                      width: double.infinity,
                                      height: mqh(context, 160),
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Card(
                                    elevation: 5,
                                    color: Colors.transparent,
                                    child: (state is GroupFlowSuccess)
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.file(
                                              context
                                                  .read<GroupFlowCubit>()
                                                  .photo!,
                                              width: double.infinity,
                                              height: mqh(context, 160),
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : Container(
                                            width: double.infinity,
                                            height: mqh(context, 160),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.white),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20.0),
                                              child: Center(
                                                child: Column(
                                                  children: [
                                                    Center(
                                                      child: Container(
                                                        width: mqw(context, 60),
                                                        height:
                                                            mqh(context, 60),
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
                                                              asset: Assets
                                                                  .icons
                                                                  .cameraSvg),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            mqh(context, 15)),
                                                    const Text(
                                                        'Photo du certificat d’inscription',
                                                        style: GlobalTextStyles
                                                            .ts15montboldBlack),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                  ),
                          ),
                          SizedBox(height: mqh(context, 20)),
                          BuildIntlPhoneFieldWithLabel(
                            
                            textt: widget.detailedMemberModel == null ? 'Téléphone 1' : context.read<GroupFlowCubit>().phone1 ??
                                'Téléphone 1',

                            onChangephoneNumber: (p0) {
                              setState(() {
                                context.read<GroupFlowCubit>().phone1 =
                                    p0.number;
                              });
                            },
                          ),
                          SizedBox(height: mqh(context, 5)),
                          BuildIntlPhoneFieldWithLabel(
                            textt: widget.detailedMemberModel == null ? 'Téléphone 2' : 'Téléphone 2',
                            onChangephoneNumber: (p0) {
                              setState(() {
                                context.read<GroupFlowCubit>().phone2 =
                                    p0.number;
                              });
                            },
                          ),
                          SizedBox(height: mqh(context, 20)),
                          BuildLabelWithTextField(
                              passwordTextEditingController: emailController,
                              keyboardType: TextInputType.emailAddress,
                              hint: 'Email',
                              validator: Validations.validateEmail,
                              onChanged: (p0) {
                                setState(() {
                                  emailController.text = p0!;
                                });
                                context.read<GroupFlowCubit>().email = p0;
                                print(emailController.text);
                              },
                              showSuffixIcon: false,
                              label: 'Email'),
                          SizedBox(height: mqh(context, 20)),
                          BuildLabelWithTextField(
                              passwordTextEditingController: websiteController,
                              hint: 'Website',
                              keyboardType: TextInputType.url,
                              validator: Validations.validateWebsiteDomain,
                              onChanged: (p0) {
                                setState(() {
                                  websiteController.text = p0!;
                                });
                                context.read<GroupFlowCubit>().website = p0;

                                print(websiteController.text);
                              },
                              showSuffixIcon: false,
                              label: 'Website'),
                          SizedBox(height: mqh(context, 20)),
                          BuildLabelWithTextField(
                              passwordTextEditingController:
                                  nationalsNumberController,
                              hint: 'Nombre de RESSORTISSANTS',
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez saisir votre nombre de ressortissants';
                                }
                                return '';
                              },
                              onChanged: (p0) {
                                setState(() {
                                  nationalsNumberController.text = p0!;
                                });
                                context.read<GroupFlowCubit>().noofmembers = p0;

                                print(nationalsNumberController.text);
                              },
                              showSuffixIcon: false,
                              label: 'Nombre de RESSORTISSANTS'),
                          SizedBox(height: mqh(context, 20)),
                          BuildLabelWithTextField(
                            passwordTextEditingController:
                                includingWomenController,
                            keyboardType: TextInputType.number,
                            hint: 'Dont Femmes',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez saisir votre Dont Femmes';
                              }
                              return '';
                            },
                            onChanged: (p0) {
                              setState(() {
                                includingWomenController.text = p0!;
                              });
                              context.read<GroupFlowCubit>().women = p0;
                            },
                            showSuffixIcon: false,
                            label: 'Dont Femmes',
                          ),
                          SizedBox(height: mqh(context, 40)),
                          BlocConsumer<UpdateLegalEntityMemberCubit,
                              UpdateLegalEntityMemberState>(
                            listener: (context, state) async {
                              if (state is UpdateLegalEntityMemberSucess) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const CustomLoaderWidget();
                                  },
                                );
                                // GlobalFunctions.showLoader(context);
                                DetailedMemberModel detailedMemberModell =
                                    await MemberRepository.getMemberById(
                                        jwttoken:
                                            GlobalFunctions.getLocalJWTToken(),
                                        memberId: widget.detailedMemberModel
                                                ?.onlineid ??
                                            '');

                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.of(context).pushNamed(
                                    Routes.nationalDetailsScreen,
                                    arguments: NationalDetailScreen(
                                        detailedMemberModel:
                                            detailedMemberModell));
                              } else if (state
                                  is UpdateLegalEntityMemberFailure) {
                                GlobalSnackbar.showFailureToast(
                                    context,
                                    state.updateLegalEntityMemberModel?.status
                                        ?.message);
                              }
                            },
                            builder: (context, state) {
                              return BuildButton(
                                onTap: widget.detailedMemberModel != null
                                    ? () {
                                        // context
                                        //     .read<
                                        //         UpdateLegalEntityMemberCubit>()
                                        //     .updateLegalEntityMember(
                                        //       jwtToken: GlobalFunctions
                                        //           .getLocalJWTToken(),
                                        //       legalEntityInfo: LegalEntityInfo(
                                        //           offlineId: widget
                                        //               .detailedMemberModel
                                        //               ?.onlineid,
                                        //           legalentitycategoryid: context
                                        //               .read<GroupFlowCubit>()
                                        //               .legalentitycategoryid,
                                        //           turnoverid: context
                                        //               .read<GroupFlowCubit>()
                                        //               .turnoverid,
                                        //           name: context
                                        //               .read<GroupFlowCubit>()
                                        //               .name,
                                        //           noofmembers: context
                                        //               .read<GroupFlowCubit>()
                                        //               .noofmembers,
                                        //           certificatedate: context
                                        //               .read<GroupFlowCubit>()
                                        //               .certificatedate,
                                        //           photoRegistration: context
                                        //               .read<GroupFlowCubit>()
                                        //               .photo,
                                        //           phone1: context
                                        //               .read<GroupFlowCubit>()
                                        //               .phone1,
                                        //           phone2: context
                                        //               .read<GroupFlowCubit>()
                                        //               .phone2,
                                        //           email: context
                                        //               .read<GroupFlowCubit>()
                                        //               .email,
                                        //           website: context
                                        //               .read<GroupFlowCubit>()
                                        //               .website,
                                        //           women: context
                                        //               .read<GroupFlowCubit>()
                                        //               .women),
                                        //     );

                                        if (context
                                                .read<GroupFlowCubit>()
                                                .legalentitycategoryid ==
                                            '5') {
                                          context
                                                  .read<GroupFlowCubit>()
                                                  .turnoverid ==
                                              context
                                                  .read<GroupFlowCubit>()
                                                  .turnoverid;
                                        } else {
                                          context
                                                  .read<GroupFlowCubit>()
                                                  .turnoverid ==
                                              '';
                                        }

                                        print(
                                            'TURN OVER ${context.read<GroupFlowCubit>().turnoverid}');

                                        LegalEntityInfo legalEntityInfo =
                                            LegalEntityInfo(
                                                offlineId: widget
                                                    .detailedMemberModel
                                                    ?.onlineid,
                                                legalentitycategoryid: context
                                                    .read<GroupFlowCubit>()
                                                    .legalentitycategoryid,
                                                turnoverid: context
                                                    .read<GroupFlowCubit>()
                                                    .turnoverid,
                                                name: context
                                                    .read<GroupFlowCubit>()
                                                    .name,
                                                noofmembers: context
                                                    .read<GroupFlowCubit>()
                                                    .noofmembers,
                                                certificatedate: context
                                                    .read<GroupFlowCubit>()
                                                    .certificatedate,
                                                photoRegistration: context
                                                    .read<GroupFlowCubit>()
                                                    .photo,
                                                phone1: context
                                                    .read<GroupFlowCubit>()
                                                    .phone1,
                                                phone2: context
                                                    .read<GroupFlowCubit>()
                                                    .phone2,
                                                email: context
                                                    .read<GroupFlowCubit>()
                                                    .email,
                                                website: context
                                                    .read<GroupFlowCubit>()
                                                    .website,
                                                women: context
                                                    .read<GroupFlowCubit>()
                                                    .women,
                                                regnumber: context
                                                    .read<GroupFlowCubit>()
                                                    .regnumber);
                                        print(legalEntityInfo.turnoverid);

                                        context
                                            .read<
                                                UpdateLegalEntityMemberCubit>()
                                            .updateLegalEntityMember(
                                                jwtToken: GlobalFunctions
                                                    .getLocalJWTToken(),
                                                legalEntityInfo:
                                                    legalEntityInfo);

                                        print(legalEntityInfo);
                                      }
                                    : () {
                                        if (context
                                                    .read<GroupFlowCubit>()
                                                    .legalentitycategoryid ==
                                                null ||
                                            context
                                                    .read<GroupFlowCubit>()
                                                    .turnoverid ==
                                                null ||
                                            context
                                                    .read<GroupFlowCubit>()
                                                    .name ==
                                                null ||
                                            context
                                                    .read<GroupFlowCubit>()
                                                    .noofmembers ==
                                                null ||
                                            context
                                                    .read<GroupFlowCubit>()
                                                    .certificatedate ==
                                                null ||
                                            context
                                                    .read<GroupFlowCubit>()
                                                    .photo ==
                                                null ||
                                            context
                                                    .read<GroupFlowCubit>()
                                                    .phone1 ==
                                                null ||
                                            context
                                                    .read<GroupFlowCubit>()
                                                    .phone2 ==
                                                null ||
                                            context
                                                    .read<GroupFlowCubit>()
                                                    .email ==
                                                null ||
                                            context
                                                    .read<GroupFlowCubit>()
                                                    .website ==
                                                null ||
                                            context
                                                    .read<GroupFlowCubit>()
                                                    .women ==
                                                null) {
                                          GlobalSnackbar.showFailureToast(
                                              context,
                                              'assurez-vous de remplir toutes les informations');
                                        } else {}
                                        // !! Remove Validation HERE

                                        if (!(_formKey.currentState!
                                            .validate())) {
                                          Navigator.of(context).pushNamed(
                                              Routes.addgroupScreen2,
                                              arguments:
                                                  const AddGroupStep2Screen(
                                                detailedMemberModel: null,
                                              ));
                                        }
                                      },
                                txt: 'suivant',
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
