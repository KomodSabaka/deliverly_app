
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/utils/constants.dart';
import '../../../common/utils/utils.dart';
import '../../../generated/l10n.dart';
import '../../../models/product.dart';
import '../../../models/client.dart';
import '../repository/basket_state.dart';
import '../widgets/basket_product_card.dart';

class BasketPage extends ConsumerStatefulWidget {
  final Client? client;

  const BasketPage({
    Key? key,
    required this.client,
  }) : super(key: key);

  @override
  ConsumerState createState() => _BasketPageState();
}

class _BasketPageState extends ConsumerState<BasketPage> {
  int cost = 0;

  int getSum() {
    int sum = 0;
    if (ref.read(basketProvider).isEmpty) {
      return sum;
    } else {
      for (var product in ref.read(basketProvider)) {
        sum += int.parse(product.cost);
      }
      return sum;
    }
  }

  void buyProducts() async {
    if (widget.client != null) {
      if (ref.read(basketProvider).isNotEmpty) {
        ref.read(basketProvider.notifier).buyProducts();
        setState(() {
          cost = 0;
        });
        showSnakeBar(context, S.of(context).thank_purchase);
      }
    } else {
      showSnakeBar(context, S.of(context).enter_information);
    }
  }

  void _deleteProductFromBasket(Product product) {
    ref.read(basketProvider.notifier).deleteProductFromBasket(product);
    setState(() {
      cost = getSum();
    });
  }

  @override
  void initState() {
    cost = getSum();
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
          : disableIndicator(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: ref.read(basketProvider).length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 24),
                itemBuilder: (context, index) {
                  var product = ref.read(basketProvider)[index];
                  return BasketProductCard(
                    product: product,
                    key: UniqueKey(),
                    deleteProductFromBasket: _deleteProductFromBasket,
                  );
                },
              ),
            ),
      bottomNavigationBar: cost == 0
          ? null
          : Container(
              height: 50,
              width: double.infinity,
              decoration:  const BoxDecoration(
                border: Border(
                  top: BorderSide(color: borderColor),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('${S.of(context).to_pay} $cost руб.'),
                  ElevatedButton(
                    onPressed: buyProducts,
                    child: Text(S.of(context).pay),
                  ),
                ],
              ),
            ),
    );
  }
}
