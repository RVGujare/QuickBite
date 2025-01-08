import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_bite/auth/states/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:quick_bite/constants/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(UnauthenticatedState());

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String get uid => auth.currentUser!.uid;

  void checkAuth() {
    if (auth.currentUser != null) {
      emit(AuthLoadingState());
      emit(AuthenticatedState());
    } else {
      emit(UnauthenticatedState());
    }
  }

  Future<bool> checkUserExists(String email) async {
    final url = Uri.parse('http://localhost:3000/auth/user/status/$email');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      debugPrint('check user exist- $jsonResponse');
      return jsonResponse;
    } else {
      throw Exception('Something went wrong while checking user status');
    }
  }

  // Future<void> createUserIfNotExists(
  //     UserCredential userCredential, String? email) async {

  // }

  Future<void> passwordReset(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  Future<void> sendEmailVerification(String email, String password) async {
    emit(AuthLoadingState());
    await auth.currentUser?.reload();
    await auth.signInWithEmailAndPassword(email: email, password: password);
    await auth.currentUser?.sendEmailVerification().catchError(
        (onError) => debugPrint('Error sending verification email - $onError'));
    await auth.signOut();
    emit(ErrorState(loginConsts.checkEmailForVerification));
  }

  Future<void> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      String uid = userCredential.user!.uid;

      final url = Uri.parse('http://localhost:3000/auth/signup');
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'email': email, 'uid': uid}));
      debugPrint('${response.statusCode}');
      if (response.statusCode == 201) {
        debugPrint('user created successfully');
        await auth.currentUser?.sendEmailVerification().catchError((onError) =>
            debugPrint('Error sending verification email - $onError'));
        await auth.signOut();
        emit(ErrorState(loginConsts.checkEmailForVerification));
      } else {
        await userCredential.user!.delete();
        debugPrint('failed to create user');
      }
    } catch (e) {
      debugPrint('error during signup -$e');
    }
  }

  Future<void> signInWithEmail(
      {required String email, required String password}) async {
    try {
      emit(AuthLoadingState());
      await auth.currentUser?.reload();
      await auth.signInWithEmailAndPassword(email: email, password: password);
      if (!auth.currentUser!.emailVerified) {
        debugPrint('email unverified');
        await auth.signOut();
        emit(EmailUnverifiedState(email, password));
        return;
      }

      emit(AuthenticatedState());
    } on FirebaseAuthException catch (error) {
      debugPrint('error - $error');
      if (error.code.contains(loginConsts.invalidCredential)) {
        debugPrint('wrong password');
        emit(ErrorState(loginConsts.invalidCredentialMsg));

        return;
      }
    }
  }
  // Future<void> signInWithGoogle() async {}

  Future<void> signOutUser() async {
    emit(AuthLoadingState());
    auth.signOut();
    await firestore.terminate();
    emit(UnauthWelcomeState());
  }
}
