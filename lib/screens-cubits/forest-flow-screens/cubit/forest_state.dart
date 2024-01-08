part of 'forest_cubit.dart';

sealed class ForestState {}

final class ForestInitial extends ForestState {}

final class UpdateForestProductsSuccess extends ForestState {
  List<Forestproducts> forestproducts;
  UpdateForestProductsSuccess({required this.forestproducts});
}
