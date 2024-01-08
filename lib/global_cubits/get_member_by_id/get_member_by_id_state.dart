part of 'get_member_by_id_cubit.dart';

sealed class GetMemberByIdState {}

final class GetMemberByIdInitial extends GetMemberByIdState {}

final class GetMemberByIdLoading extends GetMemberByIdState {}

final class GetMemberByIdFailure extends GetMemberByIdState {
  final Status status;
  GetMemberByIdFailure({required this.status});
}

final class GetMemberByIdSuccess extends GetMemberByIdState {
  final DetailedMemberModel detailedMemberModel;
  GetMemberByIdSuccess({required this.detailedMemberModel});
}
