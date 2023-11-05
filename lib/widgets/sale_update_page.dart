import 'package:flutter/material.dart';
import 'package:my_flutter_htttp/models/Sale.dart';
import 'package:my_flutter_htttp/services/sale_service.dart';

class UpdateSalePage extends StatefulWidget {
  final Sale sale;
  final Function refresh;

  const UpdateSalePage({super.key, required this.sale, required this.refresh});

  @override
  _UpdateSalePageState createState() => _UpdateSalePageState();
}

class _UpdateSalePageState extends State<UpdateSalePage> {
  TextEditingController customerController = TextEditingController();
  TextEditingController productController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController billContentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Initialize the controllers with the sale data
    customerController = TextEditingController(text: widget.sale.customer);
    productController = TextEditingController(text: widget.sale.product);
    quantityController =
        TextEditingController(text: widget.sale.quantity.toString());
    billContentController =
        TextEditingController(text: widget.sale.billContent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Sale'),
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
            ),
            TextField(
              controller: billContentController,
              decoration: const InputDecoration(labelText: 'Bill Content'),
            ),
            const SizedBox(
              height: 20,
            ),
            // In your Update Sale page when you click the "Update" button:
            ElevatedButton(
              onPressed: () async {
                final updatedSale = Sale(
                  id: widget.sale.id, // Preserve the sale ID
                  customer: customerController.text,
                  product: productController.text,
                  quantity: int.tryParse(quantityController.text) ?? 0,
                  billContent: billContentController.text,
                  saleDate: widget.sale.saleDate, // Preserve the sale date
                );
                // Send the updated sale data to the server
                // You can use a SaleService method to update the sale on the server
                await SaleService().updateSale(updatedSale, updatedSale.id);
                await widget.refresh();
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
