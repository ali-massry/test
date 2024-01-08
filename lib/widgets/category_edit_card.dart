import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:flutter/material.dart';

class BuildCategoryEditCard extends StatelessWidget {
  const BuildCategoryEditCard({
    super.key,
    required this.title,
    this.columnWidget,
    // required this.ontap,
  });
  final String? title;
  final Widget? columnWidget;
  // final VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        height: columnWidget != null ? mqh(context, 163) : mqh(context, 70),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                columnWidget ??
                    Text(title ?? '',
                        style: GlobalTextStyles.ts15montboldBlack),
                Center(
                  child: Container(
                    width: mqw(context, 37),
                    height: mqh(context, 37),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: GlobalColors.mainGreenColor.withOpacity(0.1)),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: GlobalColors.mainGreenColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: GlobalColors.mainGreenColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: GlobalColors.mainGreenColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ],
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
