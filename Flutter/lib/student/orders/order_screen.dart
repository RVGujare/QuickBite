import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_bite/constants/size_constants.dart';
import 'package:quick_bite/shared/models.dart';
import 'order_cubit.dart';
import 'package:quick_bite/constants/colors.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    _refreshOrder();
  }

  void _refreshOrder() {
    context.read<OrdersCubit>().fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    //context.read<OrdersCubit>().fetchOrders();
    return Scaffold(
      appBar: AppBar(
          title: Center(
              child: Text(
        'Your Orders',
        style: TextStyle(fontWeight: FontWeight.bold, color: primaryBrown),
      ))),
      body: BlocBuilder<OrdersCubit, List<Order>>(
        builder: (context, orders) {
          if (orders.isEmpty) {
            return const Center(
              child: Text("No orders found."),
            );
          }

          final activeOrders =
              orders.where((order) => order.status != "Picked").toList();
          final pastOrders =
              orders.where((order) => order.status == "Picked").toList();
          final recentOrders = pastOrders.reversed.take(10).toList();

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (activeOrders.isNotEmpty) ...[
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: activeOrders.length,
                    itemBuilder: (context, index) {
                      return OrderCard(
                        order: activeOrders[index],
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                        pastOrder: false,
                      );
                    },
                  ),
                ] else
                  const Center(child: Text('No active orders found')),
                mediumHeightBetweenComponents(screenHeight),
                const Divider(),
                smallHeightBetweenComponents(screenHeight),
                if (recentOrders.isNotEmpty) ...[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Past Orders",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: grey),
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: recentOrders.length,
                    itemBuilder: (context, index) {
                      return OrderCard(
                        order: recentOrders[index],
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                        pastOrder: true,
                      );
                    },
                  ),
                ] else
                  const Center(child: Text('No previous orders'))
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void didUpdateWidget(covariant OrdersScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    _refreshOrder();
  }

  @override
  bool get wantKeepAlive => true;
}

String extractTime(String formattedDateTime) {
  List<String> parts = formattedDateTime.split(', ');
  if (parts.length > 1) {
    return parts[1];
  }
  return '';
}

class OrderCard extends StatelessWidget {
  final Order order;
  final double screenHeight;
  final double screenWidth;
  final bool pastOrder;

  const OrderCard(
      {Key? key,
      required this.order,
      required this.screenHeight,
      required this.screenWidth,
      required this.pastOrder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedItems = order.items
        .map((item) => "${item.quantity} x ${item.itemName}")
        .join(", ");

    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: grey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: AutoSizeText(
                order.items.first.outletName,
                maxFontSize: 22,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: pastOrder ? grey : black),
              ),
            ),
            const Divider(),
            smallHeightBetweenComponents(screenHeight),
            Text(
              formattedItems,
              style: TextStyle(color: grey, fontSize: 18),
            ),
            const SizedBox(
              height: 5,
            ),
            AutoSizeText(
              "Total: ₹${order.totalAmount}",
              style: TextStyle(color: pastOrder ? grey : green, fontSize: 18),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!pastOrder)
                  AutoSizeText(
                    "Pickup at: ${extractTime(order.pickUpTime)}",
                    style: TextStyle(fontSize: 18),
                  )
                else
                  AutoSizeText(
                    order.pickUpTime,
                    style: TextStyle(fontSize: 18, color: grey),
                  ),
                AutoSizeText(
                  order.status,
                  maxFontSize: 22,
                  style: TextStyle(
                    fontSize: 18,
                    color: order.status == "Picked" ? green : primaryBrown,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
