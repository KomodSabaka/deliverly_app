import 'package:deliverly_app/common/navigation/routes.dart';
import 'package:deliverly_app/features/showcase/controllers/showcase_controller.dart';
import 'package:deliverly_app/features/showcase/states/search_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/app_settings/app_settings.dart';
import '../../../generated/l10n.dart';
import '../../../models/product.dart';
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

  void searching() {
    if (_searchController.text.isEmpty) {
      ref.read(searchState.notifier).noSearch();
    } else if (_searchController.text.isNotEmpty) {
      ref.read(searchState.notifier).searching();
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
          stream: ref.watch(searchState)
              ? ref
                  .watch(showCaseController)
                  .searchProduct(text: _searchController.text)
              : ref.watch(showCaseController).getProducts(),
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Padding(
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
                    const SizedBox(height: 12),
                    snapshot.connectionState == ConnectionState.waiting
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : RefreshIndicator(
                            onRefresh: () async {
                              setState(() {});
                            },
                            child: GridView.builder(
                              padding: const EdgeInsets.symmetric(vertical: 42),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 1,
                                maxCrossAxisExtent: 300,
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
                  ],
                ),
              ),
            );
          }),
    );
  }
}
