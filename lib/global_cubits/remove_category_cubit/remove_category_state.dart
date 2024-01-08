part of 'remove_category_cubit.dart';

sealed class RemoveCategoryState {}

final class RemoveCategoryInitial extends RemoveCategoryState {}

final class RemoveCategoryLoading extends RemoveCategoryState {}

final class RemoveCategorySucess extends RemoveCategoryState {
  final Status? status;
  RemoveCategorySucess({this.status});
}

final class RemoveCategoryFailure extends RemoveCategoryState {
  final Status? status;
  RemoveCategoryFailure({this.status});
}
