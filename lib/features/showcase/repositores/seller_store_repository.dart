import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliverly_app/features/showcase/repositores/abstract_store_repository.dart';
import 'package:deliverly_app/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../common/constants/firebase_fields.dart';
import '../../../common/utils/utils.dart';
import '../states/showcase_state.dart';

final sellerStoreRepository = Provider((ref) => SellerStoreRepository(
      firebaseAuth: FirebaseAuth.instance,
      firebaseFirestore: FirebaseFirestore.instance,
      ref: ref,
    ));

class SellerStoreRepository extends StoreRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final ProviderRef ref;

  SellerStoreRepository({
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.ref,
  });

  Future<void> addProducts({
    required String name,
    required double price,
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
    required double price,
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
    required String imagePath,
  }) async {
    try {
      FirebaseStorage.instance.ref().child(imagePath).delete();
      await firebaseFirestore
          .collection(FirebaseFields.products)
          .doc(productId)
          .delete();
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> searchProduct({
    required String text,
  }) async {
    String companyId = firebaseAuth.currentUser!.uid;
    var productsData =  await firebaseFirestore
        .collection(FirebaseFields.products)
        .where(FirebaseFields.sellerId, isEqualTo: companyId).get();

    List<Product> products = [];
    for (var product in productsData.docs) {
      products.add(Product.fromMap(product.data()));


      List<Product> foundProducts = [];
      if (text.isNotEmpty) {
        foundProducts = products
            .where((element) =>
                element.name.toLowerCase().contains(text.toLowerCase()))
            .toList();
      }
     ref.watch(showCaseState.notifier).addProduct(products: foundProducts);
    }
  }

  @override
  Future<void> getProducts() async {
    String companyId = firebaseAuth.currentUser!.uid;
    var productsData = await firebaseFirestore
        .collection(FirebaseFields.products)
        .where(FirebaseFields.sellerId, isEqualTo: companyId)
        .get();

    List<Product> products = [];
    for (var product in productsData.docs) {
      products.add(Product.fromMap(product.data()));
    }

    ref.read(showCaseState.notifier).addProduct(products: products);
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
