import 'package:capef/screens-cubits/physical-person-flow/step-2/step_2_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PersonalInfoWithLocationInfoModel {
  final PersonalInfoWithPhotoModel? addPhysicalMemberStep2Model;
  final int? regionId;
  final int? departmentId;
  final int? areaId;
  final int? villageId;
  final String? mailBox;
  final LatLng? latLng;

  PersonalInfoWithLocationInfoModel(
      {required this.addPhysicalMemberStep2Model,
      required this.areaId,
      required this.departmentId,
      required this.latLng,
      required this.mailBox,
      required this.regionId,
      required this.villageId});
}
