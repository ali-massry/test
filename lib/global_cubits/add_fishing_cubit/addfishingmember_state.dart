part of 'addfishingmember_cubit.dart';

sealed class AddfishingmemberState {}

final class AddfishingmemberInitial extends AddfishingmemberState {}

final class AddfishingmemberLoading extends AddfishingmemberState {}

final class AddfishingmemberFailure extends AddfishingmemberState {
  final Status? status;
  AddfishingmemberFailure({this.status});
}

final class AddfishingmemberSuccess extends AddfishingmemberState {
  final Status? status;
  AddfishingmemberSuccess({this.status});
}
