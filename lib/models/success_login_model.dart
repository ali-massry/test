import 'package:capef/models/error_response.dart';

class SuccessLoginResponse {
  bool? isfirstlogin;
  String? agentName;
  int? userid;
  dynamic usertypecode;
  dynamic usertypename;
  String? jwttoken;
  dynamic privs;
  Refreshtoken? refreshtoken;
  Status? status;

  SuccessLoginResponse(
      {this.isfirstlogin,
      this.userid,
      this.agentName,
      this.usertypecode,
      this.usertypename,
      this.jwttoken,
      this.privs,
      this.refreshtoken,
      this.status});

  SuccessLoginResponse.fromJson(Map<String, dynamic> json) {
    isfirstlogin = json["isfirstlogin"];
    userid = json["userid"];
    agentName = json["agentname"];
    usertypecode = json["usertypecode"];
    usertypename = json["usertypename"];
    jwttoken = json["jwttoken"];
    privs = json["privs"];
    refreshtoken = json["refreshtoken"] == null
        ? null
        : Refreshtoken.fromJson(json["refreshtoken"]);
    status = json["status"] == null ? null : Status.fromJson(json["status"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["isfirstlogin"] = isfirstlogin;
    data["userid"] = userid;
    data["agentname"] = agentName;
    data["usertypecode"] = usertypecode;
    data["usertypename"] = usertypename;
    data["jwttoken"] = jwttoken;
    data["privs"] = privs;
    if (refreshtoken != null) {
      data["refreshtoken"] = refreshtoken?.toJson();
    }
    if (status != null) {
      data["status"] = status?.toJson();
    }
    return data;
  }
}

class Refreshtoken {
  int? id;
  String? token;
  String? expires;
  bool? isExpired;
  String? created;
  String? createdByIp;
  dynamic revoked;
  dynamic revokedByIp;
  dynamic replacedByToken;

  Refreshtoken(
      {this.id,
      this.token,
      this.expires,
      this.isExpired,
      this.created,
      this.createdByIp,
      this.revoked,
      this.revokedByIp,
      this.replacedByToken});

  Refreshtoken.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    token = json["token"];
    expires = json["expires"];
    isExpired = json["isExpired"];
    created = json["created"];
    createdByIp = json["createdByIp"];
    revoked = json["revoked"];
    revokedByIp = json["revokedByIp"];
    replacedByToken = json["replacedByToken"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["token"] = token;
    data["expires"] = expires;
    data["isExpired"] = isExpired;
    data["created"] = created;
    data["createdByIp"] = createdByIp;
    data["revoked"] = revoked;
    data["revokedByIp"] = revokedByIp;
    data["replacedByToken"] = replacedByToken;
    return data;
  }
}
