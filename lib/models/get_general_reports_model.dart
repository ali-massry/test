import 'package:capef/models/error_response.dart';

class GetGeneralReportsModel {
  String? fromdate;
  String? todate;
  int? totalcount;
  int? agricount;
  int? breedingcount;
  int? forestscount;
  int? fishingcount;
  Status? status;

  GetGeneralReportsModel(
      {this.fromdate,
      this.todate,
      this.totalcount,
      this.agricount,
      this.breedingcount,
      this.forestscount,
      this.fishingcount,
      this.status});

  GetGeneralReportsModel.fromJson(Map<String, dynamic> json) {
    fromdate = json["fromdate"];
    todate = json["todate"];
    totalcount = json["totalcount"];
    agricount = json["agricount"];
    breedingcount = json["breedingcount"];
    forestscount = json["forestscount"];
    fishingcount = json["fishingcount"];
    status = json["status"] == null ? null : Status.fromJson(json["status"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["fromdate"] = fromdate;
    data["todate"] = todate;
    data["totalcount"] = totalcount;
    data["agricount"] = agricount;
    data["breedingcount"] = breedingcount;
    data["forestscount"] = forestscount;
    data["fishingcount"] = fishingcount;
    if (status != null) {
      data["status"] = status?.toJson();
    }
    return data;
  }
}
