import 'dart:convert';

import 'package:capef/models/offline_data_response.dart';
import 'package:capef/services/network_service.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/functions.dart';
import 'package:hive_flutter/hive_flutter.dart';

class OfflineRepository {
  // static Future<dynamic> getOfflineData({required String jwttoken}) async {
  //   String url = '$apiUrl/Agents/GetOfflineData';
  //   Map<String, String> headers = {'Authorization': 'Bearer $jwttoken'};
  //   if (!await GlobalFunctions.hasNetwork()) {
  //     var response = jsonDecode(Hive.box('offlineData').get('data'));
  //     // return response;

  //     // var realResponse =
  //     //     GetSecurityQuestions(securityqsts: response, status: Status(code: 0));
  //     GetOfflineDataModel getOfflineDataModel =
  //         GetOfflineDataModel.fromJson(response);

  //     return getOfflineDataModel;
  //   } else {
  //     final response =
  //         await NetworkService.httpGetRequest(url: url, headers: headers);

  //     GetOfflineDataModel getSecurityQuestions =
  //         GetOfflineDataModel.fromJson(response);

  //     Hive.box('offlineData').put('data', jsonEncode(response));
  //     // var t = Hive.box('offlineData').get('data');

  //     return getSecurityQuestions;
  //   }
  // }
  static Future<dynamic> getOfflineData({required String jwttoken}) async {
    String url = '$apiUrl/Agents/GetOfflineData';
    Map<String, String> headers = {'Authorization': 'Bearer $jwttoken'};
    if (!await GlobalFunctions.hasNetwork()) {
      var response = jsonDecode(Hive.box('offlineData').get('data'));
      // return response;

      // var realResponse =
      //     GetSecurityQuestions(securityqsts: response, status: Status(code: 0));
      GetOfflineDataModel getOfflineDataModel =
          GetOfflineDataModel.fromJson(response);

      return getOfflineDataModel;
    } else {
      final response =
          await NetworkService.httpGetRequest(url: url, headers: headers);

      GetOfflineDataModel getSecurityQuestions =
          GetOfflineDataModel.fromJson(response);

      Hive.box('offlineData').put('data', jsonEncode(response));
      // var t = Hive.box('offlineData').get('data');

      return getSecurityQuestions;
    }
  }
}
