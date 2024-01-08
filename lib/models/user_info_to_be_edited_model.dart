import 'dart:io';

class UserInfoEdited {
  File? photocniback;
  File? photocnifront;
  File? photomember;
  String firstname;
  String lastname;
  String onlineId;
  String meterialStatusid;
  String civilityid;
  String genderid;
  String dob;
  String placeofbirth;
  String phone1;
  String phone2;
  String email;
  String op;
  String cni;

  UserInfoEdited({
    this.photocniback,
    this.photocnifront,
    this.photomember,
    required this.firstname,
    required this.lastname,
    required this.onlineId,
    required this.meterialStatusid,
    required this.civilityid,
    required this.genderid,
    required this.dob,
    required this.placeofbirth,
    required this.phone1,
    required this.phone2,
    required this.email,
    required this.op,
    required this.cni,
  });

  factory UserInfoEdited.fromJson(Map<String, dynamic> json) {
    return UserInfoEdited(
        photocniback: File(json['photocniback']),
        photocnifront: File(json['photocnifront']),
        photomember: File(json['photomember']),
        firstname: json['firstname'],
        lastname: json['lastname'],
        meterialStatusid: json['meterialStatusid'],
        civilityid: json['civilityid'],
        genderid: json['genderid'],
        dob: json['dob'],
        onlineId: json['onlineId'],
        placeofbirth: json['placeofbirth'],
        phone1: json['phone1'],
        phone2: json['phone2'],
        email: json['email'],
        op: json['op'],
        cni: json['cni']);
  }

  Map<String, dynamic> toJson() {
    return {
      'photocniback': photocniback?.path,
      'photocnifront': photocnifront?.path,
      'photomember': photomember?.path,
      'firstname': firstname,
      'lastname': lastname,
      'meterialStatusid': meterialStatusid,
      'civilityid': civilityid,
      'genderid': genderid,
      'dob': dob,
      'placeofbirth': placeofbirth,
      'phone1': phone1,
      'phone2': phone2,
      'email': email,
      'op': op,
      'cni': cni
    };
  }
}
