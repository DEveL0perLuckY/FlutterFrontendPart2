import 'dart:convert';

// import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:my_flutter_htttp/models/Sale.dart';

class SaleService {
  // ip v4 address
  // final String baseUrl = "http://192.168.160.174:9999/api/sales";

  // final String baseUrl = "http://127.0.0.2:9999/api/sales";

  final String baseUrl = "http://10.0.2.2:9999/api/sales";

//chrome
  // final String baseUrl = "http://localhost:9999/api/sales";

// local host on ios emulation is localhost or 127.0.0.1
// local host on android is localhost or 127.0.0.2

  Future<List<Sale>> getSale() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Sale> posts = data.map((json) => Sale.fromJson(json)).toList();
      return posts;
    } else {
      throw Exception('Failed to load sale list: $baseUrl');
    }
  }

  Future<void> deleteSale(int id) async {
    await http.delete(Uri.parse('$baseUrl/$id'));
  }

  Future<void> createSale(final Sale s) async {
    try {
      await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(s.toJson()), // Use toJson method to convert to JSON
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateSale(final Sale s, final int id) async {
    try {
      await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json
            .encode(s.toJsonUpdate()), // Use toJson method to convert to JSON
      );
    } catch (e) {
      rethrow;
    }
  }
}
