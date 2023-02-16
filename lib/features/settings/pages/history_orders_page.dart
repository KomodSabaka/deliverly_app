import 'package:deliverly_app/models/purchase_order.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../common/utils/utils.dart';
import '../../../common/widgets/back_arrow_widget.dart';
import '../../../generated/l10n.dart';
import '../../store/widgets/purchase_widget.dart';
import '../repositores/client_settings_repository.dart';

class HistoryOrdersPage extends ConsumerWidget {
  const HistoryOrdersPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackArrowWidget(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).purchase_history,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Expanded(
              flex: 1,
              child: FutureBuilder<List<PurchaseOrder>>(
                future: ref.watch(clientSettingRepository).getHistory(),
                builder: (context, snapshot) {
                  return snapshot.connectionState == ConnectionState.waiting
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : snapshot.data!.isEmpty
                          ? Center(
                              child: Text(
                                S.of(context).you_havent_ordered,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            )
                          : disableIndicator(
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  var purchase = snapshot.data![index];
                                  return PurchaseWidget(purchase: purchase);
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 8),
                                itemCount: snapshot.data!.length,
                              ),
                            );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
