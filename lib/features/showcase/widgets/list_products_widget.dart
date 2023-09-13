import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/navigation/routes.dart';
import '../states/showcase_state.dart';
import 'card_product_widget.dart';

class ListProductsWidget extends ConsumerStatefulWidget {
  final ScrollController scrollController;
  final String productSearchText;

  const ListProductsWidget({
    super.key,
    required this.scrollController,
    required this.productSearchText,
  });

  @override
  ConsumerState createState() => _ListProductsWidgetState();
}

class _ListProductsWidgetState extends ConsumerState<ListProductsWidget> {
  void _lookProduct({
    required String id,
  }) {
    Navigator.pushNamed(
      context,
      AppRoutes.productPage,
      arguments: {'id': id},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {},
        child: GridView.builder(
          controller: widget.scrollController,
          padding: const EdgeInsets.symmetric(vertical: 42),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1,
            maxCrossAxisExtent: 300,
          ),
          itemCount: ref.watch(showCaseState).length,
          itemBuilder: (context, index) {
            var product = ref.watch(showCaseState)[index];
            return GestureDetector(
              onTap: () => _lookProduct(id: product.id),
              child: CardProductWidget(
                image: product.image,
                name: product.name,
                price: product.price,
              ),
            );
          },
        ),
      ),
    );
  }
}
