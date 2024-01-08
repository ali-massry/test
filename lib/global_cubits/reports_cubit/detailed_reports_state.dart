
import 'package:capef/models/error_response.dart';
import 'package:capef/models/get_detailed_report_model.dart';

sealed class DetailedReportsState {}

final class DetailedReportsInitial extends DetailedReportsState {}

final class DetailedReportsLoading extends DetailedReportsState {}

final class DetailedReportsFailure extends DetailedReportsState {
  final Status status;
  DetailedReportsFailure({required this.status});
}

final class DetailedReportsSuccess extends DetailedReportsState {
  final GetDetailedReportModel getDetailedReportModel;
  DetailedReportsSuccess({required this.getDetailedReportModel});
}
