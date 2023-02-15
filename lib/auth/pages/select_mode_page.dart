import 'package:deliverly_app/auth/widgets/auth_background.dart';
import 'package:deliverly_app/common/basket/repository/basket_state.dart';
import 'package:deliverly_app/mobile_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../generated/l10n.dart';
import 'login_page.dart';
import '../repository/auth_repository.dart';

class SelectModePage extends ConsumerStatefulWidget {
  const SelectModePage({Key? key}) : super(key: key);

  @override
  ConsumerState<SelectModePage> createState() => _SelectModePageState();
}

class _SelectModePageState extends ConsumerState<SelectModePage>{
  void _userSigned() async {
    var user = await ref.read(authRepository).getCurrentUserData();
    if (user == null) {
      ref.read(authRepository).signInAnonymous(context);
    } else {
      ref.read(basketProvider.notifier).getProductsFromDB();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MobileLayout(
              isUserMode: true,
              user: user,
            ),
          ),
          (route) => false);
    }
  }

  void _companySigned() async {
    var company = await ref.read(authRepository).getCurrentCompanyData();
    if (company == null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MobileLayout(
              isUserMode: false,
              company: company,
            ),
          ),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 64.0,
          bottom: 64,
          left: 32,
          right: 32,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.of(context).select_mode,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              style: ButtonStyle(
                fixedSize:
                    MaterialStateProperty.all<Size?>(const Size(374, 56)),
              ),
              onPressed: _userSigned,
              child: Text(S.of(context).customer),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ButtonStyle(
                fixedSize:
                    MaterialStateProperty.all<Size?>(const Size(374, 56)),
              ),
              onPressed: _companySigned,
              child: Text(S.of(context).seller),
            ),
          ],
        ),
      ),
    );
  }
}
