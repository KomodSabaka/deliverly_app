import 'package:deliverly_app/features/basket/repository/basket_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final totalPriceProvider = StateNotifierProvider<TotalPriceNotifier, int>(
    (ref) => TotalPriceNotifier(ref: ref));

class TotalPriceNotifier extends StateNotifier<int> {
  TotalPriceNotifier({required this.ref}) : super(0);

  final StateNotifierProviderRef<TotalPriceNotifier, int> ref;

  void calculate() {
    try {
      var cost = 0;

      for (var element in ref.watch(basketProvider)) {
        cost += int.parse(element.cost);
      }

      state = cost;
    } on Exception catch (e) {
      print(e);
    }
  }
}
