// ignore_for_file: avoid_print

import 'package:capef/global_cubits/get_security_questions_cubit/get_security_questions_cubit.dart';
import 'package:capef/models/get_security_questions.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildSecurityQuestionDropDownWidget extends StatefulWidget {
  const BuildSecurityQuestionDropDownWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BuildSecurityQuestionDropDownWidgetState createState() =>
      _BuildSecurityQuestionDropDownWidgetState();
}

class _BuildSecurityQuestionDropDownWidgetState
    extends State<BuildSecurityQuestionDropDownWidget> {
  String selectedValue = '';
  @override
  void initState() {
    context
        .read<GetSecurityQuestionsCubit>()
        .getSecurityQuestions(jwttoken: GlobalFunctions.getLocalJWTToken());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: mqw(context, 15)),
          child: Text(
            'Question de sécurité'.toUpperCase(),
            style: GlobalTextStyles.ts12ls1montboldGreen,
          ),
        ),
        SizedBox(height: mqh(context, 5)),
        BlocBuilder<GetSecurityQuestionsCubit, GetSecurityQuestionsState>(
          builder: (context, state) {
            if (state is GetSecurityQuestionsSuccess) {
              return Container(
                height: mqh(context, 50),
                width: mqw(context, 390),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(0.15)),
                    borderRadius: BorderRadius.circular(50)),
                child: DropdownButton<Securityqsts>(
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down,
                      color: GlobalColors.mainGreenColor),
                  underline: const SizedBox(),
                  value: null,
                  hint: Text(
                    selectedValue.isEmpty ? '— Choisir —' : selectedValue,
                    style: GlobalTextStyles.ts13montsemiBoldBlack,
                  ),
                  onChanged: (Securityqsts? newValue) {
                    setState(() {
                      context
                          .read<GetSecurityQuestionsCubit>()
                          .selectedQuestionId = newValue?.id;
                      selectedValue = newValue!.name!;
                    });
                    print(context
                        .read<GetSecurityQuestionsCubit>()
                        .selectedQuestionId);
                  },
                  items: state.getSecurityQuestions?.securityqsts
                      ?.map((Securityqsts value) {
                    return DropdownMenuItem<Securityqsts>(
                      value: value,
                      child: Text(
                        value.name!,
                        style: GlobalTextStyles.ts13montsemiBoldBlack,
                      ),
                    );
                  }).toList(),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}
