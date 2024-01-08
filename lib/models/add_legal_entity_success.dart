import 'package:capef/models/error_response.dart';

class AddLegalEntitySuccessModel {
  int? memberid;
  String? onlineid;
  String? offlineid;
  String? photoregistrationurl;
  Status? status;

  AddLegalEntitySuccessModel(
      {this.memberid,
      this.onlineid,
      this.offlineid,
      this.photoregistrationurl,
      this.status});

  AddLegalEntitySuccessModel.fromJson(Map<String, dynamic> json) {
    memberid = json["memberid"];
    onlineid = json["onlineid"];
    offlineid = json["offlineid"];
    photoregistrationurl = json["photoregistrationurl"];
    status = json["status"] == null ? null : Status.fromJson(json["status"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["memberid"] = memberid;
    data["onlineid"] = onlineid;
    data["offlineid"] = offlineid;
    data["photoregistrationurl"] = photoregistrationurl;
    if (status != null) {
      data["status"] = status?.toJson();
    }
    return data;
  }
}
