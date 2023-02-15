import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliverly_app/models/purchase_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../models/product_model.dart';

final userRepository = Provider((ref) => UserRepository(
      firebaseAuth: FirebaseAuth.instance,
      firebaseFirestore: FirebaseFirestore.instance,
    ));

class UserRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  UserRepository({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  Stream<List<ProductModel>> getProducts() {
    return firebaseFirestore.collection('product').snapshots().map(
      (event) {
        List<ProductModel> listProduct = [];
        for (var product in event.docs) {
          listProduct.add(ProductModel.fromMap(product.data()));
        }
        return listProduct;
      },
    );
  }

  Stream<List<ProductModel>> searchProducts(String text) {
    return firebaseFirestore.collection('product').snapshots().map((event) {
      List<ProductModel> products = [];
      for (var product in event.docs) {
        products.add(ProductModel.fromMap(product.data()));
      }
      List<ProductModel> foundProducts = [];
      if (text.isNotEmpty) {
        foundProducts = products
            .where((element) =>
                element.nameProduct.toLowerCase().contains(text.toLowerCase()))
            .toList();
      }
      return foundProducts;
    });
  }
}
