import 'dart:convert';

class ProductModel {
  final String id;
  final String companyId;
  final String nameProduct;
  final String priceProduct;
  final String description;
  final String photo;
  final String count;
  final String cost;

  const ProductModel({
    required this.id,
    required this.companyId,
    required this.nameProduct,
    required this.priceProduct,
    required this.description,
    required this.photo,
    required this.count,
    required this.cost,
  });

  ProductModel copyWith({
    String? id,
    String? companyId,
    String? nameProduct,
    String? priceProduct,
    String? description,
    String? photo,
    String? count,
    String? cost,
  }) {
    return ProductModel(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      nameProduct: nameProduct ?? this.nameProduct,
      priceProduct: priceProduct ?? this.priceProduct,
      description: description ?? this.description,
      photo: photo ?? this.photo,
      count: count ?? this.count,
      cost: cost ?? this.cost,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'companyId': companyId,
      'nameProduct': nameProduct,
      'priceProduct': priceProduct,
      'description': description,
      'photo': photo,
      'count': count,
      'cost': cost,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? '',
      companyId: map['companyId'] ?? '',
      nameProduct: map['nameProduct'] ?? '',
      priceProduct: map['priceProduct'] ?? '',
      description: map['description'] ?? '',
      photo: map['photo'] ?? '',
      count: map['count'] ?? '',
      cost: map['cost'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}