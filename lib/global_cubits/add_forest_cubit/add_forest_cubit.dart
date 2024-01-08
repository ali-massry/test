// ignore_for_file: avoid_print

import 'package:capef/models/error_response.dart';
import 'package:capef/repositories/add_categories_repo/categories_repository.dart';
import 'package:capef/screens-cubits/forest-flow-screens/model/add_forest_member_model.dart';
import 'package:capef/utils/functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'add_forest_state.dart';

class AddForestCubit extends Cubit<AddForestState> {
  AddForestCubit() : super(AddForestInitial());

  Future addForestMember(
      {required AddForestMemberModel addForestMemberModel}) async {
    try {
      emit(AddForestLoading());
      final response = await CategoriesRepository.addForestMember(
          addForestMemberModel: addForestMemberModel,
          jwtToken: GlobalFunctions.getLocalJWTToken());
      if ((response as Status).code == 0) {
        print('INTERNAL CODE FOR ADD FOREST API ${response.code}');

        emit(AddForestSuccess(status: response));
      } else {
        emit(AddForestFailure(status: response));
      }
    } catch (e) {
      emit(AddForestFailure(status: Status(devmessage: e.toString())));
    }
  }
}
