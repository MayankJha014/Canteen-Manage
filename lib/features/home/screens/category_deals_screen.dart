import 'package:flutter/material.dart';
import 'package:zomato_clone/common/widgets/banner_ads.dart';
import 'package:zomato_clone/common/widgets/loader.dart';
import 'package:zomato_clone/common/widgets/shimmer.dart';
import 'package:zomato_clone/common/widgets/stars.dart';
import 'package:zomato_clone/features/home/services/home_services.dart';
import 'package:zomato_clone/features/product_details/screens/product_details_screen.dart';
import 'package:zomato_clone/models/product.dart';

class CategoryDealsScreen extends StatefulWidget {
  final String category;
  static const String routeName = '/category-deals';
  const CategoryDealsScreen({Key? key, required this.category})
      : super(key: key);

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  List<Product>? productList;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    productList = await homeServices.fetchCategoryProducts(
      context: context,
      animal: widget.category,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(color: Color.fromARGB(255, 29, 29, 29)),
          ),
          leading: const BackButton(
            color: Colors.white, // <-- SEE HERE
          ),
          title: Text(
            widget.category,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: productList == null
          ? const NewLoader()
          : SingleChildScrollView(
              child: Column(children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Keep shopping for ${widget.category}",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                CustomBannerAd(),
                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: productList!.length,
                  itemBuilder: (context, index) {
                    NewLoader();
                    final product = productList![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          ProductDetailScreen.routeName,
                          arguments: product,
                        );
                      },
                      child: Column(
                        children: [
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
                                    product.images[0],
                                    // fit: BoxFit.fitWidth,
                                    fit: BoxFit.cover,
                                    height: size.height * 0.18,
                                    width: size.width * 0.36,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: size.width * 0.5,
                                        padding:
                                            EdgeInsets.only(left: 10, top: 5),
                                        child: Text(
                                          product.name,
                                          style: TextStyle(fontSize: 16),
                                          maxLines: 2,
                                        ),
                                      ),
                                      Container(
                                        // alignment: Alignment.center,
                                        width: size.width * 0.5,
                                        padding:
                                            EdgeInsets.only(left: 10, top: 5),
                                        child: Stars(rating: 4),
                                      ),
                                      Container(
                                          // alignment: Alignment.center,
                                          width: size.width * 0.5,
                                          padding: EdgeInsets.only(
                                              left: 10, top: 8, bottom: 5),
                                          child: Text(
                                              'Eligible for FREE Shiping')),
                                      Container(
                                        width: size.width * 0.5,
                                        // alignment: Alignment.center,
                                        padding:
                                            EdgeInsets.only(left: 10, top: 5),
                                        child: Text(
                                          '\₹${product.price}',
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
                        ],
                      ),
                    );
                  },
                ),
              ]),
            ),
    );
  }
}
