import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliverly_app/auth/repository/auth_repository.dart';
import 'package:deliverly_app/models/product_model.dart';
import 'package:deliverly_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

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
    required String nameProduct,
    required String priceProduct,
    required String description,
    required File photo,
  }) async {
    try {
      String companyId = firebaseAuth.currentUser!.uid;
      String productId = const Uuid().v1();
      String photoUrl = await storeFileToFirebase(
          'photoProducts/$companyId/$productId', photo);

      ProductModel product = ProductModel(
        id: productId,
        companyId: companyId,
        nameProduct: nameProduct,
        priceProduct: priceProduct,
        description: description,
        photo: photoUrl,
        count: '',
        cost: '',
      );

      await firebaseFirestore
          .collection('product')
          .doc(productId)
          .set(product.toMap());

      Navigator.pop(context);
    } catch (e) {
      print(e);
    }
  }

  void refactorProduct({
    required BuildContext context,
    required ProductModel product,
    required String nameProduct,
    required String priceProduct,
    required String description,
    required File? photo,
  }) async {
    try {
      String newPhoto = product.photo;

      if (photo != null) {
        deleteImageFromStorageFirebase(product.photo);
        newPhoto = await storeFileToFirebase(
            'photoProducts/${firebaseAuth.currentUser!.uid}/${product.id}',
            photo);
      }

      ProductModel newProduct = product.copyWith(
        nameProduct: nameProduct,
        priceProduct: priceProduct,
        description: description,
        photo: newPhoto,
      );

      await firebaseFirestore
          .collection('product')
          .doc(product.id)
          .set(newProduct.toMap());

      var company = await ref.read(authRepository).getCurrentCompanyData();
      Navigator.pop(context);
    } catch (e) {
      print(e);
    }
  }

  void deleteProduct(
    BuildContext context,
    ProductModel product,
  ) async {
    try {
      deleteImageFromStorageFirebase(product.photo);
      await firebaseFirestore.collection('product').doc(product.id).delete();
      Navigator.pop(context);
    } catch (e) {
      print(e);
    }
  }

  Stream<List<ProductModel>> searchProduct(String text) {
    String companyId = firebaseAuth.currentUser!.uid;
    return firebaseFirestore
        .collection('product')
        .where("companyId", isEqualTo: companyId)
        .snapshots()
        .map((event) {
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

  Stream<List<ProductModel>> getProductsCompany() {
    String companyId = firebaseAuth.currentUser!.uid;
    return firebaseFirestore
        .collection('product')
        .where("companyId", isEqualTo: companyId)
        .snapshots()
        .map(
      (event) {
        List<ProductModel> products = [];
        for (var product in event.docs) {
          products.add(ProductModel.fromMap(product.data()));
        }
        return products;
      },
    );
  }

  Stream<ProductModel> currentProduct(String productId) {
    return firebaseFirestore
        .collection('product')
        .where('id', isEqualTo: productId)
        .snapshots()
        .map(
      (event) {
        ProductModel product = ProductModel.fromMap(event.docs.first.data());
        return product;
      },
    );
  }
}
