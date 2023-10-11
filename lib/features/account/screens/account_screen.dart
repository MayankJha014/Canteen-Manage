import 'package:flutter/material.dart';
import 'package:zomato_clone/common/widgets/banner_ads.dart';
import 'package:zomato_clone/constants/global_variables.dart';
import 'package:zomato_clone/features/account/widgets/bellow_app_bar.dart';
import 'package:zomato_clone/features/account/widgets/orders.dart';
import 'package:zomato_clone/features/account/widgets/top_buttons.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(color: Color.fromARGB(255, 39, 39, 39)),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/logo1.png',
                  width: size.width * 0.3,
                  height: size.height * 0.15,
                ),
              ),
              Container(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Icon(
                          Icons.notifications_outlined,
                          color: Colors.white,
                        ),
                      ),
                      Icon(Icons.search_outlined, color: Colors.white)
                    ],
                  ))
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          BelowAppBar(),
          SizedBox(
            height: 10,
          ),
          TopButtons(),
          CustomBannerAd(),
          SizedBox(height: 20),
          Orders(),
          SizedBox(height: 20),
          CustomBannerAd(),
          CustomBannerAd()
        ],
      ),
    );
  }
}
