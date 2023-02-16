import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../../common/utils/constants.dart';
import '../../../common/utils/utils.dart';
import '../../../generated/l10n.dart';
import '../../../models/product.dart';
import '../../../models/purchase_order.dart';

final basketProvider =
    StateNotifierProvider<Basket, List<Product>>((ref) => Basket());

class Basket extends StateNotifier<List<Product>> {
  Basket() : super([]);
  final String basketKey = 'basket_key';

  Future<void> addProduct(
    BuildContext context,
    Product product,
    int count,
  ) async {
    Product selectedProduct = product.copyWith(
        count: count.toString(),
        cost: (count * int.parse(product.price)).toString());
    var productInBasket =
        state.firstWhereOrNull((element) => element.id == selectedProduct.id);
    if (productInBasket == null) {
      state.add(selectedProduct);
    } else {
      state.remove(productInBasket);
      state.add(selectedProduct);
    }
    var db = await SharedPreferences.getInstance();
    db.setString(basketKey, json.encode(state));

    showSnakeBar(context, S.of(context).added_cart);
  }

  Future<void> deleteProductFromBasket(Product product) async {
    state = List.from(state)..remove(product);
    final db = await SharedPreferences.getInstance();
    db.remove(basketKey);
    db.setString(basketKey, json.encode(state));
  }

  void buyProducts() async {
    List<Product> basketList = state;
    state = [];

    final db = await SharedPreferences.getInstance();
    db.remove(basketKey);
    String buyId = const Uuid().v1();

    PurchaseOrder purchase = PurchaseOrder(
      id: buyId,
      date: DateTime.now(),
      products: basketList,
    );

    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    await firebaseFirestore
        .collection(FirebaseFields.client)
        .doc(firebaseAuth.currentUser!.uid)
        .collection(FirebaseFields.buyList)
        .doc(buyId)
        .set(purchase.toMap());
  }

  Future getProductsFromDB() async {
    final db = await SharedPreferences.getInstance();
    final products = db.getString(basketKey);
    if (products == null) return null;
    Iterable l = json.decode(products);
    List<Product> basketList =
        List<Product>.from(l.map((model) => Product.fromJson(model)));
    state = basketList;
  }
}
