import 'dart:io';

import 'package:capef/screens-cubits/physical-person-flow/step-1/personal_info.dart';

class PersonalInfoWithPhotoModel {
  PersonalInformationModel? addPhysicalMemberStep1Model;
  File? nationalPhoto;
  File? rectoPhoto;
  File? versoPhoto;

  PersonalInfoWithPhotoModel(
      {required this.addPhysicalMemberStep1Model,
      required this.nationalPhoto,
      required this.rectoPhoto,
      required this.versoPhoto});
}
