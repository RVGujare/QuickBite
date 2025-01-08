import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_bite/auth/cubits/auth_cubit.dart';
import 'package:quick_bite/auth/screens/tab_controller_screen.dart';
import 'package:quick_bite/constants/colors.dart';
import 'package:quick_bite/constants/custom_elevated_button.dart';
import 'package:quick_bite/constants/size_constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/initial_page_background.png"),
            fit: BoxFit.fill,
            // colorFilter:
            //     ColorFilter.mode(black.withOpacity(0.4), BlendMode.darken),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/logo4.png",
              width: screenWidth * 0.3,
            ),
            smallHeightBetweenComponents(screenHeight),
            AutoSizeText(
              'QuickBite',
              style: TextStyle(
                  color: white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  decoration: TextDecoration.none),
            ),
            smallHeightBetweenComponents(screenHeight),
            CustomElevatedButton(
                screenWidth, screenHeight, 'Get Started', context, white, black,
                () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BlocProvider(
                        create: (context) => AuthCubit(),
                        child: const TabControllerScreen(),
                      )));
            }),

            // smallHeightBetweenComponents(screenHeight),
            // CustomElevatedButton(
            //     screenWidth, screenHeight, 'Franchise', context, white, black,
            //     () {
            //   Navigator.of(context).push(MaterialPageRoute(
            //       builder: (context) => const LoginScreen(
            //             role: 'franchise',
            //           )));
            // })
            // RoleContainer(screenWidth, screenHeight, "owner_2.jpg",
            //     'Business Owner', () {})
          ],
        ),
      ),
    );
  }
}
