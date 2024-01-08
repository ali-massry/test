part of 'localization_cubit.dart';

@immutable
class LocalizationState {
  final String locale;
  const LocalizationState({required this.locale});
  Map<String, dynamic> toMap() {
    return {'locale': locale};
  }

  factory LocalizationState.fromMap(Map<String, dynamic>? map) {
    return LocalizationState(locale: map?['locale']);
  }
}
