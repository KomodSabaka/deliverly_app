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

  /// `Введите номер телефона`
  String get enter_phone_number {
    return Intl.message(
      'Введите номер телефона',
      name: 'enter_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Введите код отправленный на указаный номер телефона`
  String get enter_otp {
    return Intl.message(
      'Введите код отправленный на указаный номер телефона',
      name: 'enter_otp',
      desc: '',
      args: [],
    );
  }

  /// `Логин`
  String get login {
    return Intl.message(
      'Логин',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Назад`
  String get back {
    return Intl.message(
      'Назад',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Подтвердить`
  String get confirm {
    return Intl.message(
      'Подтвердить',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Выберите режим`
  String get select_mode {
    return Intl.message(
      'Выберите режим',
      name: 'select_mode',
      desc: '',
      args: [],
    );
  }

  /// `Покупатель`
  String get customer {
    return Intl.message(
      'Покупатель',
      name: 'customer',
      desc: '',
      args: [],
    );
  }

  /// `Продавец`
  String get seller {
    return Intl.message(
      'Продавец',
      name: 'seller',
      desc: '',
      args: [],
    );
  }

  /// `Спасибо за покупку`
  String get thank_purchase {
    return Intl.message(
      'Спасибо за покупку',
      name: 'thank_purchase',
      desc: '',
      args: [],
    );
  }

  /// `Введите данные о себе`
  String get enter_information {
    return Intl.message(
      'Введите данные о себе',
      name: 'enter_information',
      desc: '',
      args: [],
    );
  }

  /// `Ваша корзина пуста`
  String get cart_empty {
    return Intl.message(
      'Ваша корзина пуста',
      name: 'cart_empty',
      desc: '',
      args: [],
    );
  }

  /// `Оплатить,`
  String get pay {
    return Intl.message(
      'Оплатить,',
      name: 'pay',
      desc: '',
      args: [],
    );
  }

  /// `К оплате`
  String get to_pay {
    return Intl.message(
      'К оплате',
      name: 'to_pay',
      desc: '',
      args: [],
    );
  }

  /// `Добавлено в карзину`
  String get added_cart {
    return Intl.message(
      'Добавлено в карзину',
      name: 'added_cart',
      desc: '',
      args: [],
    );
  }

  /// `Общая стоимость`
  String get total_cost {
    return Intl.message(
      'Общая стоимость',
      name: 'total_cost',
      desc: '',
      args: [],
    );
  }

  /// `История покупок`
  String get purchase_history {
    return Intl.message(
      'История покупок',
      name: 'purchase_history',
      desc: '',
      args: [],
    );
  }

  /// `Вы ничего еще\nне заказывали`
  String get you_havent_ordered {
    return Intl.message(
      'Вы ничего еще\nне заказывали',
      name: 'you_havent_ordered',
      desc: '',
      args: [],
    );
  }

  /// `Введите номер карты`
  String get enter_num_card {
    return Intl.message(
      'Введите номер карты',
      name: 'enter_num_card',
      desc: '',
      args: [],
    );
  }

  /// `Введите имя карты`
  String get enter_name_card {
    return Intl.message(
      'Введите имя карты',
      name: 'enter_name_card',
      desc: '',
      args: [],
    );
  }

  /// `Введите дату карты`
  String get enter_date_card {
    return Intl.message(
      'Введите дату карты',
      name: 'enter_date_card',
      desc: '',
      args: [],
    );
  }

  /// `Введите RCV карты`
  String get enter_rcv_card {
    return Intl.message(
      'Введите RCV карты',
      name: 'enter_rcv_card',
      desc: '',
      args: [],
    );
  }

  /// `Карта сохранена`
  String get card_saved {
    return Intl.message(
      'Карта сохранена',
      name: 'card_saved',
      desc: '',
      args: [],
    );
  }

  /// `Как к вам обращаться`
  String get how_call_you {
    return Intl.message(
      'Как к вам обращаться',
      name: 'how_call_you',
      desc: '',
      args: [],
    );
  }

  /// `Добавьте карту`
  String get add_card {
    return Intl.message(
      'Добавьте карту',
      name: 'add_card',
      desc: '',
      args: [],
    );
  }

  /// `Редактирование информации о магазине`
  String get editing_store_information {
    return Intl.message(
      'Редактирование информации о магазине',
      name: 'editing_store_information',
      desc: '',
      args: [],
    );
  }

  /// `Редактирование информации о себе`
  String get editing_user_information {
    return Intl.message(
      'Редактирование информации о себе',
      name: 'editing_user_information',
      desc: '',
      args: [],
    );
  }

  /// `Введите имя компании`
  String get enter_name_company {
    return Intl.message(
      'Введите имя компании',
      name: 'enter_name_company',
      desc: '',
      args: [],
    );
  }

  /// `Введите описание компании`
  String get enter_description_company {
    return Intl.message(
      'Введите описание компании',
      name: 'enter_description_company',
      desc: '',
      args: [],
    );
  }

  /// `Добавить карту для оплаты`
  String get add_card_for_payment {
    return Intl.message(
      'Добавить карту для оплаты',
      name: 'add_card_for_payment',
      desc: '',
      args: [],
    );
  }

  /// `Подтвердить номер телефона`
  String get confirm_phone_num {
    return Intl.message(
      'Подтвердить номер телефона',
      name: 'confirm_phone_num',
      desc: '',
      args: [],
    );
  }

  /// `Изменить`
  String get change {
    return Intl.message(
      'Изменить',
      name: 'change',
      desc: '',
      args: [],
    );
  }

  /// `Настройки`
  String get settings {
    return Intl.message(
      'Настройки',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Изменить информацию о себе`
  String get change_information_yourself {
    return Intl.message(
      'Изменить информацию о себе',
      name: 'change_information_yourself',
      desc: '',
      args: [],
    );
  }

  /// `Номер карты`
  String get num_card {
    return Intl.message(
      'Номер карты',
      name: 'num_card',
      desc: '',
      args: [],
    );
  }

  /// `Имя`
  String get name {
    return Intl.message(
      'Имя',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Дата`
  String get date {
    return Intl.message(
      'Дата',
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

  /// `Сохранить карту`
  String get save_card {
    return Intl.message(
      'Сохранить карту',
      name: 'save_card',
      desc: '',
      args: [],
    );
  }

  /// `Добавте изображение продукта`
  String get add_pic_product {
    return Intl.message(
      'Добавте изображение продукта',
      name: 'add_pic_product',
      desc: '',
      args: [],
    );
  }

  /// `Добавте имя продукта`
  String get add_name_product {
    return Intl.message(
      'Добавте имя продукта',
      name: 'add_name_product',
      desc: '',
      args: [],
    );
  }

  /// `Добавте описание продукта`
  String get add_description_product {
    return Intl.message(
      'Добавте описание продукта',
      name: 'add_description_product',
      desc: '',
      args: [],
    );
  }

  /// `Добавте стоимость продукта`
  String get add_cost_product {
    return Intl.message(
      'Добавте стоимость продукта',
      name: 'add_cost_product',
      desc: '',
      args: [],
    );
  }

  /// `Новый продукт`
  String get new_product {
    return Intl.message(
      'Новый продукт',
      name: 'new_product',
      desc: '',
      args: [],
    );
  }

  /// `Введите название продукта`
  String get enter_name_product {
    return Intl.message(
      'Введите название продукта',
      name: 'enter_name_product',
      desc: '',
      args: [],
    );
  }

  /// `Введите описание продукта`
  String get enter_description_product {
    return Intl.message(
      'Введите описание продукта',
      name: 'enter_description_product',
      desc: '',
      args: [],
    );
  }

  /// `Введите стоимость продукта в рублях`
  String get enter_cost_in_rub {
    return Intl.message(
      'Введите стоимость продукта в рублях',
      name: 'enter_cost_in_rub',
      desc: '',
      args: [],
    );
  }

  /// `Добавть`
  String get add {
    return Intl.message(
      'Добавть',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Добавить в корзину`
  String get add_to_basket {
    return Intl.message(
      'Добавить в корзину',
      name: 'add_to_basket',
      desc: '',
      args: [],
    );
  }

  /// `Удалить товар`
  String get delete_product {
    return Intl.message(
      'Удалить товар',
      name: 'delete_product',
      desc: '',
      args: [],
    );
  }

  /// `Изменить товар`
  String get change_product {
    return Intl.message(
      'Изменить товар',
      name: 'change_product',
      desc: '',
      args: [],
    );
  }

  /// `Продукты`
  String get products {
    return Intl.message(
      'Продукты',
      name: 'products',
      desc: '',
      args: [],
    );
  }

  /// `Ваши продукты`
  String get your_products {
    return Intl.message(
      'Ваши продукты',
      name: 'your_products',
      desc: '',
      args: [],
    );
  }

  /// `Поиск`
  String get search {
    return Intl.message(
      'Поиск',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Введите название компании`
  String get enter_company_name {
    return Intl.message(
      'Введите название компании',
      name: 'enter_company_name',
      desc: '',
      args: [],
    );
  }

  /// `Введите описание компании`
  String get enter_company_description {
    return Intl.message(
      'Введите описание компании',
      name: 'enter_company_description',
      desc: '',
      args: [],
    );
  }

  /// `Добавте изображение компании`
  String get add_pic_company {
    return Intl.message(
      'Добавте изображение компании',
      name: 'add_pic_company',
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
