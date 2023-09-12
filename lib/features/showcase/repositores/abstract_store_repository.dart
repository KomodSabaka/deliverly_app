import '../../../models/product.dart';

abstract class StoreRepository {
  Stream<List<Product>> getProducts();

  Stream<List<Product>> searchProduct({required String text});
}
