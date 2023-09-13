import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:deliverly_app/models/item_in_cart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/product.dart';

final basketProvider =
    StateNotifierProvider<Basket, List<ItemInCart>>((ref) => Basket());

class Basket extends StateNotifier<List<ItemInCart>> {
  Basket() : super([]);
  final String basketKey = 'basket_key';

  Future<void> addProduct({
    required Product product,
    required int count,
  }) async {
    ItemInCart selectedProduct = ItemInCart(
      count,
      count * product.price,
      id: product.id,
      sellerId: product.sellerId,
      name: product.name,
      price: product.price,
      image: product.image,
    );

    var productInBasket =
        state.firstWhereOrNull((element) => element.id == selectedProduct.id);
    if (productInBasket == null) {
      state.add(selectedProduct);
    } else {
      state.remove(productInBasket);
      state.add(selectedProduct);
    }
    var db = await SharedPreferences.getInstance();
    await db.setString(basketKey, json.encode(state));
  }

  Future<void> deleteProductFromBasket({required String id}) async {
    state = List.from(state)..removeWhere((element) => element.id == id);
    final db = await SharedPreferences.getInstance();

    await db.remove(basketKey);
    await db.setString(basketKey, json.encode(state));
  }


  Future getProductsFromDB() async {
    final db = await SharedPreferences.getInstance();
    final products = db.getString(basketKey);
    if (products == null) return null;
    Iterable l = json.decode(products);
    List<ItemInCart> basketList =
        List<ItemInCart>.from(l.map((model) => ItemInCart.fromJson(model)));
    state = basketList;
  }

  void deleteAllProducts() async {
    final db = await SharedPreferences.getInstance();
    await db.remove(basketKey);
    state = [];
  }
}
