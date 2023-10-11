import 'package:flutter/material.dart';
import 'package:zomato_clone/common/widgets/banner_ads.dart';
import 'package:zomato_clone/features/account/services/account_services.dart';
import 'package:zomato_clone/features/account/widgets/account_button.dart';
import 'package:zomato_clone/features/cart/screens/cart_screen.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
                text: "Your Orders",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                }),
            AccountButton(
              text: "Log Out",
              onTap: () => AccountServices().logOut(context),
            ),
          ],
        ),
        // SizedBox(height: 10),
      ],
    );
  }
}
