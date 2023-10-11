import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:zomato_clone/common/widgets/custom_button.dart';
import 'package:zomato_clone/common/widgets/custom_textfield.dart';
import 'package:zomato_clone/common/widgets/loader.dart';
import 'package:zomato_clone/constants/utils.dart';
import 'package:zomato_clone/features/admin/services/admin_services.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final AdminServices adminServices = AdminServices();

  String category = 'Maggi';
  List<File> images = [];
  final _addProductFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  List<String> productCategories = [
    'Maggi',
    'Pasta',
    'Sandwich',
    'Beverages',
    'Meal'
  ];

  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProduct(
          context: context,
          name: productNameController.text,
          description: descriptionController.text,
          price: double.parse(priceController.text),
          quantity: double.parse(quantityController.text),
          category: category,
          images: images);
    }
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(color: Color.fromARGB(255, 26, 26, 26)),
          ),
          leading: BackButton(
            color: Colors.white, // <-- SEE HERE
          ),
          centerTitle: true,
          title: Text(
            "Add Product",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _addProductFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(height: 20),
              images.isNotEmpty
                  ? CarouselSlider(
                      items: images.map(
                        (i) {
                          return Builder(
                            builder: (BuildContext context) => Image.file(
                              i,
                              fit: BoxFit.cover,
                              height: 200,
                            ),
                          );
                        },
                      ).toList(),
                      options:
                          CarouselOptions(viewportFraction: 1, height: 190),
                    )
                  : GestureDetector(
                      onTap: selectImages,
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: Radius.circular(10),
                        dashPattern: const [10, 4],
                        strokeCap: StrokeCap.round,
                        child: Container(
                          width: double.infinity,
                          height: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.folder_open,
                                size: 40,
                              ),
                              const SizedBox(height: 15),
                              Text(
                                "Select Product Images",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey.shade600),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: 30),
              CustomTextField(
                controller: productNameController,
                hintText: 'Product Name',
              ),
              SizedBox(height: 10),
              CustomTextField(
                controller: descriptionController,
                hintText: 'Description',
                maxLines: 8,
              ),
              SizedBox(height: 10),
              CustomTextField(
                controller: priceController,
                hintText: 'Price',
              ),
              SizedBox(height: 10),
              CustomTextField(
                controller: quantityController,
                hintText: 'Quantity',
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: DropdownButton(
                  value: category,
                  icon: Icon(Icons.keyboard_arrow_down),
                  items: productCategories.map((String item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String? newVal) {
                    setState(() {
                      category = newVal!;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomButtom(
                text: 'Sell',
                onTap: sellProduct,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
