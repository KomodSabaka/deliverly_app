import 'package:deliverly_app/common/settings/pages/history_page.dart';
import 'package:deliverly_app/models/company_model.dart';
import 'package:deliverly_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../generated/l10n.dart';
import '../../../models/user_model.dart';
import 'info_page.dart';

class SellerSettingPage extends ConsumerWidget {
  final bool isUserMode;
  final CompanyModel? company;
  final UserModel? user;

  const SellerSettingPage({
    Key? key,
    required this.isUserMode,
    this.company,
    this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => InfoPage(
                      isUserMode: isUserMode,
                      company: company,
                      user: user,
                    ),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    isUserMode
                        ? Icons.account_circle
                        : Icons.account_balance_sharp,
                    color: primaryTextColor,
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      isUserMode
                          ? S.of(context).change_information_yourself
                          : S.of(context).editing_store_information,
                    ),
                  ),
                ],
              ),
            ),
            isUserMode
                ? TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HistoryPage(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.history,
                          color: primaryTextColor,
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
