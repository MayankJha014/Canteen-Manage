import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:zomato_clone/constants/global_variables.dart';
import 'package:zomato_clone/features/account/screens/account_screen.dart';
import 'package:zomato_clone/features/admin/screens/ads_screen.dart';
import 'package:zomato_clone/features/admin/screens/analytics_scree.dart';
import 'package:zomato_clone/features/admin/screens/orders_screen.dart';
import 'package:zomato_clone/features/admin/screens/post_screen.dart';
import 'package:zomato_clone/features/home/screens/home_screen.dart';

class AdminScreen extends StatefulWidget {
  static const String routeName = '/admin-screen';

  AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> pages = [
    PostsScreen(),
    const AnalyticsScreen(),
    AdsScreen(),
    const OrdersScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: GNav(
        padding: EdgeInsets.all(15),
        gap: 10,
        selectedIndex: _page,
        // selectedItemColor: Colors.deepOrange,
        // unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: Colors.black,
        color: Colors.white,
        tabBackgroundColor: Color.fromARGB(255, 109, 109, 109),
        activeColor: Colors.white,
        iconSize: 28,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        onTabChange: updatePage,
        tabs: const [
          //HOME
          GButton(
            icon: Icons.home_outlined,
            text: "Home",
          ),
          GButton(
            icon: Icons.analytics_outlined,
            text: "Analytics",
          ),
          GButton(
            icon: Icons.newspaper_outlined,
            text: "Ads",
          ),
          //Account
          //Cart
          GButton(
            icon: Icons.shopping_cart_outlined,
            text: "Orders",
          ),
        ],
      ),
    );
  }
}
