import 'package:deliverly_app/models/product_model.dart';

class PurchaseModel {
  final String id;
  final DateTime date;
  final List<ProductModel> productList;

  const PurchaseModel({
    required this.id,
    required this.date,
    required this.productList,
  });

  PurchaseModel copyWith({
    String? id,
    DateTime? date,
    List<ProductModel>? productList,
  }) {
    return PurchaseModel(
      id: id ?? this.id,
      date: date ?? this.date,
      productList: productList ?? this.productList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date.millisecondsSinceEpoch,
      'productList': productList.map((x) => x.toMap()).toList(),
    };
  }

  factory PurchaseModel.fromMap(Map<String, dynamic> map) {
    return PurchaseModel(
      id: map['id'] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      productList: List<ProductModel>.from(
        (map['productList']).map<ProductModel>(
          (x) => ProductModel.fromMap(x),
        ),
      ),
    );
  }
}
