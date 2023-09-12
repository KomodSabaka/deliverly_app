import 'package:deliverly_app/common/app_settings/app_settings.dart';
import 'package:deliverly_app/features/basket/repository/basket_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final totalPriceProvider = StateNotifierProvider<TotalPriceNotifier, double>(
    (ref) => TotalPriceNotifier(ref: ref));

class TotalPriceNotifier extends StateNotifier<double> {
  TotalPriceNotifier({required this.ref}) : super(0.0);

  final StateNotifierProviderRef<TotalPriceNotifier, double> ref;

  void calculate() {
    try {
      double cost = 0.0;

      for (var element in ref.watch(basketProvider)) {
        cost += element.cost;
      }
      state = ref
          .read(appSettingsProvider.notifier)
          .calculateInUsersCurrency(costInDollars: cost);
    } on Exception catch (e) {
      print(e);
    }
  }
}
