part of 'breeding_cubit.dart';

sealed class BreedingCubitState {}

final class BreedingCubitInitial extends BreedingCubitState {}

final class UpdateBreedingLiveStockDropDownSuccess extends BreedingCubitState {
  List<Breedinglivestock> breedingLiveStock;
  UpdateBreedingLiveStockDropDownSuccess({required this.breedingLiveStock});
}
