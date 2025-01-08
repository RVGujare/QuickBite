import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_bite/constants/colors.dart';
import 'package:quick_bite/constants/custom_elevated_button.dart';
import 'package:quick_bite/constants/custom_outlined_button.dart';
import 'package:quick_bite/constants/size_constants.dart';
import 'package:quick_bite/shared/models.dart';
import 'package:quick_bite/shared/pick_up_time.dart';
import 'package:quick_bite/student/cart/cart_cubit.dart';
import 'package:quick_bite/student/cart/cart_state.dart';
import 'package:quick_bite/student/orders/order_screen.dart';

class CartScreen extends StatelessWidget {
  double getTotalPrice(List<CartItem> cartItems) {
    double totalPrice = 0;
    for (var item in cartItems) {
      totalPrice += item.price * item.quantity;
    }
    return totalPrice;
  }

  int getMaxPrepTime(List<CartItem> cartItems) {
    int maxTime = 0;
    for (var item in cartItems) {
      if (item.prepTime > maxTime) {
        maxTime = item.prepTime;
      }
    }

    return maxTime;
  }

  @override
  Widget build(BuildContext context) {
    context.read<CartCubit>().getCompleteCart();
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Center(
                child: Text(
          'Your Cart',
          style: TextStyle(fontWeight: FontWeight.bold, color: primaryBrown),
        ))),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartState) {
              double totalPrice = getTotalPrice(state.cartItems);
              int maxPrepTime = getMaxPrepTime(state.cartItems);
              final currentTime = DateTime.now();
              final items = state.cartItems;
              if (items.isEmpty) {
                return const Center(child: Text('Your cart is empty.'));
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return _buildCartItem(items[index], context);
                      },
                    ),
                    smallHeightBetweenComponents(screenHeight),
                    Text(
                      'Total Price: ₹$totalPrice',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryBrown,
                          fontSize: 23),
                    ),
                    //mediumHeightBetweenComponents(screenHeight),
                    PickupTimeScreen(
                        maxPrepTime: maxPrepTime,
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                        currentTime: currentTime),
                    smallHeightBetweenComponents(screenHeight),
                    CustomElevatedButton(screenWidth, screenHeight,
                        'Place Order', context, primaryBrown, white, () {
                      // TimeOfDay minTime = ;
                      context.read<CartCubit>().placeOrder(totalPrice).then(
                          (value) =>
                              {showOrderPlacedDialog(context, screenHeight)});
                    })
                  ],
                ),
              );
            }

            return const Center(child: Text('No data available.'));
          },
        ),
      ),
    );
  }

  void showOrderPlacedDialog(BuildContext context, double screenHeight) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(
                'Congratulations!',
                style: TextStyle(
                    color: primaryBrown,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              smallHeightBetweenComponents(screenHeight),
              const AutoSizeText(
                'Your order has been placed successfully',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          actions: <Widget>[
            Center(
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    side: BorderSide(color: primaryBrown),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: AutoSizeText(
                    'Close',
                    style: TextStyle(
                        color: primaryBrown,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
            ),
          ],
        );
      },
    );
  }

  // void showOrderPlacedDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         contentPadding: EdgeInsets.symmetric(horizontal: 24.0),
  //         content: Column(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             AutoSizeText(
  //               'Congratulations!',
  //               style: TextStyle(
  //                   color: primaryBrown,
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 20),
  //             ),
  //             const AutoSizeText('Your order has been placed successfully'),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget _buildCartItem(CartItem item, BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: item.itemImage,
              placeholder: (context, url) => Image.asset(
                'assets/food_placeholder.jpg',
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              imageBuilder: (context, imageProvider) => Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.itemName,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('Price: ₹${item.price}'),
                ],
              ),
            ),
            QuantityButton(cartItem: item),
          ],
        ),
      ),
    );
  }
}

class QuantityButton extends StatelessWidget {
  final CartItem cartItem;

  const QuantityButton({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      decoration: BoxDecoration(
        border: Border.all(color: primaryBrown, width: 2),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.remove, color: primaryBrown),
            onPressed: () {
              if (cartItem.quantity > 0) {
                context.read<CartCubit>().updateQuantity(
                    '', cartItem.id, cartItem.quantity - 1, true);
              }
            },
          ),
          Text(
            '${cartItem.quantity}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryBrown,
            ),
          ),
          IconButton(
            icon: Icon(Icons.add, color: primaryBrown),
            onPressed: () {
              context
                  .read<CartCubit>()
                  .updateQuantity('', cartItem.id, cartItem.quantity + 1, true);
            },
          ),
        ],
      ),
    );
  }
}
