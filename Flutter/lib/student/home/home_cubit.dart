import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_bite/shared/form_fields.dart';
import 'package:quick_bite/shared/models.dart';
import 'package:quick_bite/student/home/home_state.dart';
import 'package:http/http.dart' as http;

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeLoadingState());

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Auth.FirebaseAuth auth = Auth.FirebaseAuth.instance;

  Future<void> getUserData() async {
    emit(HomeLoadingState());
    final userId = auth.currentUser!.uid;
    final url = Uri.parse('http://localhost:3000/auth/user/$userId');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final userJson = data['user'];
      final user = User.fromJson(userJson);

      emit(HomeLoadedState(user));
    }
  }

  Future<void> updateUserDetails(User updatedUser) async {
    emit(HomeLoadingState());
    try {
      final userId = auth.currentUser!.uid;
      final url = Uri.parse('http://localhost:3000/auth/user/$userId');
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(updatedUser),
      );

      if (response.statusCode == 200) {
        debugPrint('user updated successfully');
        final data = json.decode(response.body);
        final userJson = data['user'];
        final user = User.fromJson(userJson);
        emit(HomeLoadedState(user));
      } else {
        debugPrint('Failed to update user: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('setting details failed -$e');
    }
  }
}
