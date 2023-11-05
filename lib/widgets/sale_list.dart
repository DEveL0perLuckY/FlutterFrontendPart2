import 'package:flutter/material.dart';
import 'package:my_flutter_htttp/models/Sale.dart';
import 'package:my_flutter_htttp/services/sale_service.dart';
import 'package:my_flutter_htttp/widgets/sale_details.dart';
import 'package:my_flutter_htttp/widgets/sale_add_page.dart';

class SaleList extends StatefulWidget {
  const SaleList({super.key, required this.saleArList});
  final List<Sale> saleArList;

  @override
  State<SaleList> createState() => _SaleListState();
}

class _SaleListState extends State<SaleList> {
  List<Sale> currentSaleList = [];

  @override
  void initState() {
    super.initState();
    currentSaleList = widget.saleArList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sale List'),
      ),
      body: SingleChildScrollView(
        child: DataTable(
          columnSpacing: 30,
          columns: const [
            DataColumn(
              label: SizedBox(width: 20, child: Text('ID')),
              numeric: true,
            ),
            DataColumn(
              label: SizedBox(width: 70, child: Text('Customer')),
            ),
            DataColumn(
              label: SizedBox(width: 70, child: Text('Product')),
            ),
            DataColumn(
              label: SizedBox(width: 45, child: Text('Details')),
            ),
          ],
          rows: currentSaleList.asMap().entries.map((entry) {
            final sale = entry.value;
            return DataRow(
              cells: [
                DataCell(SizedBox(width: 40, child: Text(sale.id.toString()))),
                DataCell(
                  SizedBox(
                    width: 70,
                    child: Text(
                      sale.customer,
                      softWrap: true, // Allow text to wrap to the next line
                      overflow: TextOverflow
                          .ellipsis, // Handle long texts with an ellipsis
                    ),
                  ),
                ),
                DataCell(
                  SizedBox(
                    width: 70,
                    child: Center(
                      child: Text(
                        sale.product,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                DataCell(
                  SizedBox(
                    width: 80,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SaleDetails(sale, refreshListOfSaleList),
                          ),
                        );
                      },
                      child: const Text('Details'),
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              fetchData();
            },
            child: const Icon(Icons.cloud),
          ),
          const SizedBox(width: 16), // Add some spacing
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SaleAddPage(refreshList: refreshListOfSaleList)));
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  void refreshListOfSaleList() {
    fetchData();
  }

  Future<void> fetchData() async {
    final newSaleList = await SaleService().getSale();
    setState(() {
      currentSaleList = newSaleList;
    });
  }
}
