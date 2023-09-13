import 'package:deliverly_app/common/app_settings/app_settings.dart';
import 'package:deliverly_app/features/basket/pages/checkout_page.dart';
import 'package:deliverly_app/features/basket/states/total_price_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/constants/app_palette.dart';
import '../../../common/utils/utils.dart';
import '../../../generated/l10n.dart';
import '../states/basket_state.dart';
import '../widgets/basket_product_card.dart';

class BasketPage extends ConsumerStatefulWidget {
  const BasketPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _BasketPageState();
}

class _BasketPageState extends ConsumerState<BasketPage> {
  void buyProducts() async {
    if (ref.watch(appSettingsProvider).user == null) {
      showSnakeBar(context, S.of(context).enter_information);
      return;
    }

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CheckoutPage()));
  }

  void _deleteProductFromBasket({required String id}) async {
    await ref
        .read(basketProvider.notifier)
        .deleteProductFromBasket(id: id)
        .whenComplete(
          () => _getSum(),
        );
  }

  void _getSum() {
    ref.read(totalPriceProvider.notifier).calculate();
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      _getSum();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ref.watch(basketProvider).isEmpty
          ? Center(
              child: Text(
                S.of(context).cart_empty,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            )
          : ListView.separated(
                shrinkWrap: true,
                itemCount: ref.read(basketProvider).length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 24),
                itemBuilder: (context, index) {
                  var product = ref.read(basketProvider)[index];
                  return BasketProductCard(
                    product: product,
                    deleteProductFromBasket: _deleteProductFromBasket,
                    key: UniqueKey(),
                  );
                },
              ),
      bottomNavigationBar: ref.watch(basketProvider).isEmpty
          ? null
          : Container(
              height: 50,
              width: double.infinity,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppPalette.borderColor),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    flex: 1,
                    child: Text(
                      '${S.of(context).to_pay} ${ref.watch(totalPriceProvider).toStringAsFixed(1)} руб.',
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => buyProducts(),
                    child: const Text(
                      'Delivery clearance',
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
