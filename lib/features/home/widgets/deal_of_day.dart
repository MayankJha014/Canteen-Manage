import 'package:flutter/material.dart';
import 'package:zomato_clone/common/widgets/banner_ads.dart';
import 'package:zomato_clone/common/widgets/loader.dart';
import 'package:zomato_clone/common/widgets/shimmer.dart';
import 'package:zomato_clone/common/widgets/stars.dart';
import 'package:zomato_clone/features/home/services/home_services.dart';
import 'package:zomato_clone/features/product_details/screens/product_details_screen.dart';
import 'package:zomato_clone/models/product.dart';

class DealOfDay extends StatefulWidget {
  DealOfDay({Key? key}) : super(key: key);

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  Product? product;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    product = await homeServices.fetchDealOfDay(context: context);
    setState(() {});
  }

  void navigateToDetailScreen() {
    Navigator.pushNamed(
      context,
      ProductDetailScreen.routeName,
      arguments: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return product == null
        ? const NewLoader()
        : product!.name.isEmpty
            ? const SizedBox()
            : GestureDetector(
                onTap: navigateToDetailScreen,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        "Deal of the Day",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 20.0,
                            offset: Offset(
                              1.0, // horizontal, move right 10
                              5.0, // vertical, move down 10
                            ),
                          ),
                        ],
                      ),
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 5,
                        margin: EdgeInsets.all(10),
                        child: Row(children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.network(
                              product!.images[0],
                              // fit: BoxFit.fitWidth,
                              fit: BoxFit.cover,
                              height: size.height * 0.18,
                              width: size.width * 0.36,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Column(
                              children: [
                                Container(
                                  width: size.width * 0.5,
                                  padding: EdgeInsets.only(left: 10, top: 5),
                                  child: Text(
                                    product!.name,
                                    style: TextStyle(fontSize: 16),
                                    maxLines: 2,
                                  ),
                                ),
                                Container(
                                  // alignment: Alignment.center,
                                  width: size.width * 0.5,
                                  padding: EdgeInsets.only(left: 10, top: 5),
                                  child: Stars(rating: 4),
                                ),
                                Container(
                                    // alignment: Alignment.center,
                                    width: size.width * 0.5,
                                    padding: EdgeInsets.only(
                                        left: 10, top: 8, bottom: 5),
                                    child: Text('Eligible for FREE Shiping')),
                                Container(
                                  width: size.width * 0.5,
                                  // alignment: Alignment.center,
                                  padding: EdgeInsets.only(left: 10, top: 5),
                                  child: Text(
                                    '\₹${product!.price}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                  ),
                                ),
                                Container(
                                  width: size.width * 0.5,
                                  // alignment: Alignment.center,
                                  padding: EdgeInsets.only(
                                      left: 10, top: 5, bottom: 5),
                                  child: Text(
                                    "In Stock",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.teal),
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ),
                    ),
                    CustomBannerAd(),
                    CustomBannerAd()
                  ],
                ),
              );
  }
}
