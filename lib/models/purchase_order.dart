import 'package:deliverly_app/models/product.dart';

class PurchaseOrder {
  final String id;
  final DateTime date;
  final List<Product> products;

  const PurchaseOrder({
    required this.id,
    required this.date,
    required this.products,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date.millisecondsSinceEpoch,
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory PurchaseOrder.fromMap(Map<String, dynamic> map) {
    return PurchaseOrder(
      id: map['id'] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      products: List<Product>.from(
        (map['products']).map<Product>(
          (x) => Product.fromMap(x),
        ),
      ),
    );
  }
}
