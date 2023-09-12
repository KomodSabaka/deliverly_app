import 'package:deliverly_app/common/app_settings/app_settings.dart';
import 'package:deliverly_app/common/utils/utils.dart';
import 'package:deliverly_app/models/item_in_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../generated/l10n.dart';

class BasketProductCard extends ConsumerStatefulWidget {
  final ItemInCart product;
  final Function({required String id}) deleteProductFromBasket;

  const BasketProductCard({
    Key? key,
    required this.product,
    required this.deleteProductFromBasket,
  }) : super(key: key);

  @override
  ConsumerState<BasketProductCard> createState() => _BasketProductCardState();
}

class _BasketProductCardState extends ConsumerState<BasketProductCard> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(widget.product.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Flexible(
                child: SizedBox(
                  width: size.width * 0.3,
                  child: Column(
                    children: [
                      Text(
                        widget.product.name,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                      ),
                      Text(
                        '${ref.watch(appSettingsProvider.notifier).calculateInUsersCurrency(costInDollars: widget.product.price).toStringAsFixed(1)} руб.',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Text('${widget.product.count} шт.'),
                  Text(
                    '${S.of(context).total_cost}\n${ref.watch(appSettingsProvider.notifier).calculateInUsersCurrency(costInDollars: widget.product.cost).toStringAsFixed(1)} руб.',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
          TextButton(
            onPressed: () =>
                widget.deleteProductFromBasket(id: widget.product.id),
            child: Text(
              S.of(context).delete_product,
            ),
          ),
        ],
      ),
    );
  }
}
