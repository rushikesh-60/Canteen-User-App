import 'dart:async';

import 'package:canteen_user/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Get.to(LoginController());
    });
  }

  @override
  Widget build(context) {
    return GetBuilder<LoginController>(
      builder: (ctrl) {
        return Scaffold(
          body: Center(
            child: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(width: 5, color: Colors.black),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 134, 168, 211),
                    Color.fromARGB(255, 0, 77, 186),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/pict_logo.jpeg",
                      width: 225,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text("Welcome to BooknBite",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500,
                        )),
                    const SizedBox(
                      height: 40,
                    ),
                    const Divider(
                      color: Colors.black,
                      indent: 40,
                      endIndent: 40,
                      thickness: 3,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
