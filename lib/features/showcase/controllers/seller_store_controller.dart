import 'dart:io';

import 'package:deliverly_app/features/showcase/repositores/seller_store_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/product.dart';

final sellerStoreController = Provider<SellerStoreController>((ref) {
  return SellerStoreController(
    sellerStoreRepository: ref.watch(sellerStoreRepository),
  );
});

class SellerStoreController {
  final SellerStoreRepository sellerStoreRepository;

  const SellerStoreController({
    required this.sellerStoreRepository,
  });

  void addProducts({
    required String name,
    required String price,
    required String description,
    required File image,
  }) {
    sellerStoreRepository.addProducts(
      name: name,
      price: price,
      description: description,
      image: image,
    );
  }

  void refactorProduct({
    required Product product,
    required String name,
    required String price,
    required String description,
    required File? image,
  }) {
    sellerStoreRepository.refactorProduct(
      product: product,
      name: name,
      price: price,
      description: description,
      image: image,
    );
  }

  void deleteProduct({required String productId}) {
    sellerStoreRepository.deleteProduct(productId: productId);
  }

  Stream<List<Product>> searchProduct({
    required String text,
  }) {
    return sellerStoreRepository.searchProduct(text: text);
  }

  Stream<List<Product>> getProductsCompany() {
    return sellerStoreRepository.getProductsCompany();
  }

  Stream<Product> currentProduct({
    required String productId,
  }) {
    return sellerStoreRepository.currentProduct(productId: productId);
  }
}
