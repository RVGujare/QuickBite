// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Outlet _$OutletFromJson(Map<String, dynamic> json) => Outlet(
      id: json['_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      image: json['image'] as String? ?? '',
      isOpen: json['isOpen'] as bool? ?? true,
      prepTime: (json['prepTime'] as num?)?.toInt() ?? 0,
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$OutletToJson(Outlet instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'isOpen': instance.isOpen,
      'prepTime': instance.prepTime,
      'items': instance.items,
    };

MenuItem _$MenuItemFromJson(Map<String, dynamic> json) => MenuItem(
      id: json['_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      image: json['image'] as String? ?? '',
      desc: json['desc'] as String? ?? '',
      price: (json['price'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$MenuItemToJson(MenuItem instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'desc': instance.desc,
      'price': instance.price,
    };

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
      id: json['_id'] as String? ?? '',
      outletName: json['outletName'] as String? ?? '',
      isOpen: json['isOpen'] as bool? ?? true,
      itemImage: json['itemImage'] as String? ?? '',
      itemName: json['itemName'] as String? ?? '',
      prepTime: (json['prepTime'] as num?)?.toInt() ?? 0,
      price: (json['price'] as num?)?.toInt() ?? 0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
      '_id': instance.id,
      'quantity': instance.quantity,
      'outletName': instance.outletName,
      'prepTime': instance.prepTime,
      'isOpen': instance.isOpen,
      'itemName': instance.itemName,
      'price': instance.price,
      'itemImage': instance.itemImage,
    };

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
      outletName: json['outletName'] as String? ?? '',
      itemImage: json['itemImage'] as String? ?? '',
      itemName: json['itemName'] as String? ?? '',
      price: (json['price'] as num?)?.toInt() ?? 0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'quantity': instance.quantity,
      'outletName': instance.outletName,
      'itemName': instance.itemName,
      'price': instance.price,
      'itemImage': instance.itemImage,
    };

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['_id'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalAmount: (json['totalAmount'] as num).toInt(),
      status: json['status'] as String,
      pickUpTime: json['pickUpTime'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      '_id': instance.id,
      'items': instance.items,
      'totalAmount': instance.totalAmount,
      'status': instance.status,
      'pickUpTime': instance.pickUpTime,
      'createdAt': instance.createdAt,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['_id'] as String?,
      email: json['email'] as String? ?? '',
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      cart: (json['cart'] as List<dynamic>?)
              ?.map((e) => CartItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '_id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phone': instance.phone,
      'cart': instance.cart,
    };
