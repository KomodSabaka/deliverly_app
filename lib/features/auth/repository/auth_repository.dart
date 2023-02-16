import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliverly_app/models/seller.dart';
import 'package:deliverly_app/mobile_layout.dart';
import 'package:deliverly_app/models/client.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/utils/constants.dart';
import '../pages/otp_page.dart';

final authRepository = Provider((ref) => AuthRepository(
      firebaseAuth: FirebaseAuth.instance,
      firebaseFirestore: FirebaseFirestore.instance,
      ref: ref,
    ));

class AuthRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final ProviderRef ref;

  AuthRepository({
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.ref,
  });

  void signSeller(
    BuildContext context,
    String phoneNumber,
  ) async {
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OTPPage(
                verificationId: verificationId,
                isClientMode: false,
              ),
            ),
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
          throw Exception(e);
        },
        codeSent: ((String verificationId, int? resendToken) async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OTPPage(
                verificationId: verificationId,
                isClientMode: true,
              ),
            ),
          );
        }),
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e, s) {
      print(s);
    }
  }

  Future<void> signInAnonymous(BuildContext context) async {
    await firebaseAuth.signInAnonymously();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MobileLayout(isClientMode: true),
        ),
        (route) => false);
  }

  bool isUserAnonymous() {
    return firebaseAuth.currentUser!.isAnonymous;
  }

  void verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOTP,
    required bool isClientMode,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );
      await firebaseAuth.signInWithCredential(credential);

      if (isClientMode) {
        Navigator.pop(context);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MobileLayout(
                isClientMode: isClientMode,
              ),
            ),
            (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future<Seller?> getCurrentSellerData() async {
    var companyData = await firebaseFirestore
        .collection(FirebaseFields.seller)
        .doc(firebaseAuth.currentUser?.uid)
        .get();
    Seller? company;
    if (companyData.data() != null) {
      company = Seller.fromMap(companyData.data()!);
    }
    return company;
  }

  Future<Client?> getCurrentClientData() async {
    var userData = await firebaseFirestore
        .collection(FirebaseFields.client)
        .doc(firebaseAuth.currentUser?.uid)
        .get();
    Client? user;
    if (userData.data() != null) {
      user = Client.fromMap(userData.data()!);
    }
    return user;
  }
}
