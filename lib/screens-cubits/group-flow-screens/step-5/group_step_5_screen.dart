// ignore_for_file: avoid_print

import 'package:capef/models/offline_data_response.dart';
import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/group-flow-screens/cubit/group_flow_cubit.dart';
import 'package:capef/screens-cubits/physical-person-flow/step-4/step_4_model.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/snackbar.dart';
import 'package:capef/widgets/appbar.dart';
import 'package:capef/widgets/button.dart';
import 'package:capef/widgets/easy_stepper.dart';
import 'package:capef/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class AddGroupStep5Screen extends StatefulWidget {
  const AddGroupStep5Screen({super.key, this.addPhysicalMemberStep4Model});
  final PersonalInfoWithLocationInfoWithPrinciplesModel?
      addPhysicalMemberStep4Model;

  @override
  State<AddGroupStep5Screen> createState() => _AddGroupStep5ScreenState();
}

class _AddGroupStep5ScreenState extends State<AddGroupStep5Screen> {
  bool? accepted = false;
  TextEditingController insController = TextEditingController(text: '');

  TextEditingController constController = TextEditingController(text: '');
  List<Categories> categoriesNotSelected = [];
  Categories? categories;
  bool? showList = false;
  int? sum = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          appBar: const BuildAppBar(title: 'Inscription et Cotisation'),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
            child: BuildButton(
              onTap: () {
                if (accepted == false) {
                  GlobalSnackbar.showFailureToast(
                      context, 'Veuillez accepter le montant saisi');
                } else {
                  if (context.read<GroupFlowCubit>().seasonpayment!.length <
                      5) {
                    GlobalSnackbar.showFailureToast(context,
                        'le montant saisi est erroné');
                  } else if (context
                          .read<GroupFlowCubit>()
                          .subscriptionpayment!
                          .length <
                      4) {
                    GlobalSnackbar.showFailureToast(context,
                        'La COTISATION doit comporter au minimum 4 chiffres');
                  } else if (int.parse(
                          context.read<GroupFlowCubit>().seasonpayment!) >
                      int.parse('100000')) {
                    GlobalSnackbar.showFailureToast(context,
                        'L\'INSCRIPTION doit être inférieure à 100 000');
                  } else {
                    Navigator.of(context).pushNamed(Routes.addgroupScreen6);
                  }

                  // Navigator.of(context).pushNamed(
                  //   Routes.addPhysicalPersonScreen6,
                  //   arguments: AddPhysicalPersonStep6Screen(
                  //       addPhysicalMemberStep5Model:
                  //           PersonalInfoWithLocationInfoWithPrinciplesWithNumbersModel(
                  //               step4model: widget.addPhysicalMemberStep4Model,
                  //               inscription: int.parse(insController.text),
                  //               cotisation: int.parse(constController.text))),
                  // );
                }
              },
              txt: 'SUIVANT',
            ),
          ),
          body: KeyboardDismisser(
            child: Padding(
              padding: globalScreenPaddings,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: mqh(context, 30)),
                    const BuildEasyStepperWidget(length: 6, stepNow: 5),
                    SizedBox(height: mqh(context, 40)),
                    const Center(
                      child: Text('Inscription et Cotisation',
                          style: GlobalTextStyles.ts20montboldGreen),
                    ),
                    SizedBox(height: mqh(context, 40)),
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0.0),
                        child: Text(
                          'Veuillez marquer si le ressortissant a payé son inscription et sa cotisation',
                          style: GlobalTextStyles.ts13montsemiBoldBlack,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: mqh(context, 20)),
                    BuildSmallLabelWithTextField(
                        passwordTextEditingController: insController,
                        hint: 'XXXX',
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez saisir votre montant en FCFA';
                          }
                          return '';
                        },
                        onChanged: (p0) {
                          if (p0!.length <= 6) {
                            setState(() {
                              insController.text = p0;
                              if (constController.text == '') {
                                sum = int.parse(insController.text);
                              } else if (insController.text == '') {
                                sum = int.parse(constController.text);
                              } else {
                                sum = int.parse(insController.text) +
                                    int.parse(constController.text);
                              }
                            });
                            context.read<GroupFlowCubit>().seasonpayment = p0;
                            print(
                                'HERE IS RESULT ${int.parse(context.read<GroupFlowCubit>().seasonpayment!)}  ${int.parse(context.read<GroupFlowCubit>().seasonpayment!) > 100000}');
                          }
                        },
                        showSuffixIcon: false,
                        label: 'INSCRIPTION'),
                    SizedBox(height: mqh(context, 20)),
                    BuildSmallLabelWithTextField(
                        passwordTextEditingController: constController,
                        maxLength: 5,
                        hint: 'XXXX',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez saisir votre montant en FCFA';
                          }
                          return '';
                        },
                        onChanged: (p0) {
                          if (p0!.length <= 4) {
                            setState(() {
                              constController.text = p0;
                              if (constController.text == '') {
                                sum = int.parse(insController.text);
                              } else if (insController.text == '') {
                                sum = int.parse(constController.text);
                              } else {
                                sum = int.parse(insController.text) +
                                    int.parse(constController.text);
                              }
                            });
                            context.read<GroupFlowCubit>().subscriptionpayment =
                                p0;

                            print(context
                                .read<GroupFlowCubit>()
                                .subscriptionpayment);
                          }
                        },
                        showSuffixIcon: false,
                        label: 'COTISATION'),
                    SizedBox(height: mqh(context, 70)),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          accepted = !accepted!;

                          print(accepted);
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Transform.translate(
                            offset: const Offset(0, -9),
                            child: Icon(
                              accepted == false
                                  ? Icons.check_box_outline_blank
                                  : Icons.check_box,
                              color: GlobalColors.mainGreenColor,
                            ),
                          ),
                          SizedBox(width: mqw(context, 10)),
                          SizedBox(
                            width: mqw(context, 300),
                            child: Text(
                              'Je délcare avoir reçu le montant total de $sum FCFA',
                              style: GlobalTextStyles.ts13montsemiBoldBlack,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

// ignore: must_be_immutable
class BuildSmallLabelWithTextField extends StatefulWidget {
  const BuildSmallLabelWithTextField({
    super.key,
    required this.passwordTextEditingController,
    required this.hint,
    required this.label,
    this.showSuffixIcon,
    this.onChanged,
    this.keyboardType,
    this.prefixIcon,
    this.validator,
    required this.maxLength,
  });

  final TextEditingController? passwordTextEditingController;
  final String? label;
  final String? hint;
  final bool? showSuffixIcon;
  final Function(String?)? onChanged;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final String Function(String?)? validator;
  final int? maxLength;

  @override
  State<BuildSmallLabelWithTextField> createState() =>
      _BuildSmallLabelWithTextFieldState();
}

class _BuildSmallLabelWithTextFieldState
    extends State<BuildSmallLabelWithTextField> {
  bool? obscure = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: mqw(context, 15)),
          child: Text(
            widget.label!.toUpperCase(),
            style: GlobalTextStyles.ts12ls1montboldGreen,
          ),
        ),
        SizedBox(height: mqh(context, 5)),
        Row(
          children: [
            SizedBox(
              width: mqw(context, 230),
              child: CustomMainTextField(
                hintText: widget.hint,
                textEditingController: widget.passwordTextEditingController,
                obscureText: obscure,
                maxLength: widget.maxLength,
                suffixIcon: widget.showSuffixIcon == false
                    ? const SizedBox()
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            obscure = !obscure!;
                          });
                        },
                        child: Icon(
                          obscure! ? Icons.visibility_off : Icons.visibility,
                          color: GlobalColors.mainGreenColor,
                        ),
                      ),
                keyboardType: widget.keyboardType ?? TextInputType.name,
                onChanged: widget.onChanged,
                prefixIcon: widget.prefixIcon,
                validator: widget.validator,
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.done,
              ),
            ),
            SizedBox(width: mqw(context, 15)),
            const Text(
              'FCFA',
              style: GlobalTextStyles.ts13montsemiBoldBlack,
            )
          ],
        ),
      ],
    );
  }
}
