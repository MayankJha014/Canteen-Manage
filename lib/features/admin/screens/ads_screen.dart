import 'package:flutter/material.dart';
import 'package:zomato_clone/common/widgets/loader.dart';
import 'package:zomato_clone/common/widgets/shimmer.dart';
import 'package:zomato_clone/features/account/widgets/single_product.dart';
import 'package:zomato_clone/features/admin/screens/add_ads_screen.dart';
import 'package:zomato_clone/features/admin/screens/add_product_screen.dart';
import 'package:zomato_clone/features/admin/services/admin_services.dart';
import 'package:zomato_clone/models/advertise.dart';
import 'package:zomato_clone/models/product.dart';

class AdsScreen extends StatefulWidget {
  AdsScreen({Key? key}) : super(key: key);

  @override
  State<AdsScreen> createState() => _AdsScreenState();
}

class _AdsScreenState extends State<AdsScreen> {
  List<Advertise>? advertises;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchAllAds();
  }

  fetchAllAds() async {
    advertises = await adminServices.fetchAllAds(context);
    setState(() {});
  }

  void deleteAds(Advertise advertise, int index) {
    adminServices.deleteAds(
        context: context,
        advertise: advertise,
        onSuccess: () {
          advertises!.removeAt(index);
          setState(() {});
        });
  }

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddAdsScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return advertises == null
        ? const NewLoader()
        : Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: AppBar(
                elevation: 0,
                flexibleSpace: Container(
                  decoration: BoxDecoration(color: Colors.black87),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Image.asset(
                        'assets/logo1.png',
                        width: 140,
                        height: 70,
                      ),
                    ),
                    Text(
                      "Admin",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            body: GridView.builder(
                itemCount: advertises!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  final productData = advertises![index];
                  return Column(
                    children: [
                      SizedBox(
                        height: 140,
                        child: SingleProduct(
                          image: productData.images[0],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Text(
                              productData.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          IconButton(
                              onPressed: () => deleteAds(productData, index),
                              icon: Icon(Icons.delete_outline))
                        ],
                      )
                    ],
                  );
                }),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: navigateToAddProduct,
              tooltip: 'Add a Product',
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
