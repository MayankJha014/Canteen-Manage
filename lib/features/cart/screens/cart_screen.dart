import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zomato_clone/common/widgets/banner_ads.dart';
import 'package:zomato_clone/common/widgets/custom_button.dart';
import 'package:zomato_clone/constants/global_variables.dart';
import 'package:zomato_clone/features/address/screens/address_screen.dart';
import 'package:zomato_clone/features/cart/widgets/cart_product.dart';
import 'package:zomato_clone/features/cart/widgets/cart_subtotal.dart';
import 'package:zomato_clone/features/home/widgets/address_box.dart';
import 'package:zomato_clone/features/search/screens/search_screen.dart';
import 'package:zomato_clone/providers/user_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    void navigateToSearchScreen(String query) {
      Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
    }

    void navigateToAddress(int sum) {
      Navigator.pushNamed(
        context,
        AddressScreen.routename,
        arguments: sum.toString(),
      );
    }

    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(color: Colors.black87),
          ),
          title: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    'assets/logo1.png',
                    width: 100,
                    height: 70,
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
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          const AddressBox(),
          const CartSubtotal(),
          // CustomBannerAd(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButtom(
              text: "Proceed to Buy (${user.cart.length} items)",
              onTap: () => navigateToAddress(sum),
              color: Color.fromARGB(255, 37, 37, 37),
            ),
          ),
          CustomBannerAd(),
          const SizedBox(
            height: 15,
          ),
          Container(
            color: Colors.black12.withOpacity(0.1),
            height: 2,
          ),
          const SizedBox(
            height: 5,
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return CartProduct(
                index: index,
              );
            },
            itemCount: user.cart.length,
            shrinkWrap: true,
          ),
          CustomBannerAd()
        ],
      )),
    );
  }
}
