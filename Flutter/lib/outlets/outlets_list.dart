import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_bite/constants/colors.dart';
import 'package:quick_bite/constants/role_container.dart';
import 'package:quick_bite/constants/size_constants.dart';
import 'package:quick_bite/outlets/menu.dart';
import 'package:quick_bite/outlets/outlets_cubit.dart';
import 'package:quick_bite/outlets/outlets_state.dart';
import 'package:quick_bite/shared/models.dart';
import 'package:quick_bite/student/cart/cart_cubit.dart';
import 'package:quick_bite/student/cart/cart_state.dart';

// class OutletList extends StatefulWidget {
//   const OutletList({super.key});

//   @override
//   State<OutletList> createState() => _OutletListState();
// }

// class _OutletListState extends State<OutletList> {
//   final CarouselController _controller = CarouselController();
//   int _currentPage = 0;
//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     final screenHeight = screenSize.height;
//     final screenWidth = screenSize.width;
//     return BlocProvider(
//       create: (context) => OutletsCubit()..getOutlets(),
//       child: BlocBuilder<OutletsCubit, OutletsState>(
//         builder: (context, state) {
//           if (state is OutletsLoadingState) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (state is OutletsLoadedState) {
//             return Column(
//               children: [
//                 smallHeightBetweenComponents(screenHeight),
//                 SizedBox(
//                   height: screenHeight * 0.3,
//                   width: screenWidth * 0.9,
//                   child: CarouselSlider(
//                     items: state.outlets.map((outlet) {
//                       return Container(
//                         margin: const EdgeInsets.symmetric(horizontal: 15),
//                         child: outletContainer(
//                           screenWidth,
//                           screenHeight,
//                           outlet.image,
//                           outlet.name,
//                           () {
//                             Navigator.of(context).push(MaterialPageRoute(
//                                 builder: (context) => BlocProvider<CartCubit>(
//                                     create: (context) => CartCubit(),
//                                     child: BlocBuilder<CartCubit, CartState>(
//                                         builder: (context, state) =>
//                                             MenuScreen(outlet: outlet)))));
//                           },
//                         ),
//                       );
//                     }).toList(),
//                     carouselController: _controller,
//                     options: CarouselOptions(
//                       autoPlay: true,
//                       viewportFraction: 1,
//                       onPageChanged: (index, reason) {
//                         setState(() {
//                           _currentPage = index;
//                         });
//                       },
//                     ),
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: state.outlets.asMap().entries.map((entry) {
//                     return GestureDetector(
//                       onTap: () => _controller.animateToPage(entry.key),
//                       child: Container(
//                         width: 12.0,
//                         height: 12.0,
//                         margin: const EdgeInsets.symmetric(
//                           vertical: 8.0,
//                           horizontal: 4.0,
//                         ),
//                         decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: _currentPage == entry.key
//                                 ? primaryBrown
//                                 : grey.withOpacity(0.3)),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ],
//             );
//           } else {
//             return const Center(child: AutoSizeText('Something went wrong'));
//           }
//         },
//       ),
//     );
//   }
// }

class OutletList extends StatefulWidget {
  const OutletList({super.key});

  @override
  State<OutletList> createState() => _OutletListState();
}

class _OutletListState extends State<OutletList> {
  final CarouselController _controller = CarouselController();
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    return BlocProvider(
      create: (context) => OutletsCubit()..getOutlets(),
      child: BlocBuilder<OutletsCubit, OutletsState>(
        builder: (context, state) {
          if (state is OutletsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is OutletsLoadedState) {
            return SingleChildScrollView(
                child: Column(children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: state.outlets.length,
                itemBuilder: (context, index) {
                  Outlet outlet = state.outlets[index];
                  return outletContainer(
                    screenWidth,
                    screenHeight,
                    outlet.image,
                    outlet.name,
                    () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BlocProvider<CartCubit>(
                              create: (context) => CartCubit(),
                              child: BlocBuilder<CartCubit, CartState>(
                                  builder: (context, state) =>
                                      MenuScreen(outlet: outlet)))));
                    },
                  );
                },
              ),
            ]));
          } else {
            return const Center(child: AutoSizeText('Something went wrong'));
          }
        },
      ),
    );
  }
}
