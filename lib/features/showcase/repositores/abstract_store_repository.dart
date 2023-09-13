abstract class StoreRepository {
  Future<void> getProducts();

  Future<void> searchProduct({required String text});
}
