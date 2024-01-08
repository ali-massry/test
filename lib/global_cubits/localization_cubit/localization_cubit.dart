import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
part 'localization_state.dart';

class LocalizationCubit extends HydratedCubit<LocalizationState> {
  LocalizationCubit() : super(const LocalizationState(locale: 'fr'));
  // bool? hasInternet;

  void changeLocale(String locale) {
    emit(LocalizationState(locale: locale));
  }

  @override
  LocalizationState fromJson(Map<String, dynamic> json) {
    return LocalizationState.fromMap(json);
  }

  @override
  Map<String, dynamic> toJson(LocalizationState state) {
    return state.toMap();
  }
}
