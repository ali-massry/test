import 'package:capef/screens-cubits/physical-person-flow/step-5/step_5_model.dart';

class WholeUserInfoWithoutPrinciplesDetailsModel {
  PersonalInfoWithLocationInfoWithPrinciplesWithNumbersModel? step5model;
  int? questionId;
  int? pin;
  String? response;

  WholeUserInfoWithoutPrinciplesDetailsModel({
    required this.step5model,
    required this.pin,
    this.questionId,
    required this.response,
  });
}
