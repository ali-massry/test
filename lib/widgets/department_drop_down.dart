import 'package:capef/global_cubits/get_offline_cubit/get_offline_cubit.dart';
import 'package:capef/global_cubits/location_cubit/location_cubit.dart';
import 'package:capef/models/detailed_member_model.dart';
import 'package:capef/models/offline_data_response.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildDepartmentDropDown extends StatefulWidget {
  const BuildDepartmentDropDown({super.key, required this.onChange, this.detailedMemberModel});
  final Function(Districts)? onChange;
  final DetailedMemberModel? detailedMemberModel;


  @override
  State<BuildDepartmentDropDown> createState() =>
      _BuildDepartmentDropDownState();
}

class _BuildDepartmentDropDownState extends State<BuildDepartmentDropDown> {
 
 
  @override
  void initState() {
    if (widget.detailedMemberModel != null) {
      selectedValue = getDistrictFromId();
    }
    super.initState();
  }

  Districts getDistrictFromId() {
    for (var district
        in context.read<GetOfflineCubitCubit>().getOfflineDataModel!.districts!) {
      if (district.districtname == widget.detailedMemberModel?.district) {
        return district;
      }
    }
    return Districts();
  }


  Districts? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: mqw(context, 15)),
          child: Text(
            'Département'.toUpperCase(),
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
              child: DropdownButton<Districts>(
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down,
                    color: GlobalColors.mainGreenColor),
                underline: const SizedBox(),
                value: null,
                hint: Text(
                  selectedValue == null
                      ? '— Choisir —'
                      : selectedValue?.districtname ?? '',
                  // '— Choisir —',
                  style: GlobalTextStyles.ts13montsemiBoldBlack,
                ),
                onChanged: (p0) {
                  setState(() {
                    selectedValue = p0;
                  });

                  context.read<LocationCubit>().changeAreaAccrodingToDistrict(
                      areaslist: context
                          .read<GetOfflineCubitCubit>()
                          .getOfflineDataModel!
                          .areas!,
                      districtId: p0?.districtid ?? 0);
                  widget.onChange!(p0!);
                },
                items: (state is LocationSuccess)
                    ? state.districtList?.map((Districts value) {
                        return DropdownMenuItem<Districts>(
                          value: value,
                          child: Text(
                            value.districtname!,
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
