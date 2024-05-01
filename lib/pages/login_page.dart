import 'package:canteen_user/controller/login_controller.dart';
import 'package:canteen_user/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (ctrl) {
        return Scaffold(
          body: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(20),
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 228, 228, 228)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome Back !',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: ctrl.loginNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      prefixIcon: const Icon(Icons.phone_android),
                      labelText: 'Mobile Number',
                      hintText: 'Enter your mobile number'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    ctrl.loginWithPhone();
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage()));
                    },
                    child: const Text(
                      'Register new account',
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
