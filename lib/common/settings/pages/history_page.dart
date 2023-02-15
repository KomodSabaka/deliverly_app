import 'package:deliverly_app/common/settings/repositores/user_settings_repository.dart';
import 'package:deliverly_app/common/store/widgets/purchase_widget.dart';
import 'package:deliverly_app/models/purchase_model.dart';
import 'package:deliverly_app/utils/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../generated/l10n.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/arrow_back.svg'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
              child: FutureBuilder<List<PurchaseModel>>(
                future: ref.watch(userSettingRepository).getHistory(),
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
