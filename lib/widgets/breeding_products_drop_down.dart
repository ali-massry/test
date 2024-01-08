// ignore_for_file: avoid_print

import 'package:capef/global_cubits/get_offline_cubit/get_offline_cubit.dart';
import 'package:capef/models/offline_data_response.dart';
import 'package:capef/screens-cubits/breeding-flow-screens/cubit/breeding_cubit.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildBreedingLiveStockDropDown extends StatefulWidget {
  const BuildBreedingLiveStockDropDown(
      {super.key,
      required this.onChange,
      required this.index,
      required this.resetAllValues});
  final Function(Breedinglivestock)? onChange;
  final int? index;
  final bool? resetAllValues;

  @override
  State<BuildBreedingLiveStockDropDown> createState() =>
      _BuildBreedingLiveStockDropDownState();
}

class _BuildBreedingLiveStockDropDownState
    extends State<BuildBreedingLiveStockDropDown> {
  List<Breedinglivestock> breedingLiveStock = [];
  @override
  void initState() {
    print('RESETTT ${widget.resetAllValues}');
    if (context.read<BreedingCubit>().breedingToBeEdited != null) {
      if (widget.resetAllValues == true) {
        selectedValue = getBreedingLiveStockFromId();
      }
      print(selectedValue);
    }

    super.initState();
  }

  Breedinglivestock getBreedingLiveStockFromId() {
    for (var element in context
        .read<GetOfflineCubitCubit>()
        .getOfflineDataModel!
        .breedingdata!
        .breedinglivestock!) {
      if (element.id ==
          context
              .read<BreedingCubit>()
              .breedingToBeEdited!
              .breedingproducts![widget.index!]
              .livestockid) {
        return element;
      }
    }
    return Breedinglivestock();
  }

  Breedinglivestock? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: mqw(context, 15)),
          child: Text(
            'Produits d’élevage'.toUpperCase(),
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
          child: DropdownButton<Breedinglivestock>(
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
                // context.read<BreedingCubit>().selectedValue = p0;
              });
              widget.onChange!(p0!);
            },
            items: context
                .read<BreedingCubit>()
                .breedingLiveStockkk
                .map((Breedinglivestock value) {
              return DropdownMenuItem<Breedinglivestock>(
                value: value,
                child: Text(
                  value.name!,
                  style: GlobalTextStyles.ts13montsemiBoldBlack,
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
