import 'package:capef/global_cubits/localization_cubit/localization_cubit.dart';
import 'package:capef/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildLanguageDropDownWidget extends StatefulWidget {
  const BuildLanguageDropDownWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BuildLanguageDropDownWidgetState createState() =>
      _BuildLanguageDropDownWidgetState();
}

class _BuildLanguageDropDownWidgetState
    extends State<BuildLanguageDropDownWidget> {
  String selectedValue = '';
  final List<String> languagesList = [
    'English',
    'Français',
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: mqh(context, 50),
        width: mqw(context, 390),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black.withOpacity(0.15)),
            borderRadius: BorderRadius.circular(50)),
        child: DropdownButton<String>(
          isExpanded: true,
          underline: const SizedBox(),
          value: null,
          hint: Text(
            selectedValue.isEmpty ? 'Choisir' : selectedValue,
            style: GlobalTextStyles.ts13montsemiBoldBlack,
          ),
          onChanged: (String? newValue) {
            setState(() {
              if (newValue == 'English') {
                context.read<LocalizationCubit>().changeLocale('en');
              } else {
                context.read<LocalizationCubit>().changeLocale('fr');
              }
              selectedValue = newValue!;
            });
          },
          items: languagesList.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: GlobalTextStyles.ts13montsemiBoldBlack,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
