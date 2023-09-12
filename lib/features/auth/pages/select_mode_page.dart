import 'package:deliverly_app/common/enums/mode_enum.dart';
import 'package:deliverly_app/common/navigation/routes.dart';
import 'package:deliverly_app/common/app_settings/app_settings.dart';
import 'package:deliverly_app/features/auth/controller/auth_controller.dart';
import 'package:deliverly_app/features/auth/widgets/mode_selection_buttons.dart';
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
    await ref
        .read(authController)
        .getUserData(mode: ModeEnum.client)
        .then((value) async {
      if (value == null) {
        await ref.read(authController).signInAnonymous().whenComplete(
              () => Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.storeLayout,
                (route) => false,
              ),
            );
      } else {
        print(ref.watch(appSettingsProvider).currentExchangeRate);
        ref.read(appSettingsProvider.notifier).setUser(user: value);
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.storeLayout,
          (route) => false,
        );
      }
    });
  }

  void _sellerSigned() async {
    ref.read(appSettingsProvider.notifier).setMode(mode: ModeEnum.seller);
    await ref
        .read(authController)
        .getUserData(mode: ModeEnum.seller)
        .then((value) {
      if (value == null) {
        Navigator.pushNamed(context, AppRoutes.loginPage);
      } else {
        ref.read(appSettingsProvider.notifier).setUser(user: value);
        print(ref.read(appSettingsProvider).user);
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.storeLayout,
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 64.0,
          horizontal: 32,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                S.of(context).select_mode,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 48),
              ModeSelectionButtons(
                ifPressedClient: _clientSigned,
                ifPressedSeller: _sellerSigned,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
