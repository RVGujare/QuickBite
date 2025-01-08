import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_bite/auth/states/mandatory_fields_state.dart';
import 'package:quick_bite/shared/form_fields.dart';
import 'package:http/http.dart' as http;
import 'package:quick_bite/shared/models.dart';

class MandatoryFieldsCubit extends Cubit<MandatoryFieldState> {
  MandatoryFieldsCubit() : super(MandatoryFieldState());

  bool initialDataRendered = false;

  Future<void> fetchMandatoryFields(String userId) async {
    final url = Uri.parse('http://localhost:3000/auth/user/$userId');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final userJson = data['user'];
      final user = User.fromJson(userJson);

      final formattedPhone = user.phone == '' ? '' : user.phone.substring(3);
      emit(state.copyWith(
        firstName: RequiredTextInput.dirty(user.firstName),
        lastName: RequiredTextInput.dirty(user.lastName),
        email: Email.dirty(user.email),
        phone: Phone.dirty(formattedPhone),
        initialFieldRendered: true,
      ));
    } else {
      debugPrint('Failed to fetch data: ${response.statusCode}');
    }
  }

  void setUpdateMandatoryFields(String userId) async {
    try {
      final user = User(
          firstName: state.firstName.value,
          lastName: state.lastName.value,
          phone: '+91${state.phone.value}');
      final url = Uri.parse('http://localhost:3000/auth/user/$userId');
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(user),
      );

      if (response.statusCode == 200) {
        emit(DataFilledActionState());
      } else {
        debugPrint('Failed to update user: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('setting details failed -$e');
    }
  }

  void firstNameChanged(String value) {
    final name = RequiredTextInput.dirty(value);
    emit(state.copyWith(firstName: name));
  }

  void lastNameChanged(String value) {
    final name = RequiredTextInput.dirty(value);
    emit(state.copyWith(lastName: name));
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(email: email));
  }

  void phoneChanged(String value) {
    final phone = Phone.dirty(value);
    emit(state.copyWith(phone: phone));
  }

  Future<void> checkDetailsFilled(String userId) async {
    try {
      final url = Uri.parse('http://localhost:3000/auth/user/$userId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final userJson = data['user'];
        final user = User.fromJson(userJson);

        emit(
          state.copyWith(
            hasEmail: user.email != '',
            hasPhone: user.phone != '',
            hasFirstName: user.firstName != '',
            hasLastName: user.lastName != '',
          ),
        );
      } else {
        debugPrint('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching user data: $e');
    }
  }
}
