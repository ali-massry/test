import 'package:flutter/material.dart';

class AppSignal {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      showSuccessToast(BuildContext context, String title) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.check_circle_outlined,
                  color: Colors.green,
                ),
                const VerticalDivider(),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                        // fontFamily: GlobalFonts.IBMPlexSans,
                        fontSize: 14,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          )),
      backgroundColor: Colors.black,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 135),
      dismissDirection: DismissDirection.up,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(4), bottomRight: Radius.circular(4))),
    ));
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      showFailureToast(BuildContext context, String title) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error,
                  color: Colors.red,
                ),
                const VerticalDivider(),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                        // fontFamily: GlobalFonts.IBMPlexSans,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
          )),
      backgroundColor: Colors.white,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 135),
      dismissDirection: DismissDirection.up,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(4), bottomRight: Radius.circular(4))),
    ));
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      showWarningToast(BuildContext context, String title) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.warning_amber,
                  color: Colors.amber,
                ),
                const VerticalDivider(),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                        // fontFamily: GlobalFonts.IBMPlexSans,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
          )),
      backgroundColor: Colors.white,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 135),
      dismissDirection: DismissDirection.up,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(4), bottomRight: Radius.circular(4))),
    ));
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      showInfoToast(BuildContext context, String title) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.info,
                  color: Colors.blue,
                ),
                const VerticalDivider(),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                        // fontFamily: GlobalFonts.IBMPlexSans,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
          )),
      backgroundColor: Colors.white,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 135),
      dismissDirection: DismissDirection.up,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(4), bottomRight: Radius.circular(4))),
    ));
  }
}
