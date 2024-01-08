import 'package:capef/utils/class_extentions.dart';
import 'package:flutter/material.dart';

ThemeData globalThemeData() {
  return ThemeData(
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    }),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
    iconTheme: IconThemeData(
      color: HexColor(
        '#339966',
      ),
    ),
    primaryIconTheme: IconThemeData(
      color: HexColor(
        '#339966',
      ),
    ),
  );
}
