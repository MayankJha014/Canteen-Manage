import 'package:flutter/material.dart';
import 'package:zomato_clone/common/widgets/bottom_bar.dart';
import 'package:zomato_clone/features/address/screens/address_screen.dart';
import 'package:zomato_clone/features/admin/screens/add_ads_screen.dart';
import 'package:zomato_clone/features/admin/screens/add_product_screen.dart';
import 'package:zomato_clone/features/admin/screens/admin_screen.dart';
import 'package:zomato_clone/features/auth/screens/auth_screen.dart';
import 'package:zomato_clone/features/home/screens/category_deals_screen.dart';
import 'package:zomato_clone/features/home/screens/home_screen.dart';
import 'package:zomato_clone/features/order_details/screens/order_details.dart';
import 'package:zomato_clone/features/product_details/screens/product_details_screen.dart';
import 'package:zomato_clone/features/search/screens/search_screen.dart';
import 'package:zomato_clone/models/order.dart';
import 'package:zomato_clone/models/product.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );

    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => HomeScreen(),
      );

    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );

    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddProductScreen(),
      );
    case AddAdsScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddAdsScreen(),
      );

    case AdminScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AdminScreen(),
      );

    case AddressScreen.routename:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddressScreen(
          totalAmount: totalAmount,
        ),
      );

    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealsScreen(category: category),
      );

    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(searchQuery: searchQuery),
      );

    case ProductDetailScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailScreen(
          product: product,
        ),
      );

    case OrderDetailScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OrderDetailScreen(
          order: order,
        ),
      );

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text(
              "Screen doesn't exist",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.redAccent),
            ),
          ),
        ),
      );
  }
}
