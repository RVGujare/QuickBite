import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_bite/auth/cubits/auth_cubit.dart';
import 'package:quick_bite/auth/cubits/check_cubit.dart';
import 'package:quick_bite/auth/cubits/mandatory_fields_cubit.dart';
import 'package:quick_bite/constants/colors.dart';
import 'package:quick_bite/constants/custom_outlined_button.dart';
import 'package:quick_bite/constants/custom_text_field.dart';
import 'package:quick_bite/constants/size_constants.dart';
import 'package:quick_bite/constants/strings.dart';
import 'package:quick_bite/auth/states/mandatory_fields_state.dart';
import 'package:quick_bite/shared/services.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({super.key});
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    final authCubit = context.read<AuthCubit>();
    return BlocProvider(
      create: (context) => MandatoryFieldsCubit()
        ..fetchMandatoryFields(context.read<AuthCubit>().uid)
        ..checkDetailsFilled(context.read<AuthCubit>().uid),
      child: BlocConsumer<MandatoryFieldsCubit, MandatoryFieldState>(
        buildWhen: (previous, current) => current is! DataFilledActionState,
        listenWhen: (previous, current) => current is DataFilledActionState,
        listener: (context, state) {
          if (state is DataFilledActionState) {
            context.read<CheckCubit>().emitAllDataPresentState();
          }
        },
        builder: (context, state) {
          if (state.initialFieldRendered &&
              !context.read<MandatoryFieldsCubit>().initialDataRendered) {
            firstNameController.text = state.firstName.value;
            lastNameController.text = state.lastName.value;
            phoneController.text = state.phone.value;
            emailController.text = state.email.value;
            context.read<MandatoryFieldsCubit>().initialDataRendered = true;
          }

          return SafeArea(
            child: Scaffold(
              body: SizedBox(
                height: screenHeight,
                width: screenWidth,
                child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage("assets/initial_page_background.png"),
                          fit: BoxFit.fill)),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            iconSize: 40,
                            onPressed: () {
                              context.read<AuthCubit>().signOutUser();
                              // Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_circle_left_outlined),
                            color: white,
                          ),
                        ),
                        Image.asset(
                          "assets/logo4.png",
                          width: screenWidth * 0.3,
                          height: screenHeight * 0.2,
                        ),
                        mediumHeightBetweenComponents(screenHeight),
                        AutoSizeText(
                          randomStringConsts.tellAboutYourself,
                          style: TextStyle(
                              color: white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                        smallHeightBetweenComponents(screenHeight),
                        SizedBox(
                          width: screenWidth * 0.9,
                          child: CustomTextField(
                            labelText: textFieldConsts.firstNameField,
                            controller: firstNameController,
                            onChanged: context
                                .read<MandatoryFieldsCubit>()
                                .firstNameChanged,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                        smallHeightBetweenComponents(screenHeight),
                        SizedBox(
                          width: screenWidth * 0.9,
                          child: CustomTextField(
                            labelText: textFieldConsts.lastNameField,
                            controller: lastNameController,
                            onChanged: context
                                .read<MandatoryFieldsCubit>()
                                .lastNameChanged,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                        smallHeightBetweenComponents(screenHeight),
                        SizedBox(
                          width: screenWidth * 0.9,
                          child: CustomTextField(
                            labelText: textFieldConsts.phoneField,
                            controller: phoneController,
                            onChanged: context
                                .read<MandatoryFieldsCubit>()
                                .phoneChanged,
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                        mediumHeightBetweenComponents(screenHeight),
                        CustomOutlinedButton(
                            screenWidth, screenHeight, 'Submit', () {
                          if (firstNameController.text.isEmpty ||
                              phoneController.text.isEmpty ||
                              lastNameController.text.isEmpty) {
                            Services().showSnackBar(
                                context, loginConsts.enterAllFields);
                          } else {
                            context
                                .read<MandatoryFieldsCubit>()
                                .setUpdateMandatoryFields(
                                    context.read<AuthCubit>().uid);
                          }
                        })
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
