import 'package:capef/models/error_response.dart';

class GetQuestionByUserNameModel {
  int? securityqstid;
  String? username;
  String? securityqst;
  dynamic securityqstfr;
  Status? status;

  GetQuestionByUserNameModel(
      {this.securityqstid,
      this.username,
      this.securityqst,
      this.securityqstfr,
      this.status});

  GetQuestionByUserNameModel.fromJson(Map<String, dynamic> json) {
    securityqstid = json["securityqstid"];
    username = json["username"];
    securityqst = json["securityqst"];
    securityqstfr = json["securityqstfr"];
    status = json["status"] == null ? null : Status.fromJson(json["status"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["securityqstid"] = securityqstid;
    data["username"] = username;
    data["securityqst"] = securityqst;
    data["securityqstfr"] = securityqstfr;
    if (status != null) {
      data["status"] = status?.toJson();
    }
    return data;
  }
}
