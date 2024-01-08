import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/detailed-reports-screen/detailed_reports_screen.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/svg_builder.dart';
import 'package:flutter/material.dart';

class BuildCategoryReportComponent extends StatelessWidget {
  const BuildCategoryReportComponent({
    super.key,
    required this.color,
    required this.svgAsset,
    required this.title,
    required this.number,
    required this.numbercolor,
    required this.categoryId,
    required this.from,
    required this.to,
  });
  final Color color;
  final String svgAsset;
  final String title;
  final String number;
  final String from;
  final String to;
  final Color numbercolor;
  final int categoryId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(Routes.detailedReportsScreen,
            arguments: DetailedReportsScreen(
              title: title,
              categoryId: categoryId,
              from: from,
              to: to,
            ));
      },
      child: Card(
        elevation: 5,
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: mqw(context, 63),
                    height: mqh(context, 63),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100), color: color),
                    child: Center(
                      child: SvgBuilder(asset: svgAsset),
                    ),
                  ),
                  SizedBox(height: mqh(context, 15)),
                  Text(
                    title,
                    style: GlobalTextStyles.ts14montbold50OpaqueBlack,
                  ),
                  SizedBox(height: mqh(context, 5)),
                  Text(
                    number,
                    style: TextStyle(
                        color: numbercolor,
                        fontFamily: GlobalFonts.montserratBold,
                        fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
