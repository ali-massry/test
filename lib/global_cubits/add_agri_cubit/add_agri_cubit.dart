// ignore_for_file: avoid_print

import 'package:capef/models/error_response.dart';
import 'package:capef/repositories/add_categories_repo/categories_repository.dart';
import 'package:capef/screens-cubits/agri-flow-screens/model/add_agri_member_model.dart';
import 'package:capef/utils/functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'add_agri_state.dart';

class AddAgriCubit extends Cubit<AddAgriState> {
  AddAgriCubit() : super(AddAgriInitial());

  Future addAgriMember({required AddAgriMemberModel addAgriMemberModel}) async {
    try {
      emit(AddAgriLoading());
      final response = await CategoriesRepository.addAgricultureMember(
          addAgriMemberModel: addAgriMemberModel,
          jwtToken: GlobalFunctions.getLocalJWTToken());
      if ((response as Status).code == 0) {
        print('INTERNAL CODE FOR ADD AGRI API ${response.code}');

        emit(AddAgriSuccess(status: response));
      } else {
        emit(AddAgriFailure(status: response));
      }
    } catch (e) {
      emit(AddAgriFailure(status: Status(devmessage: e.toString())));
    }
  }
}
