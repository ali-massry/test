part of 'update_individual_member_cubit.dart';

sealed class UpdateIndividualMemberState {}

final class UpdateIndividualMemberInitial extends UpdateIndividualMemberState {}

final class UpdateIndividualMemberLoading extends UpdateIndividualMemberState {}

final class UpdateIndividualMemberSucess extends UpdateIndividualMemberState {
  final UpdateLIndividualMemberModel? updateLIndividualMemberModel;
  UpdateIndividualMemberSucess({this.updateLIndividualMemberModel});
}

final class UpdateIndividualMemberFailure extends UpdateIndividualMemberState {
  final UpdateLIndividualMemberModel? updateLIndividualMemberModel;
  UpdateIndividualMemberFailure({this.updateLIndividualMemberModel});
}
