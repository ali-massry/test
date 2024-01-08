class AddFishingMemberModel {
  String? offOnId;
  int? regionId;
  int? districtId;
  int? areaId;
  int? villageId;
  List<int>? linkids;
  List<Fishings>? fishings;

  AddFishingMemberModel(
      {this.offOnId,
      this.regionId,
      this.districtId,
      this.areaId,
      this.villageId,
      this.linkids,
      this.fishings});

  AddFishingMemberModel.fromJson(Map<String, dynamic> json) {
    offOnId = json["id"];
    regionId = json["regions"];
    districtId = json["districts"];
    areaId = json["areas"];
    villageId = json["villages"];
    linkids = json["linkids"] == null ? null : List<int>.from(json["linkids"]);
    fishings = json["fishings"] == null
        ? null
        : (json["fishings"] as List).map((e) => Fishings.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = offOnId;
    data["regions"] = regionId;
    data["districts"] = districtId;
    data["areas"] = areaId;
    data["villages"] = villageId;
    if (linkids != null) {
      data["linkids"] = linkids;
    }
    if (fishings != null) {
      data["fishings"] = fishings?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Fishings {
  int? unitid;
  int? speciesid;
  num? annualprodqtt;
  num? annualprodfcfa;

  Fishings(
      {this.unitid, this.speciesid, this.annualprodqtt, this.annualprodfcfa});

  Fishings.fromJson(Map<String, dynamic> json) {
    unitid = json["unitid"];
    speciesid = json["speciesid"];
    annualprodqtt = json["annualprodqtt"];
    annualprodfcfa = json["annualprodfcfa"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["unitid"] = unitid;
    data["speciesid"] = speciesid;
    data["annualprodqtt"] = annualprodqtt;
    data["annualprodfcfa"] = annualprodfcfa;
    return data;
  }
}
