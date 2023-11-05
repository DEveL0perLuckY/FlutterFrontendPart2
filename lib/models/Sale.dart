// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

class Sale {
  final int id;
  final String customer;
  final String product;
  final int quantity;
  final String billContent;
  final DateTime saleDate;

  Sale({
    required this.id,
    required this.customer,
    required this.product,
    required this.quantity,
    required this.billContent,
    required this.saleDate,
  });

  factory Sale.fromJson(Map<String, dynamic> json) {
    return Sale(
      id: json["id"],
      customer: json['customer'],
      product: json['product'],
      quantity: json['quantity'],
      billContent: json['billContent'],
      saleDate: DateTime.parse(json['saleDate']),
    );
  }

  // Define a toJson method to convert the Sale object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer': customer,
      'product': product,
      'quantity': quantity,
      'billContent': billContent,
      'saleDate':
          saleDate.toIso8601String(), // Convert DateTime to ISO 8601 string
    };
  }

  Map<String, dynamic> toJsonUpdate() {
    return {
      'customer': customer,
      'product': product,
      'quantity': quantity,
      'billContent': billContent,
      'saleDate':
          saleDate.toIso8601String(), // Convert DateTime to ISO 8601 string
    };
  }
}
