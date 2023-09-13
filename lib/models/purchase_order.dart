// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:deliverly_app/models/item_in_cart.dart';

import 'address.dart';

class PurchaseOrder {
  final String id;
  final String clientId;
  final DateTime clearanceTime;
  final DateTime deliveryDate;
  final String deliveryTime;
  final Address address;
  final List<ItemInCart> products;

  const PurchaseOrder({
    required this.id,
    required this.clientId,
    required this.clearanceTime,
    required this.deliveryDate,
    required this.deliveryTime,
    required this.address,
    required this.products,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'clientId': clientId,
      'clearanceTime': clearanceTime.millisecondsSinceEpoch,
      'deliveryDate': deliveryDate.millisecondsSinceEpoch,
      'deliveryTime': deliveryTime,
      'address': address.toMap(),
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory PurchaseOrder.fromMap(Map<String, dynamic> map) {
    return PurchaseOrder(
      id: map['id'] ?? '',
      clientId: map['clientId'] ?? '',
      clearanceTime: DateTime.fromMillisecondsSinceEpoch(map['clearanceTime']),
      deliveryDate: DateTime.fromMillisecondsSinceEpoch(map['deliveryDate']),
      deliveryTime: map['deliveryTime'] ?? '',
      address: Address.fromMap(map['address']),
      products: List<ItemInCart>.from(
        (map['products']).map<ItemInCart>((x) => ItemInCart.fromMap(x)),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory PurchaseOrder.fromJson(String source) =>
      PurchaseOrder.fromMap(json.decode(source) as Map<String, dynamic>);
}
