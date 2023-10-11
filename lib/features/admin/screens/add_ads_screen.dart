import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:zomato_clone/common/widgets/custom_button.dart';
import 'package:zomato_clone/common/widgets/custom_textfield.dart';
import 'package:zomato_clone/constants/utils.dart';
import 'package:zomato_clone/features/admin/services/admin_services.dart';

class AddAdsScreen extends StatefulWidget {
  static const String routeName = '/add-ads';
  const AddAdsScreen({Key? key}) : super(key: key);

  @override
  State<AddAdsScreen> createState() => _AddAdsScreenState();
}

class _AddAdsScreenState extends State<AddAdsScreen> {
  final TextEditingController adsNameController = TextEditingController();
  final TextEditingController adsdescriptionController =
      TextEditingController();
  final TextEditingController adspriceController = TextEditingController();
  final AdminServices adminServices = AdminServices();

  String category = 'Maggi';
  List<File> images = [];
  final _addAdvertiseFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    adsNameController.dispose();
    adsdescriptionController.dispose();
    adspriceController.dispose();
  }

  void adsProduct() {
    if (_addAdvertiseFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.adsProduct(
          context: context,
          name: adsNameController.text,
          description: adsdescriptionController.text,
          price: double.parse(adspriceController.text),
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
          centerTitle: true,
          title: Text(
            "Add Product",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _addAdvertiseFormKey,
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
                                "Select Ads Images",
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
                controller: adsNameController,
                hintText: 'Ads Name',
              ),
              SizedBox(height: 10),
              CustomTextField(
                controller: adsdescriptionController,
                hintText: 'Description',
                maxLines: 8,
              ),
              SizedBox(height: 10),
              CustomTextField(
                controller: adspriceController,
                hintText: 'Price',
              ),
              SizedBox(height: 10),
              SizedBox(height: 10),
              SizedBox(
                height: 10,
              ),
              CustomButtom(
                text: 'Sell',
                onTap: adsProduct,
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
