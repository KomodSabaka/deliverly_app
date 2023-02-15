import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../generated/l10n.dart';
import '../../../models/product_model.dart';

class BasketProductCard extends ConsumerStatefulWidget {
  final ProductModel product;
  final Function(ProductModel product) deleteProductFromBasket;

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
                    image: NetworkImage(widget.product.photo),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    widget.product.nameProduct,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    '${widget.product.priceProduct}/руб.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              Column(
                children: [
                  Text('${widget.product.count} шт.'),
                  Text(
                    '${S.of(context).total_cost}\n${widget.product.cost} руб.',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              widget.deleteProductFromBasket(widget.product);
            },
            child: Text(
              S.of(context).delete_product,
            ),
          ),
        ],
      ),
    );
  }
}
