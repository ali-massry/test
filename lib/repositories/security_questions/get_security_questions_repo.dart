// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:capef/hive/hive_boxes.dart';
import 'package:capef/models/get_security_questions.dart';
import 'package:capef/services/network_service.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/functions.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SecurityQuestionsRepo {
  static Future<dynamic> getSecurityQuestions(
      {required String jwttoken}) async {
    String url = '$apiUrl/Agents/GetSecQsts';
    Map<String, String> headers = {'Authorization': 'Bearer $jwttoken'};
    if (!await GlobalFunctions.hasNetwork()) {
      var response =
          jsonDecode(Hive.box(ofllineDataBox).get('securityQuestions'));
      // return response;

      var a = {
        "securityqsts": response,
        "status": {"isValid": true, "message": "", "devmessage": "", "code": 0}
      };

      // var realResponse =
      //     GetSecurityQuestions(securityqsts: response, status: Status(code: 0));
      GetSecurityQuestions getSecurityQuestions =
          GetSecurityQuestions.fromJson(a);

      return getSecurityQuestions;
    } else {
      final response =
          await NetworkService.httpGetRequest(url: url, headers: headers);

      print(response);

      GetSecurityQuestions getSecurityQuestions =
          GetSecurityQuestions.fromJson(response);
      Hive.box(ofllineDataBox).put(
          'securityQuestions', jsonEncode(getSecurityQuestions.securityqsts));

      return getSecurityQuestions;
    }
  }
}
