import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = StateNotifierProvider<Counter, int>((ref) => Counter());

class Counter extends StateNotifier<int> {
  Counter() : super(1);

  void increment() => state++;

  void decrement() {
    if(state != 1) {
      state--;
    }
  }

  void reset() => state = 1;
}
