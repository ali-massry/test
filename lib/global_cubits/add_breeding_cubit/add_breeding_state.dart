part of 'add_breeding_cubit.dart';

sealed class AddBreedingState {}

final class AddBreedingInitial extends AddBreedingState {}

final class AddBreedingLoading extends AddBreedingState {}

final class AddBreedingFailure extends AddBreedingState {
  final Status? status;
  AddBreedingFailure({this.status});
}

final class AddBreedingSuccess extends AddBreedingState {
  final Status? status;
  AddBreedingSuccess({this.status});
}
