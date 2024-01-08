// ignore_for_file: avoid_print

import 'package:capef/assets.dart';
import 'package:capef/global_cubits/is_online_cubit/is_online_cubit.dart';
import 'package:capef/global_cubits/logout_cubit/logout_cubit.dart';
import 'package:capef/hive/hive_boxes.dart';
import 'package:capef/routes/routes.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/functions.dart';
import 'package:capef/utils/snackbar.dart';
import 'package:capef/utils/svg_builder.dart';
import 'package:capef/widgets/button.dart';
import 'package:capef/widgets/demand_assistance.dart';
import 'package:capef/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    print(offlineIdGlobal(agentId: 5));
    return BlocConsumer<LogoutCubit, LogoutState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          Hive.box('offlineData').delete('agent');
          Navigator.of(context)
              .pushNamedAndRemoveUntil(Routes.loginScreen, (route) => false);
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const BuildLogoWidget(),
                SizedBox(height: mqh(context, 50)),
                Text('Bienvenue $agentNameLocall',
                    style: GlobalTextStyles.ts20montboldGreen),
                SizedBox(height: mqh(context, 21)),
                const BuildConnectivityWidget(),
                SizedBox(height: mqh(context, 60)),
                BuildButton(
                    onTap: () {
                      Navigator.of(context).pushNamed(Routes.addMemberScreen);
                    },
                    iconWithText: Padding(
                      padding: const EdgeInsets.only(left: 45.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgBuilder(asset: Assets.icons.personAddSvg),
                          SizedBox(width: mqw(context, 15)),
                          Text(
                            'Ajouter un Ressortissant'.toUpperCase(),
                            style: GlobalTextStyles.ts14montboldWhite,
                          )
                        ],
                      ),
                    )),
                SizedBox(height: mqh(context, 20)),
                BuildButton(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(Routes.nationalAreaScreen);
                    },
                    whiteColor: true,
                    iconWithText: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 45.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgBuilder(asset: Assets.icons.groupAddSvg),
                          SizedBox(width: mqw(context, 15)),
                          Text(
                            'Zone Ressortissants'.toUpperCase(),
                            style: GlobalTextStyles.ts14montboldGreen,
                          )
                        ],
                      ),
                    )),
                SizedBox(height: mqh(context, 20)),
                BuildButton(
                    onTap: () {
                      Navigator.of(context).pushNamed(Routes.reportsScreen);
                    },
                    whiteColor: true,
                    iconWithText: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 45.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgBuilder(asset: Assets.icons.reportsSvg),
                          SizedBox(width: mqw(context, 15)),
                          Text(
                            'Rapports'.toUpperCase(),
                            style: GlobalTextStyles.ts14montboldGreen,
                          ),
                        ],
                      ),
                    )),
                SizedBox(height: mqh(context, 40)),
                GestureDetector(
                  onTap: () {
                    var t = hiveBoxName(boxName: membersBox).get('members');
                    print('THE MEMBERS LOCALLY $t');
                    if (hiveBoxName(boxName: membersBox).get('members') ==
                            null ||
                        (hiveBoxName(boxName: membersBox).get('members')
                                as List)
                            .isEmpty) {
                      context.read<LogoutCubit>().logoutAgent(
                          jwtToken: GlobalFunctions.getLocalJWTToken());
                    } else {
                      print('THE MEMBERS LOCALLY $t');
                      Navigator.of(context)
                          .pushNamed(Routes.synchroniseNationalsScreen);
                      GlobalSnackbar.showFailureToast(context,
                          'Vous ne pouvez pas vous déconnecter avant de synchroniser les données');
                    }
                  },
                  child: Container(
                    color: Colors.transparent,
                    width: mqw(context, 150),
                    height: mqh(context, 40),
                    child: const Center(
                      child: Text(
                        'Se deconnecter',
                        style: GlobalTextStyles.underlinedViewAllTextButton,
                      ),
                    ),
                  ),
                )
              ],
            ),
            BuildDemandAssistanceWidget(),
          ],
        );
      },
    );
  }
}

class BuildConnectivityWidget extends StatelessWidget {
  const BuildConnectivityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IsOnlineCubit, IsOnlineState>(
      builder: (context, state) {
        if (state is IsOnline) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                    color: GlobalColors.mainGreenColor,
                    borderRadius: BorderRadius.circular(100)),
              ),
              const SizedBox(width: 5),
              const Text(
                'En ligne',
                style: GlobalTextStyles.ts12ls1montboldGreen,
              )
            ],
          );
        }
        if (state is IsOffline) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(100)),
              ),
              const SizedBox(width: 5),
              const Text(
                'Hors ligne',
                style: GlobalTextStyles.ts12ls1montboldGreen,
              )
            ],
          );
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(100)),
            ),
            const SizedBox(width: 5),
            const Text(
              'Hors ligne',
              style: GlobalTextStyles.ts12ls1montboldGreen,
            )
          ],
        );
      },
    );
  }
}
