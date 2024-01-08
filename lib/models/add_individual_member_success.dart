class AddIndividualMemberSuccess {
  int? memberid;
  String? onlineid;
  String? offlineid;
  String? photocnifronturl;
  String? photocnibackurl;
  String? photomemberurl;
  Status? status;

  AddIndividualMemberSuccess(
      {this.memberid,
      this.onlineid,
      this.offlineid,
      this.photocnifronturl,
      this.photocnibackurl,
      this.photomemberurl,
      this.status});

  AddIndividualMemberSuccess.fromJson(Map<String, dynamic> json) {
    memberid = json["memberid"];
    onlineid = json["onlineid"];
    offlineid = json["offlineid"];
    photocnifronturl = json["photocnifronturl"];
    photocnibackurl = json["photocnibackurl"];
    photomemberurl = json["photomemberurl"];
    status = json["status"] == null ? null : Status.fromJson(json["status"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["memberid"] = memberid;
    data["onlineid"] = onlineid;
    data["offlineid"] = offlineid;
    data["photocnifronturl"] = photocnifronturl;
    data["photocnibackurl"] = photocnibackurl;
    data["photomemberurl"] = photomemberurl;
    if (status != null) {
      data["status"] = status?.toJson();
    }
    return data;
  }
}

class Status {
  bool? isValid;
  String? message;
  String? devmessage;
  int? code;

  Status({this.isValid, this.message, this.devmessage, this.code});

  Status.fromJson(Map<String, dynamic> json) {
    isValid = json["isValid"];
    message = json["message"];
    devmessage = json["devmessage"];
    code = json["code"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["isValid"] = isValid;
    data["message"] = message;
    data["devmessage"] = devmessage;
    data["code"] = code;
    return data;
  }
}
