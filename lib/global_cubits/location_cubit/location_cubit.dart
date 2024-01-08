// ignore_for_file: avoid_print

import 'package:capef/utils/functions.dart';
import 'package:capef/models/offline_data_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());
  int? regionId;
  int? districtId;
  int? areaId;
  int? villageId;
  List<Districts>? districts;
  List<Areas>? areas;
  List<Villages>? villages;
  Position? position;

  Future getNowLocation() async {
    try {
      Position? locationData = await GlobalFunctions.determinePosition();
      position = locationData;
      print(position);
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<void> changeDistirctAccrodingToRegion(
      {required List<Districts> districtslist, required int regionIdd}) async {
    districts = districtslist
        .where((element) => element.regionid == regionIdd)
        .toList();
    emit(LocationSuccess(
        districtList: districts, areasList: areas, villagesList: villages));
  }

  Future<void> changeAreaAccrodingToDistrict(
      {required List<Areas> areaslist, required int districtId}) async {
    areas =
        areaslist.where((element) => element.districtid == districtId).toList();
    emit(LocationSuccess(
        districtList: districts, areasList: areas, villagesList: villages));
  }

  Future<void> changeVillageAccrodingToArea(
      {required List<Villages> villageslist, required int areaId}) async {
    villages =
        villageslist.where((element) => element.areaid == areaId).toList();
    emit(LocationSuccess(
        areasList: areas, districtList: districts, villagesList: villages));
  }
}
