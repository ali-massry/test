import 'package:capef/global_cubits/get_offline_cubit/get_offline_cubit.dart';
import 'package:capef/global_cubits/location_cubit/location_cubit.dart';
import 'package:capef/models/detailed_member_model.dart';
import 'package:capef/models/offline_data_response.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildAreasDropDown extends StatefulWidget {
  const BuildAreasDropDown({
    super.key,
    required this.onChange,
    this.detailedMemberModel,
  });
  final Function(Areas)? onChange;
  final DetailedMemberModel? detailedMemberModel;

  @override
  State<BuildAreasDropDown> createState() => _BuildAreasDropDownState();
}

class _BuildAreasDropDownState extends State<BuildAreasDropDown> {
  @override
  void initState() {
    if (widget.detailedMemberModel != null) {
      selectedValue = getAreaFromId();
    }
    super.initState();
  }

  Areas getAreaFromId() {
    for (var area
        in context.read<GetOfflineCubitCubit>().getOfflineDataModel!.areas!) {
      if (area.areaname == widget.detailedMemberModel?.area) {
        return area;
      }
    }
    return Areas();
  }

  Areas? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: mqw(context, 15)),
          child: Text(
            'Arrondissement'.toUpperCase(),
            style: GlobalTextStyles.ts12ls1montboldGreen,
          ),
        ),
        SizedBox(height: mqh(context, 5)),
        BlocBuilder<LocationCubit, LocationState>(
          builder: (context, state) {
            return Container(
              height: mqh(context, 50),
              width: mqw(context, 390),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black.withOpacity(0.15)),
                  borderRadius: BorderRadius.circular(50)),
              child: DropdownButton<Areas>(
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down,
                    color: GlobalColors.mainGreenColor),
                underline: const SizedBox(),
                value: null,
                hint: Text(
                  selectedValue == null
                      ? '— Choisir —'
                      : selectedValue?.areaname ?? '',
                  // '— Choisir —',
                  style: GlobalTextStyles.ts13montsemiBoldBlack,
                ),
                onChanged: (p0) {
                  setState(() {
                    selectedValue = p0;
                  });
                  context.read<LocationCubit>().changeVillageAccrodingToArea(
                      villageslist: context
                          .read<GetOfflineCubitCubit>()
                          .getOfflineDataModel!
                          .villages!,
                      areaId: p0?.areaid ?? 0);
                  widget.onChange!(p0!);
                },
                items: (state is LocationSuccess)
                    ? state.areasList?.map((Areas value) {
                        return DropdownMenuItem<Areas>(
                          value: value,
                          child: Text(
                            value.areaname!,
                            style: GlobalTextStyles.ts13montsemiBoldBlack,
                          ),
                        );
                      }).toList()
                    : [],
              ),
            );
          },
        ),
      ],
    );
  }
}
