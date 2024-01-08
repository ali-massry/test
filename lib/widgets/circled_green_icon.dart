import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:flutter/material.dart';

class BuildCircledGreenIcon extends StatelessWidget {
  const BuildCircledGreenIcon({
    super.key,
    this.widget,
  });
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: mqw(context, 37),
        height: mqh(context, 37),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: GlobalColors.mainGreenColor.withOpacity(0.1)),
        child: widget);
  }
}
