part of 'update_legal_entity_member_cubit.dart';

sealed class UpdateLegalEntityMemberState {}

final class UpdateLegalEntityMemberInitial
    extends UpdateLegalEntityMemberState {}

final class UpdateLegalEntityMemberLoading
    extends UpdateLegalEntityMemberState {}

final class UpdateLegalEntityMemberSucess extends UpdateLegalEntityMemberState {
  final UpdateLegalEntityMemberModel? updateLegalEntityMemberModel;
  UpdateLegalEntityMemberSucess({this.updateLegalEntityMemberModel});
}

final class UpdateLegalEntityMemberFailure
    extends UpdateLegalEntityMemberState {
  final UpdateLegalEntityMemberModel? updateLegalEntityMemberModel;
  UpdateLegalEntityMemberFailure({this.updateLegalEntityMemberModel});
}
