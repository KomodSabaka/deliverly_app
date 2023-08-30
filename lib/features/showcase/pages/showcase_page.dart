import 'package:deliverly_app/common/navigation/routes.dart';
import 'package:deliverly_app/features/showcase/controllers/client_store_controller.dart';
import 'package:deliverly_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/app_settings/app_settings.dart';
import '../../../common/utils/utils.dart';
import '../../../generated/l10n.dart';
import '../controllers/seller_store_controller.dart';
import '../widgets/card_product_widget.dart';
import '../widgets/search_input_widget.dart';

class ShowcasePage extends ConsumerStatefulWidget {
  final VoidCallback updateLayout;

  const ShowcasePage({
    Key? key,
    required this.updateLayout,
  }) : super(key: key);

  @override
  ConsumerState<ShowcasePage> createState() => _SellerStoresPageState();
}

class _SellerStoresPageState extends ConsumerState<ShowcasePage> {
  late final TextEditingController _searchController;
  bool _isSearching = false;

  void searching() {
    if (_searchController.text.isEmpty) {
      setState(() => _isSearching = false);
    } else if (_searchController.text.isNotEmpty) {
      setState(() => _isSearching = true);
    }
  }

  void _lookProduct({
    required String id,
  }) {
    Navigator.pushNamed(
      context,
      AppRoutes.productPage,
      arguments: {
        'id': id,
        'updateLayout': widget.updateLayout,
      },
    );
  }

  @override
  void initState() {
    _searchController = TextEditingController();
    _searchController.addListener(searching);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var isClientMode = ref.watch(appSettingsProvider.notifier).isClientMode;
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<List<Product>>(
          stream: isClientMode
              ? _isSearching
              ? ref
              .watch(clientStoreController)
              .searchProducts(text: _searchController.text)
              : ref.watch(clientStoreController).getProducts()
              : _isSearching
              ? ref
              .watch(sellerStoreController)
              .searchProduct(text: _searchController.text)
              : ref.watch(sellerStoreController).getProductsCompany(),
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isClientMode
                      ? S.of(context).products
                      : S.of(context).your_products,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 27),
                SearchInputWidget(
                  controller: _searchController,
                ),
                Expanded(
                  flex: 1,
                  child: snapshot.connectionState == ConnectionState.waiting
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : disableIndicator(
                          child: GridView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 42),
                            shrinkWrap: true,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: MediaQuery.of(context).size.width /
                                  (MediaQuery.of(context).size.height / 1.5),
                            ),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              var product = snapshot.data![index];
                              return InkWell(
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
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
