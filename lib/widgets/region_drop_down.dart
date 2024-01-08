import 'package:capef/global_cubits/get_offline_cubit/get_offline_cubit.dart';
import 'package:capef/global_cubits/location_cubit/location_cubit.dart';
import 'package:capef/models/detailed_member_model.dart';
import 'package:capef/models/offline_data_response.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildRegionDropDown extends StatefulWidget {
  const BuildRegionDropDown(
      {super.key, required this.onChange, this.detailedMemberModel});
  final Function(Regions)? onChange;
  final DetailedMemberModel? detailedMemberModel;

  @override
  State<BuildRegionDropDown> createState() => _BuildRegionDropDownState();
}

class _BuildRegionDropDownState extends State<BuildRegionDropDown> {
  @override
  void initState() {
    if (widget.detailedMemberModel != null) {
      selectedValue = getRegionFromId();
    }
    super.initState();
  }

  Regions getRegionFromId() {
    for (var region
        in context.read<GetOfflineCubitCubit>().getOfflineDataModel!.regions!) {
      if (region.regionname == widget.detailedMemberModel?.region) {
        return region;
      }
    }
    return Regions();
  }

  Regions? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: mqw(context, 15)),
          child: Text(
            'Région'.toUpperCase(),
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
          child: DropdownButton<Regions>(
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down,
                color: GlobalColors.mainGreenColor),
            underline: const SizedBox(),
            value: null,
            hint: Text(
              selectedValue == null
                  ? '— Choisir —'
                  : selectedValue?.regionname ?? '',
              // '— Choisir —',
              style: GlobalTextStyles.ts13montsemiBoldBlack,
            ),
            onChanged: (p0) {
              setState(() {
                selectedValue = p0;
              });
              context.read<LocationCubit>().changeDistirctAccrodingToRegion(
                  districtslist: context
                      .read<GetOfflineCubitCubit>()
                      .getOfflineDataModel!
                      .districts!,
                  regionIdd: p0?.regionid ?? 0);

              widget.onChange!(p0!);
            },
            items: context
                .read<GetOfflineCubitCubit>()
                .getOfflineDataModel
                ?.regions!
                .map((Regions value) {
              return DropdownMenuItem<Regions>(
                value: value,
                child: Text(
                  value.regionname!,
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
