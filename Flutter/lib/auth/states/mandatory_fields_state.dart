import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:formz/formz.dart';
import 'package:quick_bite/shared/form_fields.dart';
import 'package:quick_bite/auth/states/check_state.dart';
part 'mandatory_fields_state.g.dart';

@CopyWith()
class MandatoryFieldState extends CheckState with FormzMixin {
  MandatoryFieldState({
    this.firstName = const RequiredTextInput.pure(),
    this.lastName = const RequiredTextInput.pure(),
    this.email = const Email.pure(),
    this.phone = const Phone.pure(),
    this.initialFieldRendered = false,
    this.hasEmail = false,
    this.hasPhone = false,
    this.hasFirstName = false,
    this.hasLastName = false,
    this.role = "",
  });

  final RequiredTextInput firstName;
  final RequiredTextInput lastName;
  final Email email;
  final Phone phone;
  final bool initialFieldRendered;
  final String role;
  bool hasEmail;
  bool hasPhone;
  bool hasFirstName;
  bool hasLastName;

  @override
  List<FormzInput> get inputs => [firstName, lastName, email, phone];
}

class DataFilledActionState extends MandatoryFieldState {}
