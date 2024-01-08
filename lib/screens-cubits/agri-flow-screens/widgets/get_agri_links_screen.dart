// ignore_for_file: avoid_print

import 'package:capef/global_cubits/get_offline_cubit/get_offline_cubit.dart';
import 'package:capef/screens-cubits/agri-flow-screens/cubit/agri_cubit.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildGetAgriLinks extends StatefulWidget {
  const BuildGetAgriLinks({super.key});

  @override
  State<BuildGetAgriLinks> createState() => _BuildGetAgriLinksState();
}

class _BuildGetAgriLinksState extends State<BuildGetAgriLinks> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sélectionner une ou plusieurs options:',
          style: GlobalTextStyles.ts12montboldGreen,
        ),
        SizedBox(height: mqh(context, 20)),
        ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (context.read<AgriCubit>().integersList.contains(context
                      .read<GetOfflineCubitCubit>()
                      .getOfflineDataModel!
                      .agridata!
                      .links![index]
                      .id)) {
                    context.read<AgriCubit>().integersList.remove(context
                        .read<GetOfflineCubitCubit>()
                        .getOfflineDataModel!
                        .agridata!
                        .links![index]
                        .id);
                  } else {
                    context.read<AgriCubit>().integersList.add(context
                        .read<GetOfflineCubitCubit>()
                        .getOfflineDataModel!
                        .agridata!
                        .links![index]
                        .id!);
                  }

                  setState(() {});
                  print('Agri Links ${context.read<AgriCubit>().integersList}');
                },
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    context.read<AgriCubit>().integersList.contains(context
                            .read<GetOfflineCubitCubit>()
                            .getOfflineDataModel!
                            .agridata!
                            .links![index]
                            .id)
                        ? const Icon(Icons.check_box,
                            color: GlobalColors.mainGreenColor)
                        : const Icon(Icons.check_box_outline_blank_outlined,
                            color: GlobalColors.mainGreenColor),
                    const SizedBox(width: 12),
                    Text(
                      context
                              .read<GetOfflineCubitCubit>()
                              .getOfflineDataModel!
                              .agridata!
                              .links?[index]
                              .name ??
                          '',
                      style: GlobalTextStyles.ts13montsemiBoldBlack,
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: mqh(context, 15));
            },
            itemCount: context
                .read<GetOfflineCubitCubit>()
                .getOfflineDataModel!
                .agridata!
                .links!
                .length),
      ],
    );
  }
}
