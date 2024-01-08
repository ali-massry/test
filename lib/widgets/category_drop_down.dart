import 'package:capef/global_cubits/get_offline_cubit/get_offline_cubit.dart';
import 'package:capef/models/offline_data_response.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildCategoryDropDown extends StatefulWidget {
  const BuildCategoryDropDown({super.key, required this.onChange});
  final Function(Categories)? onChange;

  @override
  State<BuildCategoryDropDown> createState() => _BuildCategoryDropDownState();
}

class _BuildCategoryDropDownState extends State<BuildCategoryDropDown> {
  Categories? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: mqw(context, 15)),
          child: Text(
            'Activité Principale'.toUpperCase(),
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
          child: DropdownButton<Categories>(
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down,
                color: GlobalColors.mainGreenColor),
            underline: const SizedBox(),
            value: null,
            hint: Text(
              selectedValue == null ? '— Choisir —' : selectedValue?.name ?? '',
              // '— Choisir —',
              style: GlobalTextStyles.ts13montsemiBoldBlack,
            ),
            onChanged: (p0) {
              setState(() {
                selectedValue = p0;
              });
              widget.onChange!(p0!);
            },
            items: context
                .read<GetOfflineCubitCubit>()
                .getOfflineDataModel
                ?.categories!
                .map((Categories value) {
              return DropdownMenuItem<Categories>(
                value: value,
                child: Text(
                  value.name!,
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
