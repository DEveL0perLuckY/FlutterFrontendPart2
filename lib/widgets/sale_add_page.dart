import 'package:flutter/material.dart';
import 'package:my_flutter_htttp/models/Sale.dart';
import 'package:my_flutter_htttp/services/sale_service.dart';

class SaleAddPage extends StatefulWidget {
  final Function refreshList;

  const SaleAddPage({super.key, required this.refreshList});

  @override
  State<SaleAddPage> createState() => _SaleAddPageState();
}

class _SaleAddPageState extends State<SaleAddPage> {
  TextEditingController customerController = TextEditingController();
  TextEditingController productController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController billContentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: customerController,
              decoration: const InputDecoration(labelText: 'Customer'),
            ),
            TextField(
              controller: productController,
              decoration: const InputDecoration(labelText: 'Product'),
            ),
            TextField(
              controller: quantityController,
              decoration: const InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: billContentController,
              decoration: const InputDecoration(labelText: 'Bill Content'),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                if (customerController.text.isEmpty ||
                    productController.text.isEmpty ||
                    quantityController.text.isEmpty ||
                    billContentController.text.isEmpty) {
                  // If any of the fields is empty, show an error dialog
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('All fields are required'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  try {
                    DateTime currentDate = DateTime.now();
                    final sale = Sale(
                      id: 0,
                      customer: customerController.text,
                      product: productController.text,
                      quantity: int.tryParse(quantityController.text) ?? 0,
                      billContent: billContentController.text,
                      saleDate: currentDate,
                    );
                    // Clear the input fields
                    customerController.clear();
                    productController.clear();
                    quantityController.clear();
                    billContentController.clear();
                    await SaleService().createSale(sale);
                    // Await the HTTP request
                    widget.refreshList();
                    Navigator.pop(context);
                  } catch (e) {
                    // Handle the error, e.g., show a message to the user
                  }
                }
              },
              child: const Text('Add Data'),
            )
          ],
        ),
      ),
    );
  }
}
