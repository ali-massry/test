import 'package:flutter_bloc/flutter_bloc.dart';

part 'choose_language_state.dart';

class ChooseLanguageCubit extends Cubit<ChooseLanguageState> {
  ChooseLanguageCubit() : super(ChooseLanguageInitial());
}
