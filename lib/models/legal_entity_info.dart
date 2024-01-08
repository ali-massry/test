import 'dart:io';

class LegalEntityInfo {
  String? offlineId;
  String? legalentitycategoryid;
  String? turnoverid;
  String? name;
  String? regnumber;
  String? certificatedate;
  File? photoRegistration;
  String? pin;
  String? secanswer;
  String? securityqstid;
  String? phone1;
  String? phone2;
  String? email;
  String? website;
  String? noofmembers;
  String? women;
  String? villageid;
  String? long;
  String? lat;
  String? seasonpayment;
  String? subscriptionpayment;
  String? pobox;
  String? mainactivityid;
  String? secondaryactivityid;
  String? representativesJson;

  LegalEntityInfo({
    this.offlineId,
    this.legalentitycategoryid,
    this.turnoverid,
    this.name,
    this.regnumber,
    this.certificatedate,
    this.photoRegistration,
    this.pin,
    this.secanswer,
    this.securityqstid,
    this.phone1,
    this.phone2,
    this.email,
    this.website,
    this.noofmembers,
    this.women,
    this.villageid,
    this.long,
    this.lat,
    this.seasonpayment,
    this.subscriptionpayment,
    this.pobox,
    this.mainactivityid,
    this.secondaryactivityid,
    this.representativesJson,
  });

  Map<String, dynamic> toJson() {
    return {
      'offlineId': offlineId,
      'legalentitycategoryid': legalentitycategoryid,
      'turnoverid': turnoverid,
      'name': name,
      'regnumber': regnumber,
      'certificatedate': certificatedate,
      'pin': pin,
      'secanswer': secanswer,
      'securityqstid': securityqstid,
      'phone1': phone1,
      'phone2': phone2,
      'email': email,
      'website': website,
      'noofmembers': noofmembers,
      'women': women,
      'villageid': villageid,
      'long': long,
      'lat': lat,
      'seasonpayment': seasonpayment,
      'subscriptionpayment': subscriptionpayment,
      'pobox': pobox,
      'mainactivityid': mainactivityid,
      'secondaryactivityid': secondaryactivityid,
      'representativesJson': representativesJson,
    };
  }

  factory LegalEntityInfo.fromJson(Map<String, dynamic> json) {
    return LegalEntityInfo(
      offlineId: json['offlineId'],
      legalentitycategoryid: json['legalentitycategoryid'],
      turnoverid: json['turnoverid'],
      name: json['name'],
      regnumber: json['regnumber'],
      certificatedate: json['certificatedate'],
      pin: json['pin'],
      secanswer: json['secanswer'],
      securityqstid: json['securityqstid'],
      phone1: json['phone1'],
      phone2: json['phone2'],
      email: json['email'],
      website: json['website'],
      noofmembers: json['noofmembers'],
      women: json['women'],
      villageid: json['villageid'],
      long: json['long'],
      lat: json['lat'],
      seasonpayment: json['seasonpayment'],
      subscriptionpayment: json['subscriptionpayment'],
      pobox: json['pobox'],
      mainactivityid: json['mainactivityid'],
      secondaryactivityid: json['secondaryactivityid'],
      representativesJson: json['representativesJson'],
    );
  }
}
