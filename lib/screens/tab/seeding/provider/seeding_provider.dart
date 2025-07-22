import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../model/model_cycle_info.dart';


enum ScanState {
  idle,         // Tap to scan
  scanning,     // Camera open
  success,      // Scan completed
  confirmDetail
}

final currentStepProvider = StateProvider<int>((ref) => 0);
final scanToggleProvider = StateProvider<bool>((ref) => false);
final scanStateProvider = StateProvider<ScanState>((ref) => ScanState.idle);




