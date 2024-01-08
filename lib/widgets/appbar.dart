import 'package:capef/assets.dart';
import 'package:capef/routes/routes.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/functions.dart';
import 'package:capef/utils/svg_builder.dart';
import 'package:flutter/material.dart';

class BuildAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BuildAppBar({
    super.key,
    this.title,
    this.showBack = true,
    this.ontapp,
  });
  final String? title;
  final bool? showBack;
  final VoidCallback? ontapp;

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      shadowColor: GlobalColors.mainGreenColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))),
      backgroundColor: GlobalColors.mainGreenColor,
      leading: showBack == false
          ? const SizedBox()
          : GestureDetector(
              onTap: ontapp ??
                  () {
                    Navigator.pop(context);
                  },
              child: Container(
                margin: const EdgeInsets.only(left: 20),
                decoration: const BoxDecoration(
                    color: Colors.white, shape: BoxShape.circle),
                child: const Center(
                  child: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: GlobalColors.mainGreenColor,
                  ),
                ),
              ),
            ),
      title: Text(
        title ?? '',
        style: GlobalTextStyles.ts15montboldWhite,
      ),
      centerTitle: true,
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(Routes.homeScreen, (route) => false);

            GlobalFunctions.clearCategoriesCubit(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Container(
              width: 38,
              height: 38,
              decoration: const BoxDecoration(
                  color: Colors.white, shape: BoxShape.circle),
              child: Center(
                child: SvgBuilder(asset: Assets.icons.homeSvg),
              ),
            ),
          ),
        )
      ],
    );
  }
}
