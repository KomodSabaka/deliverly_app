import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliverly_app/models/company_model.dart';
import 'package:deliverly_app/mobile_layout.dart';
import 'package:deliverly_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  void signCompany(
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
                isUserMode: false,
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

  void signUser({
    required BuildContext context,
    required String phone,
  }) async {
    try {
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phone,
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
                isUserMode: true,
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
          builder: (context) => const MobileLayout(isUserMode: true),
        ),
        (route) => false);
  }

  bool isUserAnonymous()  {
    return  firebaseAuth.currentUser!.isAnonymous;
  }

  void verifyOTP(
      {required BuildContext context,
      required String verificationId,
      required String userOTP,
      required bool isUserMode}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );
      await firebaseAuth.signInWithCredential(credential);

      if (isUserMode) {
        Navigator.pop(context);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MobileLayout(
                isUserMode: isUserMode,
              ),
            ),
            (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future<CompanyModel?> getCurrentCompanyData() async {
    var companyData = await firebaseFirestore
        .collection('company')
        .doc(firebaseAuth.currentUser?.uid)
        .get();
    CompanyModel? company;
    if (companyData.data() != null) {
      company = CompanyModel.fromMap(companyData.data()!);
    }
    return company;
  }

  Future<UserModel?> getCurrentUserData() async {
    var userData = await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser?.uid)
        .get();
    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }
    return user;
  }
}
