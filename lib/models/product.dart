import 'dart:convert';

class Product {
  final String id;
  final String sellerId;
  final String name;
  final String price;
  final String description;
  final String image;
  final String count;
  final String cost;

  const Product({
    required this.id,
    required this.sellerId,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.count,
    required this.cost,
  });

  Product copyWith({
    String? id,
    String? sellerId,
    String? name,
    String? price,
    String? description,
    String? image,
    String? count,
    String? cost,
  }) {
    return Product(
      id: id ?? this.id,
      sellerId: sellerId ?? this.sellerId,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      image: image ?? this.image,
      count: count ?? this.count,
      cost: cost ?? this.cost,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sellerId': sellerId,
      'name': name,
      'price': price,
      'description': description,
      'image': image,
      'count': count,
      'cost': cost,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? '',
      sellerId: map['sellerId'] ?? '',
      name: map['name'] ?? '',
      price: map['price'] ?? '',
      description: map['description'] ?? '',
      image: map['image'] ?? '',
      count: map['count'] ?? '',
      cost: map['cost'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
