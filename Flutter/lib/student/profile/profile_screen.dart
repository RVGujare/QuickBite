import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_bite/constants/colors.dart';
import 'package:quick_bite/constants/custom_elevated_button.dart';
import 'package:quick_bite/constants/custom_text_field.dart';
import 'package:quick_bite/constants/size_constants.dart';
import 'package:quick_bite/constants/strings.dart';
import 'package:quick_bite/shared/models.dart';
import 'package:quick_bite/student/home/home_cubit.dart';
import 'package:quick_bite/auth/cubits/auth_cubit.dart';

class ProfileScreen extends StatelessWidget {
  final User currUser;
  final Function(User) onUpdateUser;

  const ProfileScreen(
      {required this.currUser, required this.onUpdateUser, super.key});

  @override
  Widget build(BuildContext context) {
    final firstNameController = TextEditingController(text: currUser.firstName);
    final lastNameController = TextEditingController(text: currUser.lastName);
    final phoneController =
        TextEditingController(text: currUser.phone.substring(3));
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    return Scaffold(
        appBar: AppBar(
            title: Center(
                child: Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold, color: primaryBrown),
        ))),
        body: SingleChildScrollView(
          child: Center(
              child: Container(
            margin: EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/profile_placeholder.jpg',
                  height: screenHeight * 0.3,
                  width: screenWidth * 0.3,
                ),
                SizedBox(
                  width: screenWidth * 0.9,
                  child: CustomTextField(
                    controller: firstNameController,
                    labelText: textFieldConsts.firstNameField,
                    validator: (value) {
                      if (firstNameController.text.isEmpty ||
                          !RegExp(r'^[A-Za-z\s]+$')
                              .hasMatch(firstNameController.text)) {
                        return 'Please enter a valid first name';
                      }
                      return null;
                    },
                  ),
                ),
                smallHeightBetweenComponents(screenHeight),
                SizedBox(
                  width: screenWidth * 0.9,
                  child: CustomTextField(
                    controller: lastNameController,
                    labelText: textFieldConsts.lastNameField,
                    validator: (value) {
                      if (lastNameController.text.isEmpty ||
                          !RegExp(r'^[A-Za-z\s]+$')
                              .hasMatch(lastNameController.text)) {
                        return 'Please enter a valid last name';
                      }
                      return null;
                    },
                  ),
                ),
                smallHeightBetweenComponents(screenHeight),
                SizedBox(
                  width: screenWidth * 0.9,
                  child: CustomTextField(
                    initialValue: currUser.email,
                    enabled: false,
                  ),
                ),
                smallHeightBetweenComponents(screenHeight),
                SizedBox(
                  width: screenWidth * 0.9,
                  child: CustomTextField(
                    controller: phoneController,
                    labelText: 'Phone Number',
                    validator: (value) {
                      if (phoneController.text.isEmpty ||
                          phoneController.text.length != 10 ||
                          !RegExp(r'^[0-9]+$').hasMatch(phoneController.text)) {
                        return 'Please enter a valid 10-digit phone number';
                      }
                      return null;
                    },
                  ),
                ),
                mediumHeightBetweenComponents(screenHeight),
                CustomElevatedButton(screenWidth, screenHeight, 'Update',
                    context, primaryBrown, white, () {
                  final updatedUser = currUser.copyWith(
                    firstName: firstNameController.text,
                    lastName: lastNameController.text,
                    phone: phoneController.text,
                  );
                  onUpdateUser(updatedUser);
                }),
                smallHeightBetweenComponents(screenHeight),
                TextButton(
                  child: Text(
                    'Log out',
                    style: TextStyle(color: red, fontSize: 20),
                  ),
                  onPressed: () {
                    context.read<AuthCubit>().signOutUser();
                  },
                ),
              ],
            ),
          )),
        ));
  }
}
