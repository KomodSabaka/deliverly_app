import 'package:flutter_riverpod/flutter_riverpod.dart';

final productsIsLoadingState =
    StateNotifierProvider<ProductsIsLoadingState, bool>(
        (ref) => ProductsIsLoadingState());

class ProductsIsLoadingState extends StateNotifier<bool> {
  ProductsIsLoadingState() : super(false);

  void productsLoad() {
    state = true;
  }

  void productsLoaded() {
    state = false;
  }
}
