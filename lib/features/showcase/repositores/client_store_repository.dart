import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/utils/constants.dart';
import '../../../models/product.dart';

final clientStoreRepository = Provider((ref) => ClientStoreRepository(
      firebaseAuth: FirebaseAuth.instance,
      firebaseFirestore: FirebaseFirestore.instance,
    ));

class ClientStoreRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  ClientStoreRepository({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  Stream<List<Product>> getProducts() {
    return firebaseFirestore
        .collection(FirebaseFields.products)
        .snapshots()
        .map(
      (event) {
        List<Product> listProduct = [];
        for (var product in event.docs) {
          listProduct.add(Product.fromMap(product.data()));
        }
        return listProduct;
      },
    );
  }

  Stream<List<Product>> searchProducts({
    required String text,
  }) {
    return firebaseFirestore
        .collection(FirebaseFields.products)
        .snapshots()
        .map((event) {
      List<Product> products = [];
      for (var product in event.docs) {
        products.add(Product.fromMap(product.data()));
      }
      List<Product> foundProducts = [];
      if (text.isNotEmpty) {
        foundProducts = products
            .where((element) =>
                element.name.toLowerCase().contains(text.toLowerCase()))
            .toList();
      }
      return foundProducts;
    });
  }
}
