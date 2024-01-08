import 'package:flutter_bloc/flutter_bloc.dart';

part 'authfields_state.dart';

class AuthfieldsCubit extends Cubit<AuthfieldsState> {
  AuthfieldsCubit() : super(AuthfieldsInitial());
  // String? username;
  // String? newpassword;
  // String? confirmpassword;
  // String? securityAnswer;
}
