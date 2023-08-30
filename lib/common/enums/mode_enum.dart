enum ModeEnum {
  client('client'),
  seller('seller');

  final String type;

  const ModeEnum(this.type);
}

extension ConvertMode on String {
  ModeEnum toModeEnum() {
    switch (this) {
      case ('client'):
        return ModeEnum.client;
      case ('seller'):
        return ModeEnum.seller;
      default:
        return ModeEnum.client;
    }
  }
}
