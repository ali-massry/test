// ignore_for_file: avoid_print

import 'package:capef/models/error_response.dart';
import 'package:capef/repositories/add_categories_repo/categories_repository.dart';
import 'package:capef/screens-cubits/fishing-flow-screens/model/add_fishing_member_model.dart';
import 'package:capef/utils/functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'addfishingmember_state.dart';

class AddfishingmemberCubit extends Cubit<AddfishingmemberState> {
  AddfishingmemberCubit() : super(AddfishingmemberInitial());

  Future addFishingMember(
      {required AddFishingMemberModel addFishingMemberModel}) async {
    try {
      emit(AddfishingmemberLoading());
      final response = await CategoriesRepository.addFishingMember(
          addFishingMemberModel: addFishingMemberModel,
          jwtToken: GlobalFunctions.getLocalJWTToken());
      if ((response as Status).code == 0) {
        print('INTERNAL CODE FOR ADD FISHING API ${response.code}');

        emit(AddfishingmemberSuccess(status: response));
      } else {
        emit(AddfishingmemberFailure(status: response));
      }
    } catch (e) {
      emit(AddfishingmemberFailure(status: Status(devmessage: e.toString())));
    }
  }
}
