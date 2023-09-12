import 'package:deliverly_app/models/address.dart';
import 'package:deliverly_app/models/product.dart';

class Order {
  final String id;
  final String clientId;
  final DateTime clearanceTime;
  final DateTime deliveryDate;
  final String deliveryTime;
  final Address address;
  final List<Product> products;

  const Order({
    required this.id,
    required this.clientId,
    required this.clearanceTime,
    required this.deliveryDate,
    required this.deliveryTime,
    required this.address,
    required this.products,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clientId': clientId,
      'clearanceTime': clearanceTime.millisecondsSinceEpoch,
      'deliveryDate': deliveryDate.millisecondsSinceEpoch,
      'deliveryTime': deliveryTime,
      'address': address,
      'products': products,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] ?? '',
      clientId: map['clientId'] ?? '',
      clearanceTime: DateTime.fromMillisecondsSinceEpoch(map['clearanceTime']),
      deliveryDate: DateTime.fromMillisecondsSinceEpoch(map['deliveryDate']),
      deliveryTime: map['deliveryTime'] ?? '',
      address: map['address'] as Address,
      products: map['products'] as List<Product>,
    );
  }
}
