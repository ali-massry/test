class IpDetailsModel {
  String? status;
  String? country;
  String? countryCode;
  String? region;
  String? regionName;
  String? city;
  String? zip;
  double? lat;
  double? lon;
  String? timezone;
  String? isp;
  String? org;
  String? as;
  String? query;

  IpDetailsModel(
      {this.status,
      this.country,
      this.countryCode,
      this.region,
      this.regionName,
      this.city,
      this.zip,
      this.lat,
      this.lon,
      this.timezone,
      this.isp,
      this.org,
      this.as,
      this.query});

  IpDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["country"] is String) {
      country = json["country"];
    }
    if (json["countryCode"] is String) {
      countryCode = json["countryCode"];
    }
    if (json["region"] is String) {
      region = json["region"];
    }
    if (json["regionName"] is String) {
      regionName = json["regionName"];
    }
    if (json["city"] is String) {
      city = json["city"];
    }
    if (json["zip"] is String) {
      zip = json["zip"];
    }
    if (json["lat"] is double) {
      lat = json["lat"];
    }
    if (json["lon"] is double) {
      lon = json["lon"];
    }
    if (json["timezone"] is String) {
      timezone = json["timezone"];
    }
    if (json["isp"] is String) {
      isp = json["isp"];
    }
    if (json["org"] is String) {
      org = json["org"];
    }
    if (json["as"] is String) {
      as = json["as"];
    }
    if (json["query"] is String) {
      query = json["query"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["status"] = status;
    data["country"] = country;
    data["countryCode"] = countryCode;
    data["region"] = region;
    data["regionName"] = regionName;
    data["city"] = city;
    data["zip"] = zip;
    data["lat"] = lat;
    data["lon"] = lon;
    data["timezone"] = timezone;
    data["isp"] = isp;
    data["org"] = org;
    data["as"] = as;
    data["query"] = query;
    return data;
  }
}
