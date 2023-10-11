import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zomato_clone/features/cart/services/cart_services.dart';
import 'package:zomato_clone/features/product_details/services/product_details_services.dart';
import 'package:zomato_clone/models/product.dart';
import 'package:zomato_clone/providers/user_provider.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final ProductDetailServices productDetailServices = ProductDetailServices();
  final CartServices cartServices = CartServices();

  void increaseQuantity(Product product) {
    cartServices.addToCart(
      context: context,
      product: product,
    );
  }

  void decreaseQuantity(Product product) {
    cartServices.removeFromCart(
      context: context,
      product: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    final productCart = context.watch<UserProvider>().user.cart[widget.index];
    final product = Product.fromMap(productCart['product']);
    final quantity = productCart['quantity'];
    final size = MediaQuery.of(context).size;

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
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Column(
                children: [
                  Container(
                    width: size.width * 0.5,
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
                      width: size.width * 0.5,
                      padding: EdgeInsets.only(left: 10, top: 8, bottom: 5),
                      child: Text('Eligible for FREE Shiping')),
                  Container(
                    width: size.width * 0.5,
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
                    width: size.width * 0.5,
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
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black12,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => decreaseQuantity(product),
                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.remove,
                          size: 18,
                        ),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12, width: 1.3),
                        color: Colors.white,
                      ),
                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: Text(
                          quantity.toString(),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => increaseQuantity(product),
                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.add,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
