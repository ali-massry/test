import 'package:flutter_bloc/flutter_bloc.dart';
part 'is_online_state.dart';

class IsOnlineCubit extends Cubit<IsOnlineState> {
  IsOnlineCubit() : super(IsOnlineInitial());
  bool? isOnline;
  void emitIsOnline() {
    isOnline = true;
    emit(IsOnline());
  }

  void emitIsOffline() {
    isOnline = false;
    emit(IsOffline());
  }
}
