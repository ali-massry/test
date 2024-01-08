class PersonalInformationModel {
  int? civilityId;
  String? fname;
  String? lname;
  int? genderId;
  int? maternalSituationId;
  DateTime? dateOfBirth;
  String? placeOfBorth;
  String? phone1;
  String? phone2;
  String? email;
  String? opOfBelonging;
  String? cniNumber;

  PersonalInformationModel(
      {required this.civilityId,
      required this.fname,
      required this.lname,
      required this.genderId,
      required this.cniNumber,
      required this.dateOfBirth,
      required this.email,
      required this.maternalSituationId,
      required this.opOfBelonging,
      required this.phone1,
      required this.phone2,
      required this.placeOfBorth});
}
