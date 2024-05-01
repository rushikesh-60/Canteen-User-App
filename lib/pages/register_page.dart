import 'package:canteen_user/controller/login_controller.dart';
import 'package:canteen_user/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (ctrl) {
      return Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(color: Color.fromARGB(255, 228, 228, 228)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Create Your Account',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              const SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.name,
                controller: ctrl.registerNameCtrl,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    prefixIcon: const Icon(Icons.person),
                    labelText: 'Your Name',
                    hintText: 'Enter your name'),
              ),
              const SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.phone,
                controller: ctrl.registerNumberCtrl,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.blue)),
                    prefixIcon: const Icon(Icons.phone_android),
                    labelText: 'Mobile Number',
                    hintText: 'Enter your mobile number'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  ctrl.addUser();
                },
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue),
                child: const Text(
                  'Register',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const LoginPage()));
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.blue),
                  ))
            ],
          ),
        ),
      );
    });
  }
}
