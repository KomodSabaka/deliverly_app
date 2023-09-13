import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliverly_app/features/showcase/repositores/abstract_store_repository.dart';
import 'package:deliverly_app/features/showcase/states/showcase_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/constants/firebase_fields.dart';
import '../../../models/product.dart';
import '../states/products_is_loading_state.dart';

final clientStoreRepository = Provider((ref) => ClientStoreRepository(
      firebaseAuth: FirebaseAuth.instance,
      firebaseFirestore: FirebaseFirestore.instance,
      ref: ref,
    ));

class ClientStoreRepository extends StoreRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final ProviderRef ref;

  ClientStoreRepository({
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.ref,
  });

  @override
  Future<void> getProducts() async {
    var productData = await firebaseFirestore
        .collection(FirebaseFields.products)
        .limit(20)
        .get();
    List<Product> listProduct = [];
    for (var product in productData.docs) {
      listProduct.add(Product.fromMap(product.data()));
    }

    ref.read(showCaseState.notifier).addProduct(products: listProduct);
  }

  Future<void> loadMoreProducts() async {
    var isLoading = ref.read(productsIsLoadingState.notifier);

    isLoading.productsLoad();

    var lastDocument = ref.read(showCaseState).last;

    var documentReference = await firebaseFirestore
        .collection(FirebaseFields.products)
        .doc(lastDocument.id)
        .get();

    var productData = await firebaseFirestore
        .collection(FirebaseFields.products)
        .startAfterDocument(documentReference)
        .limit(20)
        .get();
    List<Product> listProduct = [];
    for (var product in productData.docs) {
      listProduct.add(Product.fromMap(product.data()));
    }

    ref.read(showCaseState.notifier).loadMoreProduct(products: listProduct);
    isLoading.productsLoaded();
  }

  @override
  Future<void> searchProduct({
    required String text,
  }) async {
    var productData =
        await firebaseFirestore.collection(FirebaseFields.products).get();

    List<Product> products = [];
    for (var product in productData.docs) {
      products.add(Product.fromMap(product.data()));
    }
    List<Product> foundProducts = [];
    if (text.isNotEmpty) {
      foundProducts = products
          .where((element) =>
              element.name.toLowerCase().contains(text.toLowerCase()))
          .toList();
    }
    ref.read(showCaseState.notifier).addProduct(products: foundProducts);
  }
}
