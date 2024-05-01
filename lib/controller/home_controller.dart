import 'package:canteen_user/model/product/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference productCollection;

  List<Product> products = [];

  @override
  Future<void> onInit() async {
    productCollection = firestore.collection("Items");
    await fetchProducts();
    super.onInit();
  }

  fetchProducts() async {
    try {
      QuerySnapshot productSnapshot = await productCollection.get();
      final List<Product> retrievedProducts = productSnapshot.docs
          .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      products.clear();
      products.assignAll(retrievedProducts);
      Get.snackbar('Success', 'Products fetched Successfully',
          colorText: Colors.green, backgroundColor: Colors.white);
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          colorText: Colors.red, backgroundColor: Colors.white);
      print(e);
    } finally {
      update();
    }
  }
}
