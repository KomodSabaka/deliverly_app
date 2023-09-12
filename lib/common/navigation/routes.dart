import 'package:deliverly_app/features/auth/pages/login_page.dart';
import 'package:deliverly_app/features/auth/pages/otp_page.dart';
import 'package:deliverly_app/features/auth/pages/select_mode_page.dart';
import 'package:deliverly_app/features/settings/pages/client_card_page.dart';
import 'package:deliverly_app/features/settings/pages/history_orders_page.dart';
import 'package:deliverly_app/features/settings/pages/info_page.dart';
import 'package:deliverly_app/features/showcase/pages/create_product_page.dart';
import 'package:deliverly_app/features/showcase/pages/product_page.dart';
import 'package:deliverly_app/store_layout.dart';
import 'package:flutter/material.dart';

import '../../features/splash/pages/splash_page.dart';

class AppRoutes {
  static const splashPage = '/';
  static const selectModePage = '/select_mode_page';
  static const storeLayout = '/store_layout';
  static const loginPage = '/login_page';
  static const otpPage = '/otp_page';
  static const clientCardPage = '/client_card_page';
  static const infoPage = '/info_page';
  static const historyPage = '/history_age';
  static const productPage = '/product_page';
  static const createProductPage = '/create_product_page';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashPage:
        return MaterialPageRoute(
          builder: (context) => const SplashPage(),
        );
      case selectModePage:
        return MaterialPageRoute(
          builder: (context) => const SelectModePage(),
        );
      case storeLayout:
        return MaterialPageRoute(
          builder: (context) => const StoreLayout(),
        );
      case loginPage:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
      case otpPage:
        final arguments = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => OTPPage(
            verificationId: arguments['verificationId'],
          ),
        );
      case clientCardPage:
        final arguments = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => ClientCardPage(
            cardNumberController: arguments['cardNumberController'],
            cardNameController: arguments['cardNameController'],
            cardDateController: arguments['cardDateController'],
            cardRCVController: arguments['cardRCVController'],
            saveCard: arguments['saveCard'],
          ),
        );
      case infoPage:
        return MaterialPageRoute(
          builder: (context) => const InfoPage(),
        );
      case historyPage:
        return MaterialPageRoute(
          builder: (context) => const HistoryOrdersPage(),
        );
      case productPage:
        final arguments = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => ProductPage(
            id: arguments['id'],
            updateLayout: arguments['updateLayout'],
          ),
        );
      case createProductPage:
        final arguments = settings.arguments as Map<String, dynamic>;
        return PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          reverseTransitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) =>
              CreateProductPage(
            product: arguments['product'],
            isRefactoring: arguments['isRefactoring'],
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = const Offset(0.0, 1.0);
            var end = Offset.zero;
            var tween = Tween(begin: begin, end: end);
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('Упс'),
            ),
          ),
        );
    }
  }
}
