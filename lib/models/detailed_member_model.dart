// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:capef/models/error_response.dart';

class DetailedMemberModel {
  num? dbmemberid;
  String? onlineid;
  String? offlineid;
  num? membertypeid;
  String? membertypecode;
  String? membertypename;
  String? memberstatus;
  String? region;
  String? district;
  String? area;
  String? village;
  String? seasonpayment;
  String? subscriptionpayment;
  String? pobox;
  String? longitude;
  String? latitude;
  String? seasonpaymenttrx;
  String? subscriptionpaymenttrx;
  String? maincategory;
  num? maincategoryid;
  String? secondarycategory;
  num? secondarycategoryid;
  List<BreedingDetail>? breedingDetail;
  List<FishingDetail>? fishing;
  List<ForestDetail>? forests;
  List<Agri>? agri;
  Individualmember? individualmember;
  Legalentitymember? legalentitymember;
  Status? status;

  DetailedMemberModel(
      {this.dbmemberid,
      this.onlineid,
      this.offlineid,
      this.membertypeid,
      this.membertypecode,
      this.membertypename,
      this.memberstatus,
      this.region,
      this.district,
      this.area,
      this.breedingDetail,
      this.village,
      this.seasonpayment,
      this.subscriptionpayment,
      this.seasonpaymenttrx,
      this.subscriptionpaymenttrx,
      this.maincategory,
      this.maincategoryid,
      this.secondarycategory,
      this.secondarycategoryid,
      this.pobox,
      this.longitude,
      this.latitude,
      // this.breeding,
      this.fishing,
      this.forests,
      this.agri,
      this.individualmember,
      this.legalentitymember,
      this.status});

  DetailedMemberModel.fromJson(Map<String, dynamic> json) {
    dbmemberid = json["dbmemberid"];
    onlineid = json["onlineid"];
    offlineid = json["offlineid"];
    membertypeid = json["membertypeid"];
    membertypecode = json["membertypecode"];
    membertypename = json["membertypename"];
    memberstatus = json["memberstatus"];
    region = json["region"];
    district = json["district"];
    area = json["area"];
    village = json["village"];
    seasonpayment = json["seasonpayment"];
    pobox = json["pobox"];
    longitude = json["longitude"];
    latitude = json["latitude"];
    subscriptionpayment = json["subscriptionpayment"];
    seasonpaymenttrx = json["seasonpaymenttrx"];
    subscriptionpaymenttrx = json["subscriptionpaymenttrx"];
    maincategory = json["maincategory"];
    maincategoryid = json["maincategoryid"];
    secondarycategory = json["secondarycategory"];
    secondarycategoryid = json["secondarycategoryid"];
    // breeding = json["breeding"];
    breedingDetail = json["breeding"] == null
        ? null
        : (json["breeding"] as List)
            .map((e) => BreedingDetail.fromJson(e))
            .toList();
    fishing = json["fishing"] == null
        ? null
        : (json["fishing"] as List)
            .map((e) => FishingDetail.fromJson(e))
            .toList();
    forests = json["forests"] == null
        ? null
        : (json["forests"] as List)
            .map((e) => ForestDetail.fromJson(e))
            .toList();
    agri = json["agri"] == null
        ? null
        : (json["agri"] as List).map((e) => Agri.fromJson(e)).toList();
    individualmember = json["individualmember"] == null
        ? null
        : Individualmember.fromJson(json["individualmember"]);
    // legalentitymember = json["legalentitymember"];
    legalentitymember = json["legalentitymember"] == null
        ? null
        : Legalentitymember.fromJson(json["legalentitymember"]);
    status = json["status"] == null ? null : Status.fromJson(json["status"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["dbmemberid"] = dbmemberid;
    data["onlineid"] = onlineid;
    data["offlineid"] = offlineid;
    data["membertypeid"] = membertypeid;
    data["membertypecode"] = membertypecode;
    data["membertypename"] = membertypename;
    data["memberstatus"] = memberstatus;
    data["region"] = region;
    data["district"] = district;
    data["area"] = area;
    data["village"] = village;
    data["seasonpayment"] = seasonpayment;
    data["subscriptionpayment"] = subscriptionpayment;
    data["pobox"] = pobox;
    data["longitude"] = longitude;
    data["latitude"] = latitude;
    data["seasonpaymenttrx"] = seasonpaymenttrx;
    data["subscriptionpaymenttrx"] = subscriptionpaymenttrx;
    data["maincategory"] = maincategory;
    data["maincategoryid"] = maincategoryid;
    data["secondarycategory"] = secondarycategory;
    data["secondarycategoryid"] = secondarycategoryid;
    if (breedingDetail != null) {
      data["breeding"] = breedingDetail?.map((e) => e.toJson()).toList();
    }
    if (fishing != null) {
      data["fishing"] = fishing?.map((e) => e.toJson()).toList();
    }
    // data["forests"] = forests;
    if (forests != null) {
      data["forests"] = forests?.map((e) => e.toJson()).toList();
    }
    if (agri != null) {
      data["agri"] = agri?.map((e) => e.toJson()).toList();
    }
    if (individualmember != null) {
      data["individualmember"] = individualmember?.toJson();
    }
    if (legalentitymember != null) {
      data["legalentitymember"] = legalentitymember?.toJson();
    }
    // data["legalentitymember"] = legalentitymember;
    if (status != null) {
      data["status"] = status?.toJson();
    }
    return data;
  }
}

class Individualmember {
  num? civilityid;
  String? firstname;
  String? lastname;
  String? gender;
  num? genderid;
  String? materialstatus;
  num? materialstatusid;
  String? dob;
  String? placeofbirth;
  String? telephone1;
  String? telephone2;
  String? email;
  String? op;
  String? cni;
  String? photomember;
  String? photofront;
  String? photoback;

  Individualmember(
      {this.civilityid,
      this.firstname,
      this.lastname,
      this.gender,
      this.genderid,
      this.materialstatus,
      this.materialstatusid,
      this.dob,
      this.placeofbirth,
      this.telephone1,
      this.telephone2,
      this.email,
      this.op,
      this.cni,
      this.photomember,
      this.photofront,
      this.photoback});

  Individualmember.fromJson(Map<String, dynamic> json) {
    civilityid = json["civilityid"];
    firstname = json["firstname"];
    lastname = json["lastname"];
    gender = json["gender"];
    genderid = json["genderid"];
    materialstatus = json["materialstatus"];
    materialstatusid = json["materialstatusid"];
    dob = json["dob"];
    placeofbirth = json["placeofbirth"];
    telephone1 = json["telephone1"];
    telephone2 = json["telephone2"];
    email = json["email"];
    op = json["op"];
    cni = json["cni"];
    photomember = json["photomember"];
    photofront = json["photofront"];
    photoback = json["photoback"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["civilityid"] = civilityid;
    data["firstname"] = firstname;
    data["lastname"] = lastname;
    data["gender"] = gender;
    data["genderid"] = genderid;
    data["materialstatus"] = materialstatus;
    data["materialstatusid"] = materialstatusid;
    data["dob"] = dob;
    data["placeofbirth"] = placeofbirth;
    data["telephone1"] = telephone1;
    data["telephone2"] = telephone2;
    data["email"] = email;
    data["op"] = op;
    data["cni"] = cni;
    data["photomember"] = photomember;
    data["photofront"] = photofront;
    data["photoback"] = photoback;
    return data;
  }
}

class Agri {
  num? membercatid;
  num? memberid;
  bool? ismain;
  num? regionid;
  num? districtid;
  num? areaid;
  num? villageid;
  List<num>? linkids;
  List<LandsMember>? lands;

  Agri(
      {this.membercatid,
      this.memberid,
      this.ismain,
      this.regionid,
      this.districtid,
      this.areaid,
      this.villageid,
      this.linkids,
      this.lands});

  Agri.fromJson(Map<String, dynamic> json) {
    membercatid = json["membercatid"];
    memberid = json["memberid"];
    ismain = json["ismain"];
    regionid = json["regionid"];
    districtid = json["districtid"];
    areaid = json["areaid"];
    villageid = json["villageid"];
    linkids = json["linkids"] == null ? null : List<num>.from(json["linkids"]);
    lands = json["lands"] == null
        ? null
        : (json["lands"] as List).map((e) => LandsMember.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["membercatid"] = membercatid;
    data["memberid"] = memberid;
    data["ismain"] = ismain;
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

class LandsMember {
  num? totalarea;
  bool? isshared;
  List<Landparts>? landparts;

  LandsMember({this.totalarea, this.isshared, this.landparts});

  LandsMember.fromJson(Map<String, dynamic> json) {
    totalarea = json["totalarea"];
    isshared = json["isshared"];
    landparts = json["landparts"] == null
        ? null
        : (json["landparts"] as List)
            .map((e) => Landparts.fromJson(e))
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

class Landparts {
  num? cropid;
  num? cropcatid;
  num? unitid;
  num? landpartpercentage;
  num? annualprodqtt;
  num? annualprodfcfa;

  Landparts(
      {this.cropid,
      this.cropcatid,
      this.unitid,
      this.landpartpercentage,
      this.annualprodqtt,
      this.annualprodfcfa});

  Landparts.fromJson(Map<String, dynamic> json) {
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

class FishingDetail {
  num? membercatid;
  num? memberid;
  bool? ismain;
  num? regionid;
  num? districtid;
  num? areaid;
  num? villageid;
  List<num>? linkids;
  List<Fishings>? fishings;

  FishingDetail(
      {this.membercatid,
      this.memberid,
      this.ismain,
      this.regionid,
      this.districtid,
      this.areaid,
      this.villageid,
      this.linkids,
      this.fishings});

  FishingDetail.fromJson(Map<String, dynamic> json) {
    membercatid = json["membercatid"];
    memberid = json["memberid"];
    ismain = json["ismain"];
    regionid = json["regionid"];
    districtid = json["districtid"];
    areaid = json["areaid"];
    villageid = json["villageid"];
    linkids = json["linkids"] == null ? null : List<num>.from(json["linkids"]);
    fishings = json["fishings"] == null
        ? null
        : (json["fishings"] as List).map((e) => Fishings.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["membercatid"] = membercatid;
    data["memberid"] = memberid;
    data["ismain"] = ismain;
    data["regionid"] = regionid;
    data["districtid"] = districtid;
    data["areaid"] = areaid;
    data["villageid"] = villageid;
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
  num? unitid;
  num? speciesid;
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

class BreedingDetail {
  num? membercatid;
  num? memberid;
  bool? ismain;
  dynamic createddate;
  num? regionid;
  num? districtid;
  num? areaid;
  num? villageid;
  List<num>? linkids;
  List<Breedings>? breedings;

  BreedingDetail(
      {this.membercatid,
      this.memberid,
      this.ismain,
      this.createddate,
      this.regionid,
      this.districtid,
      this.areaid,
      this.villageid,
      this.linkids,
      this.breedings});

  BreedingDetail.fromJson(Map<String, dynamic> json) {
    membercatid = json["membercatid"];
    memberid = json["memberid"];
    ismain = json["ismain"];
    createddate = json["createddate"];
    regionid = json["regionid"];
    districtid = json["districtid"];
    areaid = json["areaid"];
    villageid = json["villageid"];
    linkids = json["linkids"] == null ? null : List<num>.from(json["linkids"]);
    breedings = json["breedings"] == null
        ? null
        : (json["breedings"] as List)
            .map((e) => Breedings.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["membercatid"] = membercatid;
    data["memberid"] = memberid;
    data["ismain"] = ismain;
    data["createddate"] = createddate;
    data["regionid"] = regionid;
    data["districtid"] = districtid;
    data["areaid"] = areaid;
    data["villageid"] = villageid;
    if (linkids != null) {
      data["linkids"] = linkids;
    }
    if (breedings != null) {
      data["breedings"] = breedings?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Breedings {
  num? typeid;
  num? speciesid;
  num? sizelivestock;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data["typeid"] = typeid;
    data["speciesid"] = speciesid;
    data["sizelivestock"] = sizelivestock;
    if (breedingproducts != null) {
      data["breedingproducts"] =
          breedingproducts?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Breedingproducts {
  num? livestockid;
  num? annualprodqtt;
  num? unitid;
  num? annualprodfcfa;

  Breedingproducts(
      {this.livestockid, this.annualprodqtt, this.unitid, this.annualprodfcfa});

  Breedingproducts.fromJson(Map<String, dynamic> json) {
    livestockid = json["livestockid"];
    annualprodqtt = json["annualprodqtt"];
    unitid = json["unitid"];
    annualprodfcfa = json["annualprodfcfa"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["livestockid"] = livestockid;
    data["annualprodqtt"] = annualprodqtt;
    data["unitid"] = unitid;
    data["annualprodfcfa"] = annualprodfcfa;
    return data;
  }
}

class ForestDetail {
  num? membercatid;
  num? memberid;
  bool? ismain;
  num? regionid;
  num? districtid;
  num? areaid;
  num? villageid;
  List<num>? linkids;
  List<Forests>? forests;

  ForestDetail(
      {this.membercatid,
      this.memberid,
      this.ismain,
      this.regionid,
      this.districtid,
      this.areaid,
      this.villageid,
      this.linkids,
      this.forests});

  ForestDetail.fromJson(Map<String, dynamic> json) {
    membercatid = json["membercatid"];
    memberid = json["memberid"];
    ismain = json["ismain"];
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
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["membercatid"] = membercatid;
    _data["memberid"] = memberid;
    _data["ismain"] = ismain;
    _data["regionid"] = regionid;
    _data["districtid"] = districtid;
    _data["areaid"] = areaid;
    _data["villageid"] = villageid;
    if (linkids != null) {
      _data["linkids"] = linkids;
    }
    if (forests != null) {
      _data["forests"] = forests?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Forests {
  num? speciesid;
  num? prodid;
  num? qty;
  num? unitid;
  num? annualprodfcfa;
  num? cultivatedarea;
  dynamic plantationtypeid;

  Forests(
      {this.speciesid,
      this.prodid,
      this.qty,
      this.unitid,
      this.annualprodfcfa,
      this.cultivatedarea,
      this.plantationtypeid});

  Forests.fromJson(Map<String, dynamic> json) {
    speciesid = json["speciesid"];
    prodid = json["prodid"];
    qty = json["qty"];
    unitid = json["unitid"];
    annualprodfcfa = json["annualprodfcfa"];
    cultivatedarea = json["cultivatedarea"];
    plantationtypeid = json["plantationtypeid"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["speciesid"] = speciesid;
    _data["prodid"] = prodid;
    _data["qty"] = qty;
    _data["unitid"] = unitid;
    _data["annualprodfcfa"] = annualprodfcfa;
    _data["cultivatedarea"] = cultivatedarea;
    _data["plantationtypeid"] = plantationtypeid;
    return _data;
  }
}

class Legalentitymember {
  List<Representatives>? representatives;
  int? civilityid;
  int? titleid;
  String? legalentitycategoryname;
  int? legalentitycategoryid;
  String? turnover;
  int? turnoverid;
  String? name;
  String? registrationnumber;
  String? certdate;
  String? telephone1;
  String? telephone2;
  String? email;
  String? website;
  String? numberofmembers;
  String? women;
  String? photocertificate;

  Legalentitymember(
      {this.representatives,
      this.civilityid,
      this.titleid,
      this.legalentitycategoryname,
      this.legalentitycategoryid,
      this.turnover,
      this.turnoverid,
      this.name,
      this.registrationnumber,
      this.certdate,
      this.telephone1,
      this.telephone2,
      this.email,
      this.website,
      this.numberofmembers,
      this.women,
      this.photocertificate});

  Legalentitymember.fromJson(Map<String, dynamic> json) {
    representatives = json["representatives"] == null
        ? null
        : (json["representatives"] as List)
            .map((e) => Representatives.fromJson(e))
            .toList();
    civilityid = json["civilityid"];
    titleid = json["titleid"];
    legalentitycategoryname = json["legalentitycategoryname"];
    legalentitycategoryid = json["legalentitycategoryid"];
    turnover = json["turnover"];
    turnoverid = json["turnoverid"];
    name = json["name"];
    registrationnumber = json["registrationnumber"];
    certdate = json["certdate"];
    telephone1 = json["telephone1"];
    telephone2 = json["telephone2"];
    email = json["email"];
    website = json["website"];
    numberofmembers = json["numberofmembers"];
    women = json["women"];
    photocertificate = json["photocertificate"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (representatives != null) {
      _data["representatives"] =
          representatives?.map((e) => e.toJson()).toList();
    }
    _data["civilityid"] = civilityid;
    _data["titleid"] = titleid;
    _data["legalentitycategoryname"] = legalentitycategoryname;
    _data["legalentitycategoryid"] = legalentitycategoryid;
    _data["turnover"] = turnover;
    _data["turnoverid"] = turnoverid;
    _data["name"] = name;
    _data["registrationnumber"] = registrationnumber;
    _data["certdate"] = certdate;
    _data["telephone1"] = telephone1;
    _data["telephone2"] = telephone2;
    _data["email"] = email;
    _data["website"] = website;
    _data["numberofmembers"] = numberofmembers;
    _data["women"] = women;
    _data["photocertificate"] = photocertificate;
    return _data;
  }
}

class Representatives {
  int? titleid;
  int? civilityid;
  String? firstname;
  String? lastname;
  String? phonenumber;
  String? email;
  String? address;

  Representatives(
      {this.titleid,
      this.civilityid,
      this.firstname,
      this.lastname,
      this.phonenumber,
      this.address,
      this.email});

  Representatives.fromJson(Map<String, dynamic> json) {
    titleid = json["titleid"];
    civilityid = json["civilityid"];
    firstname = json["firstname"];
    lastname = json["lastname"];
    phonenumber = json["phonenumber"];
    email = json["email"];
    address = json["address"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["titleid"] = titleid;
    _data["civilityid"] = civilityid;
    _data["firstname"] = firstname;
    _data["lastname"] = lastname;
    _data["phonenumber"] = phonenumber;
    _data["email"] = email;
    _data["address"] = address;
    return _data;
  }
}
