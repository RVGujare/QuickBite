import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_bite/auth/states/check_state.dart';
import 'package:http/http.dart' as http;
import 'package:quick_bite/shared/models.dart';

class CheckCubit extends Cubit<CheckState> {
  CheckCubit() : super(DataUnavailableState());

  Future<void> checkUserDataStatus(String userId) async {
    emit(DataLoadingState());
    try {
      final url = Uri.parse('http://localhost:3000/auth/user/$userId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final userJson = data['user'];
        final user = User.fromJson(userJson);
        if (user.email != '' &&
            user.firstName != '' &&
            user.lastName != '' &&
            user.phone != '') {
          emitAllDataPresentState();
        } else {
          emit(DataUnavailableState());
        }
      } else {
        debugPrint('Failed to fetch data: ${response.statusCode}');
        emit(DataUnavailableState());
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
      emit(DataUnavailableState());
    }
  }

  void emitAllDataPresentState() {
    emit(DataAvailableState());
  }
}
