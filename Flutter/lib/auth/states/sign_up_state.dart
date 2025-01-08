import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:formz/formz.dart';
import 'package:quick_bite/shared/form_fields.dart';

part 'sign_up_state.g.dart';

@CopyWith()
class SignUpState with FormzMixin {
  const SignUpState(
      {this.password = const Password.pure(),
      this.confirmPassword = const Password.pure(),
      this.email = const Email.pure()});

  final Password password;
  final Password confirmPassword;
  final Email email;

  @override
  List<FormzInput<dynamic, dynamic>> get inputs =>
      [password, confirmPassword, email];
}
