import 'dart:io';

class UserInfo {
  File? photocniback;
  File? photocnifront;
  File? photomember;
  String firstname;
  String lastname;
  String offlineId;
  String meterialStatusid;
  String pin;
  String secanswer;
  String securityqstid;
  String pobox;
  String latitude;
  String longitude;
  String mainactivityid;
  String secondaryactivityid;
  String civilityid;
  String genderid;
  String dob;
  String placeofbirth;
  String phone1;
  String phone2;
  String email;
  String op;
  String cni;
  String villageid;
  String seasonpayment;
  String subscriptionpayment;

  UserInfo({
    this.photocniback,
    this.photocnifront,
    this.photomember,
    required this.firstname,
    required this.lastname,
    required this.offlineId,
    required this.meterialStatusid,
    required this.pin,
    required this.secanswer,
    required this.securityqstid,
    required this.pobox,
    required this.latitude,
    required this.longitude,
    required this.mainactivityid,
    required this.secondaryactivityid,
    required this.civilityid,
    required this.genderid,
    required this.dob,
    required this.placeofbirth,
    required this.phone1,
    required this.phone2,
    required this.email,
    required this.op,
    required this.cni,
    required this.villageid,
    required this.seasonpayment,
    required this.subscriptionpayment,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      photocniback: File(json['photocniback']),
      photocnifront: File(json['photocnifront']),
      photomember: File(json['photomember']),
      firstname: json['firstname'],
      lastname: json['lastname'],
      offlineId: json['offlineId'],
      meterialStatusid: json['meterialStatusid'],
      pin: json['pin'],
      secanswer: json['secanswer'],
      securityqstid: json['securityqstid'],
      pobox: json['pobox'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      mainactivityid: json['mainactivityid'],
      secondaryactivityid: json['secondaryactivityid'],
      civilityid: json['civilityid'],
      genderid: json['genderid'],
      dob: json['dob'],
      placeofbirth: json['placeofbirth'],
      phone1: json['phone1'],
      phone2: json['phone2'],
      email: json['email'],
      op: json['op'],
      cni: json['cni'],
      villageid: json['villageid'],
      seasonpayment: json['seasonpayment'],
      subscriptionpayment: json['subscriptionpayment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'photocniback': photocniback?.path,
      'photocnifront': photocnifront?.path,
      'photomember': photomember?.path,
      'firstname': firstname,
      'lastname': lastname,
      'offlineId': offlineId,
      'meterialStatusid': meterialStatusid,
      'pin': pin,
      'secanswer': secanswer,
      'securityqstid': securityqstid,
      'pobox': pobox,
      'latitude': latitude,
      'longitude': longitude,
      'mainactivityid': mainactivityid,
      'secondaryactivityid': secondaryactivityid,
      'civilityid': civilityid,
      'genderid': genderid,
      'dob': dob,
      'placeofbirth': placeofbirth,
      'phone1': phone1,
      'phone2': phone2,
      'email': email,
      'op': op,
      'cni': cni,
      'villageid': villageid,
      'seasonpayment': seasonpayment,
      'subscriptionpayment': subscriptionpayment,
    };
  }
}
