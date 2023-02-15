import 'package:deliverly_app/auth/widgets/auth_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../generated/l10n.dart';
import '../repository/auth_repository.dart';

class OTPPage extends ConsumerStatefulWidget {
  final String verificationId;
  final bool isUserMode;

  const OTPPage({
    Key? key,
    required this.verificationId,
    required this.isUserMode,
  }) : super(key: key);

  @override
  ConsumerState<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends ConsumerState<OTPPage>{
  late final TextEditingController otpController;

  void otpSend(String value) {
    if (value.length == 6) {
      ref.read(authRepository).verifyOTP(
            context: context,
            verificationId: widget.verificationId,
            userOTP: value,
            isUserMode: widget.isUserMode,
          );
    }
  }

  @override
  void initState() {
    otpController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.of(context).enter_otp,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 56),
            PinCodeTextField(
              appContext: context,
              length: 6,
              controller: otpController,
              keyboardType: TextInputType.number,
              autoDisposeControllers: false,
              onChanged: (String value) => otpSend(value),
            ),
          ],
        ),
      ),
    );
  }
}
