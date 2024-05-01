import 'package:canteen_user/config/colors.dart';
import 'package:canteen_user/controller/login_controller.dart';
import 'package:canteen_user/pages/drawer_side.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/user/user.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  Widget listTile({required IconData icon, required String title}) {
    return Column(
      children: [
        const Divider(
          height: 1,
        ),
        ListTile(
          leading: Icon(icon),
          title: Text(title),
          trailing: const Icon(Icons.arrow_forward_ios),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    User? loginUse = Get.find<LoginController>().loginUser;
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
          elevation: 0.0,
          title: Text(
            "My Profile",
            style: TextStyle(fontSize: 18, color: textColor),
          )),
      drawer: const Drawer(
        child: DrawerSide(),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 100,
                color: primaryColor,
              ),
              Container(
                height: 548,
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 250,
                          height: 80,
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Name: ' + (loginUse?.name ?? ''),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: textColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text('No.: ' +
                                      (loginUse?.number ?? 00).toString()),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    listTile(icon: Icons.shop_outlined, title: "My Orders"),
                    listTile(
                        icon: Icons.location_on_outlined,
                        title: "My Delivery Address"),
                    listTile(
                        icon: Icons.person_outlined, title: "Refer A Friends"),
                    listTile(
                        icon: Icons.file_copy_outlined,
                        title: "Terms and Conditions"),
                    listTile(
                        icon: Icons.policy_outlined, title: "Privacy Policy"),
                    listTile(icon: Icons.add_chart, title: "About"),
                    listTile(
                        icon: Icons.exit_to_app_outlined, title: "Log Out"),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 30),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: primaryColor,
              child: const CircleAvatar(
                foregroundImage: NetworkImage(
                    'https://cdn2.vectorstock.com/i/1000x1000/37/71/yellow-yummy-smiley-emoticon-hungry-face-emoji-vector-23593771.jpg'),
                backgroundColor: Colors.blue,
                radius: 45,
              ),
            ),
          )
        ],
      ),
    );
  }
}
