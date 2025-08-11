// ppm_state.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TotalPpmState {
  final int ppmValue;
  final DateTime lastUpdated;

  TotalPpmState({required this.ppmValue, required this.lastUpdated});

  TotalPpmState copyWith({int? ppmValue, DateTime? lastUpdated}) {
    return TotalPpmState(
      ppmValue: ppmValue ?? this.ppmValue,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}

class PpmNotifier extends StateNotifier<TotalPpmState> {
  PpmNotifier()
      : super(
    TotalPpmState(
      ppmValue: 750,
      lastUpdated: DateTime(2025, 7, 12),
    ),
  );

  void updatePpm(int newValue) {
    state = state.copyWith(
      ppmValue: newValue,
      lastUpdated: DateTime.now(),
    );
  }
}

final ppmProvider = StateNotifierProvider<PpmNotifier, TotalPpmState>(
      (ref) => PpmNotifier(),
);

// Expand/Collapse toggle
final isExpandedProvider = StateProvider<bool>((ref) => false);