part of 'general_reports_cubit.dart';

sealed class ReportsState {}

final class ReportsInitial extends ReportsState {}

final class GetReportsLoading extends ReportsState {}

final class GetReportsFailure extends ReportsState {
  final Status status;
  GetReportsFailure({required this.status});
}

final class GetReportsSuccess extends ReportsState {
  final GetGeneralReportsModel generalReportsModel;
  GetReportsSuccess({required this.generalReportsModel});
}
