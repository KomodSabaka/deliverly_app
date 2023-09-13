import 'package:deliverly_app/common/app_settings/app_settings.dart';
import 'package:deliverly_app/common/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/constants/app_palette.dart';
import '../../../generated/l10n.dart';

class SettingPage extends ConsumerStatefulWidget {
  const SettingPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _SellerSettingPageState();
}

class _SellerSettingPageState extends ConsumerState<SettingPage> {
  @override
  Widget build(BuildContext context) {
    var isClientMode = ref.watch(appSettingsProvider.notifier).isClientMode;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).settings,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 27),
            TextButton(
              onPressed: () async {
                Navigator.pushNamed(
                  context,
                  AppRoutes.infoPage,
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    isClientMode
                        ? Icons.account_circle
                        : Icons.account_balance_sharp,
                    color: AppPalette.primaryTextColor,
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      isClientMode
                          ? S.of(context).change_information_yourself
                          : S.of(context).editing_store_information,
                    ),
                  ),
                ],
              ),
            ),
            isClientMode
                ? TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.historyPage,
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.history,
                          color: AppPalette.primaryTextColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          S.of(context).purchase_history,
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
