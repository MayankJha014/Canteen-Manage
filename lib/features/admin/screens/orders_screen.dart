import 'package:flutter/material.dart';
import 'package:zomato_clone/common/widgets/loader.dart';
import 'package:zomato_clone/features/account/widgets/single_product.dart';
import 'package:zomato_clone/features/admin/services/admin_services.dart';
import 'package:zomato_clone/features/order_details/screens/order_details.dart';
import 'package:zomato_clone/models/order.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders;
  List<Order>? orders1;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
    fetchOrders1();
    setState(() {});
  }

  void fetchOrders() async {
    orders = await adminServices.fetchAllOrders(context);
    setState(() {});
  }

  void fetchOrders1() async {
    orders1 = await adminServices.fetchAllOrdersTo(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null && orders1 == null
        ? const Loader()
        : DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(100),
                child: AppBar(
                  elevation: 0,
                  flexibleSpace: Container(
                    decoration: BoxDecoration(color: Colors.black87),
                  ),
                  bottom: const TabBar(
                    tabs: [
                      Tab(
                          icon: Text(
                        "Pending Order",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      Tab(
                        icon: Text(
                          "Order History",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Image.asset(
                          'assets/logo1.png',
                          width: 140,
                          height: 70,
                        ),
                      ),
                      Text(
                        "Admin",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              body: TabBarView(
                children: [
                  ListView.builder(
                    itemCount: orders!.length,
                    itemBuilder: (context, index) {
                      final orderData = orders![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            OrderDetailScreen.routeName,
                            arguments: orderData,
                          );
                        },
                        child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Card(
                              color: Colors.blueAccent[50],
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: SingleProduct(
                                        image: orderData.products[0].images[0],
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: Text(
                                          orderData.products[0].name,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 19),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(
                                          "Quantity :${orderData.quantity[0]}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.blueGrey[900],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      );
                    },
                  ),
                  ListView.builder(
                    itemCount: orders1!.length,
                    itemBuilder: (context, index) {
                      final orderData = orders1![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            OrderDetailScreen.routeName,
                            arguments: orderData,
                          );
                        },
                        child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Card(
                              color: Colors.blueAccent[50],
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: SingleProduct(
                                        image: orderData.products[0].images[0],
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: Text(
                                          orderData.products[0].name,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 19),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(
                                          "Quantity :${orderData.quantity[0]}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.blueGrey[900],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
  }
}
