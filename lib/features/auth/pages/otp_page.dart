import 'package:deliverly_app/common/navigation/routes.dart';
import 'package:deliverly_app/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../generated/l10n.dart';
import '../widgets/auth_background.dart';

class OTPPage extends ConsumerStatefulWidget {
  final String verificationId;

  const OTPPage({
    Key? key,
    required this.verificationId,
  }) : super(key: key);

  @override
  ConsumerState<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends ConsumerState<OTPPage> {
  late final TextEditingController otpController;

  void otpSend(String value) async {
    if (value.length == 6) {
      await ref
          .read(authController)
          .verifyOTP(
            verificationId: widget.verificationId,
            userOTP: value,
          )
          .whenComplete(() async {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.storeLayout,
          (route) => false,
        );
      });
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
        child: SingleChildScrollView(
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
      ),
    );
  }
}
