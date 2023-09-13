import '../enums/currencies_enum.dart';

class CurrencyConversion {
  // Future<double?> convertCurrencies({
  //   required CurrenciesEnum toCurrency,
  // }) async {
  //   String request =
  //       '${APIConst.site}/v3/latest?base_currency=${CurrenciesEnum.usd.type.toUpperCase()}'
  //       '&currencies=${toCurrency.type.toUpperCase()}'
  //       '&apikey=${APIConst.api}';
  //   var response = await Dio().get(request);
  //   var value = response.data['data'][toCurrency.type.toUpperCase()]['value'];
  //   if (value == null) return null;
  //   return value;
  // }
}