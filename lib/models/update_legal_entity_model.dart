// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:capef/models/error_response.dart';

class UpdateLegalEntityMemberModel {
  int? memberid;
  String? onlineid;
  String? offlineid;
  String? photoregistrationurl;
  Status? status;

  UpdateLegalEntityMemberModel(
      {this.memberid,
      this.onlineid,
      this.offlineid,
      this.photoregistrationurl,
      this.status});

  UpdateLegalEntityMemberModel.fromJson(Map<String, dynamic> json) {
    memberid = json["memberid"];
    onlineid = json["onlineid"];
    offlineid = json["offlineid"];
    photoregistrationurl = json["photoregistrationurl"];
    status = json["status"] == null ? null : Status.fromJson(json["status"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["memberid"] = memberid;
    _data["onlineid"] = onlineid;
    _data["offlineid"] = offlineid;
    _data["photoregistrationurl"] = photoregistrationurl;
    if (status != null) {
      _data["status"] = status?.toJson();
    }
    return _data;
  }
}
