import 'package:canteen_user/controller/home_controller.dart';
import 'package:canteen_user/pages/drawer_side.dart';
import 'package:canteen_user/pages/login_page.dart';
import 'package:canteen_user/pages/product_description_page.dart';
import 'package:canteen_user/widgets/drop_down_btn.dart';
import 'package:canteen_user/widgets/multi_select_drop_down.dart';
import 'package:canteen_user/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (ctrl) {
        return Scaffold(
          drawer: const Drawer(
            child: DrawerSide(),
          ),
          appBar: AppBar(
            title: const Text(
              "BooknBite",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            backgroundColor: Colors.blue,
            actions: [
              IconButton(
                  onPressed: () {
                    GetStorage box = GetStorage();
                    box.erase();
                    Get.offAll(const LoginPage());
                  },
                  icon: const Icon(Icons.logout_outlined,
                      size: 30, weight: 50, color: Colors.white))
            ],
          ),
          body: Column(
            children: [
              SizedBox(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: ((context, index) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 12, left: 6, right: 5),
                        child: Chip(label: Text("Category")),
                      );
                    })),
              ),
              Row(
                children: [
                  Flexible(
                    child: DropDownBtn(
                        items: const ['Low to High', 'High to Low'],
                        selectedItemText: 'Sort',
                        onSelected: (selected) {}),
                  ),
                  Flexible(
                      child: MultiSelectDropDown(
                    items: const ['sweet', 'chilly', 'hot', 'cold', 'spicy'],
                    onSelectionChanged: (selectedItems) {},
                  )),
                ],
              ),
              Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8),
                    itemCount: ctrl.products.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        name: ctrl.products[index].name ?? 'no name',
                        imageUrl: ctrl.products[index].image ?? 'no url',
                        price: ctrl.products[index].price ?? 00,
                        onTap: () {
                          Get.to(
                            ProductDescriptionPage(
                              image: ctrl.products[index].image ?? '',
                              name: ctrl.products[index].name ?? '',
                              description:
                                  ctrl.products[index].description ?? '',
                              price:
                                  (ctrl.products[index].price ?? 0).toString(),
                            ),
                          );
                        },
                      );
                    }),
              )
            ],
          ),
        );
      },
    );
  }
}
