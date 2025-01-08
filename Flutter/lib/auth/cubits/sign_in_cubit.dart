import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_bite/auth/states/sign_in_state.dart';
import 'package:quick_bite/shared/form_fields.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(const SignInState());

  bool isPasswordVisible = true;

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(password: password));
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(email: email));
  }
}
