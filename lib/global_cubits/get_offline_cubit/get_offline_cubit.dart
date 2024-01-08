// ignore_for_file: avoid_print

import 'package:capef/models/error_response.dart';
import 'package:capef/models/offline_data_response.dart';
import 'package:capef/repositories/offline_data/get_offline_data_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'get_offline_state.dart';

class GetOfflineCubitCubit extends Cubit<GetOfflineCubitState> {
  GetOfflineCubitCubit() : super(GetOfflineCubitInitial());

  GetOfflineDataModel? getOfflineDataModel;

  Future getOfflineData({required String jwttoken}) async {
    try {
      emit(GetOfflineCubitLoading());
      final response =
          await OfflineRepository.getOfflineData(jwttoken: jwttoken);

      if ((response as GetOfflineDataModel).status?.code == 0) {
        getOfflineDataModel = response;

        // securityQuestionsState = response.securityqsts ?? [];
        // print(securityQuestionsState);
        emit(GetOfflineCubitSuccess(getOfflineDataModel: response));
      } else {
        print(response.status?.code);
        emit(
          GetOfflineCubitFailure(
              status: Status(devmessage: 'Quelque chose s\'est mal passé')),
        );
      }
    } catch (e) {
      print(e);

      emit(
        GetOfflineCubitFailure(status: Status(devmessage: e.toString())),
      );
    }
  }
}
