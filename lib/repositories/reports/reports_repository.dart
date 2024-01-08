import 'package:capef/models/get_detailed_report_model.dart';
import 'package:capef/models/get_general_reports_model.dart';
import 'package:capef/services/network_service.dart';
import 'package:capef/utils/constant.dart';

class ReportsRepository {
  static Future<dynamic> getGeneralReports({
    required String jwttoken,
    required String fromDate,
    required String toDate,
  }) async {
    String url = '$apiUrl/Agents/GetGeneralReport';
    // Map<String, String> headers = {'Authorization': 'Bearer $jwttoken'};
    // if (!await GlobalFunctions.hasNetwork()) {
    //   var response = jsonDecode(Hive.box('offlineData').get('data'));
    //   // return response;

    //   // var realResponse =
    //   //     GetSecurityQuestions(securityqsts: response, status: Status(code: 0));
    //   GetOfflineDataModel getOfflineDataModel =
    //       GetOfflineDataModel.fromJson(response);

    //   return getOfflineDataModel;
    // } else {

    Map<String, String> body = {"fromdate": fromDate, "todate": toDate};

    final response = await NetworkService.httpPostRequest(
        url: url, jwtToken: jwttoken, body: body);

    GetGeneralReportsModel generalReportsModel =
        GetGeneralReportsModel.fromJson(response);

    // Hive.box('offlineData').put('reports', jsonEncode(response));
    // var t = Hive.box('offlineData').get('data');

    return generalReportsModel;
    // }
  }

  static Future<dynamic> getDetailedReports({
    required String jwttoken,
    required String fromDate,
    required String toDate,
    required int categoryId,
  }) async {
    String url = '$apiUrl/Agents/GetDetailedReport';
    // Map<String, String> headers = {'Authorization': 'Bearer $jwttoken'};
    // if (!await GlobalFunctions.hasNetwork()) {
    //   var response = jsonDecode(Hive.box('offlineData').get('data'));
    //   // return response;

    //   // var realResponse =
    //   //     GetSecurityQuestions(securityqsts: response, status: Status(code: 0));
    //   GetOfflineDataModel getOfflineDataModel =
    //       GetOfflineDataModel.fromJson(response);

    //   return getOfflineDataModel;
    // } else {

    Map<String, dynamic> body = {
      "fromdate": fromDate,
      "todate": toDate,
      "catid": categoryId
    };

    final response = await NetworkService.httpPostRequest(
        url: url, jwtToken: jwttoken, body: body);

    GetDetailedReportModel getDetailedReportModel =
        GetDetailedReportModel.fromJson(response);

    // Hive.box('offlineData').put('reports', jsonEncode(response));
    // var t = Hive.box('offlineData').get('data');

    return getDetailedReportModel;
    // }
  }
}
