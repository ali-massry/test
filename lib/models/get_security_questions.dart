import 'package:capef/models/error_response.dart';

class GetSecurityQuestions {
  List<Securityqsts>? securityqsts;
  Status? status;

  GetSecurityQuestions({this.securityqsts, this.status});

  GetSecurityQuestions.fromJson(Map<String, dynamic> json) {
    securityqsts = json["securityqsts"] == null
        ? null
        : (json["securityqsts"] as List)
            .map((e) => Securityqsts.fromJson(e))
            .toList();
    status = json["status"] == null ? null : Status.fromJson(json["status"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (securityqsts != null) {
      data["securityqsts"] = securityqsts?.map((e) => e.toJson()).toList();
    }
    if (status != null) {
      data["status"] = status?.toJson();
    }
    return data;
  }
}

class Securityqsts {
  int? id;
  String? name;

  Securityqsts({this.id, this.name});

  Securityqsts.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    return data;
  }
}
