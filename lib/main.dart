import 'package:flutter/material.dart';
import 'package:my_flutter_htttp/models/Sale.dart';
import 'package:my_flutter_htttp/services/sale_service.dart';
import 'package:my_flutter_htttp/widgets/sale_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Management',
      initialRoute: '/',
      routes: {
        '/': (context) => FutureBuilder<List<Sale>>(
              future: SaleService().getSale(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error occurred: ${snapshot.error}"),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return SaleList(saleArList: snapshot.data!);
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
      },
    );
  }
}
