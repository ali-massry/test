// ignore_for_file: avoid_print

import 'package:capef/models/detailed_member_model.dart';
import 'package:capef/models/offline_data_response.dart';
import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/physical-person-flow/step-1/personal_info.dart';
import 'package:capef/screens-cubits/physical-person-flow/step-2/physical_person_step_2_screen.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/snackbar.dart';
import 'package:capef/utils/validations.dart';
import 'package:capef/widgets/appbar.dart';
import 'package:capef/widgets/button.dart';
import 'package:capef/widgets/civilization_drop_down.dart';
import 'package:capef/widgets/easy_stepper.dart';
import 'package:capef/widgets/intl_phone_field.dart';
import 'package:capef/widgets/label_with_date_picker.dart';
import 'package:capef/widgets/label_with_textfield.dart';
import 'package:capef/widgets/material_status_drop_down.dart';
import 'package:capef/widgets/sex_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../../../global_cubits/get_offline_cubit/get_offline_cubit.dart';

class AddPhysicalPersonStep1Screen extends StatefulWidget {
  const AddPhysicalPersonStep1Screen(
      {super.key, required this.detailedMemberModel});
  final DetailedMemberModel? detailedMemberModel;

  @override
  State<AddPhysicalPersonStep1Screen> createState() =>
      _AddPhysicalPersonStep1ScreenState();
}

class _AddPhysicalPersonStep1ScreenState
    extends State<AddPhysicalPersonStep1Screen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController familyNameController = TextEditingController();
  TextEditingController placeOfBirthController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController opOfBelongingController = TextEditingController();
  TextEditingController cniNumberController = TextEditingController();
  TextEditingController tel1Controller = TextEditingController();
  TextEditingController tel2Controller = TextEditingController();
  Genders? genders;
  Civilities? civility;
  MaterialStatus? materialStatus;
  DateTime? dateTime;

  DateTime parseDate() {
    List<String> dateParts =
        widget.detailedMemberModel?.individualmember?.dob?.split('-') ?? [];
    int day = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int year = int.parse(dateParts[2]);

    return DateTime(year, month, day);
  }

  void renderExistingOnes() {
    nameController = TextEditingController(
        text: widget.detailedMemberModel?.individualmember?.firstname);
    familyNameController = TextEditingController(
        text: widget.detailedMemberModel?.individualmember?.lastname);
    placeOfBirthController = TextEditingController(
        text: widget.detailedMemberModel?.individualmember?.placeofbirth);
    emailController = TextEditingController(
        text: widget.detailedMemberModel?.individualmember?.email);
    opOfBelongingController = TextEditingController(
        text: widget.detailedMemberModel?.individualmember?.op);
    cniNumberController = TextEditingController(
        text: widget.detailedMemberModel?.individualmember?.cni);
    tel1Controller = TextEditingController(
        text: widget.detailedMemberModel?.individualmember?.telephone1);
    tel2Controller = TextEditingController(
        text: widget.detailedMemberModel?.individualmember?.telephone2);

    dateTime = parseDate();
    genders = getGenderFromId();
    civility = getCivilityFromId();
    materialStatus = getMaritalStatusFromId();
  }

  Civilities? getCivilityFromId() {
    for (var element in context
        .read<GetOfflineCubitCubit>()
        .getOfflineDataModel!
        .civilities!) {
      if (element.id ==
          widget.detailedMemberModel?.individualmember?.civilityid) {
        return element;
      }
    }
    return Civilities();
  }

  MaterialStatus? getMaritalStatusFromId() {
    for (var element in context
        .read<GetOfflineCubitCubit>()
        .getOfflineDataModel!
        .materialStatus!) {
      if (element.id ==
          widget.detailedMemberModel?.individualmember?.materialstatusid) {
        return element;
      }
    }
    return MaterialStatus();
  }

  Genders? getGenderFromId() {
    for (var element
        in context.read<GetOfflineCubitCubit>().getOfflineDataModel!.genders!) {
      if (element.id ==
          widget.detailedMemberModel?.individualmember?.genderid) {
        return element;
      }
    }
    return Genders();
  }

  @override
  void initState() {
    if (widget.detailedMemberModel != null) {
      renderExistingOnes();
    }
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    print(widget.detailedMemberModel?.toJson());
    return SafeArea(
        top: true,
        child: Scaffold(
          appBar: const BuildAppBar(title: 'Personne Physique'),
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
                        child:
                            const BuildEasyStepperWidget(length: 6, stepNow: 1),
                      ),
                      SizedBox(height: mqh(context, 40)),
                      const Text('Informations Personnelles',
                          style: GlobalTextStyles.ts20montboldGreen),
                      SizedBox(height: mqh(context, 40)),
                      BuildCivilizationDropDown(
                        onChange: (p0) {
                          civility = p0;
                          print(civility?.name);
                        },
                        detailedMemberModel: widget.detailedMemberModel,
                      ),
                      SizedBox(height: mqh(context, 20)),
                      BuildLabelWithTextField(
                          passwordTextEditingController: nameController,
                          hint: 'Prénom',
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Entrez votre prénom s\'il vous plait';
                          //   }
                          //   return '';
                          // },
                          onChanged: (p0) {
                            setState(() {
                              nameController.text = p0!;
                            });
                            print(nameController.text);
                          },
                          showSuffixIcon: false,
                          label: 'Prénom'),
                      SizedBox(height: mqh(context, 20)),
                      BuildLabelWithTextField(
                          passwordTextEditingController: familyNameController,
                          hint: 'Nom',
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Veuillez entrer votre nom de famille';
                          //   }
                          //   return '';
                          // },
                          onChanged: (p0) {
                            setState(() {
                              familyNameController.text = p0!;
                            });
                            print(familyNameController.text);
                          },
                          showSuffixIcon: false,
                          label: 'Nom'),
                      SizedBox(height: mqh(context, 20)),
                      BuildSexDropDown(
                        onChange: (p0) {
                          genders = p0;
                          print(p0.name);
                        },
                        detailedMemberModel: widget.detailedMemberModel,
                      ),
                      SizedBox(height: mqh(context, 20)),
                      BuildMaterialStatusDropDown(
                        onChange: (p0) {
                          materialStatus = p0;
                        },
                        detailedMemberModel: widget.detailedMemberModel,
                      ),
                      SizedBox(height: mqh(context, 20)),
                      BuildLabelWithDatePicker(
                        label: 'Date de naissance',
                        hint: widget.detailedMemberModel == null
                            ? ''
                            : parseDate().toString().substring(0, 10),
                        dateTime: DateTime(2010),
                        onDateSelected: (p0) {
                          dateTime = p0;
                          print(dateTime);
                        },
                      ),
                      SizedBox(height: mqh(context, 20)),
                      BuildLabelWithTextField(
                          passwordTextEditingController: placeOfBirthController,
                          hint: 'Lieu de naissance',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre lieu de naissance';
                            }
                            return '';
                          },
                          onChanged: (p0) {
                            setState(() {
                              placeOfBirthController.text = p0!;
                            });
                            print(placeOfBirthController.text);
                          },
                          showSuffixIcon: false,
                          label: 'Lieu de naissance'),
                      SizedBox(height: mqh(context, 20)),
                      BuildIntlPhoneFieldWithLabel(
                        textt: widget.detailedMemberModel != null
                            ? widget.detailedMemberModel?.individualmember
                                ?.telephone1
                            : 'Téléphone 1',
                        onChangephoneNumber: (p0) {
                          setState(() {
                            tel1Controller.text = p0.number;
                          });
                        },
                      ),
                      SizedBox(height: mqh(context, 5)),
                      BuildIntlPhoneFieldWithLabel(
                        textt: widget.detailedMemberModel != null
                            ? widget.detailedMemberModel?.individualmember
                                ?.telephone2
                            : 'Téléphone 2',
                        onChangephoneNumber: (p0) {
                          setState(() {
                            tel2Controller.text = p0.number;
                          });
                        },
                      ),
                      SizedBox(height: mqh(context, 5)),
                      BuildLabelWithTextField(
                          passwordTextEditingController: emailController,
                          keyboardType: TextInputType.emailAddress,
                          hint: 'Email',
                          validator: Validations.validateEmail,
                          onChanged: (p0) {
                            setState(() {
                              emailController.text = p0!;
                            });
                            print(emailController.text);
                          },
                          showSuffixIcon: false,
                          label: 'Email'),
                      SizedBox(height: mqh(context, 20)),
                      BuildLabelWithTextField(
                          passwordTextEditingController:
                              opOfBelongingController,
                          hint: 'OP D\'APPARTENANCE',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre OP d\'appartenance';
                            }
                            return '';
                          },
                          onChanged: (p0) {
                            setState(() {
                              opOfBelongingController.text = p0!;
                            });
                            print(opOfBelongingController.text);
                          },
                          showSuffixIcon: false,
                          label: 'OP D\'APPARTENANCE'),
                      SizedBox(height: mqh(context, 20)),
                      BuildLabelWithTextField(
                          passwordTextEditingController: cniNumberController,
                          keyboardType: TextInputType.text,
                          hint: 'numéro CNI',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez saisir votre numéro CNI';
                            }
                            return '';
                          },
                          onChanged: (p0) {
                            setState(() {
                              cniNumberController.text = p0!;
                            });
                            print(cniNumberController.text);
                          },
                          showSuffixIcon: false,
                          label: 'numéro CNI'),
                      SizedBox(height: mqh(context, 40)),
                      BuildButton(
                        onTap: () {
                          // ! REMOVE COMMENT DOWN THERE FOR VALIDATION
                          if (!(_formKey.currentState!.validate())) {
                            if (civility?.id == null ||
                                nameController.text == '' ||
                                familyNameController.text == '' ||
                                genders?.id == null ||
                                cniNumberController.text == '' ||
                                dateTime == null ||
                                emailController.text == '' ||
                                materialStatus?.id == null ||
                                opOfBelongingController.text == '' ||
                                tel1Controller.text == '' ||
                                tel2Controller.text == '' ||
                                placeOfBirthController.text == '') {
                              GlobalSnackbar.showFailureToast(context,
                                  'Assurez-vous De Remplir Toutes Les Informations');
                            } else {
                              Navigator.of(context).pushNamed(
                                  Routes.addPhysicalPersonScreen2,
                                  arguments: AddPhysicalPersonStep2Screen(
                                    addPhysicalMemberStep1Model:
                                        PersonalInformationModel(
                                            civilityId: civility?.id,
                                            fname: nameController.text,
                                            lname: familyNameController.text,
                                            genderId: genders?.id,
                                            cniNumber: cniNumberController.text,
                                            dateOfBirth: dateTime,
                                            email: emailController.text,
                                            maternalSituationId:
                                                materialStatus?.id,
                                            opOfBelonging:
                                                opOfBelongingController.text,
                                            phone1: tel1Controller.text,
                                            phone2: tel2Controller.text,
                                            placeOfBorth:
                                                placeOfBirthController.text),
                                    detailedMemberModel:
                                        widget.detailedMemberModel,
                                  ));
                            }
                          }
                        },
                        txt: 'suivant',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
