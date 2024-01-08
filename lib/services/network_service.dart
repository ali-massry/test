// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:capef/models/error_response.dart';
import 'package:capef/services/network_exception.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class NetworkService {
  static Future<dynamic> httpGetRequest(
      {String? url, Map<String, String>? headers}) async {
    // final request = http.MultipartRequest('GET', Uri.parse(url));
    // request.headers.addAll(headers);
    // log('GETREQUEST:\n\t\t\t$url\n\tHEADERS:\n\t\t\t$headers');
    // final http.StreamedResponse response = await request.send();
    // dynamic responseJson;
    // debugPrint('response status code is ${response.statusCode}');
    // try {
    //   responseJson = _returnResponse(response);
    //   return responseJson;
    // } on SocketException {
    //   throw NoInternetException();
    // }
    final response = await http.get(
      Uri.parse(url ?? ''),
      headers: headers,
    );

    log('GET REQUEST:\n\t\t\t$url\n\tHEADERS:\n\t\t\t$headers\n\tBODY:\n\t\t\t');

    dynamic responseJson;
    debugPrint('Response status GET $url code is ${response.statusCode}');

    try {
      responseJson = _returnResponse(response);
      return responseJson;
    } on SocketException {
      throw NoInternetException();
    }
  }

  static Future<dynamic> httpPostRequest({
    required String url,
    String? jwtToken,
    String? language,
    required Map<String, dynamic> body,
  }) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      if (language != null) 'Lang': language,
      if (jwtToken != null) 'Authorization': 'Bearer $jwtToken'
    };
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body), // Convert the body to a JSON string
    );
    print(jsonEncode(body));
    var s = jsonEncode(body);
    print(s);

    log('POST REQUEST:\n\t\t\t$url\n\tHEADERS:\n\t\t\t$headers\n\tBODY:\n\t\t\t$body');

    dynamic responseJson;
    debugPrint('Response status POST $url is ${response.statusCode}');

    try {
      responseJson = _returnResponse(response);
      return responseJson;
    } on SocketException {
      throw NoInternetException();
    }
  }

  // static Future<dynamic> httpPostDynamicBodyRequest(
  //     String url, Map<String, String> headers, Map<String, dynamic> body,
  //     {List<http.MultipartFile>? files}) async {
  //   final request = http.MultipartRequest('POST', Uri.parse(url));
  //   if (body.isNotEmpty) request.fields.addAll(body);
  //   request.files.addAll(files ?? []);
  //   request.headers.addAll(headers);
  //   log('POSTREQUEST:\n\t\t\t$url\n\tHEADERS:\n\t\t\t$headers\n\tBODY:\n\t\t\t$body');
  //   final http.StreamedResponse response = await request.send();
  //   dynamic responseJson;
  //   debugPrint('response status code is ${response.statusCode}');
  //   try {
  //     responseJson = _returnResponse(response);
  //     return responseJson;
  //   } on SocketException {
  //     throw NoInternetException();
  //   }
  // }

  // static dynamic _returnResponse(http.StreamedResponse response) async {
  //   // whenever there is an error, send it to firebase crashlytics
  //   final data = await response.stream.bytesToString();

  //   if (response.statusCode >= 400) {
  //     // ignore: avoid_print
  //     print(data);
  //   }
  //   switch (response.statusCode) {
  //     case 200:
  //       final decodedData = jsonDecode(data);
  //       // if (decodedData.runtimeType != List &&
  //       //     decodedData['success'] != null &&
  //       //     decodedData['data'] == null) {
  //       //   final SuccessResponse successResponse =
  //       //       SuccessResponse.fromJson(decodedData['success']);
  //       //   return successResponse;
  //       // }
  //       return decodedData;
  //     case 201:
  //       final decodedData = jsonDecode(data);
  //       return decodedData;
  //     case 204:
  //       FirebaseCrashlytics.instance
  //           .setCustomKey('requestUri', "${response.request?.url}");
  //       FirebaseCrashlytics.instance.setCustomKey('message', data);
  //       FirebaseCrashlytics.instance.recordError(
  //         Exception(
  //           ['mobile_error'],
  //         ),
  //         StackTrace.current,
  //         reason: "mobile_error",
  //       );
  //       log('\nERROR\n\n\t\tREQUEST:\n\t\t\t$response.request?.url\n\t\tMESSAGE:\n\t\t\t$data');
  //       throw NoContentException();
  //     case 400:
  //       final decodedData = jsonDecode(data);
  //       final ErrorResponse errorResponse =
  //           ErrorResponse.fromJson(decodedData['error']);
  //       FirebaseCrashlytics.instance
  //           .setCustomKey('requestUri', "${response.request?.url}");
  //       FirebaseCrashlytics.instance.setCustomKey('message', data);
  //       FirebaseCrashlytics.instance.recordError(
  //         Exception(
  //           ['mobile_error'],
  //         ),
  //         StackTrace.current,
  //         reason: "mobile_error",
  //       );
  //       log('\nERROR\n\n\t\tREQUEST:\n\t\t\t${response.request?.url}\n\t\tMESSAGE:\n\t\t\t$data');

  //       return errorResponse;
  //     case 404:
  //       FirebaseCrashlytics.instance
  //           .setCustomKey('requestUri', "${response.request?.url}");
  //       FirebaseCrashlytics.instance.setCustomKey('message', data);
  //       FirebaseCrashlytics.instance.recordError(
  //         Exception(
  //           ['mobile_error'],
  //         ),
  //         StackTrace.current,
  //         reason: "mobile_error",
  //       );
  //       log('\nERROR\n\n\t\tREQUEST:\n\t\t\t$response.request?.url\n\t\tMESSAGE:\n\t\t\t$data');

  //       throw NotFoundException('Not Found');
  //     case 403:
  //       FirebaseCrashlytics.instance
  //           .setCustomKey('requestUri', "${response.request?.url}");
  //       FirebaseCrashlytics.instance.setCustomKey('message', data);
  //       FirebaseCrashlytics.instance.recordError(
  //         Exception(
  //           ['mobile_error'],
  //         ),
  //         StackTrace.current,
  //         reason: "mobile_error",
  //       );
  //       log('\nERROR\n\n\t\tREQUEST:\n\t\t\t$response.request?.url\n\t\tMESSAGE:\n\t\t\t$data');

  //       throw UnauthorizedException('Incorrect credentials.');
  //     case 500:
  //       FirebaseCrashlytics.instance
  //           .setCustomKey('requestUri', "${response.request?.url}");
  //       FirebaseCrashlytics.instance.setCustomKey('message', data);
  //       FirebaseCrashlytics.instance.recordError(
  //         Exception(
  //           ['mobile_error'],
  //         ),
  //         StackTrace.current,
  //         reason: "mobile_error",
  //       );
  //       log('\nERROR\n\n\t\tREQUEST:\n\t\t\t$response.request?.url\n\t\tMESSAGE:\n\t\t\t$data');

  //       if (kDebugMode) {
  //         log(data.split('<title>').last.split('</title>').first);
  //         throw InternalServerError(data);
  //       } else {
  //         throw InternalServerError('Server Error');
  //       }
  //     default:
  //       throw FetchDataException(
  //           'Error has occured while communicating with the server.');
  //   }
  // }

  static dynamic _returnResponse(http.Response response) {
    final data = response.body;

    if (response.statusCode >= 400) {
      Hive.box('localStorage').clear();
      // Ignore: avoid_print
      print(data);
    }

    switch (response.statusCode) {
      case 200:
        final decodedData = jsonDecode(data);
        return decodedData;
      case 201:
        final decodedData = jsonDecode(data);
        return decodedData;
      case 204:
        FirebaseCrashlytics.instance
            .setCustomKey('requestUri', "${response.request?.url}");
        FirebaseCrashlytics.instance.setCustomKey('message', data);
        FirebaseCrashlytics.instance.recordError(
          Exception(['mobile_error']),
          StackTrace.current,
          reason: "mobile_error",
        );
        log('\nERROR\n\n\t\tREQUEST:\n\t\t\t${response.request?.url}\n\t\tMESSAGE:\n\t\t\t$data');
        throw NoContentException();
      case 400:
        final decodedData = jsonDecode(data);
        final Status errorResponse = Status.fromJson(decodedData['error']);
        FirebaseCrashlytics.instance
            .setCustomKey('requestUri', "${response.request?.url}");
        FirebaseCrashlytics.instance.setCustomKey('message', data);
        FirebaseCrashlytics.instance.recordError(
          Exception(['mobile_error']),
          StackTrace.current,
          reason: "mobile_error",
        );
        log('\nERROR\n\n\t\tREQUEST:\n\t\t\t${response.request?.url}\n\t\tMESSAGE:\n\t\t\t$data');
        return errorResponse;
      case 404:
        FirebaseCrashlytics.instance
            .setCustomKey('requestUri', "${response.request?.url}");
        FirebaseCrashlytics.instance.setCustomKey('message', data);
        FirebaseCrashlytics.instance.recordError(
          Exception(['mobile_error']),
          StackTrace.current,
          reason: "mobile_error",
        );
        log('\nERROR\n\n\t\tREQUEST:\n\t\t\t$response.request?.url\n\t\tMESSAGE:\n\t\t\t$data');
        throw NotFoundException('Not Found');
      case 403:
        FirebaseCrashlytics.instance
            .setCustomKey('requestUri', "${response.request?.url}");
        FirebaseCrashlytics.instance.setCustomKey('message', data);
        FirebaseCrashlytics.instance.recordError(
          Exception(['mobile_error']),
          StackTrace.current,
          reason: "mobile_error",
        );
        log('\nERROR\n\n\t\tREQUEST:\n\t\t\t$response.request?.url\n\t\tMESSAGE:\n\t\t\t$data');
        throw UnauthorizedException('Incorrect credentials.');
      case 500:
        FirebaseCrashlytics.instance
            .setCustomKey('requestUri', "${response.request?.url}");
        FirebaseCrashlytics.instance.setCustomKey('message', data);
        FirebaseCrashlytics.instance.recordError(
          Exception(['mobile_error']),
          StackTrace.current,
          reason: "mobile_error",
        );
        log('\nERROR\n\n\t\tREQUEST:\n\t\t\t$response.request?.url\n\t\tMESSAGE:\n\t\t\t$data');
        if (kDebugMode) {
          log(data.split('<title>').last.split('</title>').first);
          throw InternalServerError(data);
        } else {
          throw InternalServerError('Server Error');
        }
      default:
        throw FetchDataException(
            'Error has occurred while communicating with the server.');
    }
  }
}
