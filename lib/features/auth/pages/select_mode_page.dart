import 'package:deliverly_app/common/enums/mode_enum.dart';
import 'package:deliverly_app/common/navigation/routes.dart';
import 'package:deliverly_app/common/app_settings/app_settings.dart';
import 'package:deliverly_app/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../generated/l10n.dart';
import '../widgets/auth_background.dart';

class SelectModePage extends ConsumerStatefulWidget {
  const SelectModePage({Key? key}) : super(key: key);

  @override
  ConsumerState<SelectModePage> createState() => _SelectModePageState();
}

class _SelectModePageState extends ConsumerState<SelectModePage> {
  void _clientSigned() async {
    ref.read(appSettingsProvider.notifier).setMode(mode: ModeEnum.client);
    var client = await ref.read(authController).getUserData(mode: ModeEnum.client);
    if (client == null) {
      await ref.read(authController).signInAnonymous();
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.storeLayout,
        (route) => false,
      );
    } else {
      ref.read(appSettingsProvider.notifier).setUser(user: client);
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.storeLayout,
        (route) => false,
      );
    }
  }

  void _sellerSigned() async {
    ref.read(appSettingsProvider.notifier).setMode(mode: ModeEnum.seller);
    var seller = await ref.read(authController).getUserData(mode: ModeEnum.seller);
    if (seller == null) {
      if (!mounted) return;
      Navigator.pushNamed(context, AppRoutes.loginPage);
    } else {
      ref.read(appSettingsProvider.notifier).setUser(user: seller);
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.storeLayout,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
            SizedBox.fromSize(
              size: Size(size.width * 0.9, size.height * 0.07),
              child: ElevatedButton(
                onPressed: _clientSigned,
                child: Text(S.of(context).customer),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox.fromSize(
              size: Size(size.width * 0.9, size.height * 0.07),
              child: ElevatedButton(
                onPressed: _sellerSigned,
                child: Text(S.of(context).seller),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
