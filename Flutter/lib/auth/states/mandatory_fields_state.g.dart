// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mandatory_fields_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MandatoryFieldStateCWProxy {
  MandatoryFieldState firstName(RequiredTextInput firstName);

  MandatoryFieldState lastName(RequiredTextInput lastName);

  MandatoryFieldState email(Email email);

  MandatoryFieldState phone(Phone phone);

  MandatoryFieldState initialFieldRendered(bool initialFieldRendered);

  MandatoryFieldState hasEmail(bool hasEmail);

  MandatoryFieldState hasPhone(bool hasPhone);

  MandatoryFieldState hasFirstName(bool hasFirstName);

  MandatoryFieldState hasLastName(bool hasLastName);

  MandatoryFieldState role(String role);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MandatoryFieldState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MandatoryFieldState(...).copyWith(id: 12, name: "My name")
  /// ````
  MandatoryFieldState call({
    RequiredTextInput? firstName,
    RequiredTextInput? lastName,
    Email? email,
    Phone? phone,
    bool? initialFieldRendered,
    bool? hasEmail,
    bool? hasPhone,
    bool? hasFirstName,
    bool? hasLastName,
    String? role,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMandatoryFieldState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMandatoryFieldState.copyWith.fieldName(...)`
class _$MandatoryFieldStateCWProxyImpl implements _$MandatoryFieldStateCWProxy {
  const _$MandatoryFieldStateCWProxyImpl(this._value);

  final MandatoryFieldState _value;

  @override
  MandatoryFieldState firstName(RequiredTextInput firstName) =>
      this(firstName: firstName);

  @override
  MandatoryFieldState lastName(RequiredTextInput lastName) =>
      this(lastName: lastName);

  @override
  MandatoryFieldState email(Email email) => this(email: email);

  @override
  MandatoryFieldState phone(Phone phone) => this(phone: phone);

  @override
  MandatoryFieldState initialFieldRendered(bool initialFieldRendered) =>
      this(initialFieldRendered: initialFieldRendered);

  @override
  MandatoryFieldState hasEmail(bool hasEmail) => this(hasEmail: hasEmail);

  @override
  MandatoryFieldState hasPhone(bool hasPhone) => this(hasPhone: hasPhone);

  @override
  MandatoryFieldState hasFirstName(bool hasFirstName) =>
      this(hasFirstName: hasFirstName);

  @override
  MandatoryFieldState hasLastName(bool hasLastName) =>
      this(hasLastName: hasLastName);

  @override
  MandatoryFieldState role(String role) => this(role: role);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MandatoryFieldState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MandatoryFieldState(...).copyWith(id: 12, name: "My name")
  /// ````
  MandatoryFieldState call({
    Object? firstName = const $CopyWithPlaceholder(),
    Object? lastName = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
    Object? initialFieldRendered = const $CopyWithPlaceholder(),
    Object? hasEmail = const $CopyWithPlaceholder(),
    Object? hasPhone = const $CopyWithPlaceholder(),
    Object? hasFirstName = const $CopyWithPlaceholder(),
    Object? hasLastName = const $CopyWithPlaceholder(),
    Object? role = const $CopyWithPlaceholder(),
  }) {
    return MandatoryFieldState(
      firstName: firstName == const $CopyWithPlaceholder() || firstName == null
          ? _value.firstName
          // ignore: cast_nullable_to_non_nullable
          : firstName as RequiredTextInput,
      lastName: lastName == const $CopyWithPlaceholder() || lastName == null
          ? _value.lastName
          // ignore: cast_nullable_to_non_nullable
          : lastName as RequiredTextInput,
      email: email == const $CopyWithPlaceholder() || email == null
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as Email,
      phone: phone == const $CopyWithPlaceholder() || phone == null
          ? _value.phone
          // ignore: cast_nullable_to_non_nullable
          : phone as Phone,
      initialFieldRendered:
          initialFieldRendered == const $CopyWithPlaceholder() ||
                  initialFieldRendered == null
              ? _value.initialFieldRendered
              // ignore: cast_nullable_to_non_nullable
              : initialFieldRendered as bool,
      hasEmail: hasEmail == const $CopyWithPlaceholder() || hasEmail == null
          ? _value.hasEmail
          // ignore: cast_nullable_to_non_nullable
          : hasEmail as bool,
      hasPhone: hasPhone == const $CopyWithPlaceholder() || hasPhone == null
          ? _value.hasPhone
          // ignore: cast_nullable_to_non_nullable
          : hasPhone as bool,
      hasFirstName:
          hasFirstName == const $CopyWithPlaceholder() || hasFirstName == null
              ? _value.hasFirstName
              // ignore: cast_nullable_to_non_nullable
              : hasFirstName as bool,
      hasLastName:
          hasLastName == const $CopyWithPlaceholder() || hasLastName == null
              ? _value.hasLastName
              // ignore: cast_nullable_to_non_nullable
              : hasLastName as bool,
      role: role == const $CopyWithPlaceholder() || role == null
          ? _value.role
          // ignore: cast_nullable_to_non_nullable
          : role as String,
    );
  }
}

extension $MandatoryFieldStateCopyWith on MandatoryFieldState {
  /// Returns a callable class that can be used as follows: `instanceOfMandatoryFieldState.copyWith(...)` or like so:`instanceOfMandatoryFieldState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MandatoryFieldStateCWProxy get copyWith =>
      _$MandatoryFieldStateCWProxyImpl(this);
}
