import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class SvgBuilder extends StatelessWidget {
  final Color? color;
  final String asset;
  final VoidCallback? onTap;
  final double? height;
  final double? width;
  final BoxFit? fit;

  const SvgBuilder(
      {Key? key,
      this.color,
      required this.asset,
      this.onTap,
      this.height,
      this.width,
      this.fit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: SvgPicture.asset(
        asset,
        // ignore: deprecated_member_use
        color: color,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
      ),
    );
  }
}
