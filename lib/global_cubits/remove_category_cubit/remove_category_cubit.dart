// ignore_for_file: avoid_print

import 'package:capef/models/error_response.dart';
import 'package:capef/repositories/add_categories_repo/categories_repository.dart';
import 'package:capef/utils/functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'remove_category_state.dart';

class RemoveCategoryCubit extends Cubit<RemoveCategoryState> {
  RemoveCategoryCubit() : super(RemoveCategoryInitial());

  Future removeCategory({required int categoryId}) async {
    try {
      emit(RemoveCategoryLoading());
      final response = await CategoriesRepository.removeCategory(
          jwtToken: GlobalFunctions.getLocalJWTToken(), categoryId: categoryId);
      // Status status = Status.fromJson(response);
      if (response.code == 0) {
        print('INTERNAL CODE FOR Remove Cat  API ${response.code}');

        emit(RemoveCategorySucess(status: response));
      } else {
        // Status status = Status.fromJson(response);
        emit(RemoveCategoryFailure(status: response));
      }
    } catch (e) {
      print(e);
      emit(RemoveCategoryFailure(
          status: Status(
              message: 'Something went wrong',
              devmessage: 'Something went wrong')));
    }
  }
}
