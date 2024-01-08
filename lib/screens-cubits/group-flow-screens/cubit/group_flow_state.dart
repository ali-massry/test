part of 'group_flow_cubit.dart';

sealed class GroupFlowState {}

final class GroupFlowInitial extends GroupFlowState {}

final class GroupFlowSuccess extends GroupFlowState {}

final class AddLegalEntityPersonLoading extends GroupFlowState {}

final class AddLegalEntitySuccess extends GroupFlowState {
  final AddLegalEntitySuccessModel? addLegalEntitySuccessModel;
  AddLegalEntitySuccess({this.addLegalEntitySuccessModel});
}

final class AddLegalEntityPersonFailure extends GroupFlowState {
  final AddIndividualMemberFailureModel? failureModel;
  AddLegalEntityPersonFailure({this.failureModel});
}
