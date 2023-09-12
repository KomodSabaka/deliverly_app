import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchState = StateNotifierProvider<SearchStateNotifier, bool>(
    (ref) => SearchStateNotifier());

class SearchStateNotifier extends StateNotifier<bool> {
  SearchStateNotifier() : super(false);

  void noSearch() => state = false;

  void searching() => state = true;
}
