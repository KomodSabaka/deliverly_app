import 'package:deliverly_app/features/store/pages/product_page.dart';
import 'package:deliverly_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/utils/utils.dart';
import '../../../generated/l10n.dart';
import '../widgets/card_product_widget.dart';
import '../widgets/search_input_widget.dart';

class StorePage extends ConsumerStatefulWidget {
  final AsyncSnapshot<List<Product>> snapshot;
  final TextEditingController searchController;
  final bool isClientMode;
  final Function selectProduct;

  const StorePage({
    Key? key,
    required this.snapshot,
    required this.searchController,
    required this.isClientMode,
    required this.selectProduct,
  }) : super(key: key);

  @override
  ConsumerState<StorePage> createState() => _SellerStoresPageState();
}

class _SellerStoresPageState extends ConsumerState<StorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.isClientMode
                  ? S.of(context).products
                  : S.of(context).your_products,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 27),
            SearchInputWidget(
              controller: widget.searchController,
            ),
            Expanded(
              flex: 1,
              child: widget.snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : disableIndicator(
                      child: GridView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 42),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          mainAxisExtent: 211,
                        ),
                        itemCount: widget.snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var product = widget.snapshot.data![index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductPage(
                                    product: product,
                                    isClientMode: widget.isClientMode,
                                    selectProduct: widget.selectProduct,
                                  ),
                                ),
                              );
                            },
                            child: CardProductWidget(
                              image: product.image,
                              name: product.name,
                              price: product.price,
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
