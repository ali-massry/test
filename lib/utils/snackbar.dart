import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class GlobalSnackbar {
  // static showSuccessToast(BuildContext context, String title) {
  //   return showTopSnackBar(
  //     Overlay.of(context),
  //     CustomSnackBar.success(
  //       message: title,
  //     ),
  //     curve: Curves.linear,
  //     reverseCurve: Curves.linear,
  //     animationDuration: const Duration(milliseconds: 300),
  //   );
  // }

  // static showFailureToast(BuildContext context, String title) {
  //   return showTopSnackBar(
  //     Overlay.of(context),
  //     CustomSnackBar.error(
  //       message: title,
  //     ),
  //     curve: Curves.linear,
  //     reverseCurve: Curves.linear,
  //     animationDuration: const Duration(
  //       milliseconds: 300,
  //     ),
  //   );
  // }

  // static showWarningToast(BuildContext context, String title) {
  //   return showTopSnackBar(
  //     Overlay.of(context),
  //     CustomSnackBar.info(
  //       message: title,
  //       backgroundColor: Colors.amber,
  //     ),
  //     curve: Curves.linear,
  //     reverseCurve: Curves.linear,
  //     animationDuration: const Duration(
  //       milliseconds: 300,
  //     ),
  //   );
  // }

  // static showInfoToast(BuildContext context, String title) {
  //   return showTopSnackBar(
  //     Overlay.of(context),
  //     CustomSnackBar.info(
  //       message: title,
  //     ),
  //     curve: Curves.linear,
  //     reverseCurve: Curves.linear,
  //     animationDuration: const Duration(
  //       milliseconds: 300
  //     ),
  //   );
  // }

  static dynamic showSuccessToast(
    BuildContext context,
    String? message, {
    String? title,
    void Function()? action,
  }) {
    return showToastWidget(
      Dismissible(
        key: const Key('up'),
        direction: DismissDirection.up,
        child: Dismissible(
          key: const Key('horizontal'),
          direction: DismissDirection.horizontal,
          child: GestureDetector(
            onTap: action,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Container(
                decoration: BoxDecoration(
                    color: GlobalColors.mainGreenColor,
                    borderRadius: BorderRadius.circular(20)),
                height: mqh(context, 65),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 8, 8, 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    CupertinoIcons.check_mark_circled,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                      child: Text(
                                    title ?? message ?? '',
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  )),
                                ],
                              ),
                            ),
                            if (title != null)
                              Column(
                                children: [
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      const SizedBox(width: 35),
                                      Text(
                                        message ?? '',
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      if (action != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: GlobalColors.mainGreenColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(18.0),
                              child: Icon(CupertinoIcons.right_chevron,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      context: context,
      position: StyledToastPosition.top,
      animation: StyledToastAnimation.slideFromTopFade,
      reverseAnimation: StyledToastAnimation.slideFromTopFade,
      duration: const Duration(milliseconds: 3000),
      isIgnoring: false,
    );
  }

  static dynamic showFailureToast(
    BuildContext context,
    String? message, {
    String? title,
    void Function()? action,
  }) {
    return showToastWidget(
      Dismissible(
        key: const Key('up'),
        direction: DismissDirection.up,
        child: Dismissible(
          key: const Key('horizontal'),
          direction: DismissDirection.horizontal,
          child: GestureDetector(
            onTap: action,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(20)),
                height: mqh(context, 65),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 8, 8, 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    CupertinoIcons.xmark_circle,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                      child: Text(
                                    title ?? message ?? '',
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  )),
                                ],
                              ),
                            ),
                            if (title != null)
                              Column(
                                children: [
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      const SizedBox(width: 35),
                                      Text(
                                        message ?? '',
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      if (action != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: GlobalColors.mainGreenColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(18.0),
                              child: Icon(CupertinoIcons.xmark_octagon,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      context: context,
      position: StyledToastPosition.top,
      animation: StyledToastAnimation.slideFromTopFade,
      reverseAnimation: StyledToastAnimation.slideFromTopFade,
      duration: const Duration(milliseconds: 3000),
      isIgnoring: false,
    );
  }

  static dynamic showInfoToast(
    BuildContext context,
    String? message, {
    String? title,
    void Function()? action,
  }) {
    return showToastWidget(
      Dismissible(
        key: const Key('up'),
        direction: DismissDirection.up,
        child: Dismissible(
          key: const Key('horizontal'),
          direction: DismissDirection.horizontal,
          child: GestureDetector(
            onTap: action,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black.withOpacity(0.5)),
                height: mqh(context, 65),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 8, 8, 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    CupertinoIcons.exclamationmark_circle,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                      child: Text(
                                    title ?? message ?? '',
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  )),
                                ],
                              ),
                            ),
                            if (title != null)
                              Column(
                                children: [
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      const SizedBox(width: 35),
                                      Text(
                                        message ?? '',
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      if (action != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: GlobalColors.mainGreenColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(18.0),
                              child: Icon(CupertinoIcons.right_chevron,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      context: context,
      position: StyledToastPosition.top,
      animation: StyledToastAnimation.slideFromTopFade,
      reverseAnimation: StyledToastAnimation.slideFromTopFade,
      duration: const Duration(milliseconds: 3000),
      isIgnoring: false,
    );
  }
}

class GlobalOverLay {
  static OverlayEntry showLoaderOverlay(BuildContext context) {
    OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height * 0.5,
        left: MediaQuery.of(context).size.width * 0.5,
        child: const Material(
          color: Colors.transparent,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);

    return overlayEntry;
  }
}
