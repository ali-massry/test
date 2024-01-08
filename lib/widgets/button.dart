import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BuildButton extends StatelessWidget {
  BuildButton(
      {super.key,
      this.height,
      this.onTap,
      this.width,
      this.txt,
      this.iconWithText,
      this.whiteColor,
      this.txtStyle});
  final double? width;
  final double? height;
  final String? txt;
  final TextStyle? txtStyle;
  VoidCallback? onTap;
  final Widget? iconWithText;
  final bool? whiteColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color:
                whiteColor == true ? Colors.white : GlobalColors.mainGreenColor,
            borderRadius: BorderRadius.circular(80),
            border: Border.all(color: GlobalColors.mainGreenColor)),
        width: width ?? mqw(context, 390),
        height: height ?? mqh(context, 55),
        child: Center(
            child: iconWithText ??
                Text(txt?.toUpperCase() ?? '',
                    style: txtStyle ?? GlobalTextStyles.buttonStyle)),
      ),
    );
  }
}
