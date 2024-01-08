import 'package:capef/assets.dart';
import 'package:capef/models/get_general_reports_model.dart';
import 'package:capef/screens-cubits/search-reports-screen/category_report_widget.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SearchReportsBody extends StatelessWidget {
  SearchReportsBody({
    super.key,
    required this.from,
    required this.to,
    required this.getGeneralReportsModel,
  });
  DateTime? from;
  DateTime? to;
  GetGeneralReportsModel? getGeneralReportsModel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: globalScreenPaddings,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: mqh(context, 40)),
            const Text(
              'Rapports',
              style: GlobalTextStyles.ts20montboldGreen,
            ),
            SizedBox(height: mqh(context, 5)),
            Text(
              '${from.toString().substring(0, 10).replaceAll('-', '/')} - ${to.toString().substring(0, 10).replaceAll('-', '/')}',
              style: GlobalTextStyles.ts20montboldGreen,
            ),
            SizedBox(height: mqh(context, 40)),
            Card(
              elevation: 5,
              child: Container(
                width: double.infinity,
                height: mqh(context, 100),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Ressortissants Enregistrés',
                          style: GlobalTextStyles.ts14montbold50OpaqueBlack,
                        ),
                        SizedBox(height: mqh(context, 10)),
                        Text(
                          getGeneralReportsModel?.totalcount.toString() ?? '',
                          style: GlobalTextStyles.ts25montboldGreen,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: mqh(context, 15)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BuildCategoryReportComponent(
                    color: GlobalColors.lightGreenColor.withOpacity(0.1),
                    title: 'Agriculture',
                    svgAsset: Assets.icons.agricultureSvg,
                    number: getGeneralReportsModel?.agricount.toString() ?? '',
                    categoryId: 1,
                    from: from.toString().substring(0, 10),
                    to: to.toString().substring(0, 10),
                    numbercolor: GlobalColors.lightGreenColor),
                BuildCategoryReportComponent(
                    color: GlobalColors.blueColor.withOpacity(0.1),
                    title: 'Pêche',
                    svgAsset: Assets.icons.pecheSvg,
                    from: from.toString().substring(0, 10),
                    to: to.toString().substring(0, 10),
                    categoryId: 2,
                    number:
                        getGeneralReportsModel?.fishingcount.toString() ?? '',
                    numbercolor: GlobalColors.blueColor),
              ],
            ),
            SizedBox(height: mqh(context, 15)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BuildCategoryReportComponent(
                    color: GlobalColors.purpleColor.withOpacity(0.1),
                    title: 'Élevage',
                    categoryId: 3,
                    from: from.toString().substring(0, 10),
                    to: to.toString().substring(0, 10),
                    svgAsset: Assets.icons.elevageSvg,
                    number:
                        getGeneralReportsModel?.breedingcount.toString() ?? '',
                    numbercolor: GlobalColors.purpleColor),
                BuildCategoryReportComponent(
                    color: GlobalColors.mainGreenColor.withOpacity(0.1),
                    title: 'Forêt et Faune',
                    svgAsset: Assets.icons.foretSvg,
                    from: from.toString().substring(0, 10),
                    to: to.toString().substring(0, 10),
                    categoryId: 4,
                    number:
                        getGeneralReportsModel?.forestscount.toString() ?? '',
                    numbercolor: GlobalColors.mainGreenColor),
              ],
            ),
            // GridView.builder(
            //   shrinkWrap: true,
            //   gridDelegate:
            //       SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            //   itemBuilder: (context, index) {
            //     return BuildCategoryReportComponent();
            //   },
            // )
          ],
        ),
      ),
    );
  }
}
