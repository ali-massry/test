import 'package:capef/utils/constant.dart';
import 'package:capef/utils/svg_builder.dart';
import 'package:flutter/material.dart';

class BuildModifyAndEditContainer extends StatelessWidget {
  const BuildModifyAndEditContainer({
    super.key,
    required this.title,
    required this.assetPath,
    required this.ontap,
  });
  final String title;
  final String assetPath;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Card(
        elevation: 5,
        child: Container(
          height: mqh(context, 70),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 19.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: GlobalTextStyles.ts15montboldBlack),
                  SvgBuilder(asset: assetPath)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
