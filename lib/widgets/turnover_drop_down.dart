import 'package:capef/global_cubits/get_offline_cubit/get_offline_cubit.dart';
import 'package:capef/models/detailed_member_model.dart';
import 'package:capef/models/offline_data_response.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildTurnoverDropDown extends StatefulWidget {
  const BuildTurnoverDropDown(
      {super.key, required this.onChange, required this.detailedMemberModel});
  final Function(Turnovers)? onChange;
  final DetailedMemberModel? detailedMemberModel;

  @override
  State<BuildTurnoverDropDown> createState() => _BuildTurnoverDropDownState();
}

class _BuildTurnoverDropDownState extends State<BuildTurnoverDropDown> {
  @override
  void initState() {
    selectedValue = getTurnover();
    super.initState();
  }

  Turnovers getTurnover() {
    for (var elemnt in context
        .read<GetOfflineCubitCubit>()
        .getOfflineDataModel!
        .turnovers!) {
      if (elemnt.id ==
          widget.detailedMemberModel?.legalentitymember?.turnoverid) {
        return elemnt;
      }
    }
    return Turnovers();
  }

  Turnovers? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: mqw(context, 15)),
          child: Text(
            'Chiffre D’Affaires'.toUpperCase(),
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
          child: DropdownButton<Turnovers>(
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
                ?.turnovers!
                .map((Turnovers value) {
              return DropdownMenuItem<Turnovers>(
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
