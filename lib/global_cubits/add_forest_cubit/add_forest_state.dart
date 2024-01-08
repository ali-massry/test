part of 'add_forest_cubit.dart';

sealed class AddForestState {}

final class AddForestInitial extends AddForestState {}

final class AddForestLoading extends AddForestState {}

final class AddForestFailure extends AddForestState {
  final Status? status;
  AddForestFailure({this.status});
}

final class AddForestSuccess extends AddForestState {
  final Status? status;
  AddForestSuccess({this.status});
}
