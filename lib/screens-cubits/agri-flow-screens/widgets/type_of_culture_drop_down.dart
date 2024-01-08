import 'package:capef/screens-cubits/agri-flow-screens/cubit/agri_cubit.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildTypeOfCultureDropDown extends StatefulWidget {
  const BuildTypeOfCultureDropDown({super.key, required this.onChange});
  final Function(String)? onChange;

  @override
  State<BuildTypeOfCultureDropDown> createState() =>
      _BuildTypeOfCultureDropDownState();
}

class _BuildTypeOfCultureDropDownState
    extends State<BuildTypeOfCultureDropDown> {
  List<String> typeOfCultureList = [
    'Pure',
    'Associée',
  ];

  @override
  void initState() {
    if (context.read<AgriCubit>().landOfIndex != null) {
      if (context.read<AgriCubit>().landOfIndex?.isshared == true) {
        selectedValue = typeOfCultureList[1];
        context.read<AgriCubit>().typeOfCulture = typeOfCultureList[1];
      } else {
        selectedValue = typeOfCultureList[0];
        context.read<AgriCubit>().typeOfCulture = typeOfCultureList[0];
      }
    }
    super.initState();
  }

  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: mqw(context, 15)),
          child: Text(
            'Type de Culture'.toUpperCase(),
            style: GlobalTextStyles.ts12ls1montboldGreen,
          ),
        ),
        SizedBox(height: mqh(context, 5)),
        Container(
          height: mqh(context, 50),
          width: mqw(context, 390),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black.withOpacity(0.15)),
              borderRadius: BorderRadius.circular(50)),
          child: DropdownButton<String>(
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down,
                color: GlobalColors.mainGreenColor),
            underline: const SizedBox(),
            value: null,
            hint: Text(
              selectedValue == null ? '— Choisir —' : selectedValue ?? '',
              // '— Choisir —',
              style: GlobalTextStyles.ts13montsemiBoldBlack,
            ),
            onChanged: (p0) {
              setState(() {
                selectedValue = p0;
              });
              widget.onChange!(p0!);
            },
            items: typeOfCultureList.map((String value) {
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
      ],
    );
  }
}
