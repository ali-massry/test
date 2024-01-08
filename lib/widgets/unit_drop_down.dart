// ignore_for_file: avoid_print

import 'package:capef/global_cubits/get_offline_cubit/get_offline_cubit.dart';
import 'package:capef/models/offline_data_response.dart';
import 'package:capef/screens-cubits/breeding-flow-screens/cubit/breeding_cubit.dart';
import 'package:capef/screens-cubits/fishing-flow-screens/cubit/fishing_cubit.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildUnitsDropDown extends StatefulWidget {
  const BuildUnitsDropDown(
      {super.key,
      required this.onChange,
      this.hint,
      this.index,
      this.resetAllValuesInBreeding});
  final Function(Units)? onChange;
  final String? hint;
  final int? index;
  final bool? resetAllValuesInBreeding;

  @override
  State<BuildUnitsDropDown> createState() => _BuildUnitsDropDownState();
}

class _BuildUnitsDropDownState extends State<BuildUnitsDropDown> {
  Units? selectedValue;

  Units getUnitFromId({required int id}) {
    for (var ele
        in context.read<GetOfflineCubitCubit>().getOfflineDataModel!.units!) {
      if (ele.id == id) {
        return ele;
      }
    }
    return Units();
  }

  @override
  void initState() {
    print('RESETTT ${widget.resetAllValuesInBreeding}');

    if (context.read<FishingCubit>().fishingsToBeEdited != null) {
      selectedValue = getUnitFromId(
          id: context.read<FishingCubit>().fishingsToBeEdited!.unitid!);
    }
    if (context.read<BreedingCubit>().breedingToBeEdited != null) {
      if (widget.resetAllValuesInBreeding == true) {
        selectedValue = getUnitFromId(
            id: context
                .read<BreedingCubit>()
                .breedingToBeEdited!
                .breedingproducts![widget.index!]
                .unitid!);
      }
    }

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
            'Production Annuelle'.toUpperCase(),
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
          child: DropdownButton<Units>(
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down,
                color: GlobalColors.mainGreenColor),
            underline: const SizedBox(),
            value: null,
            hint: Text(
              selectedValue == null
                  ? '— Choisir unité de mesure —'
                  : selectedValue?.name ?? '',
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
                ?.units!
                .map((Units value) {
              return DropdownMenuItem<Units>(
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
