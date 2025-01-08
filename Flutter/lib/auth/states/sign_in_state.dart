import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:formz/formz.dart';
import 'package:quick_bite/shared/form_fields.dart';
part 'sign_in_state.g.dart';

@CopyWith()
class SignInState with FormzMixin {
  const SignInState(
      {this.password = const Password.pure(), this.email = const Email.pure()});

  final Password password;
  final Email email;

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [password, email];

  // SignInState copyWith({Password? password, Email? email}) {
  //   return SignInState(
  //       password: password ?? this.password, email: email ?? this.email);
  // }
}
