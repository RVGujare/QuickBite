import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_bite/auth/cubits/auth_cubit.dart';
import 'package:quick_bite/auth/cubits/check_cubit.dart';
import 'package:quick_bite/auth/screens/details_screen.dart';
import 'package:quick_bite/auth/screens/welcome_screen.dart';
import 'package:quick_bite/auth/states/auth_state.dart';
import 'package:quick_bite/auth/states/check_state.dart';
import 'package:quick_bite/student/home/home_cubit.dart';
import 'package:quick_bite/student/home/home_screen.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit()..checkAuth(),
      child: BlocBuilder<AuthCubit, AuthState>(builder: (context, authState) {
        if (authState is AuthenticatedState) {
          return const DisplayScreen();
        } else if (authState is AuthLoadingState) {
          return const CircularProgressIndicator();
        } else if (authState is UnauthWelcomeState) {
          return const WelcomeScreen();
        } else {
          return const WelcomeScreen();
        }
      }),
    );
  }
}

class DisplayScreen extends StatelessWidget {
  const DisplayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CheckCubit()..checkUserDataStatus(context.read<AuthCubit>().uid),
      child: BlocBuilder<CheckCubit, CheckState>(
        builder: (context, state) {
          if (state is DataUnavailableState) {
            return DetailsScreen();
          } else if (state is DataLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const StudentHomePage();
          }
        },
      ),
    );
  }
}
