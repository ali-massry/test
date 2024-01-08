// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:capef/global_cubits/get_offline_cubit/get_offline_cubit.dart';
import 'package:capef/models/offline_data_response.dart';
import 'package:capef/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

abstract class GlobalApiUrls {}

String? offlineIdGlobal({required int? agentId}) {
  String? offlineId = '200$agentId${generateTimestamp()}';
  return offlineId.toString();
}

String villageCategory(BuildContext context,
    {required int villageId, required int principalCategoryId}) {
  List<Villages>? villages = context
      .read<GetOfflineCubitCubit>()
      .getOfflineDataModel
      ?.villages
      ?.where((element) => element.villageid == villageId)
      .toList();
  List<Areas>? areas = context
      .read<GetOfflineCubitCubit>()
      .getOfflineDataModel
      ?.areas
      ?.where((element) => element.districtid == villages![0].areaid)
      .toList();
  List<Categories>? categories = context
      .read<GetOfflineCubitCubit>()
      .getOfflineDataModel
      ?.categories
      ?.where((element) => element.id == principalCategoryId)
      .toList();
  print(villages);

  return '${villages?[0].villagename} / ${areas?[0].areaname} / ${categories?[0].name}';
}

String? transactionId({
  required int? agentId,
  required int? onlineOrOffline,
}) {
  String? offlineId = 'p${onlineOrOffline}00$agentId${generateTimestamp()}';
  return offlineId.toString();
}

int generateTimestamp() {
  return DateTime.now().millisecondsSinceEpoch ~/ 1000;
}

int agentIdLocall = jsonDecode(Hive.box('offlineData').get('agent'))['userid'];
String agentNameLocall =
    jsonDecode(Hive.box('offlineData').get('agent'))['agentname'];

const EdgeInsetsGeometry globalScreenPaddings =
    EdgeInsets.symmetric(horizontal: 20.0, vertical: 24);
const EdgeInsetsGeometry padding30hor =
    EdgeInsets.symmetric(horizontal: 30.0, vertical: 24);

const String apiUrl = 'http://capefmobile.myeasycards.com';

abstract class GlobalEnvKeys {
  static String appkey = 'APP_KEY';
  static String onesignalkey = 'ONESIGNALKEY';
}

double screenWidth(BuildContext context, {required double width}) {
  return MediaQuery.of(context).size.width * (width / 399);
}

double screenHeight(BuildContext context, {required double height}) {
  return MediaQuery.of(context).size.height * (height / 844);
}

mqw(BuildContext context, double width) =>
    MediaQuery.of(context).size.width * (width / 390);
mqh(BuildContext context, double height) =>
    MediaQuery.of(context).size.height * (height / 844);

abstract class GlobalHiveKeys {
  static const String hiveBox = 'localStorage';
  static const String listOfTasksId = 'listOfTasksId';
  static const String listOfUserFriendIds = 'listOfUserFriends';
  static const String skipped = 'skipped';
  static const String isOneSignalenabled = 'isOneSignalenabled';
  static const String isUserOnline = 'isUserOnline';
  static const String userModel = 'userModel';
  static const String recentSearches = 'recentSearches';
  static const String userToken = 'userToken';
  static const String selectedLanguage = 'selectedLanguage';
  static const String selectedStoreId = 'selectedStoreId';
  static const String selectedMusicGenres = 'selectedMusicGenres';
  static const String selectedBirthDay = 'selectedBirthDay';
  static const String gender = 'Gender';
  static const String location = 'Location';
  static const String userVisitedMusicGenresFavoritesScreen =
      'userVisitedMusicGenresFavoritesScreen';
  static const String firstTime = 'firstTime';
  static const String numberofInvited = 'numberofInvited';
  static const String invitedAPIrequest = 'invitedAPIrequest';
  static const String messagingToken = 'messagingToken';
}

abstract class GlobalConstants {
  static const String storeId = '1';
  static const double globalPadding = 24;
  static const String mapStyle = """[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dadada"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#c9c9c9"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]""";
}

// ignore_for_file: constant_identifier_names

abstract class GlobalTextStyles {
  static const TextStyle underlinedTextButton = TextStyle(
    letterSpacing: 1,
    fontSize: 14 + 2,
    decoration: TextDecoration.underline,
    color: GlobalColors.mainGreenColor,
    fontFamily: GlobalFonts.montserratBold,
  );

  static const TextStyle underlinedViewAllTextButton = TextStyle(
      letterSpacing: 1,
      fontSize: 14,
      decoration: TextDecoration.underline,
      color: GlobalColors.mainGreenColor,
      fontFamily: GlobalFonts.montserratBold,
      decorationColor: GlobalColors.mainGreenColor);
  static const TextStyle ts12underlineGreenBold = TextStyle(
      fontSize: 12,
      decoration: TextDecoration.underline,
      color: GlobalColors.mainGreenColor,
      fontFamily: GlobalFonts.montserratBold,
      decorationColor: GlobalColors.mainGreenColor);

  static TextStyle tstextField = TextStyle(
      fontFamily: GlobalFonts.Montserrat,
      fontSize: 14 + 2,
      fontStyle: FontStyle.italic,
      color: Colors.white.withOpacity(0.5));

  static const TextStyle buttonStyle = TextStyle(
      fontSize: 14,
      color: Colors.white,
      fontFamily: GlobalFonts.montserratBold);
  static const TextStyle ts11montsemiBolddarkBlue = TextStyle(
    fontSize: 11 + 2,
    color: GlobalColors.mainGreenColor,
    fontFamily: GlobalFonts.monserratSemiBold,
  );
  static TextStyle ts13montsemiBold30OpaquBlack = TextStyle(
    fontSize: 13,
    color: Colors.black.withOpacity(0.3),
    fontFamily: GlobalFonts.monserratSemiBold,
  );
  static const TextStyle ts11montsemiBolddarkBlueLS15 = TextStyle(
    fontSize: 11 + 2,
    color: GlobalColors.mainGreenColor,
    fontFamily: GlobalFonts.monserratSemiBold,
    letterSpacing: 1.5,
  );
  static const TextStyle ts11montsemiBolddarkBlueLS10 = TextStyle(
    fontSize: 11 + 2,
    color: GlobalColors.mainGreenColor,
    fontFamily: GlobalFonts.monserratSemiBold,
    letterSpacing: 1,
  );
  static const TextStyle ts13montsemimontserratMediumBlue = TextStyle(
    fontSize: 13 + 2,
    color: GlobalColors.mainGreenColor,
    fontFamily: GlobalFonts.montserratMedium,
  );
  static const TextStyle ts18montBolddarkBlue = TextStyle(
    fontSize: 18 + 2,
    color: GlobalColors.mainGreenColor,
    fontFamily: GlobalFonts.montserratBold,
  );
  static const TextStyle ts15montboldWhite = TextStyle(
    fontSize: 15,
    color: Colors.white,
    fontFamily: GlobalFonts.montserratBold,
  );
  static const TextStyle ts12montboldBlack = TextStyle(
    fontSize: 12,
    color: Colors.black,
    fontFamily: GlobalFonts.montserratBold,
  );
  static const TextStyle ts11montboldBlack = TextStyle(
    fontSize: 11,
    color: Colors.black,
    fontFamily: GlobalFonts.montserratBold,
  );
  static const TextStyle ts15montboldBlack = TextStyle(
    fontSize: 15,
    color: Colors.black,
    fontFamily: GlobalFonts.montserratBold,
  );
  static const TextStyle ts14montsemibolddarkBlue = TextStyle(
    fontSize: 14 + 2,
    color: GlobalColors.mainGreenColor,
    fontFamily: GlobalFonts.monserratSemiBold,
  );

  static const TextStyle ts14montsemibolddarkBlueLS15 = TextStyle(
    fontSize: 14 + 2,
    color: GlobalColors.mainGreenColor,
    fontFamily: GlobalFonts.monserratSemiBold,
    letterSpacing: 1.5,
  );

  static TextStyle ts13montregularDarkBlue = const TextStyle(
    fontSize: 13 + 2,
    color: GlobalColors.mainGreenColor,
    fontFamily: GlobalFonts.Montserrat,
  );
  static TextStyle ts11montregularBlackOp60 = TextStyle(
    fontSize: 11 + 2,
    color: Colors.black.withOpacity(0.6),
    fontFamily: GlobalFonts.Montserrat,
  );
  static const TextStyle ts14montmediumdarkblue = TextStyle(
    fontSize: 14 + 2,
    color: GlobalColors.mainGreenColor,
    fontFamily: GlobalFonts.montserratMedium,
  );
  static const TextStyle ts12montregulardarkblue = TextStyle(
    fontSize: 12 + 2,
    color: GlobalColors.mainGreenColor,
    fontFamily: GlobalFonts.Montserrat,
  );
  static TextStyle ts12montregulardarkblueOp70 = TextStyle(
    fontSize: 12 + 2,
    color: GlobalColors.mainGreenColor.withOpacity(0.7),
    fontFamily: GlobalFonts.Montserrat,
  );
  static TextStyle ts12montregulardarkBlackOp70 = TextStyle(
    fontSize: 12 + 2,
    color: Colors.black.withOpacity(0.7),
    fontFamily: GlobalFonts.Montserrat,
  );
  static const TextStyle ts12montregulardarkblueBold = TextStyle(
    fontSize: 12 + 2,
    color: GlobalColors.mainGreenColor,
    fontFamily: GlobalFonts.montserratBold,
  );
  static const TextStyle ts12montmediumdarkblue = TextStyle(
    fontSize: 12 + 2,
    color: GlobalColors.mainGreenColor,
    fontFamily: GlobalFonts.montserratMedium,
  );
  static const TextStyle ts13montlightdarkblue = TextStyle(
    fontSize: 13 + 2,
    color: GlobalColors.mainGreenColor,
    fontFamily: GlobalFonts.montserratLight,
  );
  static const TextStyle ts13montsemiBoldBlack = TextStyle(
    fontSize: 13 + 2,
    color: Colors.black,
    fontFamily: GlobalFonts.monserratSemiBold,
  );
  static TextStyle ts13montsemiBoldBlackWith40Opacity = TextStyle(
    fontSize: 13 + 2,
    color: Colors.black.withOpacity(0.4),
    fontFamily: GlobalFonts.monserratSemiBold,
  );
  static const TextStyle ts25montbolddarkblue = TextStyle(
    fontSize: 30 + 2,
    color: GlobalColors.mainGreenColor,
    fontFamily: GlobalFonts.montserratBold,
  );
  static const TextStyle noconnectionsFound = TextStyle(
    fontSize: 20,
    color: GlobalColors.mainGreenColor,
    fontFamily: GlobalFonts.montserratBold,
  );
  static const TextStyle ts13montbolddarkblueUnderlined = TextStyle(
    fontSize: 13 + 2,
    color: GlobalColors.mainGreenColor,
    decoration: TextDecoration.underline,
    fontFamily: GlobalFonts.Montserrat,
  );
  static const TextStyle ts13montboldGreen = TextStyle(
    fontSize: 13,
    color: GlobalColors.mainGreenColor,
    fontFamily: GlobalFonts.montserratBold,
  );
  static TextStyle ts12montsemibold50OpaqueWhitels110 = TextStyle(
    fontSize: 12 + 2,
    color: Colors.white.withOpacity(0.5),
    fontFamily: GlobalFonts.monserratSemiBold,
    letterSpacing: 1.1,
  );
  static TextStyle ts26montsemibold50OpaqueWhitels110 = TextStyle(
    fontSize: 26 + 2,
    color: Colors.white.withOpacity(0.5),
    fontFamily: GlobalFonts.monserratSemiBold,
    letterSpacing: 1.1,
  );
  static TextStyle ts12ls1montsemibolddarkBlue = const TextStyle(
    fontSize: 12 + 2,
    letterSpacing: 1,
    color: GlobalColors.mainGreenColor,
    fontFamily: GlobalFonts.monserratSemiBold,
  );
  static TextStyle ts12montsemibolddarkBlue = const TextStyle(
    fontSize: 12 + 2,
    color: GlobalColors.mainGreenColor,
    fontFamily: GlobalFonts.monserratSemiBold,
  );
  static TextStyle ts12montregular60opaqueBlack = TextStyle(
    fontSize: 12 + 2,
    color: Colors.black.withOpacity(0.6),
    fontFamily: GlobalFonts.Montserrat,
  );
  static TextStyle ts12montBold50opaqueBlack = TextStyle(
    fontSize: 12,
    color: Colors.black.withOpacity(0.5),
    fontFamily: GlobalFonts.montserratBold,
  );
  static const TextStyle ts20montboldGreen = TextStyle(
    fontSize: 20,
    color: GlobalColors.mainGreenColor,
    fontFamily: GlobalFonts.montserratBold,
  );
  static const TextStyle ts17montboldGreen = TextStyle(
    fontSize: 17,
    color: GlobalColors.mainGreenColor,
    fontFamily: GlobalFonts.montserratBold,
  );
  static const TextStyle ts20montboldBlack = TextStyle(
    fontSize: 20,
    color: Colors.black,
    fontFamily: GlobalFonts.montserratBold,
  );
  static const TextStyle ts12montboldGreen = TextStyle(
    fontSize: 12,
    color: GlobalColors.mainGreenColor,
    fontFamily: GlobalFonts.montserratBold,
  );
  static const TextStyle ts25montboldGreen = TextStyle(
    fontSize: 25,
    color: GlobalColors.mainGreenColor,
    fontFamily: GlobalFonts.montserratBold,
  );
  static const TextStyle ts12ls1montboldGreen = TextStyle(
      fontSize: 12,
      color: GlobalColors.mainGreenColor,
      fontFamily: GlobalFonts.montserratBold,
      letterSpacing: 1);
  static const TextStyle ts14montboldGreen = TextStyle(
    fontSize: 14,
    color: GlobalColors.mainGreenColor,
    fontFamily: GlobalFonts.montserratBold,
  );
  static TextStyle ts14montbold50OpaqueBlack = TextStyle(
    fontSize: 13,
    color: Colors.black.withOpacity(0.5),
    fontFamily: GlobalFonts.montserratBold,
  );
  static const TextStyle ts14montboldBlack = TextStyle(
    fontSize: 14,
    color: Colors.black,
    fontFamily: GlobalFonts.montserratBold,
  );
  static const TextStyle ts14montboldWhite = TextStyle(
    fontSize: 14,
    color: Colors.white,
    fontFamily: GlobalFonts.montserratBold,
  );

  static TextStyle ts10montboldregular40OpaqueGrey70 = const TextStyle(
    fontSize: 10 + 2,
    color: GlobalColors.mainGreenColor,
    fontFamily: GlobalFonts.Montserrat,
  );
  static TextStyle ts16montBoldGreen = const TextStyle(
    fontSize: 16,
    color: GlobalColors.mainGreenColor,
    fontFamily: GlobalFonts.montserratBold,
  );
  static TextStyle ts10montMediumdarkBlue = const TextStyle(
    fontSize: 10 + 2,
    color: GlobalColors.mainGreenColor,
    fontFamily: GlobalFonts.montserratMedium,
  );
  static TextStyle ts10montBolddarkBlueLs100 = const TextStyle(
    fontFamily: GlobalFonts.montserratBold,
    fontSize: 10 + 2,
    color: GlobalColors.mainGreenColor,
    letterSpacing: 1,
  );
}
//191919

abstract class GlobalFonts {
  static const String Montserrat = 'Montserrat';
  static const String monserratSemiBold = 'MontserratSemiBold';
  static const String montserratBold = 'MontserratBold';
  static const String montserratMedium = 'MontserratMedium';
  static const String montserratLight = 'MontserratLight';

//   Montserrat-Regular.ttf
// Montserrat-SemiBold.ttf
// Montserrat-Medium.ttf
// Montserrat-Bold.ttf
}

//ENUMS
enum GlobalSocialSignInMethods { facebook, google, apple }

enum GlobalCartUpdateDirection { add, remove }

enum GlobalShippingAddressType { shipping, billing }

OutlineInputBorder buildOutlineInputBorder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        width: 1.5,
        color: Colors.black.withOpacity(0.2),
        // color: Colors.black.withOpacity(0.2),
      ));
}

abstract class GlobalSendRequestFields {
  static const String reservationFor = 'Reservation For';
  static const String section = 'Section';
  static const String eventName = 'Event Name';
  static const String numberOfPeople = 'Number Of People';
}

enum GlobalEnumSocialSignInMethods { facebook, google, apple }

enum GlobalEnumSubmitRequestType { accept, reject }

enum GlobalEnumNotificationTypes {
  ADD_FRIEND,
  ADD_REVIEW,
  WAITING_LIST,
  SECTION_CHANGE,
  FRIEND_ACCEPTED,
  BOOKING_ACCEPTED,
  TASK_COMPLETED
}

String getTime(String time) {
  return DateFormat('hh:mm a').format(DateTime.parse('2012-02-27 $time'));
}

String getDayOfWeek({required DateTime dateTime}) {
  final DateFormat formatter = DateFormat('EEEE');
  final String formatted = formatter.format(dateTime);
  if (isWithinNext7Days(dateTime) == true) {
    return formatted;
  } else {
    return dateTime.toString().substring(0, 10);
  }
}

bool isWithinNext7Days(DateTime dateTime) {
  DateTime now = DateTime.now();
  DateTime next7Days = now.add(const Duration(days: 7));
  return dateTime.isAfter(now) && dateTime.isBefore(next7Days);
}

enum GlobalEnumDays { mon, tue, wed, thu, fri, sat, sun }
