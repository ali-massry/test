import 'package:capef/models/error_response.dart';

class GetOfflineDataModel {
  List<Categories>? categories;
  String? whatsappNumber;
  String? supportNumber;
  Agent? agent;
  List<Securityquestions>? securityquestions;
  Agridata? agridata;
  Fishingdata? fishingdata;
  Breedingdata? breedingdata;
  Forestandwilddata? forestandwilddata;
  List<Civilities>? civilities;
  List<Genders>? genders;
  List<Units>? units;
  List<Titles>? titles;
  List<MaterialStatus>? materialStatus;
  List<Turnovers>? turnovers;
  List<LegalEntityCategories>? legalEntityCategories;

  List<Regions>? regions;
  List<Districts>? districts;

  List<Areas>? areas;
  List<Villages>? villages;
  List<Plantationtype>? plantationtype;

  Status? status;

  GetOfflineDataModel(
      {this.categories,
      this.agent,
      this.securityquestions,
      this.whatsappNumber,
      this.supportNumber,
      this.agridata,
      this.materialStatus,
      this.fishingdata,
      this.breedingdata,
      this.forestandwilddata,
      this.genders,
      this.units,
      this.titles,
      this.legalEntityCategories,
      this.regions,
      this.districts,
      this.areas,
      this.villages,
      this.plantationtype,
      this.status});

  GetOfflineDataModel.fromJson(Map<String, dynamic> json) {
    categories = json["categories"] == null
        ? null
        : (json["categories"] as List)
            .map((e) => Categories.fromJson(e))
            .toList();
    agent = json["agent"] == null ? null : Agent.fromJson(json["agent"]);
    whatsappNumber = json["whatsappnumber"];
    supportNumber = json["supportnumber"];
    securityquestions = json["securityquestions"] == null
        ? null
        : (json["securityquestions"] as List)
            .map((e) => Securityquestions.fromJson(e))
            .toList();
    agridata =
        json["agridata"] == null ? null : Agridata.fromJson(json["agridata"]);
    fishingdata = json["fishingdata"] == null
        ? null
        : Fishingdata.fromJson(json["fishingdata"]);
    breedingdata = json["breedingdata"] == null
        ? null
        : Breedingdata.fromJson(json["breedingdata"]);
    forestandwilddata = json["forestandwilddata"] == null
        ? null
        : Forestandwilddata.fromJson(json["forestandwilddata"]);
    genders = json["genders"] == null
        ? null
        : (json["genders"] as List).map((e) => Genders.fromJson(e)).toList();
    units = json["units"] == null
        ? null
        : (json["units"] as List).map((e) => Units.fromJson(e)).toList();
    titles = json["titles"] == null
        ? null
        : (json["titles"] as List).map((e) => Titles.fromJson(e)).toList();
    turnovers = json["turnover"] == null
        ? null
        : (json["turnover"] as List).map((e) => Turnovers.fromJson(e)).toList();
    civilities = json["civilities"] == null
        ? null
        : (json["civilities"] as List)
            .map((e) => Civilities.fromJson(e))
            .toList();
    materialStatus = json["materialstatus"] == null
        ? null
        : (json["materialstatus"] as List)
            .map((e) => MaterialStatus.fromJson(e))
            .toList();
    legalEntityCategories = json["legalEntityCategories"] == null
        ? null
        : (json["legalEntityCategories"] as List)
            .map((e) => LegalEntityCategories.fromJson(e))
            .toList();
    regions = json["regions"] == null
        ? null
        : (json["regions"] as List).map((e) => Regions.fromJson(e)).toList();
    districts = json["districts"] == null
        ? null
        : (json["districts"] as List)
            .map((e) => Districts.fromJson(e))
            .toList();
    areas = json["areas"] == null
        ? null
        : (json["areas"] as List).map((e) => Areas.fromJson(e)).toList();
    villages = json["villages"] == null
        ? null
        : (json["villages"] as List).map((e) => Villages.fromJson(e)).toList();
    plantationtype = json["plantationtype"] == null
        ? null
        : (json["plantationtype"] as List)
            .map((e) => Plantationtype.fromJson(e))
            .toList();

    status = json["status"] == null ? null : Status.fromJson(json["status"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["supportnumber"] = supportNumber;
    data["whatsappnumber"] = whatsappNumber;
    if (categories != null) {
      data["categories"] = categories?.map((e) => e.toJson()).toList();
    }
    if (agent != null) {
      data["agent"] = agent?.toJson();
    }
    if (securityquestions != null) {
      data["securityquestions"] =
          securityquestions?.map((e) => e.toJson()).toList();
    }
    if (agridata != null) {
      data["agridata"] = agridata?.toJson();
    }
    if (fishingdata != null) {
      data["fishingdata"] = fishingdata?.toJson();
    }
    if (breedingdata != null) {
      data["breedingdata"] = breedingdata?.toJson();
    }
    if (forestandwilddata != null) {
      data["forestandwilddata"] = forestandwilddata?.toJson();
    }
    if (genders != null) {
      data["genders"] = genders?.map((e) => e.toJson()).toList();
    }
    if (units != null) {
      data["units"] = units?.map((e) => e.toJson()).toList();
    }
    if (titles != null) {
      data["titles"] = titles?.map((e) => e.toJson()).toList();
    }
    if (turnovers != null) {
      data["turnover"] = turnovers?.map((e) => e.toJson()).toList();
    }
    if (legalEntityCategories != null) {
      data["legalEntityCategories"] =
          legalEntityCategories?.map((e) => e.toJson()).toList();
    }
    if (regions != null) {
      data["regions"] = regions?.map((e) => e.toJson()).toList();
    }
    if (districts != null) {
      data["districts"] = districts?.map((e) => e.toJson()).toList();
    }
    if (areas != null) {
      data["areas"] = areas?.map((e) => e.toJson()).toList();
    }
    if (villages != null) {
      data["villages"] = villages?.map((e) => e.toJson()).toList();
    }
    if (plantationtype != null) {
      data["plantationtype"] = plantationtype?.map((e) => e.toJson()).toList();
    }
    if (materialStatus != null) {
      data["materialstatus"] = materialStatus?.map((e) => e.toJson()).toList();
    }
    if (status != null) {
      data["status"] = status?.toJson();
    }
    return data;
  }
}

class Villages {
  int? villageid;
  String? villagename;
  int? areaid;

  Villages({this.villageid, this.villagename, this.areaid});

  Villages.fromJson(Map<String, dynamic> json) {
    villageid = json["villageid"];
    villagename = json["villagename"];
    areaid = json["areaid"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["villageid"] = villageid;
    data["villagename"] = villagename;
    data["areaid"] = areaid;
    return data;
  }
}

class Areas {
  int? areaid;
  String? areaname;
  int? districtid;

  Areas({this.areaid, this.areaname, this.districtid});

  Areas.fromJson(Map<String, dynamic> json) {
    areaid = json["areaid"];
    areaname = json["areaname"];
    districtid = json["districtid"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["areaid"] = areaid;
    data["areaname"] = areaname;
    data["districtid"] = districtid;
    return data;
  }
}

class Districts {
  int? districtid;
  String? districtname;
  int? regionid;

  Districts({this.districtid, this.districtname, this.regionid});

  Districts.fromJson(Map<String, dynamic> json) {
    districtid = json["districtid"];
    districtname = json["districtname"];
    regionid = json["regionid"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["districtid"] = districtid;
    data["districtname"] = districtname;
    data["regionid"] = regionid;
    return data;
  }
}

class Regions {
  int? regionid;
  String? regionname;

  Regions({this.regionid, this.regionname});

  Regions.fromJson(Map<String, dynamic> json) {
    regionid = json["regionid"];
    regionname = json["regionname"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["regionid"] = regionid;
    data["regionname"] = regionname;
    return data;
  }
}

class LegalEntityCategories {
  String? name;
  String? code;
  int? id;

  LegalEntityCategories({
    this.name,
    this.id,
    this.code,
  });

  LegalEntityCategories.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    id = json["id"];
    code = json["code"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["id"] = id;
    data["code"] = code;
    return data;
  }
}

class Titles {
  String? name;
  int? id;

  Titles({this.name, this.id});

  Titles.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["id"] = id;
    return data;
  }
}

class Turnovers {
  String? name;
  int? id;

  Turnovers({this.name, this.id});

  Turnovers.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["id"] = id;
    return data;
  }
}

class Civilities {
  String? name;
  int? id;

  Civilities({this.name, this.id});

  Civilities.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["id"] = id;
    return data;
  }
}

class Units {
  int? id;
  String? name;

  Units({this.id, this.name});

  Units.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    return data;
  }
}

class MaterialStatus {
  int? id;
  String? name;

  MaterialStatus({this.id, this.name});

  MaterialStatus.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    return data;
  }
}

class Genders {
  int? id;
  String? name;
  bool? isactive;

  Genders({this.id, this.name, this.isactive});

  Genders.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    isactive = json["isactive"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["isactive"] = isactive;
    return data;
  }
}

class Forestandwilddata {
  List<Links6>? links;
  List<Forestspecies>? forestspecies;
  List<Forestessences>? forestessences;
  List<Forestproducts>? forestproducts;

  Forestandwilddata(
      {this.links,
      this.forestspecies,
      this.forestessences,
      this.forestproducts});

  Forestandwilddata.fromJson(Map<String, dynamic> json) {
    links = json["links"] == null
        ? null
        : (json["links"] as List).map((e) => Links6.fromJson(e)).toList();
    forestspecies = json["forestspecies"] == null
        ? null
        : (json["forestspecies"] as List)
            .map((e) => Forestspecies.fromJson(e))
            .toList();
    forestessences = json["forestessences"] == null
        ? null
        : (json["forestessences"] as List)
            .map((e) => Forestessences.fromJson(e))
            .toList();
    forestproducts = json["forestproducts"] == null
        ? null
        : (json["forestproducts"] as List)
            .map((e) => Forestproducts.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (links != null) {
      data["links"] = links?.map((e) => e.toJson()).toList();
    }
    if (forestspecies != null) {
      data["forestspecies"] = forestspecies?.map((e) => e.toJson()).toList();
    }
    if (forestessences != null) {
      data["forestessences"] = forestessences?.map((e) => e.toJson()).toList();
    }
    data["forestproducts"] = forestproducts;
    return data;
  }
}

class Forestessences {
  int? id;
  String? name;
  bool? isactive;
  int? essencetypeid;
  List<Links7>? links;

  Forestessences(
      {this.id, this.name, this.isactive, this.essencetypeid, this.links});

  Forestessences.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    isactive = json["isactive"];
    essencetypeid = json["essencetypeid"];
    links = json["links"] == null
        ? null
        : (json["links"] as List).map((e) => Links7.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["isactive"] = isactive;
    data["essencetypeid"] = essencetypeid;
    if (links != null) {
      data["links"] = links?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Links7 {
  int? id;
  String? name;

  Links7({this.id, this.name});

  Links7.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    return data;
  }
}

class Forestspecies {
  int? id;
  String? name;
  bool? isactive;

  Forestspecies({this.id, this.name, this.isactive});

  Forestspecies.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    isactive = json["isactive"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["isactive"] = isactive;
    return data;
  }
}

class Links6 {
  int? id;
  String? name;

  Links6({this.id, this.name});

  Links6.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    return data;
  }
}

class Breedingdata {
  List<BreedingLinks>? links;
  List<Breedingtypes>? breedingtypes;
  List<Breedingspecies>? breedingspecies;
  List<Breedinglivestock>? breedinglivestock;

  Breedingdata(
      {this.links,
      this.breedingtypes,
      this.breedingspecies,
      this.breedinglivestock});

  Breedingdata.fromJson(Map<String, dynamic> json) {
    links = json["links"] == null
        ? null
        : (json["links"] as List)
            .map((e) => BreedingLinks.fromJson(e))
            .toList();
    breedingtypes = json["breedingtypes"] == null
        ? null
        : (json["breedingtypes"] as List)
            .map((e) => Breedingtypes.fromJson(e))
            .toList();
    breedingspecies = json["breedingspecies"] == null
        ? null
        : (json["breedingspecies"] as List)
            .map((e) => Breedingspecies.fromJson(e))
            .toList();
    breedinglivestock = json["breedinglivestock"] == null
        ? null
        : (json["breedinglivestock"] as List)
            .map((e) => Breedinglivestock.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (links != null) {
      data["links"] = links?.map((e) => e.toJson()).toList();
    }
    if (breedingtypes != null) {
      data["breedingtypes"] = breedingtypes?.map((e) => e.toJson()).toList();
    }
    if (breedingspecies != null) {
      data["breedingspecies"] =
          breedingspecies?.map((e) => e.toJson()).toList();
    }
    if (breedinglivestock != null) {
      data["breedinglivestock"] =
          breedinglivestock?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Breedinglivestock {
  int? id;
  String? name;
  bool? isactive;
  dynamic speciesid;
  dynamic typeid;
  List<int>? units;

  Breedinglivestock(
      {this.id,
      this.name,
      this.isactive,
      this.speciesid,
      this.typeid,
      this.units});

  Breedinglivestock.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    isactive = json["isactive"];
    speciesid = json["speciesid"];
    typeid = json["typeid"];
    units = json["units"] == null ? null : List<int>.from(json["units"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["isactive"] = isactive;
    data["speciesid"] = speciesid;
    data["typeid"] = typeid;
    if (units != null) {
      data["units"] = units;
    }
    return data;
  }
}

class Breedingspecies {
  int? id;
  String? name;
  bool? isactive;
  int? breedingtypeid;

  Breedingspecies({this.id, this.name, this.isactive, this.breedingtypeid});

  Breedingspecies.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    isactive = json["isactive"];
    breedingtypeid = json["breedingtypeid"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["isactive"] = isactive;
    data["breedingtypeid"] = breedingtypeid;
    return data;
  }
}

class Breedingtypes {
  int? id;
  String? name;
  bool? isactive;
  List<Links5>? links;

  Breedingtypes({this.id, this.name, this.isactive, this.links});

  Breedingtypes.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    isactive = json["isactive"];
    links = json["links"] == null
        ? null
        : (json["links"] as List).map((e) => Links5.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["isactive"] = isactive;
    if (links != null) {
      data["links"] = links?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Links5 {
  int? id;
  String? name;

  Links5({this.id, this.name});

  Links5.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    return data;
  }
}

class BreedingLinks {
  int? id;
  String? name;

  BreedingLinks({this.id, this.name});

  BreedingLinks.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    return data;
  }
}

class Fishingdata {
  List<FishingLinks>? links;
  List<Species>? species;

  Fishingdata({this.links, this.species});

  Fishingdata.fromJson(Map<String, dynamic> json) {
    links = json["links"] == null
        ? null
        : (json["links"] as List).map((e) => FishingLinks.fromJson(e)).toList();
    species = json["species"] == null
        ? null
        : (json["species"] as List).map((e) => Species.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (links != null) {
      data["links"] = links?.map((e) => e.toJson()).toList();
    }
    if (species != null) {
      data["species"] = species?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Species {
  int? id;
  String? name;
  bool? isactive;
  List<Links3>? links;
  List<int>? units;

  Species({this.id, this.name, this.isactive, this.links, this.units});

  Species.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    isactive = json["isactive"];
    links = json["links"] == null
        ? null
        : (json["links"] as List).map((e) => Links3.fromJson(e)).toList();
    units = json["units"] == null ? null : List<int>.from(json["units"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["isactive"] = isactive;
    if (links != null) {
      data["links"] = links?.map((e) => e.toJson()).toList();
    }
    if (units != null) {
      data["units"] = units;
    }
    return data;
  }
}

class Links3 {
  int? id;
  String? name;

  Links3({this.id, this.name});

  Links3.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    return data;
  }
}

class FishingLinks {
  int? id;
  String? name;

  FishingLinks({this.id, this.name});

  FishingLinks.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    return data;
  }
}

class Agridata {
  List<Links>? links;
  List<Cropcategories>? cropcategories;
  List<Crops>? crops;

  Agridata({this.links, this.cropcategories, this.crops});

  Agridata.fromJson(Map<String, dynamic> json) {
    links = json["links"] == null
        ? null
        : (json["links"] as List).map((e) => Links.fromJson(e)).toList();
    cropcategories = json["cropcategories"] == null
        ? null
        : (json["cropcategories"] as List)
            .map((e) => Cropcategories.fromJson(e))
            .toList();
    crops = json["crops"] == null
        ? null
        : (json["crops"] as List).map((e) => Crops.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (links != null) {
      data["links"] = links?.map((e) => e.toJson()).toList();
    }
    if (cropcategories != null) {
      data["cropcategories"] = cropcategories?.map((e) => e.toJson()).toList();
    }
    if (crops != null) {
      data["crops"] = crops?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Crops {
  int? cropcategoryid;
  int? id;
  bool? isactive;
  String? name;
  List<int>? unitsids;

  Crops(
      {this.cropcategoryid, this.id, this.isactive, this.name, this.unitsids});

  Crops.fromJson(Map<String, dynamic> json) {
    cropcategoryid = json["cropcategoryid"];
    id = json["id"];
    isactive = json["isactive"];
    name = json["name"];
    unitsids =
        json["unitsids"] == null ? null : List<int>.from(json["unitsids"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["cropcategoryid"] = cropcategoryid;
    data["id"] = id;
    data["isactive"] = isactive;
    data["name"] = name;
    if (unitsids != null) {
      data["unitsids"] = unitsids;
    }
    return data;
  }
}

class Cropcategories {
  int? id;
  String? name;
  bool? isactive;
  List<Links1>? links;

  Cropcategories({this.id, this.name, this.isactive, this.links});

  Cropcategories.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    isactive = json["isactive"];
    links = json["links"] == null
        ? null
        : (json["links"] as List).map((e) => Links1.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["isactive"] = isactive;
    if (links != null) {
      data["links"] = links?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Links1 {
  int? id;
  String? name;

  Links1({this.id, this.name});

  Links1.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    return data;
  }
}

class Links {
  int? id;
  String? name;

  Links({this.id, this.name});

  Links.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    return data;
  }
}

class Securityquestions {
  int? id;
  String? name;

  Securityquestions({this.id, this.name});

  Securityquestions.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    return data;
  }
}

class Forestproducts {
  int? id;
  String? name;
  int? speciesid;
  int? essencetypeid;

  Forestproducts({this.id, this.name, this.speciesid, this.essencetypeid});

  Forestproducts.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    speciesid = json["speciesid"];
    essencetypeid = json["essencetypeid"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["speciesid"] = speciesid;
    data["essencetypeid"] = essencetypeid;
    return data;
  }
}

class Agent {
  int? securityquestionid;
  String? answer;
  String? name;
  int? id;
  List<int>? villageids;

  Agent(
      {this.securityquestionid,
      this.answer,
      this.name,
      this.id,
      this.villageids});

  Agent.fromJson(Map<String, dynamic> json) {
    securityquestionid = json["securityquestionid"];
    answer = json["answer"];
    name = json["name"];
    id = json["id"];
    villageids =
        json["villageids"] == null ? null : List<int>.from(json["villageids"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["securityquestionid"] = securityquestionid;
    data["answer"] = answer;
    data["name"] = name;
    data["id"] = id;
    if (villageids != null) {
      data["villageids"] = villageids;
    }
    return data;
  }
}

class Categories {
  int? id;
  String? name;

  Categories({this.id, this.name});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    return data;
  }
}

class Plantationtype {
  int? id;
  String? name;
  String? code;

  Plantationtype({this.id, this.name, this.code});

  Plantationtype.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    code = json["code"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["code"] = code;
    return data;
  }
}
