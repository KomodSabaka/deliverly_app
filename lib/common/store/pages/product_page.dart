import 'package:deliverly_app/models/product_model.dart';
import 'package:deliverly_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../generated/l10n.dart';
import '../../../utils/colors.dart';
import '../repositores/counter_state.dart';
import '../repositores/seller_store_repository.dart';
import 'add_product_page.dart';

class ProductPage extends ConsumerStatefulWidget {
  final ProductModel product;
  final bool isUserMode;
  final Function selectProduct;

  const ProductPage({
    Key? key,
    required this.product,
    required this.isUserMode,
    required this.selectProduct,
  }) : super(key: key);

  @override
  ConsumerState<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends ConsumerState<ProductPage> {
  void _deleteProduct() {
    ref.read(sellerStoreRepository).deleteProduct(context, widget.product);
  }

  void incrementCountProduct() {
    ref.read(counterProvider.notifier).increment();
  }

  void decrementCountProduct() {
    ref.read(counterProvider.notifier).decrement();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                expandedHeight: 400,
                leading: IconButton(
                  icon: SvgPicture.asset('assets/icons/arrow_back.svg'),
                  onPressed: () {
                    ref.read(counterProvider.notifier).reset();
                    Navigator.pop(context);
                  },
                ),
                flexibleSpace: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Image.network(
                        widget.product.photo,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: -1,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 30,
                        decoration: const BoxDecoration(
                          color: backdropColor,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: disableIndicator(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 37,
              ),
              child: StreamBuilder<ProductModel>(
                stream: ref
                    .read(sellerStoreRepository)
                    .currentProduct(widget.product.id),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const CircularProgressIndicator();
                  }
                  var product = snapshot.data!;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.nameProduct,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            product.priceProduct,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            ' руб.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontSize: 24),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Text(
                        product.description,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 32),
                      widget.isUserMode
                          ? Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: decrementCountProduct,
                                      icon: const Icon(Icons.remove),
                                    ),
                                    Container(
                                      width: 100,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: borderColor),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(ref
                                            .watch(counterProvider)
                                            .toString()),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: incrementCountProduct,
                                      icon: const Icon(Icons.add),
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    widget.selectProduct(widget.product);
                                  },
                                  child: Text(S.of(context).add_to_basket),
                                ),
                              ],
                            )
                          : Center(
                              child: Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: _deleteProduct,
                                    child: Text(S.of(context).delete_product),
                                  ),
                                  const SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AddProductPage(
                                            isRefactoring: true,
                                            product: product,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(S.of(context).change_product),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
