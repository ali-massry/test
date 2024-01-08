part of 'add_agri_cubit.dart';

sealed class AddAgriState {}

final class AddAgriInitial extends AddAgriState {}

final class AddAgriLoading extends AddAgriState {}

final class AddAgriFailure extends AddAgriState {
  final Status? status;
  AddAgriFailure({this.status});
}

final class AddAgriSuccess extends AddAgriState {
  final Status? status;
  AddAgriSuccess({this.status});
}
