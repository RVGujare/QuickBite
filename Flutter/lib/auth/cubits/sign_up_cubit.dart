import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_bite/auth/states/sign_up_state.dart';
import 'package:quick_bite/shared/form_fields.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(const SignUpState());

  bool isPasswordVisible = true;
  bool isConfirmPasswordVisible = true;

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(password: password));
  }

  void confirmPasswordChanged(String value) {
    final confirmPassword = Password.dirty(value);
    emit(state.copyWith(confirmPassword: confirmPassword));
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(email: email));
  }
}
