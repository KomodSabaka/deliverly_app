import 'dart:convert';

class Product {
  final String id;
  final String sellerId;
  final String name;
  final double price;
  final String description;
  final String image;

  const Product({
    required this.id,
    required this.sellerId,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
  });

  Product copyWith({
    String? id,
    String? sellerId,
    String? name,
    double? price,
    String? description,
    String? image,
  }) {
    return Product(
      id: id ?? this.id,
      sellerId: sellerId ?? this.sellerId,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      image: image ?? this.image,
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
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      sellerId: map['sellerId'],
      name: map['name'] ,
      price: double.parse(map['price'].toString()),
      description: map['description'] ,
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
