import 'package:deliverly_app/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final showCaseState = StateNotifierProvider<ShowcaseState, List<Product>>(
    (ref) => ShowcaseState());

class ShowcaseState extends StateNotifier<List<Product>> {
  ShowcaseState() : super([]);

  void addProduct({required List<Product> products}) {
    state = products;
    print(state.length);
  }

  void loadMoreProduct({required List<Product> products}) {
    state = state + products;
    print(state.length);
  }
}
