// ignore_for_file: avoid_print

import 'package:capef/models/error_response.dart';
import 'package:capef/repositories/add_categories_repo/categories_repository.dart';
import 'package:capef/screens-cubits/breeding-flow-screens/model/add_breeding_member_model.dart';
import 'package:capef/utils/functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_breeding_state.dart';

class AddBreedingCubit extends Cubit<AddBreedingState> {
  AddBreedingCubit() : super(AddBreedingInitial());

  Future addAgriMember(
      {required AddBreedingMemberModel addBreedingMemberModel}) async {
    try {
      emit(AddBreedingLoading());
      final response = await CategoriesRepository.addBreedingMember(
          addBreedingMemberModel: addBreedingMemberModel,
          jwtToken: GlobalFunctions.getLocalJWTToken());
      if ((response as Status).code == 0) {
        print('INTERNAL CODE FOR ADD BREEDING API ${response.code}');

        emit(AddBreedingSuccess(status: response));
      } else {
        emit(AddBreedingFailure(status: response));
      }
    } catch (e) {
      emit(AddBreedingFailure(status: Status(devmessage: e.toString())));
    }
  }
}
