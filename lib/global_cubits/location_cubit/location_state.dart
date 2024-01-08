part of 'location_cubit.dart';

sealed class LocationState {}

final class LocationInitial extends LocationState {}

final class LocationSuccess extends LocationState {
  List<Districts>? districtList;
  List<Areas>? areasList;
  List<Villages>? villagesList;
  LocationSuccess({this.districtList, this.areasList, this.villagesList});
}
