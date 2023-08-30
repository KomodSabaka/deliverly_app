import 'package:deliverly_app/features/showcase/repositores/client_store_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/product.dart';

final clientStoreController = Provider<ClientStoreController>((ref) {
  return ClientStoreController(
    clientStoreRepository: ref.watch(clientStoreRepository),
  );
});

class ClientStoreController {
  final ClientStoreRepository clientStoreRepository;

  const ClientStoreController({
    required this.clientStoreRepository,
  });

  Stream<List<Product>> getProducts() {
    return clientStoreRepository.getProducts();
  }

  Stream<List<Product>> searchProducts({
    required String text,
  }) {
    return clientStoreRepository.searchProducts(text: text);
  }
}
