import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:flutter/material.dart';

class BuildForestBox extends StatelessWidget {
  const BuildForestBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 60),
      // width: mqw(context, 137),
      height: 30,
      decoration: BoxDecoration(
        color: GlobalColors.forestGreenColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(horizontal: mqw(context, 34)),
      child: Center(
        child: Text(
          'Forêts Et Faune'.toUpperCase(),
          style: const TextStyle(
              color: GlobalColors.forestGreenColor,
              fontFamily: GlobalFonts.montserratBold,
              fontSize: 12),
        ),
      ),
    );
  }
}
