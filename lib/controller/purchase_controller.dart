import 'package:canteen_user/controller/login_controller.dart';
import 'package:canteen_user/model/user/user.dart';
import 'package:canteen_user/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PurchaseController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference orderCollection;

  TextEditingController addressController = TextEditingController();

  double orderPrice = 0;
  String itemName = '';
  String orderAddress = '';

  @override
  void onInit() {
    // Initialize orderCollection in onInit method
    orderCollection = firestore.collection('orders');
    super.onInit();
  }

  submitOrder(
      {required double price,
      required String item,
      required String description}) {
    orderPrice = price;
    itemName = item;
    orderAddress = addressController.text;
    Razorpay razorpay = Razorpay();
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': (price * 100).toInt(),
      'name': itemName,
      'description': description,
    };

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.open(options);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    orderSuccess(transactionId: response.paymentId);
    Get.snackbar('Success', 'Payment is successful',
        colorText: Colors.green, backgroundColor: Colors.white);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Get.snackbar('Error', '$response.message',
        colorText: Colors.red, backgroundColor: Colors.white);
  }

  Future<void> orderSuccess({required String? transactionId}) async {
    User? loginUse = Get.find<LoginController>().loginUser;
    try {
      if (transactionId != null) {
        DocumentReference docRef = await orderCollection.add({
          'customer': loginUse?.name ?? '',
          'phone': loginUse?.number ?? "",
          'item': itemName,
          'price': orderPrice,
          'address': orderAddress,
          'transactionId': transactionId,
          'datetime': DateTime.now().toString(),
        });
        print('Order Created Successful:${docRef.id}');
        showOrderSuccessDialog(docRef.id);
        Get.snackbar('Success', 'Order Created Successful',
            colorText: Colors.green, backgroundColor: Colors.white);
      } else {
        Get.snackbar('Error', 'Please all the fields',
            colorText: Colors.red, backgroundColor: Colors.white);
      }
    } catch (e) {
      print("Failed to register user:$e");

      Get.snackbar('Error', 'Failed to create user',
          colorText: Colors.red, backgroundColor: Colors.white);
    }
  }

  void showOrderSuccessDialog(String orderId) {
    Get.defaultDialog(
        title: 'Order Success',
        content: Text("Your OrderId is $orderId"),
        confirm: ElevatedButton(
          onPressed: () {
            Get.off(const HomePage());
          },
          child: const Text('Close'),
        ));
  }
}
