import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/utils/constants.dart';
import '../../../models/pay_card.dart';
import '../../../models/purchase_order.dart';
import '../../../models/user.dart';

final clientSettingRepository = Provider((ref) => ClientSettingRepository(
      firebaseAuth: FirebaseAuth.instance,
      firebaseFirestore: FirebaseFirestore.instance,
    ));

class ClientSettingRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  ClientSettingRepository({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  Future changeUser({
    required String name,
    required String phone,
    required PayCard card,
    required File? photo,
  }) async {
    try {
      String uid = firebaseAuth.currentUser!.uid;

      Client client = Client(
        id: uid,
        name: name,
        phone: phone,
        card: card,
      );

      await firebaseFirestore
          .collection(FirebaseFields.client)
          .doc(uid)
          .set(client.toMap());
    } catch (e) {
      print(e);
    }
  }

  Future<List<PurchaseOrder>> getHistory() async {
    return await firebaseFirestore
        .collection(FirebaseFields.client)
        .doc(firebaseAuth.currentUser!.uid)
        .collection(FirebaseFields.buyList)
        .get()
        .then((value) {
      List<PurchaseOrder> purchaseList = [];
      for (var purchase in value.docs) {
        purchaseList.add(PurchaseOrder.fromMap(purchase.data()));
      }
      return purchaseList;
    });
  }
}
