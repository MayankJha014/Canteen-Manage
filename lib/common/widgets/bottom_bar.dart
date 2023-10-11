import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:zomato_clone/features/account/screens/account_screen.dart';
import 'package:zomato_clone/features/cart/screens/cart_screen.dart';
import 'package:zomato_clone/features/home/screens/home_screen.dart';
import 'package:zomato_clone/providers/user_provider.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  // double bottomBarWidth = 42;
  // double bottomBarBorderWidth = 5;

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> pages = [
    HomeScreen(),
    AccountScreen(),
    const CartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final userCartLen = context.watch<UserProvider>().user.cart.length;
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
        tabs: [
          //HOME
          GButton(
            icon: Icons.home_outlined,
            text: "Home",
          ),
          //Account
          GButton(
            icon: Icons.person_outlined,
            text: "Profile",
          ),
          //Cart
          GButton(
            icon: Icons.shopping_cart_outlined,
            text: "Cart",
            // semanticLabel: '${userCartLen.toString()}',
          ),
        ],
      ),
    );
  }
}
