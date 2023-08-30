import 'package:deliverly_app/common/enums/mode_enum.dart';
import 'package:deliverly_app/features/auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/user.dart';

final authController = Provider<AuthController>((ref) {
  return AuthController(authRepository: ref.watch(authRepository));
});

class AuthController {
  final AuthRepository authRepository;

  const AuthController({
    required this.authRepository,
  });

  void signUp({
    required BuildContext context,
    required String phoneNumber,
    required ModeEnum mode,
  }) {
    switch (mode) {
      case ModeEnum.client:
        authRepository.signClient(context: context, phoneNumber: phoneNumber);
        break;
      case ModeEnum.seller:
        authRepository.signSeller(context: context, phoneNumber: phoneNumber);
        break;
    }
  }

  Future<void> signInAnonymous() async {
    await authRepository.signInAnonymous();
  }

  bool isUserAnonymous() {
    return authRepository.isUserAnonymous();
  }

  Future verifyOTP({
    required String verificationId,
    required String userOTP,
  }) async {
    await authRepository.verifyOTP(
        verificationId: verificationId, userOTP: userOTP);
  }

  Future<AppUser?> getUserData({required ModeEnum mode}) async {
    switch (mode) {
      case ModeEnum.client:
        return await authRepository.getCurrentClientData();
      case ModeEnum.seller:
        return await authRepository.getCurrentSellerData();
    }
  }
}
