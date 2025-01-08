import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:quick_bite/shared/models.dart';
import 'dart:convert';

class OrdersCubit extends Cubit<List<Order>> {
  OrdersCubit() : super([]);

  Future<void> fetchOrders() async {
    emit([]);
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final url = Uri.parse("http://localhost:3000/order/$userId");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        List<dynamic> orderJson = jsonResponse['orders'];

        // Parse JSON into Order objects.
        List<Order> orders =
            orderJson.map((order) => Order.fromJson(order)).toList();

        emit(orders);
      } else {
        throw Exception("Failed to fetch orders");
      }
    } catch (e) {
      print("Error fetching orders: $e");
      emit([]);
    }
  }
}
