import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:quick_bite/shared/models.dart';
import 'package:quick_bite/student/cart/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  late TimeOfDay pickUpTime;

  CartCubit() : super(CartState(cartItems: []));
  Auth.FirebaseAuth auth = Auth.FirebaseAuth.instance;

  Future<void> updateQuantity(
      String outletId, String itemId, int quantity, bool isCart) async {
    final userId = auth.currentUser!.uid;
    final url = Uri.parse('http://localhost:3000/cart/update');

    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'itemId': itemId,
          'userId': userId,
          'quantity': quantity,
          'outletId': outletId
        }));

    if (response.statusCode == 200) {
      debugPrint('quantity updated successfully');

      if (isCart) {
        getCompleteCart();
      } else {
        final jsonResponse = json.decode(response.body);
        debugPrint('${response.body}');
        List<dynamic> cartJson = jsonResponse['cart'];
        List<CartItem> cart =
            cartJson.map((item) => CartItem.fromJson(item)).toList();
        emit(CartState(cartItems: cart));
      }
    }
  }

  Future<List<CartItem>> getCart() async {
    final userId = auth.currentUser!.uid;
    final url = Uri.parse('http://localhost:3000/cart/$userId');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      // debugPrint('${response.body}');
      List<dynamic> cartJson = jsonResponse['cart'];
      List<CartItem> cart =
          cartJson.map((item) => CartItem.fromJson(item)).toList();
      //emit(CartState(cartItems: cart));

      return cart;
    } else {
      return [];
    }
  }

  Future<void> getCompleteCart() async {
    debugPrint('complete cart called');
    final userId = auth.currentUser!.uid;
    final url = Uri.parse('http://localhost:3000/cart/complete/$userId');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      //debugPrint('${response.body}');
      List<dynamic> cartJson = jsonResponse['cart'];
      List<CartItem> cart =
          cartJson.map((item) => CartItem.fromJson(item)).toList();
      emit(CartState(cartItems: cart));
    }
  }

  void increment(String outletId, String itemId, int quantity) {
    updateQuantity(outletId, itemId, quantity + 1, false);
    //getCart();
  }

  void decrement(String outletId, String itemId, int quantity) {
    updateQuantity(outletId, itemId, quantity - 1, false);
    //getCart();
  }

  Map<String, int> convertTimeOfDayToMap(TimeOfDay time) {
    return {'hour': time.hour, 'minute': time.minute};
  }

  Future<void> placeOrder(double totalPrice) async {
    debugPrint('pick up time - $pickUpTime');
    final pickUpTimeMap = convertTimeOfDayToMap(pickUpTime);
    final userId = auth.currentUser!.uid;
    final url = Uri.parse('http://localhost:3000/order/place/$userId');

    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json
            .encode({'totalPrice': totalPrice, 'pickUpTime': pickUpTimeMap}));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      debugPrint('${response.body}');
      List<dynamic> cartJson = jsonResponse['cart'];
      List<CartItem> cart =
          cartJson.map((item) => CartItem.fromJson(item)).toList();
      emit(CartState(cartItems: cart));
    }
  }

  // Future<List<Order>> getOrders() async {
  //   final userId = auth.currentUser!.uid;
  //   final url = Uri.parse('http://localhost:3000/order/$userId');

  //   final response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     final List<dynamic> ordersJson = data['orders'];
  //     return ordersJson.map((json) => Order.fromJson(json)).toList();
  //   } else {
  //     throw Exception("Failed to fetch orders");
  //   }
  // }
}
