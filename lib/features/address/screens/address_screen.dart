// ignore_for_file: must_call_super

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:zomato_clone/common/widgets/custom_textfield.dart';
import 'package:zomato_clone/constants/utils.dart';
import 'package:zomato_clone/features/address/services/address_services.dart';
import 'package:zomato_clone/providers/user_provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routename = '/address';
  final String totalAmount;

  const AddressScreen({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();
  String category = 'HiddenCafe';

  List<String> productCategories = [
    'Nescafe',
    'HiddenCafe',
  ];

  String addressToBeUsed = "";
  List<PaymentSuccessResponse> paymentItems = [];
  final AddressServices addressServices = AddressServices();

  void payPressed(String addressFromProvider) {
    addressToBeUsed = "";

    bool isForm = flatBuildingController.text.isNotEmpty ||
        mobileController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${category},- ${flatBuildingController.text}, ${mobileController.text}';
        openCheckout();
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
      openCheckout();
    } else {
      showSnackBar(context, 'Please Fill the Address');
    }
    print(addressToBeUsed);
  }

  late Razorpay razorpay;

  @override
  void initState() {
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    mobileController.dispose();
    razorpay.clear();
  }

  void openCheckout() async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    var options = {
      // 'key': 'rzp_live_w7ohA8kqA6ayFE',
      'key': 'rzp_test_f7CrHBY7zSvL3B',
      'amount': int.parse(widget.totalAmount) * 100,
      'name': user.name,
      'description': 'Raj Maggi Station',
      'send_sms_hash': true,
      'prefill': {'contact': '${mobileController.text}', 'email': user.email},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print('Success Response: $response');

    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalSum: double.parse(widget.totalAmount),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: $response');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: $response');
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          leading: const BackButton(
            color: Colors.white, // <-- SEE HERE
          ),
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(color: Color.fromARGB(255, 24, 24, 24)),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: flatBuildingController,
                      hintText: 'Flat, House no, Building',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: mobileController,
                      hintText: 'Mobile Number',
                      keyboard: TextInputType.number,
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Row(
                        children: [
                          Text(
                            "Choose your Canteen: ",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: 150,
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  payPressed(address);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  onSurface: Colors.amber,
                  primary: Colors.redAccent,
                ),
                label: Text(
                  "Proced for Payment",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                icon: Icon(
                  Icons.currency_rupee,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
