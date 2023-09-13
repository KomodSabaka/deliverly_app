import 'dart:convert';

import 'package:deliverly_app/models/product.dart';

class ItemInCart extends Product {
  final int count;
  final double cost;

  ItemInCart(
    this.count,
    this.cost, {
    required String id,
    required String sellerId,
    required String name,
    required double price,
    required String image,
  }) : super(
          id: id,
          sellerId: sellerId,
          name: name,
          price: price,
          description: '',
          image: image,
        );

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.remove('description');
    map['count'] = count;
    map['cost'] = cost;
    return map;
  }

  static ItemInCart fromMap(Map<String, dynamic> map) {
    return ItemInCart(
      int.parse(map['count'].toString()),
      double.parse(map['cost'].toString()),
      id: map['id'],
      sellerId: map['sellerId'],
      name: map['name'],
      price: double.parse(map['price'].toString()),
      image: map['image'],
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory ItemInCart.fromJson(String source) =>
      ItemInCart.fromMap(json.decode(source) as Map<String, dynamic>);
}
