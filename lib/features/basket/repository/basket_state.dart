import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:deliverly_app/common/utils/notification.dart';
import 'package:deliverly_app/models/date_and_time.dart';
import 'package:deliverly_app/models/item_in_cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../../common/utils/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/product.dart';
import '../../../models/purchase_order.dart';

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
      count.toString(),
      (count * int.parse(product.price)).toString(),
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

  void buyProducts({
    required BuildContext context,
    required DateAndTime dateAndTime,
  }) async {
    List<Product> basketList = state;
    state = [];

    final db = await SharedPreferences.getInstance();
    await db.remove(basketKey);
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
    NotificationService().createNotification(
      id: 10,
      title: S.of(context).thank_purchase,
      body: S.of(context).thank_purchase,
      dateAndTime: dateAndTime,
    );
  }

  int getSum() {
    int sum = 0;

    for (var element in state) {
      sum += int.parse(element.cost);
    }
    return sum;
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
}
