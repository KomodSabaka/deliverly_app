import 'dart:io';
import 'package:deliverly_app/common/app_settings/app_settings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/enums/mode_enum.dart';
import '../../../models/product.dart';
import '../repositores/client_store_repository.dart';
import '../repositores/seller_store_repository.dart';

final showCaseController = Provider<ShowCaseController>((ref) {
  return ShowCaseController(
    ref: ref,
    clientStoreRepository: ref.watch(clientStoreRepository),
    sellerStoreRepository: ref.watch(sellerStoreRepository),
  );
});

class ShowCaseController {
  final ProviderRef ref;
  final ClientStoreRepository clientStoreRepository;
  final SellerStoreRepository sellerStoreRepository;

  const ShowCaseController({
    required this.ref,
    required this.clientStoreRepository,
    required this.sellerStoreRepository,
  });


  Future<void> getProducts() {
    switch(ref.watch(appSettingsProvider).mode) {
      case ModeEnum.client:
        return clientStoreRepository.getProducts();
      case ModeEnum.seller:
        return sellerStoreRepository.getProducts();
      default: throw ArgumentError("Unexpected ModeEnum value");
    }
  }

  Future<void> searchProduct({
    required String text,
  }) {
    switch(ref.watch(appSettingsProvider).mode) {
      case ModeEnum.client:
        return clientStoreRepository.searchProduct(text: text);
      case ModeEnum.seller:
        return sellerStoreRepository.searchProduct(text: text);
      default: throw ArgumentError("Unexpected ModeEnum value");
    }
  }

  Future<void> addProducts({
    required String name,
    required double price,
    required String description,
    required File image,
  }) {
   return sellerStoreRepository.addProducts(
      name: name,
      price: price,
      description: description,
      image: image,
    );
  }

  void refactorProduct({
    required Product product,
    required String name,
    required double price,
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

  void deleteProduct({required String productId,required String imagePath}) {
    sellerStoreRepository.deleteProduct(
      productId: productId,
      imagePath: imagePath,
    );
  }


  Stream<Product> currentProduct({
    required String productId,
  }) {
    return sellerStoreRepository.currentProduct(productId: productId);
  }
}
