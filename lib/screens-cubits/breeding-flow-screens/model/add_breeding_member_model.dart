// ignore_for_file: no_leading_underscores_for_local_identifiers

class AddBreedingMemberModel {
  String? id;
  int? region;
  int? district;
  int? area;
  int? village;
  List<int>? linkids;
  List<Breedings>? breedings;

  AddBreedingMemberModel(
      {this.id,
      this.region,
      this.district,
      this.area,
      this.village,
      this.linkids,
      this.breedings});

  AddBreedingMemberModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    region = json["region"];
    district = json["district"];
    area = json["area"];
    village = json["village"];
    linkids = json["linkids"] == null ? null : List<int>.from(json["linkids"]);
    breedings = json["breedings"] == null
        ? null
        : (json["breedings"] as List)
            .map((e) => Breedings.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["region"] = region;
    _data["district"] = district;
    _data["area"] = area;
    _data["village"] = village;
    if (linkids != null) {
      _data["linkids"] = linkids;
    }
    if (breedings != null) {
      _data["breedings"] = breedings?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Breedings {
  int? typeid;
  int? speciesid;
  int? sizelivestock;
  List<Breedingproducts>? breedingproducts;

  Breedings(
      {this.typeid, this.speciesid, this.sizelivestock, this.breedingproducts});

  Breedings.fromJson(Map<String, dynamic> json) {
    typeid = json["typeid"];
    speciesid = json["speciesid"];
    sizelivestock = json["sizelivestock"];
    breedingproducts = json["breedingproducts"] == null
        ? null
        : (json["breedingproducts"] as List)
            .map((e) => Breedingproducts.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["typeid"] = typeid;
    _data["speciesid"] = speciesid;
    _data["sizelivestock"] = sizelivestock;
    if (breedingproducts != null) {
      _data["breedingproducts"] =
          breedingproducts?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Breedingproducts {
  int? unitid;
  int? livestockid;
  int? annualprodqtt;
  int? annualprodfcfa;

  Breedingproducts(
      {this.unitid, this.livestockid, this.annualprodqtt, this.annualprodfcfa});

  Breedingproducts.fromJson(Map<String, dynamic> json) {
    unitid = json["unitid"];
    livestockid = json["livestockid"];
    annualprodqtt = json["annualprodqtt"];
    annualprodfcfa = json["annualprodfcfa"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["unitid"] = unitid;
    _data["livestockid"] = livestockid;
    _data["annualprodqtt"] = annualprodqtt;
    _data["annualprodfcfa"] = annualprodfcfa;
    return _data;
  }
}
