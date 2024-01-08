import 'package:capef/utils/constant.dart';
import 'package:flutter/material.dart';

class BuildCenteredAgriText extends StatelessWidget {
  const BuildCenteredAgriText({super.key, required this.title});
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Text(
          title ?? '',
          style: GlobalTextStyles.ts20montboldGreen,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
