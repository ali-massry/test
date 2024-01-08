// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:capef/models/offline_data_response.dart';
import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/group-flow-screens/cubit/group_flow_cubit.dart';
import 'package:capef/screens-cubits/group-flow-screens/step-3/step_3_model.dart';
import 'package:capef/screens-cubits/physical-person-flow/step-2/step_2_model.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/snackbar.dart';
import 'package:capef/widgets/appbar.dart';
import 'package:capef/widgets/button.dart';
import 'package:capef/widgets/civilization_drop_down.dart';
import 'package:capef/widgets/easy_stepper.dart';
import 'package:capef/widgets/intl_phone_field.dart';
import 'package:capef/widgets/label_with_textfield.dart';
import 'package:capef/widgets/marital_status_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class AddGroupStep3Screen extends StatefulWidget {
  const AddGroupStep3Screen({super.key, this.addPhysicalMemberStep2Model});
  final PersonalInfoWithPhotoModel? addPhysicalMemberStep2Model;

  @override
  State<AddGroupStep3Screen> createState() => _AddGroupStep3ScreenState();
}

class _AddGroupStep3ScreenState extends State<AddGroupStep3Screen> {
  List<RepresentativeModel> representatives = [RepresentativeModel()];
  List<Widget> representativesNumber = [const BuildRepresentativeFormWidget()];
  bool goToNextPhase = false;
  // LegalEntityCategories? legalEntityCategories;
  Civilities? civility;
  TextEditingController nameController = TextEditingController();
  TextEditingController familyNameController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController tel1Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          appBar: const BuildAppBar(title: 'Adresse du Siège'),
          body: KeyboardDismisser(
            child: Padding(
                padding: globalScreenPaddings,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: mqh(context, 30)),
                      const BuildEasyStepperWidget(length: 6, stepNow: 3),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: representativesNumber.length,
                        itemBuilder: (context, index) {
                          return BuildRepresentativeFormWidget(
                              index: index,
                              representativeModelList: representatives);
                        },
                      ),
                      SizedBox(height: mqh(context, 40)),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (representativesNumber.length < 5) {
                              representativesNumber
                                  .add(const BuildRepresentativeFormWidget());
                              representatives.add(RepresentativeModel());
                            }
                          });
                        },
                        child: Text(
                          'Ajouter un autre Représentant'.toUpperCase(),
                          style: GlobalTextStyles.underlinedViewAllTextButton,
                        ),
                      ),
                      SizedBox(height: mqh(context, 30)),
                      BuildButton(
                        txt: 'suivant',
                        onTap: () {
                          for (var representative in representatives) {
                            if (representative.civilityId == null ||
                                representative.address == null ||
                                representative.email == null ||
                                representative.firstname == null ||
                                representative.lastname == null ||
                                representative.phone == null ||
                                representative.titleId == null) {
                              setState(() {
                                goToNextPhase = false;
                              });
                            } else {
                              setState(() {
                                goToNextPhase = true;
                              });

                              if (goToNextPhase == false) {
                                GlobalSnackbar.showFailureToast(context,
                                    'assurez-vous de remplir toutes les informations sur les représentants');
                              } else {
                                if (!RegExp(r'\S+@\S+\.\S+')
                                    .hasMatch(representative.email!)) {
                                  GlobalSnackbar.showFailureToast(
                                      context, 'Adresse email non valide');
                                } else {
                                  List<Map<String, dynamic>>
                                      representativesJson = representatives
                                          .map((rep) => rep.toJson())
                                          .toList();

                                  context
                                          .read<GroupFlowCubit>()
                                          .representativesJson =
                                      jsonEncode(representativesJson);
                                  print(
                                      'JSONED LIST ${jsonEncode(representativesJson)}');
                                  Navigator.of(context)
                                      .pushNamed(Routes.addgroupScreen4);
                                }
                              }
                            }
                          }
                        },
                      ),
                    ],
                  ),
                )),
          ),
        ));
  }
}

class BuildRepresentativeFormWidget extends StatefulWidget {
  const BuildRepresentativeFormWidget({
    super.key,
    this.index,
    this.representativeModelList,
  });
  final int? index;
  final List<RepresentativeModel>? representativeModelList;

  @override
  State<BuildRepresentativeFormWidget> createState() =>
      _BuildRepresentativeFormWidgetState();
}

class _BuildRepresentativeFormWidgetState
    extends State<BuildRepresentativeFormWidget> {
  Civilities? civility;
  TextEditingController nameController = TextEditingController();
  TextEditingController familyNameController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController tel1Controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: mqh(context, 40)),
        Text('${widget.index! + 1}er Représentant',
            style: GlobalTextStyles.ts20montboldGreen),
        SizedBox(height: mqh(context, 40)),
        BuildCivilizationDropDown(
          onChange: (p0) {
            widget.representativeModelList![widget.index!].civilityId = p0.id;

            civility = p0;
          },
        ),
        SizedBox(height: mqh(context, 20)),
        BuildLabelWithTextField(
            passwordTextEditingController: nameController,
            hint: 'Prénom',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Entrez votre prénom s\'il vous plait';
              }
              return '';
            },
            onChanged: (p0) {
              setState(() {
                nameController.text = p0!;
              });
              widget.representativeModelList![widget.index!].firstname = p0;
            },
            showSuffixIcon: false,
            label: 'Prénom'),
        SizedBox(height: mqh(context, 20)),
        BuildLabelWithTextField(
            passwordTextEditingController: familyNameController,
            hint: 'Nom',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer votre nom de famille';
              }
              return '';
            },
            onChanged: (p0) {
              setState(() {
                familyNameController.text = p0!;
              });
              widget.representativeModelList![widget.index!].lastname = p0;
            },
            showSuffixIcon: false,
            label: 'Nom'),
        SizedBox(height: mqh(context, 20)),
        BuildTitleDropDown(
          onChange: (p0) {
            widget.representativeModelList![widget.index!].titleId = p0.id;
          },
        ),
        // BuildLabelWithTextField(
        //     passwordTextEditingController: titleController,
        //     hint: 'Titre',
        //     validator: (value) {
        //       if (value == null || value.isEmpty) {
        //         return 'Entrez votre titre';
        //       }
        //       return '';
        //     },
        //     onChanged: (p0) {
        //       setState(() {
        //         titleController.text = p0!;
        //       });
        //       print(titleController.text);
        //     },
        //     showSuffixIcon: false,
        //     label: 'Titre'),
        SizedBox(height: mqh(context, 20)),
        BuildIntlPhoneFieldWithLabel(
          textt: 'Téléphone 1',
          onChangephoneNumber: (p0) {
            setState(() {
              tel1Controller.text = p0.number;
              widget.representativeModelList![widget.index!].phone = p0.number;
            });
          },
        ),
        SizedBox(height: mqh(context, 5)),
        BuildLabelWithTextField(
            passwordTextEditingController: emailController,
            hint: 'Email',
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Entrer votre Email';
              }
              return '';
            },
            onChanged: (p0) {
              setState(() {
                emailController.text = p0!;
              });

              widget.representativeModelList![widget.index!].email = p0;
            },
            showSuffixIcon: false,
            label: 'Email'),
        // SizedBox(height: mqh(context, 247)),
        SizedBox(height: mqh(context, 20)),
        BuildLabelWithTextField(
            passwordTextEditingController: addressController,
            hint: 'Address',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Entrez votre adresse';
              }
              return '';
            },
            onChanged: (p0) {
              setState(() {
                addressController.text = p0!;
              });
              widget.representativeModelList![widget.index!].address = p0;
            },
            showSuffixIcon: false,
            label: 'Address'),
      ],
    );
  }
}
