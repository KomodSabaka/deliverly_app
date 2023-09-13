import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliverly_app/common/app_settings/app_settings.dart';
import 'package:deliverly_app/common/navigation/routes.dart';
import 'package:deliverly_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/constants/firebase_fields.dart';

final authRepository = Provider((ref) => AuthRepository(
      firebaseAuth: FirebaseAuth.instance,
      firebaseFirestore: FirebaseFirestore.instance,
      ref: ref,
    ));

class AuthRepository  {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final ProviderRef ref;

  AuthRepository({
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.ref,
  });

  void signSeller({
    required BuildContext context,
    required String phoneNumber,
  }) async {
    try {
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          throw Exception(e);
        },
        codeSent: ((String verificationId, int? resendToken) async {
          Navigator.pushNamed(
            context,
            AppRoutes.otpPage,
            arguments: {'verificationId': verificationId},
          );
        }),
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e, s) {
      print(s);
    }
  }

  void signClient({
    required BuildContext context,
    required String phoneNumber,
  }) async {
    try {
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          ref.read(appSettingsProvider.notifier).setUser(user: null);
        },
        codeSent: ((String verificationId, int? resendToken) async {
          Navigator.pushNamed(
            context,
            AppRoutes.otpPage,
            arguments: {'verificationId': verificationId},
          );
        }),
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e, s) {
      print(s);
    }
  }

  Future<void> signInAnonymous() async {
    try {
      await firebaseAuth.signInAnonymously();
    } on Exception catch (e) {
      print(e);
    }
  }

  bool isUserAnonymous() {
    return firebaseAuth.currentUser!.isAnonymous;
  }

  Future verifyOTP({
    required String verificationId,
    required String userOTP,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );
      await firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future<Seller?> getCurrentSellerData() async {
    try {
      var sellerData = await firebaseFirestore
          .collection(FirebaseFields.seller)
          .doc(firebaseAuth.currentUser?.uid)
          .get();
      Seller? seller;
      if (sellerData.data() != null) {
        seller = Seller.fromMap(sellerData.data()!);
      }
      return seller;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<Client?> getCurrentClientData() async {
    try {
      var clientData = await firebaseFirestore
          .collection(FirebaseFields.client)
          .doc(firebaseAuth.currentUser?.uid)
          .get();

      Client? client;
      if (clientData.data() != null) {
        client = Client.fromMap(clientData.data()!);
      }
      return client;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }
}
