// ignore_for_file: avoid_print

import 'package:capef/global_cubits/get_offline_cubit/get_offline_cubit.dart';
import 'package:capef/screens-cubits/fishing-flow-screens/cubit/fishing_cubit.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildGetFishingLinks extends StatefulWidget {
  const BuildGetFishingLinks({super.key});

  @override
  State<BuildGetFishingLinks> createState() => _BuildGetFishingLinksState();
}

class _BuildGetFishingLinksState extends State<BuildGetFishingLinks> {
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
                  if (context.read<FishingCubit>().fishingLinks.contains(context
                      .read<GetOfflineCubitCubit>()
                      .getOfflineDataModel!
                      .fishingdata!
                      .links![index])) {
                    context.read<FishingCubit>().fishingLinks.remove(context
                        .read<GetOfflineCubitCubit>()
                        .getOfflineDataModel!
                        .fishingdata!
                        .links![index]);
                    context.read<FishingCubit>().linkids.remove(context
                        .read<GetOfflineCubitCubit>()
                        .getOfflineDataModel!
                        .fishingdata!
                        .links![index]
                        .id!);
                  } else {
                    context.read<FishingCubit>().fishingLinks.add(context
                        .read<GetOfflineCubitCubit>()
                        .getOfflineDataModel!
                        .fishingdata!
                        .links![index]);
                    context.read<FishingCubit>().linkids.add(context
                        .read<GetOfflineCubitCubit>()
                        .getOfflineDataModel!
                        .fishingdata!
                        .links![index]
                        .id!);
                  }

                  setState(() {});
                  print(
                      'Fishing Links ${context.read<FishingCubit>().fishingLinks}');
                },
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    context.read<FishingCubit>().fishingLinks.contains(context
                            .read<GetOfflineCubitCubit>()
                            .getOfflineDataModel!
                            .fishingdata!
                            .links![index])
                        ? const Icon(Icons.check_box,
                            color: GlobalColors.mainGreenColor)
                        : const Icon(Icons.check_box_outline_blank_outlined,
                            color: GlobalColors.mainGreenColor),
                    const SizedBox(width: 12),
                    Text(
                      context
                              .read<GetOfflineCubitCubit>()
                              .getOfflineDataModel!
                              .fishingdata!
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
            itemCount: 
            context
                .read<GetOfflineCubitCubit>()
                .getOfflineDataModel!
                .fishingdata!
                .links!
                .length
                ),
      ],
    );
  }
}
