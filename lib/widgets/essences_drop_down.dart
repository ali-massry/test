// ignore_for_file: avoid_print

import 'package:capef/global_cubits/get_offline_cubit/get_offline_cubit.dart';
import 'package:capef/models/offline_data_response.dart';
import 'package:capef/screens-cubits/forest-flow-screens/cubit/forest_cubit.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildEssencesDropDown extends StatefulWidget {
  const BuildEssencesDropDown({super.key, required this.onChange});
  final Function(Forestessences)? onChange;

  @override
  State<BuildEssencesDropDown> createState() => _BuildEssencesDropDownState();
}

class _BuildEssencesDropDownState extends State<BuildEssencesDropDown> {
  List<Forestessences> forestEssencesList = [];
  Future<void> forestListAndGet() async {
    for (var ele in context
        .read<GetOfflineCubitCubit>()
        .getOfflineDataModel!
        .forestandwilddata!
        .forestessences!) {
      for (var element in ele.links!) {
        for (var id
            in context.read<ForestCubit>().constantLinkedIdsToBeSentToApi) {
          if (element.id == id) {
            if (!(forestEssencesList.contains(ele))) {
              forestEssencesList.add(ele);
            }
          }
        }
      }
    }

    print(forestEssencesList);
  }

  @override
  void initState() {
    if (context.read<ForestCubit>().forestsToBeEdited != null) {
      selectedValue = getFroestEssences();
    }
    forestListAndGet();
    super.initState();
  }

  Forestessences getFroestEssences() {
    for (var elementt in context
        .read<GetOfflineCubitCubit>()
        .getOfflineDataModel!
        .forestandwilddata!
        .forestessences!) {
      if (elementt.id ==
          context.read<ForestCubit>().forestsToBeEdited?.essenceid) {
        return elementt;
      }
    }
    return Forestessences();
  }  
 
  Forestessences? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: mqw(context, 15)),
          child: Text(
            'Essences'.toUpperCase(),
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
          child: DropdownButton<Forestessences>(
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
            items: forestEssencesList.map((Forestessences value) {
              return DropdownMenuItem<Forestessences>(
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
