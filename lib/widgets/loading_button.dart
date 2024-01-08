import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BuildLoadingButton extends StatelessWidget {
  BuildLoadingButton(
      {super.key,
      this.height,
      this.onTap,
      this.width,
      this.txt,
      this.txtStyle});
  final double? width;
  final double? height;
  final String? txt;
  final TextStyle? txtStyle;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: GlobalColors.mainGreenColor,
            borderRadius: BorderRadius.circular(80)),
        width: width ?? mqw(context, 390),
        height: height ?? mqh(context, 55),
        child:
            const Center(child: CircularProgressIndicator(color: Colors.white)),
      ),
    );
  }
}
