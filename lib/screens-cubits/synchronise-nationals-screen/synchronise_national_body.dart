// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:capef/assets.dart';
import 'package:capef/global_cubits/physical_person_cubit/add_physical_person_cubit.dart';
import 'package:capef/hive/hive_boxes.dart';
import 'package:capef/models/legal_entity_info.dart';
import 'package:capef/models/user_info_model.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/snackbar.dart';
import 'package:capef/utils/svg_builder.dart';
import 'package:capef/utils/sync_function.dart';
import 'package:capef/widgets/button.dart';
import 'package:capef/widgets/sync_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SynchroniseNationalsBody extends StatefulWidget {
  const SynchroniseNationalsBody({super.key});

  @override
  State<SynchroniseNationalsBody> createState() =>
      _SynchroniseNationalsBodyState();
}

class _SynchroniseNationalsBodyState extends State<SynchroniseNationalsBody> {
  List<String> dynamicList = [];
  int? currentIndex;

  @override
  void initState() {
    print(generateTimestamp());
    dynamicList = hiveBoxName(boxName: membersBox).get('members') ?? [];
    print(dynamicList);
    super.initState();
  }

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

  bool? loadingButton = false;
  OverlayEntry overlay = OverlayEntry(builder: (BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: GlobalColors.mainGreenColor,
      ),
    );
  }
      // Your overlay configuration...
      );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddPhysicalPersonCubit, AddPhysicalPersonState>(
      listener: (context, state) {
        if (state is AddPhysicalPersonSucess) {
          // (hiveBoxName(boxName: membersBox).get('members') as List)
          //     .removeAt(currentIndex!);
          showSyncedModalBottomSheet(context);
        } else {
          GlobalSnackbar.showFailureToast(context, 'Something went wrong');
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'SYNCHRONISATION DES RESSORTISSANTS',
              style: GlobalTextStyles.ts20montboldGreen,
              textAlign: TextAlign.center,
            ),
            Expanded(
                child: dynamicList.isEmpty
                    ?  Center(
                        child: Text('No members to Sync'.toUpperCase(),
                            style: GlobalTextStyles.ts14montbold50OpaqueBlack),
                      )
                    : ListView.separated(
                        separatorBuilder: (context, index) {
                          return SizedBox(height: mqh(context, 15));
                        },
                        itemBuilder: (context, index) {
                          return BuildSyncCard(
                            details: dynamicList[index],
                            ontap: () async {
                              Map<String, dynamic> mapp =
                                  jsonDecode(dynamicList[index]);

                              Map<String, dynamic> jsonMap =
                                  jsonDecode(dynamicList[index]);

                              print(jsonMap);

                              if (jsonMap
                                  .containsKey('legalentitycategoryid')) {
                                LegalEntityInfo legalEntityInfo =
                                    LegalEntityInfo.fromJson(jsonMap);
                                print(legalEntityInfo.offlineId);
                                syncGlobalFunction(context,
                                    offlineId: legalEntityInfo.offlineId,
                                    legalEntityInfo: legalEntityInfo);
                              } else {
                                UserInfo userInfo = UserInfo.fromJson(jsonMap);
                                print(userInfo.offlineId);
                                syncGlobalFunction(context,
                                    offlineId: mapp['offlineId'],
                                    userInfo: userInfo);
                              }

                              setState(() {});
                            },
                          );
                        },
                        itemCount: dynamicList.length,
                      ))
          ],
        );
      },
    );
  }
}
