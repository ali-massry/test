import 'package:capef/global_cubits/reports_cubit/detailed_reports_state.dart';
import 'package:capef/models/error_response.dart';
import 'package:capef/models/get_detailed_report_model.dart';
import 'package:capef/repositories/reports/reports_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailedReportsCubit extends Cubit<DetailedReportsState> {
  DetailedReportsCubit() : super(DetailedReportsInitial());

  Future getDetailedReports({
    required String jwttoken,
    required String fromDate,
    required String toDate,
    required int categoryId,
  }) async {
    try {
      emit(DetailedReportsLoading());
      final response = await ReportsRepository.getDetailedReports(
          jwttoken: jwttoken,
          fromDate: fromDate,
          toDate: toDate,
          categoryId: categoryId);
      if ((response as GetDetailedReportModel).status?.code == 0) {
        // getOfflineDataModel = response;

        // print(getOfflineDataModel);

        // securityQuestionsState = response.securityqsts ?? [];
        // print(securityQuestionsState);
        emit(DetailedReportsSuccess(getDetailedReportModel: response));
      } else {
        emit(
          DetailedReportsFailure(status: response.status!),
        );
      }
    } catch (e) {
      emit(
        DetailedReportsFailure(status: Status(devmessage: e.toString())),
      );
    }
  }
}
