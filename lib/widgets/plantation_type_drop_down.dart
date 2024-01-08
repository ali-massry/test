import 'package:capef/global_cubits/get_offline_cubit/get_offline_cubit.dart';
import 'package:capef/models/offline_data_response.dart';
import 'package:capef/screens-cubits/forest-flow-screens/cubit/forest_cubit.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildPlantationTypeDropDown extends StatefulWidget {
  const BuildPlantationTypeDropDown({super.key, required this.onChange});
  final Function(Plantationtype)? onChange;

  @override
  State<BuildPlantationTypeDropDown> createState() =>
      _BuildPlantationTypeDropDownState();
}

class _BuildPlantationTypeDropDownState
    extends State<BuildPlantationTypeDropDown> {
  @override
  void initState() {
    if (context.read<ForestCubit>().forestsToBeEdited != null) {
      selectedValue = getPalntationTypeFromId();
    }
    super.initState();
  }

  Plantationtype getPalntationTypeFromId() {
    for (var element in context
        .read<GetOfflineCubitCubit>()
        .getOfflineDataModel!
        .plantationtype!) {
      if (element.id ==
          context.read<ForestCubit>().forestsToBeEdited?.plantationtypeid) {
        return element;
      }
    }
    return Plantationtype();
  }

  Plantationtype? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: mqw(context, 15)),
          child: Text(
            'Type de Plantation'.toUpperCase(),
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
          child: DropdownButton<Plantationtype>(
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
                ?.plantationtype!
                .map((Plantationtype value) {
              return DropdownMenuItem<Plantationtype>(
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
