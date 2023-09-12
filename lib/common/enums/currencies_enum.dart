enum CurrenciesEnum {
  rub('rub'),
  usd('usd');

  final String type;

  const CurrenciesEnum(this.type);
}

extension ConvertCurrencies on String {
  CurrenciesEnum toCurrenciesEnum() {
    switch (this) {
      case ('rub'):
        return CurrenciesEnum.rub;
      case ('usd'):
        return CurrenciesEnum.usd;
      default:
        return CurrenciesEnum.usd;
    }
  }
}