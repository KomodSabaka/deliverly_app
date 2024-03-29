import 'package:deliverly_app/common/enums/mode_enum.dart';
import 'package:deliverly_app/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/utils/utils.dart';
import '../../../common/widgets/input_field_widget.dart';
import '../../../generated/l10n.dart';
import '../widgets/auth_background.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _RegistrationSellerPageState();
}

class _RegistrationSellerPageState extends ConsumerState<LoginPage> {
  late TextEditingController _phoneController;

  void _signUp() async {
    if (_phoneController.text.isEmpty) {
      showSnakeBar(context, S.of(context).enter_phone_number);
    } else {
      ref.read(authController).signUp(
            context: context,
            phoneNumber: _phoneController.text,
            mode: ModeEnum.seller,
          );
    }
  }

  @override
  void initState() {
    _phoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.of(context).login,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            InputFieldWidget(
              hintText: S.of(context).enter_phone_number,
              controller: _phoneController,
              keyboardType: TextInputType.number,
              maxLength: 16,
              onChanged: (value) => phoneNumberFormat(
                value: value,
                controller: _phoneController,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: SizedBox(
                    width: 100,
                    child: Text(
                      S.of(context).back,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _signUp,
                  child: SizedBox(
                    width: 100,
                    child: Text(
                      S.of(context).confirm,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
