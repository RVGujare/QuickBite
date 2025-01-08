import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_bite/auth/cubits/auth_cubit.dart';
import 'package:quick_bite/auth/cubits/sign_up_cubit.dart';
import 'package:quick_bite/auth/states/sign_up_state.dart';
import 'package:quick_bite/constants/colors.dart';
import 'package:quick_bite/constants/custom_elevated_button.dart';
import 'package:quick_bite/constants/custom_text_field.dart';
import 'package:quick_bite/constants/size_constants.dart';
import 'package:quick_bite/constants/strings.dart';
import 'package:quick_bite/main.dart';
import 'package:quick_bite/shared/services.dart';

class SignUpScreen extends StatefulWidget {
  final TabController tabController;
  const SignUpScreen({super.key, required this.tabController});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isVerified = false;
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    Services service = Services();
    final authCubit = context.read<AuthCubit>();
    final signUpCubit = context.read<SignUpCubit>();

    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocBuilder<SignUpCubit, SignUpState>(
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
                      onChanged: context.read<SignUpCubit>().emailChanged,
                      labelText: textFieldConsts.emailField,
                      icon: Icons.person,
                      validator: (_) =>
                          context.read<SignUpCubit>().state.email.error,
                    ),
                  ),
                  smallHeightBetweenComponents(screenHeight),
                  SizedBox(
                    width: screenWidth * 0.9,
                    child: CustomTextField(
                        obscureText: signUpCubit.isPasswordVisible,
                        validator: (_) =>
                            context.read<SignUpCubit>().state.password.error,
                        onChanged: context.read<SignUpCubit>().passwordChanged,
                        controller: passwordController,
                        labelText: textFieldConsts.passwordField,
                        icon: Icons.lock,
                        suffixIcon: signUpCubit.isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        onSuffixIconPressed: () {
                          setState(() {
                            signUpCubit.isPasswordVisible =
                                !signUpCubit.isPasswordVisible;
                          });
                        }),
                  ),
                  smallHeightBetweenComponents(screenHeight),
                  SizedBox(
                    width: screenWidth * 0.9,
                    child: CustomTextField(
                        obscureText: signUpCubit.isConfirmPasswordVisible,
                        validator: (_) => context
                            .read<SignUpCubit>()
                            .state
                            .confirmPassword
                            .error,
                        onChanged:
                            context.read<SignUpCubit>().confirmPasswordChanged,
                        controller: confirmPasswordController,
                        labelText: textFieldConsts.confirmPasswordField,
                        icon: Icons.lock,
                        suffixIcon: signUpCubit.isConfirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        onSuffixIconPressed: () {
                          setState(() {
                            signUpCubit.isConfirmPasswordVisible =
                                !signUpCubit.isConfirmPasswordVisible;
                          });
                        }),
                  ),
                  // Align(
                  //     alignment: Alignment.centerRight,
                  //     child: TextButton(
                  //         onPressed: () {
                  //           context
                  //               .read<AuthCubit>()
                  //               .sendEmailVerification(); //this is not working
                  //         },
                  //         child: AutoSizeText(
                  //           'Resend verification link?   ',
                  //           style: TextStyle(color: black),
                  //         ))),
                  smallHeightBetweenComponents(screenHeight),
                  CustomElevatedButton(screenWidth, screenHeight,
                      'Verify Email', context, primaryBrown, white, () {
                    verifySignUpFields(
                        context,
                        emailController,
                        passwordController,
                        confirmPasswordController,
                        widget.tabController,
                        authCubit);
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
                  // GoogleLogo(context.read<AuthCubit>().signInWithGoogle),
                  // smallHeightBetweenComponents(screenHeight),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        randomStringConsts.alreadyHaveAccount,
                        style: appTheme.textTheme.bodySmall,
                      ),
                      TextButton(
                        child: AutoSizeText(
                          'Sign In',
                          style: TextStyle(color: primaryBrown, fontSize: 15),
                        ),
                        onPressed: () {
                          widget.tabController.animateTo(0);
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

Future<void> verifySignUpFields(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController confirmPasswordController,
    TabController tabController,
    AuthCubit authCubit) async {
  if (emailController.text.isEmpty ||
      passwordController.text.isEmpty ||
      confirmPasswordController.text.isEmpty) {
    Services().showSnackBar(context, loginConsts.enterAllFields);
  } else if (passwordController.text.length < 8 ||
      confirmPasswordController.text.length < 8) {
    Services().showSnackBar(context, loginConsts.passwordLengthError);
  } else if (passwordController.text != confirmPasswordController.text) {
    Services().showSnackBar(context, loginConsts.passwordMismatch);
  } else {
    final bool userExist =
        await context.read<AuthCubit>().checkUserExists(emailController.text);
    if (userExist) {
      Services().showSnackBar(context, loginConsts.userExists);
    } else {
      context
          .read<AuthCubit>()
          .signUpWithEmail(
              email: emailController.text, password: passwordController.text)
          .then((value) => {tabController.animateTo(0)});
    }
  }
}
