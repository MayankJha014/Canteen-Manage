import 'package:flutter/material.dart';
import 'package:zomato_clone/common/widgets/loader.dart';
import 'package:zomato_clone/features/account/services/account_services.dart';
import 'package:zomato_clone/features/account/widgets/single_product.dart';
import 'package:zomato_clone/features/admin/services/admin_services.dart';
import 'package:zomato_clone/features/order_details/screens/order_details.dart';
import 'package:zomato_clone/models/order.dart';
import 'package:zomato_clone/models/product.dart';

class Orders extends StatefulWidget {
  Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;
  final AccountServices accountServices = AccountServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
    fetchAllProducts();
  }

  void fetchOrders() async {
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {});
  }

  final AdminServices adminServices = AdminServices();

  List<Product>? products;

  fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return orders == null
        ? const Loader()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      "Your Orders",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 15),
                    child: Text(
                      "See all",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.brown,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              //display Order
              Container(
                height: size.height * 0.3,
                width: size.width * 0.8,
                padding: EdgeInsets.only(
                  left: 10,
                  top: 20,
                  right: 10,
                ),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisExtent: 150),
                  scrollDirection: Axis.horizontal,
                  itemCount: orders!.length,
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, OrderDetailScreen.routeName,
                            arguments: orders![index]);
                      },
                      child: SingleProduct(
                        image: orders![index].products[0].images[0],
                      ),
                    );
                  }),
                ),
              )
            ],
          );
  }
}
