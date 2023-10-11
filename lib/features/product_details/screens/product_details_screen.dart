import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:provider/provider.dart';
import 'package:zomato_clone/common/widgets/banner_ads.dart';
import 'package:zomato_clone/common/widgets/custom_button.dart';
import 'package:zomato_clone/common/widgets/stars.dart';
import 'package:zomato_clone/constants/global_variables.dart';
import 'package:zomato_clone/features/product_details/services/product_details_services.dart';
import 'package:zomato_clone/features/search/screens/search_screen.dart';
import 'package:zomato_clone/models/order.dart';
import 'package:zomato_clone/models/product.dart';
import 'package:zomato_clone/providers/user_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  static const String routeName = '/product-details';
  final Product product;
  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  final ProductDetailServices productDetailServices = ProductDetailServices();
  double avgRating = 0;
  double myRating = 0;

  @override
  void initState() {
    super.initState();
    double totalRating = 0;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.rating![i].rating;
      }
    }

    if (totalRating != 0) {
      avgRating = totalRating / widget.product.rating!.length;
    }
  }

  void addToCart() {
    productDetailServices.addToCart(
      context: context,
      product: widget.product,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          leading: const BackButton(
            color: Colors.white, // <-- SEE HERE
          ),
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(color: Colors.black87),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/logo1.png',
                  width: size.width * 0.25,
                  height: size.height * 0.15,
                ),
              ),
              Expanded(
                child: Container(
                  height: 42,
                  margin: EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(15),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.only(top: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                            borderSide: BorderSide.none),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'Search Your Meal',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  height: size.height * 0.25,
                  child: Swiper(
                    autoplay: true,
                    autoplayDelay: 1500,
                    curve: Curves.easeIn,
                    itemCount: widget.product.images.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image(
                            image: NetworkImage(widget.product.images[0]),
                            fit: BoxFit.fitWidth,
                          ));
                    },
                    viewportFraction: 0.8,
                    scale: 0.9,
                    pagination: SwiperPagination(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Container(
            color: Colors.black12,
            height: 3,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            child: Text(
              widget.product.name,
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
            child: RichText(
              text: TextSpan(
                  text: 'Deal Price: ',
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: '\₹${widget.product.price}',
                      style: const TextStyle(
                          fontSize: 22,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              widget.product.description,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            color: Colors.black12,
            height: 3,
          ),
          SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CustomButtom(
              text: 'Add to Cart',
              onTap: addToCart,
              color: Colors.black87,
            ),
          ),
          CustomBannerAd(),
          SizedBox(height: 5),
          Container(
            color: Colors.black12,
            height: 3,
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              "Rate the Product",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          RatingBar.builder(
            initialRating: myRating,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 5),
            itemBuilder: (context, _) =>
                const Icon(Icons.star, color: GlobalVariables.secondaryColor),
            onRatingUpdate: (rating) {
              productDetailServices.rateProduct(
                context: context,
                product: widget.product,
                rating: rating,
              );
            },
          ),
          SizedBox(height: 20),
          CustomBannerAd(),
        ],
      )),
    );
  }
}
