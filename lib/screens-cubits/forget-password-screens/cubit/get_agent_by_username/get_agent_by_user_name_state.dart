part of 'get_agent_by_user_name_cubit.dart';

sealed class GetAgentByUserNameState {}

final class GetAgentByUserNameInitial extends GetAgentByUserNameState {}

final class GetAgentByUserNameLoading extends GetAgentByUserNameState {}

final class GetAgentByUserNameFailure extends GetAgentByUserNameState {
  final Status status;
  GetAgentByUserNameFailure({required this.status});
}

final class GetAgentByUserNameSuccess extends GetAgentByUserNameState {
  final GetQuestionByUserNameModel getQuestionByUserNameModel;
  GetAgentByUserNameSuccess({required this.getQuestionByUserNameModel});
}
