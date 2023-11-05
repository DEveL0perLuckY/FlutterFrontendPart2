import 'package:flutter/material.dart';
import 'package:my_flutter_htttp/models/Sale.dart';
import 'package:my_flutter_htttp/services/sale_service.dart';
import 'package:my_flutter_htttp/widgets/sale_update_page.dart';

class SaleDetails extends StatefulWidget {
  final Sale obj;
  final Function refreshList;
  const SaleDetails(this.obj, this.refreshList, {super.key});

  @override
  State<SaleDetails> createState() => _SaleDetailsState();
}

class _SaleDetailsState extends State<SaleDetails> {
  @override
  Widget build(BuildContext context) {
    Sale sale = widget.obj;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sale Details'),
      ),
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Sale Details For Sale ${sale.id}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(thickness: 2, color: Colors.blue), // Horizontal line
          ListTile(
            title:
                const Text('ID', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(sale.id.toString()),
          ),
          ListTile(
            title: const Text('Customer',
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(sale.customer),
          ),
          ListTile(
            title: const Text('Product',
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(sale.product),
          ),
          ListTile(
            title: const Text('Quantity',
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(sale.quantity.toString()),
          ),
          ListTile(
            title: const Text('Bill Content',
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(sale.billContent),
          ),
          ListTile(
            title: const Text('Sale Date',
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(sale.saleDate.toString()),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  await SaleService().deleteSale(sale.id);
                  widget.refreshList();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text('Delete'),
              ),
              const SizedBox(
                width: 14,
              ),
              ElevatedButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateSalePage(
                          sale: sale, refresh: widget.refreshList),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text('Update'),
              ),
              // const SizedBox(
              //   width: 14,
              // ),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.pop(context); // Navigate back to the previous page
              //   },
              //   child: const Text('Back'),
              // )
            ],
          ),
        ],
      ),
    );
  }
}
