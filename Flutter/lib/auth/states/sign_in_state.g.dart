// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SignInStateCWProxy {
  SignInState password(Password password);

  SignInState email(Email email);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SignInState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SignInState(...).copyWith(id: 12, name: "My name")
  /// ````
  SignInState call({
    Password? password,
    Email? email,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSignInState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSignInState.copyWith.fieldName(...)`
class _$SignInStateCWProxyImpl implements _$SignInStateCWProxy {
  const _$SignInStateCWProxyImpl(this._value);

  final SignInState _value;

  @override
  SignInState password(Password password) => this(password: password);

  @override
  SignInState email(Email email) => this(email: email);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SignInState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SignInState(...).copyWith(id: 12, name: "My name")
  /// ````
  SignInState call({
    Object? password = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
  }) {
    return SignInState(
      password: password == const $CopyWithPlaceholder() || password == null
          ? _value.password
          // ignore: cast_nullable_to_non_nullable
          : password as Password,
      email: email == const $CopyWithPlaceholder() || email == null
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as Email,
    );
  }
}

extension $SignInStateCopyWith on SignInState {
  /// Returns a callable class that can be used as follows: `instanceOfSignInState.copyWith(...)` or like so:`instanceOfSignInState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SignInStateCWProxy get copyWith => _$SignInStateCWProxyImpl(this);
}
