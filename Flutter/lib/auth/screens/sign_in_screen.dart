import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_bite/auth/cubits/auth_cubit.dart';
import 'package:quick_bite/auth/cubits/sign_in_cubit.dart';
import 'package:quick_bite/auth/states/sign_in_state.dart' as form_state;
import 'package:quick_bite/constants/colors.dart';
import 'package:quick_bite/constants/custom_elevated_button.dart';
import 'package:quick_bite/constants/custom_text_field.dart';
import 'package:quick_bite/constants/size_constants.dart';
import 'package:quick_bite/constants/strings.dart';
import 'package:quick_bite/main.dart';
import 'package:quick_bite/shared/services.dart';

class SignInScreen extends StatefulWidget {
  final TabController tabController;
  const SignInScreen({super.key, required this.tabController});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    final signInCubit = context.read<SignInCubit>();

    return BlocProvider(
      create: (context) => SignInCubit(),
      child: BlocBuilder<SignInCubit, form_state.SignInState>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              body: Column(
                children: [
                  smallHeightBetweenComponents(screenHeight),
                  SizedBox(
                    width: screenWidth * 0.9,
                    child: CustomTextField(
                      controller: emailController,
                      onChanged: context.read<SignInCubit>().emailChanged,
                      labelText: textFieldConsts.emailField,
                      icon: Icons.person,
                      validator: (_) =>
                          context.read<SignInCubit>().state.email.error,
                    ),
                  ),
                  smallHeightBetweenComponents(screenHeight),
                  SizedBox(
                    width: screenWidth * 0.9,
                    child: CustomTextField(
                        controller: passwordController,
                        obscureText: signInCubit.isPasswordVisible,
                        validator: (_) =>
                            context.read<SignInCubit>().state.password.error,
                        onChanged: context.read<SignInCubit>().passwordChanged,
                        labelText: textFieldConsts.passwordField,
                        icon: Icons.lock,
                        suffixIcon: signInCubit.isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        onSuffixIconPressed: () {
                          setState(() {
                            signInCubit.isPasswordVisible =
                                !signInCubit.isPasswordVisible;
                          });
                        }),
                  ),

                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {
                            context
                                .read<AuthCubit>()
                                .passwordReset(emailController.text);
                          },
                          child: TextButton(
                            onPressed: () async {
                              bool userExist = await context
                                  .read<AuthCubit>()
                                  .checkUserExists(emailController.text);

                              if (emailController.text.isEmpty) {
                                Services().showSnackBar(
                                    context, loginConsts.enterValidEmail);
                              } else if (!userExist) {
                                Services().showSnackBar(
                                    context, loginConsts.userDoesNotExists);
                              } else {
                                Services().showSnackBar(
                                    context, loginConsts.passwordResetLinkSent);
                                context
                                    .read<AuthCubit>()
                                    .passwordReset(emailController.text);
                              }
                            },
                            child: AutoSizeText(
                              'Forgot password?  ',
                              style: TextStyle(color: black),
                            ),
                          ))),
                  smallHeightBetweenComponents(screenHeight),
                  CustomElevatedButton(screenWidth, screenHeight, 'Sign In',
                      context, primaryBrown, white, () {
                    verifySignInFields(context, emailController,
                        passwordController, authCubit);
                  }),
                  smallHeightBetweenComponents(screenHeight),
                  // SizedBox(
                  //   width: screenWidth * 0.9,
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //           child: Divider(
                  //         color: black,
                  //       )),
                  //       mediumWidthBetweenComponents(screenWidth),
                  //       AutoSizeText(
                  //         randomStringConsts.orLoginWith,
                  //         style: appTheme.textTheme.bodySmall,
                  //       ),
                  //       mediumWidthBetweenComponents(screenWidth),
                  //       Expanded(
                  //           child: Divider(
                  //         color: black,
                  //       )),
                  //     ],
                  //   ),
                  // ),
                  // smallHeightBetweenComponents(screenHeight),
                  //GoogleLogo(context.read<AuthCubit>().signInWithGoogle),
                  //smallHeightBetweenComponents(screenHeight),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        randomStringConsts.dontHaveAccount,
                        style: appTheme.textTheme.bodySmall,
                      ),
                      TextButton(
                        child: AutoSizeText(
                          'Sign Up',
                          style: TextStyle(color: primaryBrown, fontSize: 15),
                        ),
                        onPressed: () {
                          widget.tabController.animateTo(1);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Future<void> verifySignInFields(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
    AuthCubit authCubit) async {
  if (emailController.text.isEmpty || passwordController.text.isEmpty) {
    Services().showSnackBar(context, loginConsts.enterAllFields);
  } else if (passwordController.text.length < 8) {
    Services().showSnackBar(context, loginConsts.passwordLengthError);
  } else {
    bool userExist =
        await context.read<AuthCubit>().checkUserExists(emailController.text);

    if (!userExist) {
      Services().showSnackBar(context, loginConsts.userDoesNotExists);
    } else {
      context.read<AuthCubit>().signInWithEmail(
          email: emailController.text, password: passwordController.text);
    }
  }
}
