import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_bite/auth/cubits/auth_cubit.dart';
import 'package:quick_bite/auth/cubits/sign_in_cubit.dart';
import 'package:quick_bite/auth/cubits/sign_up_cubit.dart';
import 'package:quick_bite/auth/screens/sign_in_screen.dart';
import 'package:quick_bite/auth/screens/sign_up_screen.dart';
import 'package:quick_bite/auth/screens/welcome_screen.dart';
import 'package:quick_bite/auth/states/auth_state.dart';
import 'package:quick_bite/constants/colors.dart';
import 'package:quick_bite/initial_screen.dart';
import 'package:quick_bite/shared/services.dart';

class TabControllerScreen extends StatefulWidget {
  final int initialTabIndex;
  const TabControllerScreen({super.key, this.initialTabIndex = 0});

  @override
  State<TabControllerScreen> createState() => _TabControllerScreenState();
}

class _TabControllerScreenState extends State<TabControllerScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabTitles = ['Sign In', 'Sign Up'];
  String _appBarTitle = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 2, vsync: this, initialIndex: widget.initialTabIndex);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
      _appBarTitle = _tabTitles[_tabController.index];
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    return BlocProvider(
      create: (context) => AuthCubit()..checkAuth(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ErrorState) {
            Services().showSnackBar(context, state.message);
          } else if (state is EmailUnverifiedState) {
            debugPrint('email - ${state.email}');

            Services()
                .showSnackBarWithAction(context, state.email, state.password);
          }
        },
        builder: (context, state) {
          debugPrint('called');

          if (state is AuthenticatedState) {
            return const DisplayScreen();
          } else if (state is AuthLoadingState) {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          } else if (state is UnauthWelcomeState) {
            return const WelcomeScreen();
          } else {
            //authCubit.role = widget.role;
            return SafeArea(
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Container(
                      //   height: screenHeight * 0.3,
                      //   decoration: const BoxDecoration(
                      //       image: DecorationImage(
                      //           image: AssetImage("initial_page_background.png"),
                      //           fit: BoxFit.cover)),
                      // ),
                      Container(
                        height: screenHeight * 0.3,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: screenHeight * 0.3,
                              width: screenWidth,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                image: AssetImage(
                                    "assets/initial_page_background.png"),
                                fit: BoxFit.cover,
                              )),
                            ),
                            Positioned(
                                child: IconButton(
                              iconSize: 40,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon:
                                  const Icon(Icons.arrow_circle_left_outlined),
                              color: white,
                            )),
                            Align(
                              alignment: Alignment.center,
                              child: Image.asset(
                                "assets/logo4.png",
                                width: screenWidth * 0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenHeight,
                        child: Scaffold(
                          appBar: AppBar(
                            automaticallyImplyLeading: false,
                            bottom: TabBar(
                                dividerHeight: 0,
                                indicatorColor: primaryBrown,
                                controller: _tabController,
                                tabs: [
                                  Tab(
                                    child: AutoSizeText(
                                      'Sign In',
                                      style: TextStyle(
                                          color: primaryBrown, fontSize: 20),
                                    ),
                                  ),
                                  Tab(
                                    child: AutoSizeText(
                                      'Sign Up',
                                      style: TextStyle(
                                          color: primaryBrown, fontSize: 20),
                                    ),
                                  )
                                ]),
                          ),
                          body: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                BlocProvider(
                                    create: (context) => SignInCubit(),
                                    child: SignInScreen(
                                        tabController: _tabController)),
                                BlocProvider(
                                    create: (context) => SignUpCubit(),
                                    child: SignUpScreen(
                                        tabController: _tabController))
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
