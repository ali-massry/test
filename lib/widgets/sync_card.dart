// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:capef/assets.dart';
import 'package:capef/global_cubits/is_online_cubit/is_online_cubit.dart';
import 'package:capef/models/legal_entity_info.dart';
import 'package:capef/models/user_info_model.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/functions.dart';
import 'package:capef/utils/svg_builder.dart';
import 'package:capef/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildSyncCard extends StatefulWidget {
  const BuildSyncCard({super.key, required this.details, required this.ontap});
  final String details;
  final VoidCallback ontap;

  @override
  State<BuildSyncCard> createState() => _BuildSyncCardState();
}

class _BuildSyncCardState extends State<BuildSyncCard> {
  UserInfo? userInfo;
  LegalEntityInfo? legalEntityInfo;
  // String villageCategory(
  //     {required int villageId, required int principalCategoryId}) {
  //   List<Villages>? villages = context
  //       .read<GetOfflineCubitCubit>()
  //       .getOfflineDataModel
  //       ?.villages
  //       ?.where((element) => element.villageid == villageId)
  //       .toList();
  //   List<Areas>? areas = context
  //       .read<GetOfflineCubitCubit>()
  //       .getOfflineDataModel
  //       ?.areas
  //       ?.where((element) => element.districtid == villages![0].areaid)
  //       .toList();
  //   List<Categories>? categories = context
  //       .read<GetOfflineCubitCubit>()
  //       .getOfflineDataModel
  //       ?.categories
  //       ?.where((element) => element.id == principalCategoryId)
  //       .toList();
  //   print(villages);

  //   return '${villages?[0].villagename} / ${areas?[0].areaname} / ${categories?[0].name}';
  // }

  Future<void> showSyncedModalBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      // elevation: mqh(context, 310),
      builder: (context) {
        return Container(
          height: mqh(context, 310),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: mqw(context, 83),
                  height: mqh(context, 83),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: GlobalColors.mainGreenColor.withOpacity(0.1)),
                  child: Center(
                    child: SvgBuilder(asset: Assets.icons.checkSvg),
                  ),
                ),
              ),
              SizedBox(height: mqh(context, 20)),
              Center(
                child: SizedBox(
                  width: mqw(context, 250),
                  child: const Text(
                    'Profil Du Ressortissant Est Synchronisé Avec Succès',
                    style: GlobalTextStyles.ts15montboldBlack,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: mqh(context, 40)),
              BuildButton(
                onTap: () {
                  Navigator.pop(context);
                },
                txt: 'OK',
              )
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    Map<String, dynamic> jsonMap = jsonDecode(widget.details);
    if (jsonMap.containsKey('photocniback')) {
      userInfo = UserInfo.fromJson(jsonMap);
      print(userInfo);
    } else {
      legalEntityInfo = LegalEntityInfo.fromJson(jsonMap);
      print(legalEntityInfo);
    }

    super.initState();
  }

  String extractLast10Characters(String input) {
    if (input.length >= 10) {
      return input.substring(input.length - 10);
    } else {
      // If the input string is less than 10 characters, return the entire string.
      return input;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: userInfo == null
                      ? Image.file(
                          File(legalEntityInfo?.photoRegistration?.path ?? ''),
                          height: mqh(context, 95),
                          width: mqw(context, 95),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const SizedBox();
                          },
                        )
                      : Image.file(
                          File(userInfo!.photomember?.path ?? ''),
                          height: mqh(context, 95),
                          width: mqw(context, 95),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const SizedBox();
                          },
                        ),
                ),
                SizedBox(width: mqw(context, 15)),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userInfo == null
                            ? '${legalEntityInfo?.name}'
                            : '${userInfo?.firstname} ${userInfo?.lastname}',
                        style: GlobalTextStyles.ts15montboldBlack,
                      ),
                      SizedBox(height: mqh(context, 5)),
                      SizedBox(
                        width: mqw(context, 200),
                        child: Text(
                          userInfo == null
                              ? villageCategory(context,
                                  villageId:
                                      int.parse(legalEntityInfo!.villageid!),
                                  principalCategoryId: int.parse(
                                      legalEntityInfo!.mainactivityid!))
                              : villageCategory(context,
                                  villageId: int.parse(userInfo!.villageid),
                                  principalCategoryId:
                                      int.parse(userInfo!.mainactivityid)),
                          style: TextStyle(
                              fontFamily: GlobalFonts.monserratSemiBold,
                              fontSize: 13,
                              color: Colors.black.withOpacity(0.4)),
                        ),
                      ),
                      SizedBox(height: mqh(context, 15)),
                      Text(
                        userInfo == null
                            ? 'Personne Morale'
                            : 'Personne Physique',
                        style: GlobalTextStyles.ts12montboldGreen,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        userInfo == null
                            ? 'ID ${legalEntityInfo?.offlineId}'
                            : 'ID ${userInfo?.offlineId}',
                        style: GlobalTextStyles.ts12montboldGreen,
                      ),
                      SizedBox(height: mqh(context, 5)),
                      Text(
                          userInfo == null
                              ? GlobalFunctions.timestampToDate(int.parse(
                                  extractLast10Characters(
                                      legalEntityInfo!.offlineId!)))
                              : GlobalFunctions.timestampToDate(int.parse(
                                  extractLast10Characters(
                                      userInfo!.offlineId))),
                          style: TextStyle(
                              fontFamily: GlobalFonts.montserratBold,
                              fontSize: 12,
                              color: Colors.black.withOpacity(0.5))),
                      SizedBox(height: mqh(context, 20)),
                      BlocBuilder<IsOnlineCubit, IsOnlineState>(
                        builder: (context, state) {
                          if (state is IsOnline) {
                            return SizedBox(
                              width: mqw(context, 180),
                              child: BuildButton(
                                onTap: widget.ontap,
                                height: mqh(context, 35),
                                txt: 'SYNCHRONISER',
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                      SizedBox(height: mqh(context, 10))
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
