// ignore_for_file: avoid_print

import 'package:capef/main.dart';
import 'package:capef/models/error_response.dart';
import 'package:capef/models/get_security_by_username_model.dart';
import 'package:capef/models/success_login_model.dart';
import 'package:capef/services/network_service.dart';
import 'package:capef/utils/constant.dart';

class AuthRepository {
  static Future<dynamic> agentLogin(
      {required String userName,
      required String password,
      required String language}) async {
    String url = '$apiUrl/Agents/Login';
    Map<String, String> body = {"username": userName, "password": password};
    final response = await NetworkService.httpPostRequest(
        url: url, language: language, body: body);
    SuccessLoginResponse successLoginResponse =
        SuccessLoginResponse.fromJson(response);
    return successLoginResponse;
  }

  static Future<dynamic> setFirstLogin({
    required String securityId,
    required String securityAnswer,
    required String password,
    required String jwtToken,
  }) async {
    String url = '$apiUrl/Agents/SetAgentFirstLogin';
    // Map<String, String> headers = {
    //   'Content-Type': 'application/json',
    //   'Authorization': 'Bearer $jwtToken'
    // };
    Map<String, dynamic> body = {
      "securityqstid": securityId,
      "answer": securityAnswer,
      "newpassword": password
    };

    final response = await NetworkService.httpPostRequest(
        url: url, jwtToken: jwtToken, body: body);
    print(response['status']);

    Status status = Status.fromJson(response['status']);
    return status;
  }

  static Future<dynamic> resetPassword({
    required String username,
    required String securityAnswer,
    required String securityqstid,
    required String newpassword,
  }) async {
    String url = '$apiUrl/Agents/ResetAgentPassword';
    // Map<String, String> headers = {};
    // Map<String, String> headers = {'Authorization': 'Bearer $jwtToken'};
    Map<String, String> body = {
      "username": username,
      "answer": securityAnswer,
      "newpassword": newpassword,
    };
    final response = await NetworkService.httpPostRequest(url: url, body: body);

    Status status = Status.fromJson(response['status']);
    return status;
  }

  static Future<dynamic> refreshToken({
    required String refreshToken,
    required String jwtToken,
  }) async {
    print(hasInternetNow);
    String url = '$apiUrl/Agents/RefreshToken';
    Map<String, String> body = {
      "refreshtoken": refreshToken,
      "jwttoken": jwtToken
    };

    final response = await NetworkService.httpPostRequest(url: url, body: body);

    SuccessLoginResponse successLoginResponse =
        SuccessLoginResponse.fromJson(response);
    return successLoginResponse;
  }

  static Future<dynamic> logout({required String jwtToken}) async {
    String url = '$apiUrl/Agents/logout';

    // Map<String, String> headers = {'Authorization': 'Bearer $jwtToken'};
    final response = await NetworkService.httpPostRequest(
      url: url,
      jwtToken: jwtToken,
      body: {},
    );
    Status status = Status.fromJson(response['status']);
    return status;
  }

  static Future<dynamic> getAgentByUserName({required String userName}) async {
    String url = '$apiUrl/Agents/GetAgentByUsername';

    // Map<String, String> headers = {'Authorization': 'Bearer $jwtToken'};
    final response = await NetworkService.httpPostRequest(
      url: url,
      body: {"username": userName},
    );

    GetQuestionByUserNameModel getQuestionByUserNameModel =
        GetQuestionByUserNameModel.fromJson(response);
    // Status status = Status.fromJson(response);
    return getQuestionByUserNameModel;
  }
}
