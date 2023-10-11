import 'package:flutter/material.dart';
import 'package:zomato_clone/common/widgets/stars.dart';
import 'package:zomato_clone/models/product.dart';

class SearchedProduct extends StatelessWidget {
  final Product product;
  const SearchedProduct({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(children: [
            Image.network(
              product.images[0],
              // fit: BoxFit.fitWidth,
              fit: BoxFit.contain,
              height: 135,
              width: 135,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  Container(
                    width: 220,
                    // alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      product.name,
                      style: TextStyle(fontSize: 16),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    // alignment: Alignment.center,
                    width: 220,
                    padding: EdgeInsets.only(left: 10, top: 5),
                    child: Stars(rating: 4),
                  ),
                  Container(
                      // alignment: Alignment.center,
                      width: 220,
                      padding: EdgeInsets.only(left: 10, top: 8, bottom: 5),
                      child: Text('Eligible for FREE Shiping')),
                  Container(
                    width: 220,
                    // alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      '\₹${product.price}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 220,
                    // alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                    child: Text(
                      "In Stock",
                      style: TextStyle(fontSize: 14, color: Colors.teal),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
          ]),
        )
      ],
    );
  }
}
