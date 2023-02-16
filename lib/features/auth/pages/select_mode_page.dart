
import 'package:deliverly_app/mobile_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../generated/l10n.dart';
import '../../basket/repository/basket_state.dart';
import '../widgets/auth_background.dart';
import 'login_page.dart';
import '../repository/auth_repository.dart';

class SelectModePage extends ConsumerStatefulWidget {
  const SelectModePage({Key? key}) : super(key: key);

  @override
  ConsumerState<SelectModePage> createState() => _SelectModePageState();
}

class _SelectModePageState extends ConsumerState<SelectModePage>{
  void _clientSigned() async {
    var client = await ref.read(authRepository).getCurrentClientData();
    if (client == null) {
      ref.read(authRepository).signInAnonymous(context);
    } else {
      ref.read(basketProvider.notifier).getProductsFromDB();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MobileLayout(
              isClientMode: true,
              client: client,
            ),
          ),
          (route) => false);
    }
  }

  void _sellerSigned() async {
    var seller = await ref.read(authRepository).getCurrentSellerData();
    if (seller == null) {
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
              isClientMode: false,
              seller: seller,
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
              onPressed: _clientSigned,
              child: Text(S.of(context).customer),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ButtonStyle(
                fixedSize:
                    MaterialStateProperty.all<Size?>(const Size(374, 56)),
              ),
              onPressed: _sellerSigned,
              child: Text(S.of(context).seller),
            ),
          ],
        ),
      ),
    );
  }
}
