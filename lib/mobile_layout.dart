import 'package:deliverly_app/models/company_model.dart';
import 'package:deliverly_app/models/user_model.dart';
import 'package:deliverly_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'common/basket/pages/basket_page.dart';
import 'common/basket/repository/basket_state.dart';
import 'common/settings/pages/settings_page.dart';
import 'common/store/pages/add_product_page.dart';
import 'common/store/pages/store_page.dart';
import 'common/store/repositores/counter_state.dart';
import 'common/store/repositores/seller_store_repository.dart';
import 'common/store/repositores/user_store_repository.dart';
import 'common/store/widgets/seller_bottom_bar.dart';
import 'common/store/widgets/user_bottom_bar.dart';
import 'models/product_model.dart';
import 'utils/colors.dart';

class MobileLayout extends ConsumerStatefulWidget {
  final bool isUserMode;
  final CompanyModel? company;
  final UserModel? user;

  const MobileLayout({
    Key? key,
    required this.isUserMode,
    this.company,
    this.user,
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

  void _haveCompanyData() {
    if (widget.company == null) {
      showSnakeBar(context, 'Введите информацию о магазине');
    } else {
      Navigator.of(context)
          .push(createRoute(const AddProductPage(isRefactoring: false)));
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const AddProductPage(isRefactoring: false),
      //   ),
      // );
    }
  }

  void _getProductsFromDB() {
    if (widget.isUserMode == true && widget.user == null) {
      ref.read(basketProvider.notifier).getProductsFromDB();
    }
  }

  void selectProduct(ProductModel product) {
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
            StreamBuilder<List<ProductModel>>(
              stream: widget.isUserMode
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
                  AsyncSnapshot<List<ProductModel>> snapshot) {
                return StorePage(
                  snapshot: snapshot,
                  searchController: _searchController,
                  isUserMode: widget.isUserMode,
                  selectProduct: selectProduct,
                );
              },
            ),
            widget.isUserMode
                ? BasketPage(user: widget.user)
                : SellerSettingPage(
                    isUserMode: widget.isUserMode,
                    user: widget.user,
                    company: widget.company,
                  ),
            SellerSettingPage(
              isUserMode: widget.isUserMode,
              user: widget.user,
              company: widget.company,
            ),
          ],
        ),
      ),
      bottomNavigationBar: widget.isUserMode
          ? UserBottomBar(
              currentIndex: currentIndex,
              basketLength: ref.watch(basketProvider).length,
              setIndex: (index) => setIndex(index),
            )
          : SellerBottomBar(
              currentIndex: currentIndex,
              setIndex: (index) => setIndex(index),
            ),
      floatingActionButton: widget.isUserMode
          ? null
          : currentIndex == 0
              ? FloatingActionButton(
                  backgroundColor: backgroundColorSelectModePage,
                  onPressed: _haveCompanyData,
                  child: const Icon(Icons.add),
                )
              : null,
    );
  }
}
