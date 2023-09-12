import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterState = StateNotifierProvider<CounterState, int>((ref) => CounterState());

class CounterState extends StateNotifier<int> {
  CounterState() : super(1);

  void increment() => state++;

  void decrement() {
    if (state != 1) state--;
  }

  void reset() => state = 1;
}
