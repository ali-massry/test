class SlipModel {
  String? type;
  String? nationalName;
  String? identificationId;
  String? telephoneNumber;
  String? qrCode;
  String? regionAndDepartment;
  String? agentName;
  String? nationalPhoneNumber;

  SlipModel(
      {required this.agentName,
      required this.identificationId,
      required this.nationalName,
      required this.nationalPhoneNumber,
      required this.qrCode,
      required this.regionAndDepartment,
      required this.telephoneNumber,
      required this.type});
}
