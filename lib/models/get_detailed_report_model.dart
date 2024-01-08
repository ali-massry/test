// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:capef/models/error_response.dart';

class GetDetailedReportModel {
  String? fromdate;
  String? todate;
  int? count;
  List<Data>? data;
  Status? status;

  GetDetailedReportModel(
      {this.fromdate, this.todate, this.count, this.data, this.status});

  GetDetailedReportModel.fromJson(Map<String, dynamic> json) {
    fromdate = json["fromdate"];
    todate = json["todate"];
    count = json["count"];
    data = json["data"] == null
        ? null
        : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
    status = json["status"] == null ? null : Status.fromJson(json["status"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["fromdate"] = fromdate;
    _data["todate"] = todate;
    _data["count"] = count;
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    if (status != null) {
      _data["status"] = status?.toJson();
    }
    return _data;
  }
}

class Data {
  String? offlineid;
  String? onlineid;
  String? status;
  String? statuscode;
  String? datestr;
  String? membername;

  Data(
      {this.offlineid,
      this.onlineid,
      this.status,
      this.statuscode,
      this.datestr,
      this.membername});

  Data.fromJson(Map<String, dynamic> json) {
    offlineid = json["offlineid"];
    onlineid = json["onlineid"];
    status = json["status"];
    statuscode = json["statuscode"];
    datestr = json["datestr"];
    membername = json["membername"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["offlineid"] = offlineid;
    _data["onlineid"] = onlineid;
    _data["status"] = status;
    _data["statuscode"] = statuscode;
    _data["datestr"] = datestr;
    _data["membername"] = membername;
    return _data;
  }
}
