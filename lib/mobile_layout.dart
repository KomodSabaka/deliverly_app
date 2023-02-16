import 'package:deliverly_app/models/seller.dart';
import 'package:deliverly_app/models/client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'common/utils/constants.dart';
import 'common/utils/utils.dart';
import 'features/basket/pages/basket_page.dart';
import 'features/basket/repository/basket_state.dart';
import 'features/settings/pages/settings_page.dart';
import 'features/store/pages/add_product_page.dart';
import 'features/store/pages/store_page.dart';
import 'features/store/repositores/counter_state.dart';
import 'features/store/repositores/seller_store_repository.dart';
import 'features/store/repositores/user_store_repository.dart';
import 'features/store/widgets/client_bottom_bar.dart';
import 'features/store/widgets/seller_bottom_bar.dart';
import 'generated/l10n.dart';
import 'models/product.dart';

class MobileLayout extends ConsumerStatefulWidget {
  final bool isClientMode;
  final Seller? seller;
  final Client? client;

  const MobileLayout({
    Key? key,
    required this.isClientMode,
    this.seller,
    this.client,
  }) : super(key: key);

  @override
  ConsumerState<MobileLayout> createState() => _StoreLayoutState();
}

class _StoreLayoutState extends ConsumerState<MobileLayout> {
  late final TextEditingController _searchController;
  late final PageController _pageController;
  int currentIndex = 0;
  bool isSearching = false;

  void setIndex(int index) {
    setState(() => currentIndex = index);
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
  }

  void searching() {
    if (_searchController.text.isEmpty) {
      setState(() => isSearching = false);
    } else if (_searchController.text.isNotEmpty) {
      setState(() => isSearching = true);
    }
  }

  void _haveSellerData() {
    if (widget.seller == null) {
      showSnakeBar(context, S.of(context).enter_description_company);
    } else {
      Navigator.of(context)
          .push(createRoute(const AddProductPage(isRefactoring: false)));
    }
  }

  void _getProductsFromDB() {
    if (widget.isClientMode == true && widget.client == null) {
      ref.read(basketProvider.notifier).getProductsFromDB();
    }
  }

  void selectProduct(Product product) {
    ref.read(basketProvider.notifier).addProduct(
          context,
          product,
          ref.read(counterProvider),
        );
    ref.read(counterProvider.notifier).reset();
    setState(() {});
  }

  @override
  void initState() {
    _getProductsFromDB();
    _searchController = TextEditingController();
    _pageController = PageController();
    _searchController.addListener(searching);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: disableIndicator(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => currentIndex = index);
          },
          children: [
            StreamBuilder<List<Product>>(
              stream: widget.isClientMode
                  ? isSearching
                      ? ref
                          .watch(userRepository)
                          .searchProducts(_searchController.text)
                      : ref.watch(userRepository).getProducts()
                  : isSearching
                      ? ref
                          .watch(sellerStoreRepository)
                          .searchProduct(_searchController.text)
                      : ref.watch(sellerStoreRepository).getProductsCompany(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Product>> snapshot) {
                return StorePage(
                  snapshot: snapshot,
                  searchController: _searchController,
                  isClientMode: widget.isClientMode,
                  selectProduct: selectProduct,
                );
              },
            ),
            widget.isClientMode
                ? BasketPage(client: widget.client)
                : SellerSettingPage(
                    isClientMode: widget.isClientMode,
                    client: widget.client,
                    seller: widget.seller,
                  ),
            SellerSettingPage(
              isClientMode: widget.isClientMode,
              client: widget.client,
              seller: widget.seller,
            ),
          ],
        ),
      ),
      bottomNavigationBar: widget.isClientMode
          ? ClientBottomBar(
              currentIndex: currentIndex,
              basketLength: ref.watch(basketProvider).length,
              setIndex: (index) => setIndex(index),
            )
          : SellerBottomBar(
              currentIndex: currentIndex,
              setIndex: (index) => setIndex(index),
            ),
      floatingActionButton: widget.isClientMode
          ? null
          : currentIndex == 0
              ? FloatingActionButton(
                  backgroundColor: backgroundColorSelectModePage,
                  onPressed: _haveSellerData,
                  child: const Icon(Icons.add),
                )
              : null,
    );
  }
}
