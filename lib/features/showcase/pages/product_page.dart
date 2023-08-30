import 'package:deliverly_app/common/navigation/routes.dart';
import 'package:deliverly_app/features/basket/repository/total_price_state.dart';
import 'package:deliverly_app/features/showcase/controllers/seller_store_controller.dart';
import 'package:deliverly_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/app_settings/app_settings.dart';
import '../../../common/utils/constants.dart';
import '../../../common/utils/utils.dart';
import '../../../common/widgets/back_arrow_widget.dart';
import '../../../generated/l10n.dart';
import '../../basket/repository/basket_state.dart';
import '../repositores/counter_state.dart';

class ProductPage extends ConsumerStatefulWidget {
  final String id;
  final VoidCallback updateLayout;

  const ProductPage({
    Key? key,
    required this.id,
    required this.updateLayout,
  }) : super(key: key);

  @override
  ConsumerState<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends ConsumerState<ProductPage> {
  void _deleteProduct({required String id}) {
    ref.read(sellerStoreController).deleteProduct(productId: id);
    Navigator.pop(context);
  }

  void selectProduct({
    required Product product,
  }) {
    ref.read(basketProvider.notifier).addProduct(
          product: product,
          count: ref.read(counterProvider),
        );
    ref.read(totalPriceProvider.notifier).calculate();
    ref.read(counterProvider.notifier).reset();
    showSnakeBar(context, S.of(context).added_cart);
  }

  void incrementCountProduct() {
    ref.read(counterProvider.notifier).increment();
  }

  void decrementCountProduct() {
    ref.read(counterProvider.notifier).decrement();
  }

  @override
  Widget build(BuildContext context) {
    var isClientMode = ref.watch(appSettingsProvider.notifier).isClientMode;
    return Scaffold(
      body: StreamBuilder<Product>(
          stream: ref
              .read(sellerStoreController)
              .currentProduct(productId: widget.id),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            var product = snapshot.data!;
            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return <Widget>[
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: SliverAppBar(
                      expandedHeight: 400,
                      leading: BackArrowWidget(
                        onPressed: () {
                          isClientMode
                              ? ref.read(counterProvider.notifier).reset()
                              : null;
                          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.storeLayout, (route) => false);
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
                              product.image,
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Text(
                                product.price,
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
                          isClientMode
                              ? Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: decrementCountProduct,
                                          icon: const Icon(Icons.remove),
                                        ),
                                        Container(
                                          width: 100,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: borderColor),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              ref
                                                  .watch(counterProvider)
                                                  .toString(),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: incrementCountProduct,
                                          icon: const Icon(Icons.add),
                                        ),
                                      ],
                                    ),
                                    ElevatedButton(
                                      onPressed: () =>
                                          selectProduct(product: product),
                                      child: Text(S.of(context).add_to_basket),
                                    ),
                                  ],
                                )
                              : Center(
                                  child: Column(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () =>
                                            _deleteProduct(id: product.id),
                                        child:
                                            Text(S.of(context).delete_product),
                                      ),
                                      const SizedBox(height: 16),
                                      ElevatedButton(
                                        onPressed: () => Navigator.pushNamed(
                                          context,
                                          AppRoutes.createProductPage,
                                          arguments: {
                                            'isRefactoring': true,
                                            'product': product,
                                          },
                                        ),
                                        child:
                                            Text(S.of(context).change_product),
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      )),
                ),
              ),
            );
          }),
    );
  }
}
