import 'package:deliverly_app/models/seller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/utils/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/client.dart';
import 'history_orders_page.dart';
import 'info_page.dart';

class SellerSettingPage extends ConsumerWidget {
  final bool isClientMode;
  final Seller? seller;
  final Client? client;

  const SellerSettingPage({
    Key? key,
    required this.isClientMode,
    this.seller,
    this.client,
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
                      isClientMode: isClientMode,
                      seller: seller,
                      client: client,
                    ),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    isClientMode
                        ? Icons.account_circle
                        : Icons.account_balance_sharp,
                    color: primaryTextColor,
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HistoryOrdersPage(),
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
