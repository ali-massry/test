import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:flutter/material.dart';

class BuildEasyStepperWidget extends StatelessWidget {
  const BuildEasyStepperWidget({
    super.key,
    this.length,
    this.stepNow,
  });
  final int? length;
  final int? stepNow;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      padding: EdgeInsets.only(left: length == 4 ? 15 : 10),
      child: ListView.builder(
        itemCount: length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (stepNow! == (index + 1)) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: mqw(context, 37),
                  height: mqh(context, 37),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                          color: GlobalColors.mainGreenColor, width: 2)),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                          fontSize: 15,
                          fontFamily: GlobalFonts.monserratSemiBold,
                          color: GlobalColors.mainGreenColor),
                    ),
                  ),
                ),
                (index == length! - 1)
                    ? const SizedBox()
                    : Container(
                        height: 2,
                        width: length == 4
                            ? 50
                            : length == 8
                                ? 5
                                : length == 5
                                    ? 36
                                    : length == 3
                                        ? 90
                                        : 20,
                        color: Colors.black.withOpacity(0.2)),
              ],
            );
          }
          if (stepNow! > (index + 1)) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: mqw(context, 37),
                  height: mqh(context, 37),
                  decoration: BoxDecoration(
                      color: GlobalColors.mainGreenColor,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                          color: GlobalColors.mainGreenColor, width: 0)),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                          fontSize: 15,
                          fontFamily: GlobalFonts.monserratSemiBold,
                          color: Colors.white),
                    ),
                  ),
                ),
                (index == length! - 1)
                    ? const SizedBox()
                    : Container(
                        height: 2,
                        width: length == 4
                            ? 50
                            : length == 8
                                ? 5
                                : length == 5
                                    ? 36
                                    : length == 3
                                        ? 90
                                        : 20,
                        color: GlobalColors.mainGreenColor),
              ],
            );
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: mqw(context, 37),
                height: mqh(context, 37),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                        color: Colors.black.withOpacity(0.2), width: 2)),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: GlobalFonts.monserratSemiBold,
                        color: Colors.black.withOpacity(0.2)),
                  ),
                ),
              ),
              (index == length! - 1)
                  ? const SizedBox()
                  : Container(
                      height: 2,
                      width: length == 4
                          ? 50
                          : length == 8
                              ? 5
                              : length == 5
                                  ? 36
                                  : length == 3
                                      ? 90
                                      : 20,
                      color: Colors.black.withOpacity(0.2)),
            ],
          );
        },
      ),
    );
  }
}
