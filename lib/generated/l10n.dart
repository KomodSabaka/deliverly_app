// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Enter phone number`
  String get enter_phone_number {
    return Intl.message(
      'Enter phone number',
      name: 'enter_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Enter the code sent to the specified phone number`
  String get enter_otp {
    return Intl.message(
      'Enter the code sent to the specified phone number',
      name: 'enter_otp',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Select mode`
  String get select_mode {
    return Intl.message(
      'Select mode',
      name: 'select_mode',
      desc: '',
      args: [],
    );
  }

  /// `Customer`
  String get customer {
    return Intl.message(
      'Customer',
      name: 'customer',
      desc: '',
      args: [],
    );
  }

  /// `Seller`
  String get seller {
    return Intl.message(
      'Seller',
      name: 'seller',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for your purchase`
  String get thank_purchase {
    return Intl.message(
      'Thank you for your purchase',
      name: 'thank_purchase',
      desc: '',
      args: [],
    );
  }

  /// `Enter your information`
  String get enter_information {
    return Intl.message(
      'Enter your information',
      name: 'enter_information',
      desc: '',
      args: [],
    );
  }

  /// `Your cart is empty`
  String get cart_empty {
    return Intl.message(
      'Your cart is empty',
      name: 'cart_empty',
      desc: '',
      args: [],
    );
  }

  /// `Pay`
  String get pay {
    return Intl.message(
      'Pay',
      name: 'pay',
      desc: '',
      args: [],
    );
  }

  /// `To Pay`
  String get to_pay {
    return Intl.message(
      'To Pay',
      name: 'to_pay',
      desc: '',
      args: [],
    );
  }

  /// `Added to cart`
  String get added_cart {
    return Intl.message(
      'Added to cart',
      name: 'added_cart',
      desc: '',
      args: [],
    );
  }

  /// `Total cost`
  String get total_cost {
    return Intl.message(
      'Total cost',
      name: 'total_cost',
      desc: '',
      args: [],
    );
  }

  /// `Purchase history`
  String get purchase_history {
    return Intl.message(
      'Purchase history',
      name: 'purchase_history',
      desc: '',
      args: [],
    );
  }

  /// `You haven't ordered anything yet`
  String get you_havent_ordered {
    return Intl.message(
      'You haven\'t ordered anything yet',
      name: 'you_havent_ordered',
      desc: '',
      args: [],
    );
  }

  /// `Enter card number`
  String get enter_num_card {
    return Intl.message(
      'Enter card number',
      name: 'enter_num_card',
      desc: '',
      args: [],
    );
  }

  /// `Enter card name`
  String get enter_name_card {
    return Intl.message(
      'Enter card name',
      name: 'enter_name_card',
      desc: '',
      args: [],
    );
  }

  /// `Enter card date`
  String get enter_date_card {
    return Intl.message(
      'Enter card date',
      name: 'enter_date_card',
      desc: '',
      args: [],
    );
  }

  /// `Enter card RCV`
  String get enter_rcv_card {
    return Intl.message(
      'Enter card RCV',
      name: 'enter_rcv_card',
      desc: '',
      args: [],
    );
  }

  /// `Card saved`
  String get card_saved {
    return Intl.message(
      'Card saved',
      name: 'card_saved',
      desc: '',
      args: [],
    );
  }

  /// `How should we address you`
  String get how_call_you {
    return Intl.message(
      'How should we address you',
      name: 'how_call_you',
      desc: '',
      args: [],
    );
  }

  /// `Add card`
  String get add_card {
    return Intl.message(
      'Add card',
      name: 'add_card',
      desc: '',
      args: [],
    );
  }

  /// `Editing store information`
  String get editing_store_information {
    return Intl.message(
      'Editing store information',
      name: 'editing_store_information',
      desc: '',
      args: [],
    );
  }

  /// `Editing your information`
  String get editing_user_information {
    return Intl.message(
      'Editing your information',
      name: 'editing_user_information',
      desc: '',
      args: [],
    );
  }

  /// `Enter company name`
  String get enter_name_company {
    return Intl.message(
      'Enter company name',
      name: 'enter_name_company',
      desc: '',
      args: [],
    );
  }

  /// `Enter company description`
  String get enter_description_company {
    return Intl.message(
      'Enter company description',
      name: 'enter_description_company',
      desc: '',
      args: [],
    );
  }

  /// `Add card for payment`
  String get add_card_for_payment {
    return Intl.message(
      'Add card for payment',
      name: 'add_card_for_payment',
      desc: '',
      args: [],
    );
  }

  /// `Confirm phone number`
  String get confirm_phone_num {
    return Intl.message(
      'Confirm phone number',
      name: 'confirm_phone_num',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get change {
    return Intl.message(
      'Change',
      name: 'change',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Change your information`
  String get change_information_yourself {
    return Intl.message(
      'Change your information',
      name: 'change_information_yourself',
      desc: '',
      args: [],
    );
  }

  /// `Card number`
  String get num_card {
    return Intl.message(
      'Card number',
      name: 'num_card',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `RCV`
  String get rcv {
    return Intl.message(
      'RCV',
      name: 'rcv',
      desc: '',
      args: [],
    );
  }

  /// `Save card`
  String get save_card {
    return Intl.message(
      'Save card',
      name: 'save_card',
      desc: '',
      args: [],
    );
  }

  /// `Add product image`
  String get add_pic_product {
    return Intl.message(
      'Add product image',
      name: 'add_pic_product',
      desc: '',
      args: [],
    );
  }

  /// `Add product name`
  String get add_name_product {
    return Intl.message(
      'Add product name',
      name: 'add_name_product',
      desc: '',
      args: [],
    );
  }

  /// `Add product description`
  String get add_description_product {
    return Intl.message(
      'Add product description',
      name: 'add_description_product',
      desc: '',
      args: [],
    );
  }

  /// `Add product cost`
  String get add_cost_product {
    return Intl.message(
      'Add product cost',
      name: 'add_cost_product',
      desc: '',
      args: [],
    );
  }

  /// `New product`
  String get new_product {
    return Intl.message(
      'New product',
      name: 'new_product',
      desc: '',
      args: [],
    );
  }

  /// `Enter product name`
  String get enter_name_product {
    return Intl.message(
      'Enter product name',
      name: 'enter_name_product',
      desc: '',
      args: [],
    );
  }

  /// `Enter product description`
  String get enter_description_product {
    return Intl.message(
      'Enter product description',
      name: 'enter_description_product',
      desc: '',
      args: [],
    );
  }

  /// `Enter product cost in rubles`
  String get enter_cost_in_rub {
    return Intl.message(
      'Enter product cost in rubles',
      name: 'enter_cost_in_rub',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Add to basket`
  String get add_to_basket {
    return Intl.message(
      'Add to basket',
      name: 'add_to_basket',
      desc: '',
      args: [],
    );
  }

  /// `Delete product`
  String get delete_product {
    return Intl.message(
      'Delete product',
      name: 'delete_product',
      desc: '',
      args: [],
    );
  }

  /// `Change product`
  String get change_product {
    return Intl.message(
      'Change product',
      name: 'change_product',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get products {
    return Intl.message(
      'Products',
      name: 'products',
      desc: '',
      args: [],
    );
  }

  /// `Your products`
  String get your_products {
    return Intl.message(
      'Your products',
      name: 'your_products',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Enter company name`
  String get enter_company_name {
    return Intl.message(
      'Enter company name',
      name: 'enter_company_name',
      desc: '',
      args: [],
    );
  }

  /// `Enter company description`
  String get enter_company_description {
    return Intl.message(
      'Enter company description',
      name: 'enter_company_description',
      desc: '',
      args: [],
    );
  }

  /// `Add company image`
  String get add_pic_company {
    return Intl.message(
      'Add company image',
      name: 'add_pic_company',
      desc: '',
      args: [],
    );
  }

  /// `Select date`
  String get select_date {
    return Intl.message(
      'Select date',
      name: 'select_date',
      desc: '',
      args: [],
    );
  }

  /// `Select time`
  String get select_time {
    return Intl.message(
      'Select time',
      name: 'select_time',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
