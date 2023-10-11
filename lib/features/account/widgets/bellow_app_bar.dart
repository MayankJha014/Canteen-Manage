import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zomato_clone/constants/global_variables.dart';
import 'package:zomato_clone/providers/user_provider.dart';

class BelowAppBar extends StatelessWidget {
  const BelowAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 43, 43, 43),
      ),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
                text: 'Hello ,  ',
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
                children: [
                  TextSpan(
                    text: user.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
