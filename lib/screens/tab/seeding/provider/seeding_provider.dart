import 'package:hooks_riverpod/hooks_riverpod.dart';


enum ScanState {
  idle,         // Tap to scan
  scanning,     // Camera open
  success,      // Scan completed
}

final currentStepProvider = StateProvider<int>((ref) => 0);
final scanToggleProvider = StateProvider<bool>((ref) => false);
final scanStateProvider = StateProvider<ScanState>((ref) => ScanState.idle);