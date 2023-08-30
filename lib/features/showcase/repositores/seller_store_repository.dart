import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliverly_app/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../common/utils/constants.dart';
import '../../../common/utils/utils.dart';

final sellerStoreRepository = Provider((ref) => SellerStoreRepository(
      firebaseAuth: FirebaseAuth.instance,
      firebaseFirestore: FirebaseFirestore.instance,
    ));

class SellerStoreRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  const SellerStoreRepository({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  void addProducts({
    required String name,
    required String price,
    required String description,
    required File image,
  }) async {
    try {
      String companyId = firebaseAuth.currentUser!.uid;
      String productId = const Uuid().v1();
      String urlImage = await storeFileToFirebase(
          '${FirebaseFields.productPic}/$companyId/$productId', image);

      Product product = Product(
        id: productId,
        sellerId: companyId,
        name: name,
        price: price,
        description: description,
        image: urlImage,
      );

      await firebaseFirestore
          .collection(FirebaseFields.products)
          .doc(productId)
          .set(product.toMap());
    } catch (e) {
      print(e);
    }
  }

  void refactorProduct({
    required Product product,
    required String name,
    required String price,
    required String description,
    required File? image,
  }) async {
    try {
      String newImage = product.image;

      if (image != null) {
        deleteImageFromStorageFirebase(product.image);
        newImage = await storeFileToFirebase(
            '${FirebaseFields.productPic}/${firebaseAuth.currentUser!.uid}/${product.id}',
            image);
      }

      Product newProduct = product.copyWith(
        name: name,
        price: price,
        description: description,
        image: newImage,
      );

      await firebaseFirestore
          .collection(FirebaseFields.products)
          .doc(product.id)
          .set(newProduct.toMap());
    } catch (e) {
      print(e);
    }
  }

  void deleteProduct({
    required String productId,
  }) async {
    try {
      await firebaseFirestore
          .collection(FirebaseFields.products)
          .doc(productId)
          .delete();
    } catch (e) {
      print(e);
    }
  }

  Stream<List<Product>> searchProduct({
    required String text,
  }) {
    String companyId = firebaseAuth.currentUser!.uid;
    return firebaseFirestore
        .collection(FirebaseFields.products)
        .where(FirebaseFields.sellerId, isEqualTo: companyId)
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


  Stream<List<Product>> getProductsCompany() {
    String companyId = firebaseAuth.currentUser!.uid;
    return firebaseFirestore
        .collection(FirebaseFields.products)
        .where(FirebaseFields.sellerId, isEqualTo: companyId)
        .snapshots()
        .map(
      (event) {
        List<Product> products = [];
        for (var product in event.docs) {
          products.add(Product.fromMap(product.data()));
        }
        return products;
      },
    );
  }

  Stream<Product> currentProduct({
    required String productId,
  }) {
    return firebaseFirestore
        .collection(FirebaseFields.products)
        .doc(productId)
        .snapshots()
        .map(
          (event) => Product.fromMap(event.data()!),
        );
  }
}
