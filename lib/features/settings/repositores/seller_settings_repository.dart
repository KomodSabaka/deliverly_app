import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/utils/constants.dart';
import '../../../common/utils/utils.dart';
import '../../../models/user.dart';

final sellerSettingRepository = Provider((ref) => SellerSettingRepository(
      firebaseAuth: FirebaseAuth.instance,
      firebaseFirestore: FirebaseFirestore.instance,
    ));

class SellerSettingRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  SellerSettingRepository({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

 Future changeCompany({
    required String name,
    required String description,
    required File? photo,
  }) async {
    try {
      String uid = firebaseAuth.currentUser!.uid;
      String? phone = firebaseAuth.currentUser!.phoneNumber;
      String? urlPhoto;

      if (photo != null) {
        urlPhoto = await storeFileToFirebase(
            '${FirebaseFields.companyPic}/$uid', photo);
      }

      Seller seller = Seller(
        id: uid,
        name: name,
        description: description,
        phone: phone!,
        photo: urlPhoto,
      );

      await firebaseFirestore
          .collection(FirebaseFields.seller)
          .doc(uid)
          .set(seller.toMap());
    } catch (e, s) {
      print(s);
    }
  }
}
