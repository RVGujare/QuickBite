import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_bite/constants/colors.dart';
import 'package:quick_bite/shared/models.dart';
import 'package:quick_bite/student/cart/cart_cubit.dart';
import 'package:quick_bite/student/cart/cart_state.dart';

class AddToCartButton extends StatefulWidget {
  const AddToCartButton({
    super.key,
    required this.itemId,
    this.cartItems,
    this.outletId,
  });

  final String itemId;
  final String? outletId;
  final Future<List<CartItem>>? cartItems;

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  int quantity = 0;

  @override
  void initState() {
    super.initState();
    _initializeQuantity();
  }

  Future<void> _initializeQuantity() async {
    final cartItems = await widget.cartItems;
    final cartItem = cartItems!.firstWhere(
      (item) => item.id == widget.itemId,
      orElse: () => CartItem(id: widget.itemId!, quantity: 0),
    );
    setState(() {
      quantity = cartItem.quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CartState) {
          final cartItem = state.cartItems.firstWhere(
            (item) => item.id == widget.itemId,
            orElse: () => CartItem(id: widget.itemId!, quantity: 0),
          );
          setState(() {
            quantity = cartItem.quantity;
          });
        }
      },
      child: quantity == 0
          ? SizedBox(
              width: 100,
              child: ElevatedButton(
                onPressed: () {
                  context
                      .read<CartCubit>()
                      .increment(widget.outletId!, widget.itemId!, quantity);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBrown,
                ),
                child: Text('Add', style: TextStyle(color: Colors.white)),
              ),
            )
          : Container(
              width: 120,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.brown, width: 2),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove, color: primaryBrown),
                    onPressed: () {
                      context.read<CartCubit>().decrement(
                          widget.outletId!, widget.itemId!, quantity);
                    },
                  ),
                  Text(
                    '$quantity',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryBrown,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add, color: primaryBrown),
                    onPressed: () {
                      context.read<CartCubit>().increment(
                          widget.outletId!, widget.itemId!, quantity);
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
