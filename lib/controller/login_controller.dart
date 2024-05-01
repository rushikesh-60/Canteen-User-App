import 'package:canteen_user/model/user/user.dart';
import 'package:canteen_user/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  GetStorage box = GetStorage();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference userCollection;

  TextEditingController registerNameCtrl = TextEditingController();
  TextEditingController registerNumberCtrl = TextEditingController();
  TextEditingController loginNumberController = TextEditingController();

  User? loginUser;

  @override
  void onReady() {
    Map<String, dynamic>? user = box.read('loginUser');
    if (user != null) {
      loginUser = User.fromJson(user);
      Get.to(const HomePage());
    }

    super.onReady();
  }

  @override
  void onInit() {
    userCollection = firestore.collection('users');
    super.onInit();
  }

  addUser() {
    try {
      if (registerNameCtrl.text.isEmpty || registerNumberCtrl.text.isEmpty) {
        Get.snackbar('Error', "Please field the details",
            colorText: Colors.red, backgroundColor: Colors.white);
        return;
      }
      DocumentReference doc = userCollection.doc();
      User user = User(
        id: doc.id,
        name: registerNameCtrl.text,
        number: int.parse(registerNumberCtrl.text),
      );
      final userJson = user.toJson();
      doc.set(userJson);
      Get.snackbar('Success', "User added successfully",
          colorText: const Color.fromARGB(255, 6, 203, 52),
          backgroundColor: Colors.white);
      registerNameCtrl.clear();
      registerNumberCtrl.clear();
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          colorText: Colors.red, backgroundColor: Colors.white);
      print(e);
    }
  }

  loginWithPhone() async {
    try {
      String phoneNumber = loginNumberController.text;
      if (phoneNumber.isNotEmpty) {
        var querySnapshot = await userCollection
            .where('number', isEqualTo: int.tryParse(phoneNumber))
            .limit(1)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          var userDoc = querySnapshot.docs.first;
          var userData = userDoc.data() as Map<String, dynamic>;

          box.write('loginUser', userData);
          loginNumberController.clear();
          Get.to(const HomePage());

          Get.snackbar('Success', 'Login Successful',
              colorText: Colors.green, backgroundColor: Colors.white);
        } else {
          Get.snackbar('Error', 'User not found, please register',
              colorText: Colors.red, backgroundColor: Colors.white);
        }
      } else {
        Get.snackbar('Error', 'Please enter your phone number',
            colorText: Colors.red, backgroundColor: Colors.white);
      }
    } catch (e) {
      print(e); // TODO
    }
  }
}
