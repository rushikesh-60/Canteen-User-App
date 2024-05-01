import 'package:canteen_user/controller/purchase_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDescriptionPage extends StatelessWidget {
  final String image;
  final String name;
  final String description;
  final String price;
  const ProductDescriptionPage(
      {super.key,
      required this.image,
      required this.name,
      required this.description,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PurchaseController>(
      builder: (ctrl) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Item Details',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    image ?? "",
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: 200,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  name ?? '',
                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  description ?? '',
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
                const SizedBox(height: 20),
                Text(
                  'Rs ${price ?? 0}',
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: ctrl.addressController,
                  maxLines: 3,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      label: const Text('Enter your Name')),
                ),
                const SizedBox(height: 20),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white),
                        onPressed: () {
                          ctrl.submitOrder(
                              price: double.parse(price),
                              item: name,
                              description: description);
                        },
                        child: const Text(
                          'Buy Now',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              height: 1.5,
                              fontSize: 15),
                        )))
              ],
            ),
          ),
        );
      },
    );
  }
}
