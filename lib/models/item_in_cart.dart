import 'dart:convert';

import 'package:deliverly_app/models/product.dart';

class ItemInCart extends Product {
  final String count;
  final String cost;

  ItemInCart(
    this.count,
    this.cost, {
    required String id,
    required String sellerId,
    required String name,
    required String price,
    required String image,
  }) : super(
          id: id,
          sellerId: sellerId,
          name: name,
          price: price,
          description: '',
          image: image,
        );

  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.remove('description');
    map['count'] = count;
    map['cost'] = cost;
    return map;
  }

  static ItemInCart fromMap(Map<String, dynamic> map) {
    return ItemInCart(
      map['count'],
      map['cost'],
      id: map['id'],
      sellerId: map['sellerId'],
      name: map['name'],
      price: map['price'],
      image: map['image'],

    );
  }

  String toJson() => json.encode(toMap());

  factory ItemInCart.fromJson(String source) =>
      ItemInCart.fromMap(json.decode(source) as Map<String, dynamic>);
}
