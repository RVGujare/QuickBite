import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_bite/constants/colors.dart';
import 'package:quick_bite/shared/models.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:quick_bite/student/cart/add_to_cart_button.dart';
import 'package:quick_bite/student/cart/cart_cubit.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key, required this.outlet});

  final Outlet outlet;

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<MenuItem> filteredItems = [];

  late Future<List<CartItem>> cartItems;

  @override
  void initState() {
    super.initState();
    filteredItems = widget.outlet.items;
    cartItems = context.read<CartCubit>().getCart();
    //debugPrint('cart items - $cartItems');
  }

  void _filterMenuItems(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredItems = widget.outlet.items;
      } else {
        filteredItems = widget.outlet.items
            .where(
                (item) => item.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Outlet outlet = widget.outlet;
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: screenHeight * 0.2,
                  decoration: BoxDecoration(
                    color: primaryBrown,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: IconButton(
                    iconSize: 30,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_circle_left_outlined),
                    //icon: const Icon(Icons.arrow_back),
                    color: white,
                  ),
                ),
                Column(
                  children: [
                    AutoSizeText(
                      outlet.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: white,
                      ),
                      maxLines: 1,
                      minFontSize: 13,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          color: yellow,
                        ),
                        AutoSizeText(
                          ' Preparation time: ${outlet.prepTime} mins',
                          style: TextStyle(fontSize: 16, color: white),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    // backgroundColor: primaryBrown,
                    automaticallyImplyLeading: false,
                    title: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          //color: Colors.grey[350],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          onChanged: _filterMenuItems,
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search for dishes',
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: grey)),
                            prefixIcon: Icon(Icons.search, color: grey),
                            suffixIcon: _searchController.text.isNotEmpty
                                ? IconButton(
                                    icon: Icon(Icons.clear, color: grey),
                                    onPressed: () {
                                      _searchController.clear();
                                      _filterMenuItems('');
                                    },
                                  )
                                : null,
                          ),
                        ),
                      ),
                    ),
                  ),
                  filteredItems.isEmpty
                      ? SliverFillRemaining(
                          child: Center(
                            child: AutoSizeText(
                              "No dishes found!",
                              style: TextStyle(
                                fontSize: 18,
                                color: grey,
                              ),
                            ),
                          ),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return itemCard(
                                  filteredItems[index],
                                  screenHeight,
                                  screenWidth,
                                  context,
                                  cartItems);
                            },
                            childCount: filteredItems.length,
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemCard(
    MenuItem item,
    double screenHeight,
    double screenWidth,
    BuildContext context,
    Future<List<CartItem>> cartItems,
  ) {
    return GestureDetector(
      onTap: () {
        showItemDetails(item, screenHeight, screenWidth, context, cartItems);
      },
      child: Card(
        shadowColor: grey,
        elevation: 5,
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      item.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    AutoSizeText(
                      item.desc,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 10),
                    AutoSizeText(
                      '₹${item.price}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: green,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: item.image,
                    placeholder: (context, url) => Image.asset(
                      'assets/food_placeholder.jpg',
                      height: screenHeight * 0.2,
                      width: screenWidth * 0.38,
                      fit: BoxFit.cover,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    imageBuilder: (context, imageProvider) => Container(
                      height: screenHeight * 0.2,
                      width: screenWidth * 0.38,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  AddToCartButton(
                      itemId: item.id,
                      cartItems: cartItems,
                      outletId: widget.outlet.id)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showItemDetails(MenuItem item, double screenHeight, double screenWidth,
      BuildContext context, Future<List<CartItem>> cartItems) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Stack(
          children: [
            Container(
              height: screenHeight * 0.75,
              decoration: BoxDecoration(
                color: white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: item.image,
                    placeholder: (context, url) => Image.asset(
                      'assets/food_placeholder.jpg',
                      height: screenHeight * 0.35,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    imageBuilder: (context, imageProvider) => Container(
                      height: screenHeight * 0.35,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          item.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        AutoSizeText(
                          item.desc,
                          style: TextStyle(fontSize: 16, color: grey),
                        ),
                        const SizedBox(height: 20),
                        AutoSizeText(
                          '₹${item.price}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: green,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Center(
                        //   child: ElevatedButton(
                        //     onPressed: () {
                        //       // Add button functionality
                        //     },
                        //     style: ElevatedButton.styleFrom(
                        //       backgroundColor: primaryBrown,
                        //       padding: const EdgeInsets.symmetric(
                        //           vertical: 12, horizontal: 30),
                        //     ),
                        //     child: AutoSizeText(
                        //       'Add to Cart',
                        //       style: TextStyle(fontSize: 18, color: white),
                        //     ),
                        //   ),
                        // ),
                        // Center(
                        //   child: BlocProvider<CartCubit>(
                        //     create: (BuildContext context) => CartCubit(),
                        //     child: AddToCartButton(
                        //       itemId: item.id,
                        //       cartItems: cartItems,
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.close, color: Colors.black),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

// void showItemDetails(MenuItem item, double screenHeight, double screenWidth,
//     BuildContext context) {
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     builder: (context) {
//       return Container(
//         height: screenHeight * 0.75,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(30),
//             topRight: Radius.circular(30),
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               children: [
//                 CachedNetworkImage(
//                   imageUrl: item.image!,
//                   placeholder: (context, url) => Image.asset(
//                     'assets/food_placeholder.jpg',
//                     height: screenHeight * 0.35,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   ),
//                   errorWidget: (context, url, error) => Icon(Icons.error),
//                   imageBuilder: (context, imageProvider) => Container(
//                     height: screenHeight * 0.35,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(30),
//                         topRight: Radius.circular(30),
//                       ),
//                       image: DecorationImage(
//                         image: imageProvider,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 10,
//                   right: 10,
//                   child: IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon:
//                         const Icon(Icons.close, color: Colors.white, size: 30),
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     item.name!,
//                     style: const TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     item.desc!,
//                     style: const TextStyle(fontSize: 16, color: Colors.grey),
//                   ),
//                   const SizedBox(height: 20),
//                   Text(
//                     '₹${item.price}',
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.green,
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Center(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Add button functionality
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: primaryBrown,
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 12, horizontal: 30),
//                       ),
//                       child: const Text(
//                         'Add to Cart',
//                         style: TextStyle(fontSize: 18, color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }
}
