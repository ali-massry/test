import 'package:capef/assets.dart';
import 'package:capef/utils/svg_builder.dart';
import 'package:flutter/material.dart';

class BuildLogoWidget extends StatelessWidget {
  const BuildLogoWidget({super.key, this.ontap});

  final VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return SvgBuilder(onTap: ontap, asset: Assets.icons.logoSvg);
  }
}
