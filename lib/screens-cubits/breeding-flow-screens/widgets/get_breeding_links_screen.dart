// ignore_for_file: avoid_print

import 'package:capef/global_cubits/get_offline_cubit/get_offline_cubit.dart';
import 'package:capef/screens-cubits/breeding-flow-screens/cubit/breeding_cubit.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildGetBreedingLinks extends StatefulWidget {
  const BuildGetBreedingLinks({super.key});

  @override
  State<BuildGetBreedingLinks> createState() => _BuildGetBreedingLinksState();
}

class _BuildGetBreedingLinksState extends State<BuildGetBreedingLinks> {
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
                  if (context.read<BreedingCubit>().breedingLinks.contains(
                      context
                          .read<GetOfflineCubitCubit>()
                          .getOfflineDataModel!
                          .breedingdata!
                          .links![index])) {
                    context.read<BreedingCubit>().breedingLinks.remove(context
                        .read<GetOfflineCubitCubit>()
                        .getOfflineDataModel!
                        .breedingdata!
                        .links![index]);
                    context.read<BreedingCubit>().linkids.remove(context
                        .read<GetOfflineCubitCubit>()
                        .getOfflineDataModel!
                        .breedingdata!
                        .links![index]
                        .id!);
                  } else {
                    context.read<BreedingCubit>().breedingLinks.add(context
                        .read<GetOfflineCubitCubit>()
                        .getOfflineDataModel!
                        .breedingdata!
                        .links![index]);
                    context.read<BreedingCubit>().linkids.add(context
                        .read<GetOfflineCubitCubit>()
                        .getOfflineDataModel!
                        .breedingdata!
                        .links![index]
                        .id!);
                  }

                  setState(() {});
                  print(
                      'Fishing Links ${context.read<BreedingCubit>().breedingLinks}');
                },
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    context.read<BreedingCubit>().breedingLinks.contains(context
                            .read<GetOfflineCubitCubit>()
                            .getOfflineDataModel!
                            .breedingdata!
                            .links![index])
                        ? const Icon(Icons.check_box,
                            color: GlobalColors.mainGreenColor)
                        : const Icon(Icons.check_box_outline_blank_outlined,
                            color: GlobalColors.mainGreenColor),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        context
                                .read<GetOfflineCubitCubit>()
                                .getOfflineDataModel!
                                .breedingdata!
                                .links?[index]
                                .name ??
                            '',
                        style: GlobalTextStyles.ts13montsemiBoldBlack,
                      ),
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
                .breedingdata!
                .links!
                .length),
      ],
    );
  }
}
