import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenCubitState> {
  HomeScreenCubit() : super(HomeScreenCubitInitial());
}
