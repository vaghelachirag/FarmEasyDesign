import 'package:hooks_riverpod/hooks_riverpod.dart';

enum MoveTrayScanState {
  idle,         // Tap to scan
  scanning,     // Camera open
  scanLevelQR,      // Scan completed
  addDetail,
  confirmAndScan
}

final  moveTrayScanCurrentStepProvider = StateProvider<int>((ref) => 0);
final  moveTrayScanToggleProvider = StateProvider<bool>((ref) => false);
final  moveTrayScanStateProvider = StateProvider<MoveTrayScanState>((ref) => MoveTrayScanState.confirmAndScan);

// scanned_items_provider.dart
final scannedItemsProvider = StateNotifierProvider<ScannedItemsNotifier, List<String>>(
      (ref) => ScannedItemsNotifier(),
);

class ScannedItemsNotifier extends StateNotifier<List<String>> {
  ScannedItemsNotifier() : super([]);

  void addItem(String item) {
    state = [...state, item];
  }

  void clear() {
    state = [];
  }

  int get count => state.length;
}





