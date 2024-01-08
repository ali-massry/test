// ignore_for_file: avoid_print

import 'package:capef/global_cubits/get_offline_cubit/get_offline_cubit.dart';
import 'package:capef/screens-cubits/forest-flow-screens/cubit/forest_cubit.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildGetForestsLinks extends StatefulWidget {
  const BuildGetForestsLinks({super.key});

  @override
  State<BuildGetForestsLinks> createState() => _BuildGetForestsLinksState();
}

class _BuildGetForestsLinksState extends State<BuildGetForestsLinks> {
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
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (context.read<ForestCubit>().constantLinkedIdsToBeSentToApi.contains(
                      context
                          .read<GetOfflineCubitCubit>()
                          .getOfflineDataModel!
                          .forestandwilddata!
                          .links![index]
                          .id)) {
                    context.read<ForestCubit>().constantLinkedIdsToBeSentToApi.remove(context
                        .read<GetOfflineCubitCubit>()
                        .getOfflineDataModel!
                        .forestandwilddata!
                        .links![index]
                        .id!);
                    context.read<ForestCubit>().linkIds.remove(context
                        .read<GetOfflineCubitCubit>()
                        .getOfflineDataModel!
                        .forestandwilddata!
                        .links![index]
                        .id!);
                  } else {
                    context.read<ForestCubit>().constantLinkedIdsToBeSentToApi.add(context
                        .read<GetOfflineCubitCubit>()
                        .getOfflineDataModel!
                        .forestandwilddata!
                        .links![index]
                        .id!);
                    context.read<ForestCubit>().linkIds.add(context
                        .read<GetOfflineCubitCubit>()
                        .getOfflineDataModel!
                        .forestandwilddata!
                        .links![index]
                        .id!);
                  }

                  setState(() {});
                  print(
                      'Forest Links ${context.read<ForestCubit>().constantLinkedIdsToBeSentToApi}');
                  print(
                      'Forest Links ${context.read<ForestCubit>().linkIds}');
                },
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    context.read<ForestCubit>().constantLinkedIdsToBeSentToApi.contains(
                            context
                                .read<GetOfflineCubitCubit>()
                                .getOfflineDataModel!
                                .forestandwilddata!
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
                              .forestandwilddata!
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
                .forestandwilddata!
                .links!
                .length),
      ],
    );
  }
}
