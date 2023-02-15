import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../mobile_layout.dart';
import '../../../models/company_model.dart';
import '../../../utils/utils.dart';

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

  void changeCompany({
    required BuildContext context,
    required String nameCompany,
    required String descriptionCompany,
    required File? photo,
  }) async {
    try {
      String uid = firebaseAuth.currentUser!.uid;
      String? phone = firebaseAuth.currentUser!.phoneNumber;
      String urlPhoto = await storeFileToFirebase('companyPic/$uid', photo!);

      CompanyModel company = CompanyModel(
        id: uid,
        nameCompany: nameCompany,
        descriptionCompany: descriptionCompany,
        phoneNumberCompany: phone!,
        photo: urlPhoto,
      );

      await firebaseFirestore
          .collection('company')
          .doc(uid)
          .set(company.toMap());

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MobileLayout(
              isUserMode: false,
              company: company,
            ),
          ),
              (route) => false);
    } catch (e, s) {
      print(s);
    }
  }

}
