part of 'get_offline_cubit.dart';

sealed class GetOfflineCubitState {}

final class GetOfflineCubitInitial extends GetOfflineCubitState {}

final class GetOfflineCubitLoading extends GetOfflineCubitState {}

final class GetOfflineCubitFailure extends GetOfflineCubitState {
  final Status? status;
  GetOfflineCubitFailure({required this.status});
}

final class GetOfflineCubitSuccess extends GetOfflineCubitState {
  final GetOfflineDataModel? getOfflineDataModel;
  GetOfflineCubitSuccess({required this.getOfflineDataModel});
}
