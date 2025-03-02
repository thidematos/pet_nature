import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabProviderNotifier extends StateNotifier<int> {
  TabProviderNotifier() : super(1);

  void changeActiveTab(int tabIndex) {
    state = tabIndex;
  }

  void goToProfile() {
    state = 0;
  }

  void reset() {
    state = 1;
  }
}

final TabProvider = StateNotifierProvider<TabProviderNotifier, int>(
  (ref) => TabProviderNotifier(),
);
