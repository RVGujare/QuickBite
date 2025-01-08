import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_bite/auth/cubits/auth_cubit.dart';
import 'package:quick_bite/constants/strings.dart';

class Services {
  void showSnackBar(BuildContext context, String snackbarMessage,
      {SnackBarAction? action}) {
    SnackBar snackBar = SnackBar(
      content: AutoSizeText(snackbarMessage),
      action: action,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showSnackBarWithAction(
      BuildContext context, String email, String password) {
    SnackBar snackBar = SnackBar(
      content: AutoSizeText(loginConsts.emailUnverified),
      action: SnackBarAction(
          label: 'Resend link',
          onPressed: () {
            context.read<AuthCubit>().sendEmailVerification(email, password);
          }),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
