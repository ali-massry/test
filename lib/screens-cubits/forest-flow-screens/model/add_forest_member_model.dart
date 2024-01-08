class AddForestMemberModel {
  String? id;
  num? regionid;
  num? districtid;
  num? areaid;
  num? villageid;
  List<num>? linkids;
  List<Forests>? forests;

  AddForestMemberModel({
    this.id,
    this.regionid,
    this.districtid,
    this.areaid,
    this.villageid,
    this.linkids,
    this.forests,
  });

  AddForestMemberModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    regionid = json["regionid"];
    districtid = json["districtid"];
    areaid = json["areaid"];
    villageid = json["villageid"];
    linkids = json["linkids"] == null ? null : List<num>.from(json["linkids"]);
    forests = json["forests"] == null
        ? null
        : (json["forests"] as List).map((e) => Forests.fromJson(e)).toList();
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
    if (forests != null) {
      data["forests"] = forests?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Forests {
  num? linkid;
  num? speciesid;
  num? prodid;
  num? qty;
  num? unitid;
  num? annualprodfcfa;
  num? cultivatedarea;
  dynamic plantationtypeid;
  int? essenceid;

  Forests({
    this.linkid,
    this.speciesid,
    this.prodid,
    this.qty,
    this.unitid,
    this.annualprodfcfa,
    this.cultivatedarea,
    this.plantationtypeid,
   required this.essenceid
  });

  Forests.fromJson(Map<String, dynamic> json) {
    linkid = json["linkid"];
    speciesid = json["speciesid"];
    prodid = json["prodid"];
    qty = json["qty"];
    unitid = json["unitid"];
    annualprodfcfa = json["annualprodfcfa"];
    cultivatedarea = json["cultivatedarea"];
    plantationtypeid = json["plantationtypeid"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["linkid"] = linkid;
    data["speciesid"] = speciesid;
    data["prodid"] = prodid;
    data["qty"] = qty;
    data["unitid"] = unitid;
    data["annualprodfcfa"] = annualprodfcfa;
    data["cultivatedarea"] = cultivatedarea;
    data["plantationtypeid"] = plantationtypeid;
    return data;
  }
}
