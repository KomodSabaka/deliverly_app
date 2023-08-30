import 'package:deliverly_app/common/navigation/routes.dart';
import 'package:deliverly_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'common/app_settings/app_settings.dart';
import 'common/utils/constants.dart';
import 'common/utils/utils.dart';
import 'features/basket/pages/basket_page.dart';
import 'features/basket/repository/basket_state.dart';
import 'features/settings/pages/settings_page.dart';
import 'features/showcase/pages/showcase_page.dart';
import 'features/showcase/widgets/client_bottom_bar.dart';
import 'features/showcase/widgets/seller_bottom_bar.dart';
import 'generated/l10n.dart';

class StoreLayout extends ConsumerStatefulWidget {
  const StoreLayout({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<StoreLayout> createState() => _StoreLayoutState();
}

class _StoreLayoutState extends ConsumerState<StoreLayout> {
  late final PageController _pageController;
  int currentIndex = 0;

  void setIndex({
    required int index,
  }) {
    setState(() => currentIndex = index);
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
  }

  void _haveSellerData() {
    var user = ref.watch(appSettingsProvider).user;
    if (user == null && user is Seller) {
      showSnakeBar(context, S.of(context).enter_description_company);
    } else {
      Navigator.pushNamed(context, AppRoutes.createProductPage);
    }
  }

  void _getProductsFromDB() async {
    var isClientMode = ref.watch(appSettingsProvider.notifier).isClientMode;
    if (isClientMode) {
      await ref.read(basketProvider.notifier).getProductsFromDB();
    }
  }

  void _updateLayout() {
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    _getProductsFromDB();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var isClientMode = ref.watch(appSettingsProvider.notifier).isClientMode;
    return Scaffold(
      body: SafeArea(
        child: disableIndicator(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => currentIndex = index);
            },
            children: [
              ShowcasePage(updateLayout: _updateLayout),
              isClientMode ? const BasketPage() : const SettingPage(),
              const SettingPage(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: isClientMode
          ? ClientBottomBar(
              currentIndex: currentIndex,
              basketLength: ref.watch(basketProvider).length,
              setIndex: (index) => setIndex(index: index),
            )
          : SellerBottomBar(
              currentIndex: currentIndex,
              setIndex: (index) => setIndex(index: index),
            ),
      floatingActionButton: isClientMode
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
