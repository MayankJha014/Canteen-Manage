import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentController extends GetxController {
  late Razorpay razorpay;

  @override
  void onInit() {
    super.onInit();
    razorpay = Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Get.snackbar(
        'Payment Succesfull!',
        // ignore: prefer_interpolation_to_compose_strings
        response.orderId! +
            " \n" +
            response.paymentId! +
            "\n" +
            response.signature!);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Get.snackbar('Payment Error Occured', response.message!);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Get.snackbar('External Wallet Succesfull!', response.walletName!);
  }

  void dispatchPayment(int amount, String name, String contact,
      String description, String email, String wallet) {
    var options = {
      'key': 'your_api_key',
      'amount': amount, //in the smallest currency sub-unit.
      'name': name,
      'description': description,
      // 'timeout': 60, // in seconds
      'prefill': {'contact': contact, 'email': email},
      'external': {
        'wallets': [wallet]
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {}
  }
}
