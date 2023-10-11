import 'package:flutter/material.dart';

String uri = 'https://zomato-clone-sand-zeta.vercel.app';
// String uri = 'http://192.168.1.9:3000';

class GlobalVariables {
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 63, 64, 65),
      Color.fromARGB(255, 63, 64, 65),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromARGB(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Maggi',
      'image': 'assets/noodles.png',
    },
    {
      'title': 'Pasta',
      'image': 'assets/hot-soup.png',
    },
    {
      'title': 'Sandwich',
      'image': 'assets/sandwich.png',
    },
    {
      'title': 'Beverages',
      'image': 'assets/coffee-cup.png',
    },
    {
      'title': 'Meal',
      'image': 'assets/lunch.png',
    },
  ];
}
