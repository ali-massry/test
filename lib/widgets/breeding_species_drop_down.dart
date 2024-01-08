// ignore_for_file: avoid_print

import 'package:capef/global_cubits/get_offline_cubit/get_offline_cubit.dart';
import 'package:capef/models/offline_data_response.dart';
import 'package:capef/screens-cubits/breeding-flow-screens/cubit/breeding_cubit.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildBreedingSpeciesDropDown extends StatefulWidget {
  const BuildBreedingSpeciesDropDown(
      {super.key, required this.onChange, required this.resetAllValues});
  final Function(Breedingspecies)? onChange;
  final bool? resetAllValues;

  @override
  State<BuildBreedingSpeciesDropDown> createState() =>
      _BuildBreedingSpeciesDropDownState();
}

class _BuildBreedingSpeciesDropDownState
    extends State<BuildBreedingSpeciesDropDown> {
  List<Breedingspecies> breedingSpeciesList = [];

  @override
  void initState() {
    print(widget.resetAllValues);
    if (context.read<BreedingCubit>().breedingToBeEdited != null) {
      if (widget.resetAllValues == true) {
        selectedValue = breedingSpeciesFromId(
            context.read<BreedingCubit>().breedingToBeEdited?.speciesid);
      }
    }
    filterBreedingSpecies();
    super.initState();
  }

  Future<void> filterBreedingSpecies() async {
    for (var breedingSpecies in context
        .read<GetOfflineCubitCubit>()
        .getOfflineDataModel!
        .breedingdata!
        .breedingspecies!) {
      if (breedingSpecies.breedingtypeid ==
          context.read<BreedingCubit>().breedingTypeId) {
        breedingSpeciesList.add(breedingSpecies);
      }
    }
  }

  Breedingspecies? breedingSpeciesFromId(int? id) {
    for (var breedingSpecies in context
        .read<GetOfflineCubitCubit>()
        .getOfflineDataModel!
        .breedingdata!
        .breedingspecies!) {
      if (breedingSpecies.id == id) {
        return breedingSpecies;
      }
    }
    return Breedingspecies();
  }

  Breedingspecies? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: mqw(context, 15)),
          child: Text(
            'Espèce Élevée'.toUpperCase(),
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
          child: DropdownButton<Breedingspecies>(
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
            items: breedingSpeciesList.map((Breedingspecies value) {
              return DropdownMenuItem<Breedingspecies>(
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
