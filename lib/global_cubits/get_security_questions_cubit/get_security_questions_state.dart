part of 'get_security_questions_cubit.dart';

sealed class GetSecurityQuestionsState {}

final class GetSecurityQuestionsInitial extends GetSecurityQuestionsState {}

final class GetSecurityQuestionsLoading extends GetSecurityQuestionsState {}

final class GetSecurityQuestionsFailure extends GetSecurityQuestionsState {
  final String? message;
  GetSecurityQuestionsFailure({required this.message});
}

final class GetSecurityQuestionsSuccess extends GetSecurityQuestionsState {
  final GetSecurityQuestions? getSecurityQuestions;
  GetSecurityQuestionsSuccess({required this.getSecurityQuestions});
}
