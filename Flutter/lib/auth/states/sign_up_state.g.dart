// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SignUpStateCWProxy {
  SignUpState password(Password password);

  SignUpState confirmPassword(Password confirmPassword);

  SignUpState email(Email email);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SignUpState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SignUpState(...).copyWith(id: 12, name: "My name")
  /// ````
  SignUpState call({
    Password? password,
    Password? confirmPassword,
    Email? email,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSignUpState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSignUpState.copyWith.fieldName(...)`
class _$SignUpStateCWProxyImpl implements _$SignUpStateCWProxy {
  const _$SignUpStateCWProxyImpl(this._value);

  final SignUpState _value;

  @override
  SignUpState password(Password password) => this(password: password);

  @override
  SignUpState confirmPassword(Password confirmPassword) =>
      this(confirmPassword: confirmPassword);

  @override
  SignUpState email(Email email) => this(email: email);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SignUpState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SignUpState(...).copyWith(id: 12, name: "My name")
  /// ````
  SignUpState call({
    Object? password = const $CopyWithPlaceholder(),
    Object? confirmPassword = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
  }) {
    return SignUpState(
      password: password == const $CopyWithPlaceholder() || password == null
          ? _value.password
          // ignore: cast_nullable_to_non_nullable
          : password as Password,
      confirmPassword: confirmPassword == const $CopyWithPlaceholder() ||
              confirmPassword == null
          ? _value.confirmPassword
          // ignore: cast_nullable_to_non_nullable
          : confirmPassword as Password,
      email: email == const $CopyWithPlaceholder() || email == null
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as Email,
    );
  }
}

extension $SignUpStateCopyWith on SignUpState {
  /// Returns a callable class that can be used as follows: `instanceOfSignUpState.copyWith(...)` or like so:`instanceOfSignUpState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SignUpStateCWProxy get copyWith => _$SignUpStateCWProxyImpl(this);
}
