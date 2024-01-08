import 'package:capef/assets.dart';
import 'package:capef/routes/routes.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/svg_builder.dart';
import 'package:capef/widgets/demand_assistance.dart';
import 'package:flutter/material.dart';

class NationalAreaBody extends StatelessWidget {
  const NationalAreaBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            SizedBox(height: mqh(context, 40)),
            const Text('Zone Ressortissants',
                style: GlobalTextStyles.ts20montboldGreen),
            SizedBox(height: mqh(context, 40)),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(Routes.synchroniseNationalsScreen);
              },
              child: Card(
                elevation: 5,
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
                        SvgBuilder(asset: Assets.icons.syncSvg),
                        SizedBox(width: mqw(context, 25)),
                        const Text(
                          'SYNCHRONISER LES RESSORTISSANTS',
                          style: GlobalTextStyles.ts11montboldBlack,
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
                Navigator.of(context).pushNamed(Routes.manageNationalsScreen);
              },
              child: Card(
                elevation: 5,
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
                        SvgBuilder(asset: Assets.icons.settingsSvg),
                        SizedBox(width: mqw(context, 25)),
                        const Text(
                          'GÉRER LES RESSORTISSANTS',
                          style: GlobalTextStyles.ts11montboldBlack,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        BuildDemandAssistanceWidget()
      ],
    );
  }
}
