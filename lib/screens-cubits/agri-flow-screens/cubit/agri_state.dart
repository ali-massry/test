part of 'agri_cubit.dart';

sealed class AgriState {}

final class AgriInitial extends AgriState {}

final class AgriEmpty extends AgriState {}

final class AgriUpdated extends AgriState {
  AddAgriMemberModel? addAgriMemberModel;
  AgriUpdated({required this.addAgriMemberModel});
}
