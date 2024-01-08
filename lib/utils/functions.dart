// ignore_for_file: avoid_print, prefer_collection_literals

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:capef/hive/hive_boxes.dart';
import 'package:capef/main.dart';
import 'package:capef/models/ip_details_model.dart';
import 'package:capef/models/offline_data_response.dart';
import 'package:capef/models/slip_model.dart';
import 'package:capef/screens-cubits/agri-flow-screens/cubit/agri_cubit.dart';
import 'package:capef/screens-cubits/breeding-flow-screens/cubit/breeding_cubit.dart';
import 'package:capef/screens-cubits/fishing-flow-screens/cubit/fishing_cubit.dart';
import 'package:capef/screens-cubits/forest-flow-screens/cubit/forest_cubit.dart';
// import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'constant.dart';

class GlobalFunctions {
  static bool containsDuplicate(List<num?> numbers) {
    Set<num> seenNumbers = Set<num>();

    for (var number in numbers) {
      if (seenNumbers.contains(number)) {
        return true; // Found a duplicate
      } else {
        seenNumbers.add(number!);
      }
    }

    return false; // No duplicates found
  }

  // static showLoader(BuildContext context) {
  //   context.loaderOverlay.show(widget: SizedBox());
  // }

  // static hideLoader(BuildContext context) {
  //   context.loaderOverlay.hide();
  // }

  static void clearCategoriesCubit(BuildContext context) {
    context.read<FishingCubit>().resetToInitial();
    context.read<AgriCubit>().resetToInitial();
    context.read<BreedingCubit>().resetToInitial();
    context.read<ForestCubit>().resetToInitial();
  }

  static Future<void> captureAndSharePng({
    required String? imageData,
    required GlobalKey<State<StatefulWidget>> qrkeyy,
    required SlipModel slipModel,
  }) async {
    Future.delayed(const Duration(seconds: 1));
    try {
      RenderRepaintBoundary? boundary =
          qrkeyy.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      var image = await boundary?.toImage();
      ByteData? byteData = await image?.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/$imageData.png').create();

      // fileShow = file;
      await file.writeAsBytes(pngBytes);

      print(file.path);

      GlobalFunctions.executeJavaCode(
          qrkeyy: qrkeyy, file: File('path'), slipModel: slipModel
          //  SlipModel(
          //     agentName: 'agentNameLocall',
          //     identificationId: 'iddd',
          //     qrCode: 'qrtest',
          //     type: 'PêCHEURS',
          //     nationalName: 'name',
          //     nationalPhoneNumber: '71861264',
          //     regionAndDepartment: 'baalback/hortaala',
          //     telephoneNumber: '71861634'),
          );

      // setState(() {});

      // await executeJavaCode(file: file);

      // await Share.file(_dataString, '$_dataString.png', pngBytes, 'image/png');
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> executeJavaCode({
    required GlobalKey<State<StatefulWidget>> qrkeyy,
    required File file,
    required SlipModel slipModel,
  }) async {
    RenderRepaintBoundary? boundary =
        qrkeyy.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    try {
      var imaggge = await boundary?.toImage(pixelRatio: 3);
      final whitePaint = Paint()..color = Colors.white;
      final recorder = PictureRecorder();
      final canvas = Canvas(
          recorder,
          Rect.fromLTWH(
              0, 0, imaggge!.width.toDouble(), imaggge.height.toDouble()));
      canvas.drawRect(
          Rect.fromLTWH(
              0, 0, imaggge.width.toDouble(), imaggge.height.toDouble()),
          whitePaint);
      canvas.drawImage(imaggge, Offset.zero, Paint());

      final picture = recorder.endRecording();
      final img = await picture.toImage(imaggge.width, imaggge.height);
      ByteData? byteData = await img.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // final ByteData byteData = await rootBundle.load(Assets.images.qrPNG);
      // var bytess = byteData.buffer.asUint8List();

      String backVal = await platform.invokeMethod('myJavaFunc', {
        'data': pngBytes,
        'date_time': dateTimeSlash(),
        'type': slipModel.type?.toUpperCase(),
        'national_name': slipModel.nationalName,
        'identification_id': slipModel.identificationId,
        'national_phone_number': slipModel.nationalPhoneNumber,
        'qr_code': slipModel.qrCode,
        'region_department': slipModel.regionAndDepartment,
        'agent_name': slipModel.agentName,
        'assistance_phone': slipModel.telephoneNumber
      });
      print('the result back: $backVal');
    } on PlatformException catch (e) {
      print('something wrong: $e');
    }
  }

  static Future<bool> hasNetwork() async {
    try {
      final hasInternet = await internerConnectionChecker.hasConnection;
      hasInternetNow = hasInternet;
      return hasInternet;
    } catch (_) {
      hasInternetNow = false;
      return false;
    }
  }

  static String timestampToDate(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    return formattedDate;
  }

  static String dateTimeSlash() {
    String? dateNow = DateTime.now().toString();
    String? date = dateNow.substring(0, 10);
    String? timeNow = dateNow.substring(11, 16);
    return '$date / $timeNow';
  }

  // static Future<void> executeJavaCode() async {
  //   try {
  //     // ignore: unused_local_variable
  //     String? backVal = await platform.invokeMethod('myJavaFunc');
  //   } catch (e) {
  //     print('ERROR $e');
  //   }
  // }

  static String? principleFromId(
      {required List<Categories>? list, required int id}) {
    Categories? category = list?.firstWhere((element) => element.id == id,
        orElse: () => Categories(name: ''));
    return category?.name;
  }

  static String getLocalJWTToken() {
    if (Hive.box(ofllineDataBox).get('agent') != null) {
      return jsonDecode(Hive.box(ofllineDataBox).get('agent'))['jwttoken'];
    } else {
      return '';
    }
  }

  static String getLocalRefreshToken() {
    if (Hive.box(ofllineDataBox).get('agent') != null) {
      return jsonDecode(Hive.box(ofllineDataBox).get('agent'))['refreshtoken']
          ['token'];
    } else {
      return '';
    }
  }

  static String formatDateToAFormat(DateTime dateTime) {
    // Create a DateFormat instance with the desired format
    final dateFormat = DateFormat('M/d/yyyy');

    // Format the DateTime object as a string
    return dateFormat.format(dateTime);
  }

  static bool isValidImageUrl(String url) {
    // Define a regular expression pattern to match a valid URL
    RegExp urlPattern = RegExp(
      r'^(http(s)?:\/\/)?[^\s\/$.?#].[^\s]*$',
      caseSensitive: false,
      multiLine: false,
    );

    // Test the URL against the pattern
    return urlPattern.hasMatch(url);
  }

  static Future<void> addSSlToTrusted(String url) async {
    final securityContext = SecurityContext();
    final certificates = await rootBundle.load('assets/certificates/$url'); //1
    securityContext
        .setTrustedCertificatesBytes(certificates.buffer.asUint8List()); //2
    final httpClient = HttpClient(context: securityContext);
    final httpClientRequest =
        await httpClient.getUrl(Uri.parse('https://$url'));
    final response = await httpClientRequest.close();
    log(response.statusCode.toString());
  }

  // static Future<void> requestNotificationPermission() async {
  //   FirebaseMessaging messaging = FirebaseMessaging.instance;

  //   // NOTE this here to note if message is received and content of it
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     print('Got a message whilst in the foreground!');
  //     print('Message data: ${message.data}');
  //     if (message.notification != null) {
  //       print('Message also contained a notification: ${message.notification}');
  //     }
  //   });
  //   // ignore: unused_local_variable
  //   NotificationSettings settings = await messaging.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );
  // }

  // static void showDialogue({required BuildContext context}) async {
  //   showAdaptiveDialog(
  //     context: context,
  //     builder: (context) {
  //       return GestureDetector(
  //         onTap:
  //             context.read<GetPopUpBranchCubit>().dialogueBranchModel?.link !=
  //                     null
  //                 ? () {
  //                     launchUrlString(context
  //                             .read<GetPopUpBranchCubit>()
  //                             .dialogueBranchModel
  //                             ?.link ??
  //                         '');
  //                   }
  //                 : () {},
  //         child: DialogueWidget(
  //           dialogueBranchModel:
  //               context.read<GetPopUpBranchCubit>().dialogueBranchModel,
  //         ),
  //       );
  //     },
  //   );
  // }

  // static String getCityLabelFromId(
  //     {required List<Cities>? cities, required int? cityId}) {
  //   String? label = '';
  //   for (var city in cities!) {
  //     if (city.id == cityId) {
  //       label = city.label;
  //     }
  //   }
  //   return label!;
  // }

  // static Future<void> createFcmToken() async {
  //   // if (GlobalFunctions.hiveGet(GlobalHiveKeys.messagingToken) != null) {}
  //   final fcmToken = await FirebaseMessaging.instance.getToken();
  //   GlobalFunctions.hivePut(GlobalHiveKeys.messagingToken, fcmToken);
  //   print(GlobalFunctions.hiveGet(GlobalHiveKeys.messagingToken));
  //   print('Messaging Token: $fcmToken');

  //   requestNotificationPermission();
  // }

  static String getDateMessage(String? date) {
    DateTime currentDate = DateTime.now();
    // Get the date of the messages
    DateTime messageDate = DateTime.parse(date ?? DateTime.now().toString());

    String dateText = '';

    final currentTime = DateTime.now();

    final timeDifferencehours = currentTime.difference(messageDate).inHours;
    // Compare the dates
    if (currentDate.year == messageDate.year &&
        currentDate.month == messageDate.month &&
        currentDate.day == messageDate.day) {
      // If the dates are the same, display "Today"
      dateText = 'Today';
    } else if (currentDate.year == messageDate.year &&
        currentDate.month == messageDate.month &&
        currentDate.day - 1 == messageDate.day) {
      // If the dates differ by 1 day, display "Yesterday"
      dateText = 'Yesterday';
    } else if (timeDifferencehours > 48 && timeDifferencehours < 168) {
      final formatter = DateFormat('EEEE');
      final dayOfWeek = formatter.format(messageDate);
      dateText = dayOfWeek;
    } else {
      String formattedDate = DateFormat('MMMM d\'th\', y').format(messageDate);
      // Format the date in any other case

      dateText = formattedDate;
    }
    return dateText;
  }

  // function for transforming month number to name

  static String getMonthAbbreviation(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }

// function to give the date in a daymonth format like 14 aug ..., which is needed when the date for the message is not today
  static String formatToDayMonth(String dateStr) {
    DateTime inputDate = DateTime.parse(dateStr);
    String day = inputDate.day.toString();
    String month = getMonthAbbreviation(inputDate.month);

    return '$day $month';
  }

  static String formatFromDateTimeToString(TimeOfDay timeOfDay) {
    Duration duration =
        Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
    String formattedTime = duration.toString();
    return formattedTime;
  }

  static String formatDate(String inputDate) {
    DateTime date = DateTime.parse(inputDate);
    String formattedDate = DateFormat.yMMMMd().format(date);
    return formattedDate;
  }

  static String formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dateTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final formattedTime = DateFormat.jm().format(dateTime);
    return formattedTime;
  }

  // function that return true if the date entered as a String is at the same time for date time now

  static bool isSameDay(String dateStr) {
    DateTime inputDate = DateTime.parse(dateStr);
    DateTime today = DateTime.now();

    return inputDate.year == today.year &&
        inputDate.month == today.month &&
        inputDate.day == today.day;
  }

  static bool isYesterday(String dateStr) {
    DateTime inputDate = DateTime.parse(dateStr);
    DateTime today = DateTime.now();
    if (inputDate.year == today.year &&
        inputDate.month == today.month &&
        inputDate.day == today.day - 1) {
      return true;
    } else {
      return false;
    }
  }

  static String organizeChatId(String input) {
    if (input.contains('buisness_app_')) {
      return input;
    }
    List<String> parts = input.split('_');
    int firstNum = int.parse(parts[0]);
    int secondNum = int.parse(parts[1]);

    if (firstNum < secondNum) {
      return '${firstNum}_$secondNum';
    } else {
      return '${secondNum}_$firstNum';
    }
  }

  // static AppLocalizations getApplocalizations(BuildContext context) {
  //   return AppLocalizations.of(context)!;
  // }

  // static logAndCopyError(String message) {
  //   log(message);
  //   FlutterClipboard.copy(message);
  // }

  static String getFirstLetters(String fullName) {
    List<String> words = fullName.split(' ');
    String? firstLetter = words[0].substring(0, 1);
    String? secondLetter = words[1].substring(0, 1);
    String? wholeText = firstLetter + secondLetter;
    return wholeText.toUpperCase();
  }

  static String getMessageTime({String? messageTime}) {
    DateTime dateTime = DateTime.parse(messageTime ?? '');
    DateFormat format = DateFormat('hh:mm a');
    String formattedTime = format.format(dateTime);
    return formattedTime;
  }

  // static Future<void> checkUserWithToken(BuildContext context) async {
  //   await context
  //       .read<LoginUserCubit>()
  //       .checkUserWithToken(token: GlobalFunctions.getUserToken(context));
  // }

  // static Future<List<MultipartFile>> listOfPathsToListOfMultipart({
  //   required List<String> listOfPath,
  //   required String field,
  // }) async {
  //   final List<MultipartFile> listOfFiles = [];
  //   for (String element in listOfPath) {
  //     listOfFiles.add(await MultipartFile.fromPath(field, element));
  //   }
  //   return listOfFiles;
  // }

  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  // static Future<LocationData?> getLocationInCubit() async {
  //   Location location = Location();
  //   bool serviceEnabled;
  //   PermissionStatus permissionGranted;
  //   LocationData locationData;

  //   serviceEnabled = await location.serviceEnabled();
  //   if (!serviceEnabled) {
  //     serviceEnabled = await location.requestService();
  //     if (!serviceEnabled) {
  //       return null;
  //     }
  //   }

  //   permissionGranted = await location.hasPermission();
  //   if (permissionGranted == PermissionStatus.denied) {
  //     permissionGranted = await location.requestPermission();
  //     if (permissionGranted != PermissionStatus.granted) {
  //       return null;
  //     }
  //   }

  //   // Define a timeout duration (e.g., 10 seconds).
  //   const timeoutDuration = Duration(seconds: 10);

  //   try {
  //     // Use the timeout function to limit the time spent in getLocation.
  //     locationData = await location.getLocation().timeout(timeoutDuration);
  //     return locationData;
  //   } catch (e) {
  //     // If a timeout occurs, return dummy data or handle the error as needed.
  //     return dummyLocationData(); // Implement the dummyLocationData function.
  //   }
  // }

  // static LocationData? dummyLocationData() {
  //   // Create and return dummy location data.
  //   return LocationData.fromMap({
  //     "latitude": 33.882432,
  //     "longitude": 35.542791,
  //   });
  // }

  // static Future getLocationAddress(
  //     {required LocationData? locationData}) async {
  //   LocationData? location = locationData;
  //   final response = await http.get(Uri.parse(
  //       'https://maps.googleapis.com/maps/api/geocode/json?latlng=${location?.latitude},${location?.longitude}&key=${Platform.isAndroid ? 'AIzaSyCg8KAg_r-e3eVAf1KrAlOAvar7jPLgpxM' : 'AIzaSyCc2FEYq4g3YvWsgsDNjubrnDgQbYTS_lo'}'));
  //   return jsonDecode(response.body);
  // }
  // static AppLocalizations getApplocalizations(BuildContext context) {
  //   return AppLocalizations.of(context)!;
  // }

  // static logAndCopyError(String message) {
  //   log(message);
  //   FlutterClipboard.copy(message);
  // }

  static String getUserToken(BuildContext context) {
    return hiveGet(GlobalHiveKeys.userToken) ?? 't_';
  }

  static String convertTimeToString(TimeOfDay? timeOfDay) {
    String formattedTime =
        '${timeOfDay?.hour.toString().padLeft(2, '0')}:${timeOfDay?.minute.toString().padLeft(2, '0')}:00';
    return formattedTime;
  }

  static String showDatePickerHintText(String? date, String? time) {
    DateTime dateTime = DateTime.parse('${date?.split(' ').first} $time');
    String formattedDateTime =
        DateFormat('dd/MMM/yyyy hh:mm a').format(dateTime);
    return formattedDateTime;
  }

  static String getStoreId(BuildContext context) {
    return GlobalConstants.storeId;
  }

  // static UserModel? getCurrentUserModel(BuildContext context) {
  //   return context.read<LoginUserCubit>().userModel;
  // }

  // static UserModel? updateCurrentUserState(
  //     BuildContext context, UserModel userModel) {
  //   context.read<LoginUserCubit>().userModel = userModel;
  //   return null;
  // }

  // static Future<void> checkFCM({String? userId}) async {
  //   bool? fcmtokenExists = await APIs.doesFcmtokenExist(userId: userId);
  //   print('Fcmtoken exists: $fcmtokenExists');
  // }

  static bool isUserGuest(BuildContext context) {
    return hiveGet(GlobalHiveKeys.userToken)?.contains('t_') ?? true;
  }

  // static RoundedRectangleBorder getRoundedRectangleModel() {
  //   return RoundedRectangleBorder(
  //     borderRadius: BorderRadius.vertical(
  //       top: Radius.circular(GlobalConstants.globalRadiusBottomSheet),
  //     ),
  //   );
  // }

  static getWidth(BuildContext context, double width) =>
      MediaQuery.of(context).size.width * (width / 390);
  static getScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static getScreenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static getHeight(BuildContext context, double height) =>
      MediaQuery.of(context).size.height * (height / 844);

  static dynamic hiveGet(String key) =>
      Hive.box(GlobalHiveKeys.hiveBox).get(key);

  static Future<void> hiveDelete(String key) async =>
      Hive.box(GlobalHiveKeys.hiveBox).delete(key);

  static Future<void> hiveClear() async =>
      await Hive.box(GlobalHiveKeys.hiveBox).clear();

  static Future<void> hivePut(String key, dynamic value) async =>
      Hive.box(GlobalHiveKeys.hiveBox).put(key, value);

  static String ordinalSuffixOf(int i) {
    final int j = i % 10, k = i % 100;

    if (j == 1 && k != 11) {
      return '$i st';
    }
    if (j == 2 && k != 12) {
      return '$i nd';
    }
    if (j == 3 && k != 13) {
      return '$i rd';
    }
    return '$i th';
  }

  static int getMaxRowNumber(
    BuildContext context, {
    required double itemWidth,
  }) {
    return (GlobalFunctions.getScreenWidth(context) /
            GlobalFunctions.getWidth(context, itemWidth))
        .floor();
  }

  static Future<IpDetailsModel> getIpInfo() async {
    final http.Response data =
        await http.get(Uri.parse('http://ip-api.com/json'));
    final Map<String, dynamic> decodedData = jsonDecode(data.body);
    final IpDetailsModel ipDetailsResponse =
        IpDetailsModel.fromJson(decodedData);
    return ipDetailsResponse;
  }

  /// the function hideStatusBar must be inside initstate
  static void hideStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom,
    ]);
  }

  static void turnStatusBarToDark() {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarBrightness: Brightness.light));
  }

  static void turnStatusBarToLight() {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark));
  }

  static void showStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom,
      SystemUiOverlay.top,
    ]);
  }

  // static getFromEnv(String variable) {
  //   return dotenv.env[variable];
  // }

  // static Future<void> oneSignalInitialize() async {
  //   //Remove this method to stop OneSignal Debugging
  //   await OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  //   await OneSignal.shared.setAppId('e26dc853-2bc6-4e27-bd3c-2dfea2923d50');
  //   // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  //   await OneSignal.shared
  //       .promptUserForPushNotificationPermission()
  //       .then((accepted) {
  //     print(accepted);
  //   });
  // }

  static Duration parseDuration(String durationString) {
    List<String> parts = durationString.split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    int seconds = int.parse(parts[2]);

    return Duration(hours: hours, minutes: minutes, seconds: seconds);
  }

  // static void onesignalDisable() {
  //   //Remove this method to stop OneSignal Debugging
  //   hivePut(GlobalHiveKeys.isOneSignalenabled, false);
  //   OneSignal.shared.disablePush(true);
  // }

  // static void onesignalEnable() {
  //   //Remove this method to stop OneSignal Debugging
  //   hivePut(GlobalHiveKeys.isOneSignalenabled, true);
  //   OneSignal.shared.disablePush(false);
  // }

  static void onlineEnable() {
    //Remove this method to stop OneSignal Debugging
    hivePut(GlobalHiveKeys.isUserOnline, false);
  }

  static void onlineDisable() {
    //Remove this method to stop OneSignal Debugging
    hivePut(GlobalHiveKeys.isUserOnline, false);
  }
  // static Future<bool> isVersionGreaterThan(
  //   String theVersionFromBackend,
  // ) async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   await hivePut(GlobalHiveKeys.packageInfo, packageInfo.version);
  //   final currentVersion = Version.parse(packageInfo.version);
  //   final minimumVersion = Version.parse(theVersionFromBackend);

  //   if (currentVersion > minimumVersion) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  // you must initialize one signal before uncommenting the below
  // https://documentation.onesignal.com/docs/flutter-sdk-setup
  // static void onseSignalSendTags(
  //   BuildContext context, {
  //   required String userId,
  // }) {
  //   final bool isGuest = getUserToken(context).contains('t_');
  //   try {
  //     getIpInfo().then((ipDetails) {
  //       OneSignal.shared.sendTags({
  //         'user_id': userId,
  //         'is_user_guest': isGuest,
  //       });
  //     });
  //   } catch (e) {
  //     Sentry.captureException(
  //       e.toString(),
  //       stackTrace: StackTrace.current,
  //     );
  //     log('$e');
  //     firebaseCrashlytics.setCustomKey('title', 'OneSignal.shared.sendTags');
  //     firebaseCrashlytics.setCustomKey(
  //         'message',
  //         jsonEncode({
  //           'onesignal_error': '$e',
  //         }));
  //     firebaseCrashlytics.recordError(
  //         Exception(['mobile_error']), StackTrace.current,
  //         reason: 'mobile_error');
  //   }
  // }

  // https://documentation.onesignal.com/docs/flutter-sdk-setup
  // you must initialize one signal before uncommenting the above
  // static getFromEnv(String variable) {
  //   return dotenv.env[variable];
  // }

  // static Future<void> handleGoogleSignIn(
  //   BuildContext context,
  //   bool mounted,
  // ) async {
  //   final GoogleSignIn googleSignIn = GoogleSignIn();
  //   final GoogleSignInAccount? googleSignInAccount =
  //       await googleSignIn.signIn();
  //   if (googleSignInAccount == null) {
  //     return;
  //   }

  //   GlobalFunctions.createFcmToken();
  //   final String userName = googleSignInAccount.displayName!;
  //   final List<String> splittedUsername = userName.split(' ');
  //   final String name = splittedUsername.first;
  //   splittedUsername.remove(name);
  //   String lastname = '';
  //   for (var element in splittedUsername) {
  //     lastname += '$element ';
  //   }
  //   lastname.trim();
  //   if (mounted) {
  //     await context.read<SocialLoginCubit>().socialLoginUser(
  //           provider: GlobalEnumSocialSignInMethods.google,
  //           signature: md5
  //               .convert(utf8.encode(
  //                   '${GlobalEnumSocialSignInMethods.google.name}${googleSignInAccount.id}${googleSignInAccount.email}'))
  //               .toString(),
  //           email: googleSignInAccount.email,
  //           firstName: name,
  //           lastName: lastname,
  //           providerId: googleSignInAccount.id,
  //         );
  //   }
  // }

  // static Future<void> handleFacebookLogIn(
  //   BuildContext context,
  //   bool mounted,
  // ) async {
  //   try {
  //     GlobalFunctions.createFcmToken();
  //     final FacebookAuth facebookAuth = FacebookAuth.instance;
  //     final LoginResult result = await facebookAuth
  //         .login(); // by default we request the email and the public profile
  //     // or FacebookAuth.i.login()
  //     if (result.status == LoginStatus.success) {
  //       // you are logged
  //       final Map<String, dynamic> user = await facebookAuth.getUserData();
  //       final AccessToken? accessToken = await facebookAuth.accessToken;
  //       final String? token = accessToken?.token;
  //       final String userName = user['name'] as String;
  //       final List<String> splittedUsername = userName.split(' ');
  //       final String name = splittedUsername.first;
  //       splittedUsername.remove(name);
  //       String lastname = '';
  //       for (var element in splittedUsername) {
  //         lastname += '$element ';
  //       }
  //       lastname.trim();
  //       if (mounted) {
  //         await context.read<SocialLoginCubit>().socialLoginUser(
  //               provider: GlobalEnumSocialSignInMethods.facebook,
  //               signature: md5
  //                   .convert(utf8.encode(
  //                       '${GlobalEnumSocialSignInMethods.facebook.name}$token${user['email']}'))
  //                   .toString(),
  //               email: user['email'],
  //               firstName: name,
  //               lastName: lastname,
  //               providerId: token ?? '',
  //             );
  //       }
  //     } else {
  //       result.toString();
  //     }
  //   } catch (e) {
  //     await Sentry.captureException(
  //       e.toString(),
  //       stackTrace: StackTrace.current,
  //     );
  //     log('$e');
  //   }
  // }

  // static Future<void> handleAppleLogIn(
  //     BuildContext context, bool mounted) async {
  //   final credential = await SignInWithApple.getAppleIDCredential(
  //     scopes: [
  //       AppleIDAuthorizationScopes.email,
  //       AppleIDAuthorizationScopes.fullName,
  //     ],
  //   );
  //   if (mounted) {
  //     GlobalFunctions.createFcmToken();
  //     await context.read<SocialLoginCubit>().socialLoginUser(
  //           provider: GlobalEnumSocialSignInMethods.apple,
  //           signature: md5
  //               .convert(utf8.encode(
  //                   '${GlobalEnumSocialSignInMethods.apple.name}${credential.userIdentifier}${credential.email}'))
  //               .toString(),
  //           email: credential.email,
  //           firstName: credential.givenName,
  //           lastName: credential.familyName,
  //           providerId: credential.userIdentifier ?? '',
  //         );
  //   }
  // }

  // static List<Widget> buildChildrenRecursivly(
  //   List<FrontEndMenuModel> frontEndMenuModelMainMenu,
  // ) {
  //   List<Widget> listOfChildren = [];
  //   for (FrontEndMenuModel element in frontEndMenuModelMainMenu) {
  //     if (element.children?.isEmpty ?? true) {
  //       listOfChildren.add(
  //         Text(
  //           element.dataFrontEndMenu?.label ?? '',
  //           style: GlobalTextStyles.ts14poppinsMediumGrey,
  //         ),
  //       );
  //     } else {
  //       List<Widget> innerList = buildChildrenRecursivly(
  //         element.children ?? [],
  //       );
  //       listOfChildren.add(
  //         ExpansionTile(
  //           // onExpansionChanged: (value) =>
  //           //     valueNotifierCategories.value = value,
  //           trailing: const BuildAnimatedDropIcon(value: false),
  //           title: Text(
  //             element.dataFrontEndMenu?.label ?? '',
  //             style: GlobalTextStyles.ts14poppinsMediumGrey,
  //           ),
  //           children: innerList,
  //         ),
  //       );
  //     }
  //   }
  //   return listOfChildren;
  // }

  // static void openStoreFromUrl() async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   String packageName = packageInfo.packageName;
  //   if (Platform.isAndroid || Platform.isIOS) {
  //     final url = Uri.parse(
  //       Platform.isAndroid
  //           ? "market://details?id=$packageName"
  //           : "https://apps.apple.com/app/id$packageName",
  //     );
  //     launchUrl(
  //       url,
  //       mode: LaunchMode.externalApplication,
  //     );
  //   }
  // }
  static Widget buildFailCubit(BuildContext context, String? error) {
    // WebViewController webViewController = WebViewController()
    //   ..loadHtmlString(error ?? '')
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted);
    return Text(error ?? '');
    // Future.delayed(
    //   const Duration(
    //     milliseconds: 200,
    //   ),
    //   () => Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) => Scaffold(
    //                 appBar: AppBar(),
    //                 body: SafeArea(
    //                   child: Center(
    //                     child: WebViewWidget(
    //                       controller: webViewController,
    //                     ),
    //                   ),
    //                 ),
    //               ))),
    // );
  }
}

class CustomLoaderWidget extends StatelessWidget {
  const CustomLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent, // Set your desired background color here
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
