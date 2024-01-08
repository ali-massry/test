import 'package:capef/screens-cubits/physical-person-flow/step-3/step_3_model.dart';

class PersonalInfoWithLocationInfoWithPrinciplesModel {
  PersonalInfoWithLocationInfoModel? step3model;
  int? proncipleId;
  int? secondaryId;

  PersonalInfoWithLocationInfoWithPrinciplesModel({
    required this.step3model,
    required this.proncipleId,
    this.secondaryId,
  });
}
