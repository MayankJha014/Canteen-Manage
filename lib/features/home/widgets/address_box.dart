import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zomato_clone/providers/user_provider.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      height: 38,
      decoration: BoxDecoration(color: Color.fromARGB(255, 24, 24, 24)),
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Icon(Icons.location_on_outlined, size: 20),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                'Deliver to ${user.name} - ${user.address}',
                style:
                    TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 2, top: 2),
            child: Icon(
              Icons.arrow_drop_down_outlined,
              size: 18,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
