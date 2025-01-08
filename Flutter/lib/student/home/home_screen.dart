import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_bite/constants/colors.dart';
import 'package:quick_bite/constants/custom_elevated_button.dart';
import 'package:quick_bite/constants/size_constants.dart';
import 'package:quick_bite/outlets/menu.dart';
import 'package:quick_bite/outlets/outlets_list.dart';
import 'package:quick_bite/shared/models.dart';
import 'package:quick_bite/student/cart/add_to_cart_button.dart';
import 'package:quick_bite/student/cart/cart_cubit.dart';
import 'package:quick_bite/student/cart/cart_screen.dart';
import 'package:quick_bite/student/home/home_cubit.dart';
import 'package:quick_bite/student/home/home_state.dart';
import 'package:quick_bite/student/orders/order_cubit.dart';
import 'package:quick_bite/student/orders/order_screen.dart';
import 'package:quick_bite/student/profile/profile_screen.dart';
import 'package:provider/provider.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    return BlocProvider<HomeCubit>(
        create: (context) => HomeCubit()..getUserData(),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeLoadedState) {
              return SafeArea(
                child: Scaffold(
                  bottomNavigationBar: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    items: const <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.shopping_cart),
                        label: 'Cart',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.receipt_long),
                        label: 'Orders',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.person),
                        label: 'Profile',
                      ),
                    ],
                    currentIndex: _selectedIndex,
                    selectedItemColor: primaryBrown,
                    onTap: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                  ),
                  body: IndexedStack(
                    index: _selectedIndex,
                    children: [
                      SingleChildScrollView(
                        child: Container(
                          margin: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              smallHeightBetweenComponents(screenHeight),
                              AutoSizeText(
                                'Hello ${state.user.firstName},',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const AutoSizeText(
                                  'Where would you like to eat today?'),
                              smallHeightBetweenComponents(screenHeight),
                              AutoSizeText(
                                'Available Outlets',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryBrown),
                              ),
                              smallHeightBetweenComponents(screenHeight),
                              const OutletList(),
                            ],
                          ),
                        ),
                      ),
                      BlocProvider<CartCubit>(
                          create: (context) => CartCubit(),
                          child: CartScreen()),
                      BlocProvider(
                        create: (context) => OrdersCubit()..fetchOrders(),
                        child: OrdersScreen(),
                      ),
                      ProfileScreen(
                          currUser: state.user,
                          onUpdateUser: (updatedUser) {
                            context
                                .read<HomeCubit>()
                                .updateUserDetails(updatedUser);
                          })
                    ],
                  ),
                ),
              );
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ));
  }
}
