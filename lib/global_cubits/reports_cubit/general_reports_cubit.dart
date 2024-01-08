import 'package:capef/models/error_response.dart';
import 'package:capef/models/get_general_reports_model.dart';
import 'package:capef/repositories/reports/reports_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'general_reports_state.dart';

class GetReportsCubit extends Cubit<ReportsState> {
  GetReportsCubit() : super(ReportsInitial());

  Future getGeneralReports({
    required String jwttoken,
    required String fromDate,
    required String toDate,
  }) async {
    try {
      emit(GetReportsLoading());
      final response = await ReportsRepository.getGeneralReports(
          jwttoken: jwttoken, fromDate: fromDate, toDate: toDate);
      if ((response as GetGeneralReportsModel).status?.code == 0) {
        // getOfflineDataModel = response;

        // print(getOfflineDataModel);

        // securityQuestionsState = response.securityqsts ?? [];
        // print(securityQuestionsState);
        emit(GetReportsSuccess(generalReportsModel: response));
      } else {
        emit(
          GetReportsFailure(status: response.status!),
        );
      }
    } catch (e) {
      emit(
        GetReportsFailure(status: Status(devmessage: e.toString())),
      );
    }
  }
}
