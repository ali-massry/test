import 'package:capef/global_cubits/get_offline_cubit/get_offline_cubit.dart';
import 'package:capef/models/offline_data_response.dart';
import 'package:capef/screens-cubits/forest-flow-screens/cubit/forest_cubit.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildForestProductsDropDown extends StatefulWidget {
  const BuildForestProductsDropDown({super.key, required this.onChange});
  final Function(Forestproducts)? onChange;

  @override
  State<BuildForestProductsDropDown> createState() =>
      _BuildForestProductsDropDownState();
}

class _BuildForestProductsDropDownState
    extends State<BuildForestProductsDropDown> {
  List<Forestproducts> forestProductsList = [];

  @override
  void initState() {
    if (context.read<ForestCubit>().forestsToBeEdited != null) {
      selectedValue = getFroestProducts();
    }
    super.initState();
  }


  Forestproducts getFroestProducts() {
    for (var elementt in context
        .read<GetOfflineCubitCubit>()
        .getOfflineDataModel!
        .forestandwilddata!
        .forestproducts!) {
      if (elementt.id ==
          context.read<ForestCubit>().forestsToBeEdited?.prodid) {
        return elementt;
      }
    }
    return Forestproducts();
  }  

  Forestproducts? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: mqw(context, 15)),
          child: Text(
            'Produits'.toUpperCase(),
            style: GlobalTextStyles.ts12ls1montboldGreen,
          ),
        ),
        SizedBox(height: mqh(context, 5)),
        BlocBuilder<ForestCubit, ForestState>(
          builder: (context, state) {
            if (state is UpdateForestProductsSuccess) {
              return Container(
                height: mqh(context, 50),
                width: mqw(context, 390),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(0.15)),
                    borderRadius: BorderRadius.circular(50)),
                child: DropdownButton<Forestproducts>(
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down,
                      color: GlobalColors.mainGreenColor),
                  underline: const SizedBox(),
                  value: null,
                  hint: Text(
                    selectedValue == null
                        ? '— Choisir —'
                        : selectedValue?.name ?? '',
                    // '— Choisir —',
                    style: GlobalTextStyles.ts13montsemiBoldBlack,
                  ),
                  onChanged: (p0) {
                    setState(() {
                      selectedValue = p0;
                    });
                    widget.onChange!(p0!);
                  },
                  items: state.forestproducts.map((Forestproducts value) {
                    return DropdownMenuItem<Forestproducts>(
                      value: value,
                      child: Text(
                        value.name!,
                        style: GlobalTextStyles.ts13montsemiBoldBlack,
                      ),
                    );
                  }).toList(),
                ),
              );
            }
            return Container(
              height: mqh(context, 50),
              width: mqw(context, 390),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black.withOpacity(0.15)),
                  borderRadius: BorderRadius.circular(50)),
              child: DropdownButton<Forestproducts>(
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down,
                    color: GlobalColors.mainGreenColor),
                underline: const SizedBox(),
                value: null,
                hint: Text(
                  selectedValue == null
                      ? '— Choisir —'
                      : selectedValue?.name ?? '',
                  // '— Choisir —',
                  style: GlobalTextStyles.ts13montsemiBoldBlack,
                ),
                onChanged: (p0) {
                  setState(() {
                    selectedValue = p0;
                  });
                  widget.onChange!(p0!);
                },
                items: forestProductsList.map((Forestproducts value) {
                  return DropdownMenuItem<Forestproducts>(
                    value: value,
                    child: Text(
                      value.name!,
                      style: GlobalTextStyles.ts13montsemiBoldBlack,
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ),
      ],
    );
  }
}
