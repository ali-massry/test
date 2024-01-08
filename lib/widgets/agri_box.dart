import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:flutter/material.dart';

class BuildAgriBox extends StatelessWidget {
  const BuildAgriBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 80),
      // width: mqw(context, 137),
      height: 30,
      decoration: BoxDecoration(
        color: GlobalColors.lightGreenColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(horizontal: mqw(context, 34)),
      child: Center(
        child: Text(
          'Agriculture'.toUpperCase(),
          style: const TextStyle(
              color: GlobalColors.lightGreenColor,
              fontFamily: GlobalFonts.montserratBold,
              fontSize: 12),
        ),
      ),
    );
  }
}
