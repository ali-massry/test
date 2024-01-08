// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:capef/models/error_response.dart';

class UpdateLIndividualMemberModel {
  int? memberid;
  String? onlineid;
  String? offlineid;
  String? photocnifronturl;
  String? photocnibackurl;
  String? photomemberurl;
  Status? status;

  UpdateLIndividualMemberModel(
      {this.memberid,
      this.onlineid,
      this.offlineid,
      this.photocnifronturl,
      this.photocnibackurl,
      this.photomemberurl,
      this.status});

  UpdateLIndividualMemberModel.fromJson(Map<String, dynamic> json) {
    memberid = json["memberid"];
    onlineid = json["onlineid"];
    offlineid = json["offlineid"];
    photocnifronturl = json["photocnifronturl"];
    photocnibackurl = json["photocnibackurl"];
    photomemberurl = json["photomemberurl"];
    status = json["status"] == null ? null : Status.fromJson(json["status"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["memberid"] = memberid;
    _data["onlineid"] = onlineid;
    _data["offlineid"] = offlineid;
    _data["photocnifronturl"] = photocnifronturl;
    _data["photocnibackurl"] = photocnibackurl;
    _data["photomemberurl"] = photomemberurl;
    if (status != null) {
      _data["status"] = status?.toJson();
    }
    return _data;
  }
}
