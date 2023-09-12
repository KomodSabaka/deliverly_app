import 'package:deliverly_app/common/enums/mode_enum.dart';
import 'package:deliverly_app/models/pay_card.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/app_settings_state.dart';
import '../../models/user.dart';
import '../enums/currencies_enum.dart';
import '../utils/constants.dart';

final appSettingsProvider =
    StateNotifierProvider<AppSettingsNotifier, AppSettingsState>(
  (ref) => AppSettingsNotifier(),
);

class AppSettingsNotifier extends StateNotifier<AppSettingsState> {
  AppSettingsNotifier() : super(const AppSettingsState());

  bool get isClientMode {
    return state.mode == ModeEnum.client ? true : false;
  }

  void createClient({
    required String name,
    required String phoneNumber,
    required PayCard card,
  }) {
    Client client = Client(
      card: card,
      id: FirebaseAuth.instance.currentUser!.uid,
      name: name,
      phone: phoneNumber,
    );

    setUser(user: client);
  }

  void setUser({required AppUser? user}) {
    state = state.copyWith(user: user);
  }

  void setMode({required ModeEnum mode}) {
    state = state.copyWith(mode: mode);
  }

  double calculateInUsersCurrency({
    required double costInDollars,
  }) {
    return costInDollars * state.currentExchangeRate;
  }

  Future getCurrentExchangeRate() async {
    try {
      var currentExchangeRate =
      await convertCurrencies(toCurrency: CurrenciesEnum.rub);
      state = state.copyWith(currentExchangeRate: currentExchangeRate);
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<double?> convertCurrencies({
    required CurrenciesEnum toCurrency,
  }) async {
    String request =
        '${APIConst.site}/v3/latest?base_currency=${CurrenciesEnum.usd.type.toUpperCase()}'
        '&currencies=${toCurrency.type.toUpperCase()}'
        '&apikey=${APIConst.api}';
    var response = await Dio().get(request);
    var value = response.data['data'][toCurrency.type.toUpperCase()]['value'];
    if (value == null) return null;
    return value;
  }
}
