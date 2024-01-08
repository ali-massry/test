import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:flutter/material.dart';

class BuildBreedingBox extends StatelessWidget {
  const BuildBreedingBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 80),
      // width: mqw(context, 137),
      height: 30,
      decoration: BoxDecoration(
        color: GlobalColors.purpleColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(horizontal: mqw(context, 34)),
      child: Center(
        child: Text(
          'Éleveurs'.toUpperCase(),
          style: const TextStyle(
              color: GlobalColors.purpleColor,
              fontFamily: GlobalFonts.montserratBold,
              fontSize: 12),
        ),
      ),
    );
  }
}
