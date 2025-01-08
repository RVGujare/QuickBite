import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable()
class Outlet {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String image;
  final bool isOpen;
  final int prepTime;
  final List<MenuItem> items;

  Outlet({
    this.id = '',
    this.name = '',
    this.image = '',
    this.isOpen = true,
    this.prepTime = 0,
    this.items = const [],
  });

  factory Outlet.fromJson(Map<String, dynamic> json) => _$OutletFromJson(json);
  Map<String, dynamic> toJson() => _$OutletToJson(this);
}

@JsonSerializable()
class MenuItem {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String image;
  final String desc;
  final int price;

  MenuItem({
    this.id = '',
    this.name = '',
    this.image = '',
    this.desc = '',
    this.price = 0,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) =>
      _$MenuItemFromJson(json);
  Map<String, dynamic> toJson() => _$MenuItemToJson(this);
}

@JsonSerializable()
class CartItem {
  @JsonKey(name: '_id')
  final String id;
  final int quantity;
  String outletName;
  int prepTime;
  bool isOpen;
  String itemName;
  int price;
  String itemImage;

  CartItem(
      {this.id = '',
      this.outletName = '',
      this.isOpen = true,
      this.itemImage = '',
      this.itemName = '',
      this.prepTime = 0,
      this.price = 0,
      this.quantity = 0});

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}

@JsonSerializable()
class OrderItem {
  final int quantity;
  String outletName;
  String itemName;
  int price;
  String itemImage;

  OrderItem(
      {this.outletName = '',
      this.itemImage = '',
      this.itemName = '',
      this.price = 0,
      this.quantity = 0});

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}

@JsonSerializable()
class Order {
  @JsonKey(name: '_id')
  final String id;
  final List<OrderItem> items;
  final int totalAmount;
  final String status;
  final String pickUpTime;
  final String createdAt;

  Order({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.pickUpTime,
    required this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

@JsonSerializable()
class User {
  @JsonKey(name: '_id')
  String? id;
  final String email;
  final String firstName;
  final String lastName;
  final String phone;
  final List<CartItem> cart;

  User(
      {this.id,
      this.email = '',
      this.firstName = '',
      this.lastName = '',
      this.phone = '',
      this.cart = const []});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? phone,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
    );
  }
}
