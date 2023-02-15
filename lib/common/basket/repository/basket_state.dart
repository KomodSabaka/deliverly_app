import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:deliverly_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../../generated/l10n.dart';
import '../../../models/product_model.dart';
import '../../../models/purchase_model.dart';

final basketProvider =
    StateNotifierProvider<Basket, List<ProductModel>>((ref) => Basket());

class Basket extends StateNotifier<List<ProductModel>> {
  Basket() : super([]);
  final String basketKey = 'basket_key';

  Future<void> addProduct(
    BuildContext context,
    ProductModel product,
    int count,
  ) async {
    ProductModel selectedProduct = product.copyWith(
        count: count.toString(),
        cost: (count * int.parse(product.priceProduct)).toString());
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

  Future<void> deleteProductFromBasket(ProductModel product) async {
    state = List.from(state)..remove(product);
    final db = await SharedPreferences.getInstance();
    db.remove(basketKey);
    db.setString(basketKey, json.encode(state));
  }

  void buyProducts() async {
    List<ProductModel> basketList = state;
    state = [];

    final db = await SharedPreferences.getInstance();
    db.remove(basketKey);
    String buyId = const Uuid().v1();

    PurchaseModel purchase = PurchaseModel(
      id: buyId,
      date: DateTime.now(),
      productList: basketList,
    );

    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('buyList')
        .doc(buyId)
        .set(purchase.toMap());
  }

  Future getProductsFromDB() async {
    final db = await SharedPreferences.getInstance();
    final products = db.getString(basketKey);
    if (products == null) return null;
    Iterable l = json.decode(products);
    List<ProductModel> basketList =
        List<ProductModel>.from(l.map((model) => ProductModel.fromJson(model)));
    state = basketList;
  }
}
