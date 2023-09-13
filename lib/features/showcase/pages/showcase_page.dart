import 'package:deliverly_app/features/showcase/controllers/showcase_controller.dart';
import 'package:deliverly_app/features/showcase/repositores/client_store_repository.dart';
import 'package:deliverly_app/features/showcase/states/products_is_loading_state.dart';
import 'package:deliverly_app/features/showcase/widgets/list_products_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/app_settings/app_settings.dart';
import '../../../generated/l10n.dart';
import '../widgets/search_input_widget.dart';

class ShowcasePage extends ConsumerStatefulWidget {
  const ShowcasePage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ShowcasePage> createState() => _SellerStoresPageState();
}

class _SellerStoresPageState extends ConsumerState<ShowcasePage> {
  late final TextEditingController _searchController;
  late final ScrollController _scrollController;

  void searching() {
    if (_searchController.text.isEmpty) {
      ref.read(showCaseController).getProducts();
    } else if (_searchController.text.isNotEmpty) {
      ref.read(showCaseController).searchProduct(text: _searchController.text);
    }
  }

  void _loadMore() {
    ref.read(clientStoreRepository).loadMoreProducts();
  }

  @override
  void initState() {
    _searchController = TextEditingController();
    _searchController.addListener(searching);
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMore();
      }
    });
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
      body: Padding(
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
            ListProductsWidget(
              scrollController: _scrollController,
              productSearchText: _searchController.text,
            ),
            if (ref.watch(productsIsLoadingState))
              const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
