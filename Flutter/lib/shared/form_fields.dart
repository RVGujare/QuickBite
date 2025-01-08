import 'package:quick_bite/constants/strings.dart';
import 'package:formz/formz.dart';

class RequiredTextInput extends FormzInput<String, String> {
  const RequiredTextInput.pure() : super.pure('');
  const RequiredTextInput.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.isNotEmpty == true ? null : loginConsts.requiredField;
  }
}

class Phone extends FormzInput<String, String> {
  const Phone.pure() : super.pure('');
  const Phone.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return (double.tryParse(value) == null) || value.length != 10
        ? loginConsts.enterValidPhone
        : null;
  }
}

class Email extends FormzInput<String, String> {
  const Email.pure() : super.pure('');
  const Email.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value?.isEmpty == true || !value.contains('@')
        ? loginConsts.enterValidEmail
        : null;
  }
}

class Password extends FormzInput<String, String> {
  const Password.pure() : super.pure('');
  const Password.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.length < 8 ? loginConsts.passwordLengthError : null;
  }
}
