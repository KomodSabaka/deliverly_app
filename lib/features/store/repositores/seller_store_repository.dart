import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliverly_app/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

import '../../../common/utils/constants.dart';
import '../../../common/utils/utils.dart';

final sellerStoreRepository = Provider((ref) => SellerStoreRepository(
      firebaseAuth: FirebaseAuth.instance,
      firebaseFirestore: FirebaseFirestore.instance,
      ref: ref,
    ));

class SellerStoreRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final ProviderRef ref;

  const SellerStoreRepository({
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.ref,
  });

  void addProducts({
    required BuildContext context,
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
        count: '',
        cost: '',
      );

      await firebaseFirestore
          .collection(FirebaseFields.products)
          .doc(productId)
          .set(product.toMap());

      Navigator.pop(context);
    } catch (e) {
      print(e);
    }
  }

  void refactorProduct({
    required BuildContext context,
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

      Navigator.pop(context);
    } catch (e) {
      print(e);
    }
  }

  void deleteProduct(
    BuildContext context,
    Product product,
  ) async {
    try {
      deleteImageFromStorageFirebase(product.image);
      await firebaseFirestore
          .collection(FirebaseFields.products)
          .doc(product.id)
          .delete();
      Navigator.pop(context);
    } catch (e) {
      print(e);
    }
  }

  Stream<List<Product>> searchProduct(String text) {
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

  Stream<Product> currentProduct(String productId) {
    return firebaseFirestore
        .collection(FirebaseFields.products)
        .where(FirebaseFields.id, isEqualTo: productId)
        .snapshots()
        .map(
      (event) {
        Product product = Product.fromMap(event.docs.first.data());
        return product;
      },
    );
  }
}
