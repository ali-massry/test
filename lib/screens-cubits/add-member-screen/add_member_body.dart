import 'package:capef/assets.dart';
import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/group-flow-screens/step-1/group_step_1_screen.dart';
import 'package:capef/screens-cubits/physical-person-flow/step-1/physical_person_step_1_screen.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/svg_builder.dart';
import 'package:flutter/material.dart';

class AddMemberBody extends StatefulWidget {
  const AddMemberBody({super.key});

  @override
  State<AddMemberBody> createState() => _AddMemberBodyState();
}

class _AddMemberBodyState extends State<AddMemberBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: globalScreenPaddings,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: mqh(context, 40)),
          Center(
            child: SizedBox(
              width: mqw(context, 320),
              child: const Text(
                  'Veuillez sélectionner le type de Ressortissant',
                  style: GlobalTextStyles.ts20montboldGreen,
                  textAlign: TextAlign.center),
            ),
          ),
          SizedBox(height: mqh(context, 40)),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(Routes.addPhysicalPersonScreen1,
                  arguments: const AddPhysicalPersonStep1Screen(
                      detailedMemberModel: null));
            },
            child: Card(
              elevation: 5,
              surfaceTintColor: Colors.transparent,
              child: Container(
                height: mqh(context, 60),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 28.0),
                  child: Row(
                    children: [
                      SvgBuilder(asset: Assets.icons.personSvg),
                      SizedBox(width: mqw(context, 25)),
                      const Text(
                        'Personne Physique',
                        style: GlobalTextStyles.ts15montboldBlack,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: mqh(context, 20)),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(Routes.addgroupScreen1,
                  arguments:
                      const AddGroupStep1Screen(detailedMemberModel: null));
            },
            child: Card(
              elevation: 5,
              surfaceTintColor: Colors.transparent,
              child: Container(
                height: mqh(context, 60),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 28.0),
                  child: Row(
                    children: [
                      SvgBuilder(asset: Assets.icons.groupSvg),
                      SizedBox(width: mqw(context, 13)),
                      const Text(
                        'Personne Morale',
                        style: GlobalTextStyles.ts15montboldBlack,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
