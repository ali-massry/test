import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:flutter/material.dart';

class BuildBackButton extends StatelessWidget {
  const BuildBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: mqw(context, 38),
        height: mqh(context, 38),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: GlobalColors.mainGreenColor.withOpacity(0.1),
        ),
        child: const Center(
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: GlobalColors.mainGreenColor,
          ),
        ),
      ),
    );
  }
}
