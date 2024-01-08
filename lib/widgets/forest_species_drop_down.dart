import 'package:capef/global_cubits/get_offline_cubit/get_offline_cubit.dart';
import 'package:capef/models/offline_data_response.dart';
import 'package:capef/screens-cubits/forest-flow-screens/cubit/forest_cubit.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildForestSpeciesDropDown extends StatefulWidget {
  const BuildForestSpeciesDropDown(
      {super.key, required this.onChange, this.hint});
  final Function(Forestspecies)? onChange;
  final String? hint;

  @override
  State<BuildForestSpeciesDropDown> createState() =>
      _BuildForestSpeciesDropDownState();
}

class _BuildForestSpeciesDropDownState
    extends State<BuildForestSpeciesDropDown> {
  // List<Forestspecies> forestSpeciesList = [];
  Forestspecies? selectedValue;

  Forestspecies getSpeciesFromId({required int id}) {
    for (var ele in context
        .read<GetOfflineCubitCubit>()
        .getOfflineDataModel!
        .forestandwilddata!
        .forestspecies!) {
      if (ele.id == id) {
        return ele;
      }
    }
    return Forestspecies();
  }




  @override
  void initState() {
    if (context.read<ForestCubit>().forestsToBeEdited != null) {
      selectedValue = getSpeciesFromId(
          id: int.parse(context.read<ForestCubit>().forestsToBeEdited!.speciesid.toString()));
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
            'Espèces'.toUpperCase(),
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
          child: DropdownButton<Forestspecies>(
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down,
                color: GlobalColors.mainGreenColor),
            underline: const SizedBox(),
            value: null,
            hint: Text(
              selectedValue == null ? '— Choisir —' : selectedValue?.name ?? '',
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
                .getOfflineDataModel!
                .forestandwilddata!
                .forestspecies!
                .map((Forestspecies value) {
              return DropdownMenuItem<Forestspecies>(
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
