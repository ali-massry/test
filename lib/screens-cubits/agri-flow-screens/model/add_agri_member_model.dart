class AddAgriMemberModel {
  String? id;
  int? regionid;
  int? districtid;
  int? areaid;
  int? villageid;
  List<int>? linkids;
  List<Lands>? lands;

  AddAgriMemberModel({
    this.id,
    this.regionid,
    this.districtid,
    this.areaid,
    this.villageid,
    this.linkids,
    this.lands,
  });

  AddAgriMemberModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    regionid = json["regionid"];
    districtid = json["districtid"];
    areaid = json["areaid"];
    villageid = json["villageid"];
    linkids = json["linkids"] == null ? null : List<int>.from(json["linkids"]);
    lands = json["lands"] == null
        ? null
        : (json["lands"] as List).map((e) => Lands.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["regionid"] = regionid;
    data["districtid"] = districtid;
    data["areaid"] = areaid;
    data["villageid"] = villageid;
    if (linkids != null) {
      data["linkids"] = linkids;
    }
    if (lands != null) {
      data["lands"] = lands?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Lands {
  double? totalarea;
  bool? isshared;
  List<Landpartss>? landparts;

  Lands({this.totalarea, this.isshared, this.landparts});

  Lands.fromJson(Map<String, dynamic> json) {
    totalarea = json["totalarea"];
    isshared = json["isshared"];
    landparts = json["landparts"] == null
        ? null
        : (json["landparts"] as List)
            .map((e) => Landpartss.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["totalarea"] = totalarea;
    data["isshared"] = isshared;
    if (landparts != null) {
      data["landparts"] = landparts?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Landpartss {
  int? cropid;
  int? cropcatid;
  int? unitid;
  int? landpartpercentage;
  double? annualprodqtt;
  double? annualprodfcfa;

  Landpartss(
      {this.cropid,
      this.cropcatid,
      this.unitid,
      this.landpartpercentage,
      this.annualprodqtt,
      this.annualprodfcfa});

  Landpartss.fromJson(Map<String, dynamic> json) {
    cropid = json["cropid"];
    cropcatid = json["cropcatid"];
    unitid = json["unitid"];
    landpartpercentage = json["landpartpercentage"];
    annualprodqtt = json["annualprodqtt"];
    annualprodfcfa = json["annualprodfcfa"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["cropid"] = cropid;
    data["cropcatid"] = cropcatid;
    data["unitid"] = unitid;
    data["landpartpercentage"] = landpartpercentage;
    data["annualprodqtt"] = annualprodqtt;
    data["annualprodfcfa"] = annualprodfcfa;
    return data;
  }
}
