import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../mobile_layout.dart';
import '../../../models/card_model.dart';
import '../../../models/purchase_model.dart';
import '../../../models/user_model.dart';
import '../../../utils/utils.dart';

final userSettingRepository = Provider((ref) => UserSettingRepository(
      firebaseAuth: FirebaseAuth.instance,
      firebaseFirestore: FirebaseFirestore.instance,
    ));

class UserSettingRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  UserSettingRepository({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  void changeUser({
    required BuildContext context,
    required String nameUser,
    required String phoneUser,
    required CardModel card,
    required File photo,
    required UserModel? userData,
  }) async {
    try {
      String uid = firebaseAuth.currentUser!.uid;

      String urlPhoto = await storeFileToFirebase('userAvatar/$uid', photo);

      UserModel user = UserModel(
        id: uid,
        name: nameUser,
        phone: phoneUser,
        card: card,
        urlPhoto: urlPhoto,
      );

      await firebaseFirestore.collection('users').doc(uid).set(user.toMap());

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MobileLayout(
              isUserMode: true,
              user: user,
            ),
          ),
          (route) => false);
    } catch (e) {
      print(e);
    }
  }

  Future<List<PurchaseModel>> getHistory() async {
    return await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('buyList')
        .get()
        .then((value) {
      List<PurchaseModel> purchaseList = [];
      for (var purchase in value.docs) {
        purchaseList.add(PurchaseModel.fromMap(purchase.data()));
      }
      return purchaseList;
    });
  }
}
