part of 'add_physical_person_cubit.dart';

sealed class AddPhysicalPersonState {}

final class AddPhysicalPersonInitial extends AddPhysicalPersonState {}

final class AddPhysicalPersonLoading extends AddPhysicalPersonState {}

final class AddPhysicalPersonSucess extends AddPhysicalPersonState {
  final AddIndividualMemberSuccess? addIndividualMemberSuccess;
  AddPhysicalPersonSucess({this.addIndividualMemberSuccess});
}

final class AddPhysicalPersonFailure extends AddPhysicalPersonState {
  final AddIndividualMemberFailureModel? failureModel;
  AddPhysicalPersonFailure({this.failureModel});
}

final class AddPhotosSuccess extends AddPhysicalPersonState {}

final class AddNationalPhotoSuccess extends AddPhysicalPersonState {}

final class AddRectoPhotoSuccess extends AddPhysicalPersonState {}

final class AddVersoPhotoSuccess extends AddPhysicalPersonState {}
