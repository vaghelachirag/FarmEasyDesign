import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum StepStatus { completed, current, upcoming, error }

@immutable
class StepConfigMovingTray {
  final String caption; // e.g., "Step 1"
  final String label;   // e.g., "Scan Tray QR"
  final IconData icon;  // default icon when not completed
  const StepConfigMovingTray({required this.caption, required this.label, required this.icon});
}

@immutable
class StepState {
  final int currentIndex;
  final List<StepStatus> statuses;
  const StepState({required this.currentIndex, required this.statuses});

  StepState copyWith({int? currentIndex, List<StepStatus>? statuses}) =>
      StepState(currentIndex: currentIndex ?? this.currentIndex,
          statuses: statuses ?? this.statuses);
}

class StepController extends StateNotifier<StepState> {
  StepController({required int length})
      : super(StepState(
    currentIndex: 0,
    statuses: List<StepStatus>.filled(length, StepStatus.upcoming)..[0] = StepStatus.current,
  ));

  void goTo(int index) {
    if (index < 0 || index >= state.statuses.length) return;
    
    final list = List<StepStatus>.from(state.statuses);
    for (int i = 0; i < list.length; i++) {
      if (i < index && list[i] != StepStatus.completed) list[i] = StepStatus.completed;
      if (i == index) list[i] = StepStatus.current;
      if (i > index && list[i] != StepStatus.upcoming) list[i] = StepStatus.upcoming;
    }
    state = state.copyWith(currentIndex: index, statuses: list);
  }

  void setStatus(int index, StepStatus status) {
    if (index < 0 || index >= state.statuses.length) return;
    
    final list = List<StepStatus>.from(state.statuses)..[index] = status;
    state = state.copyWith(statuses: list);
  }

  void completeAndNext() {
    final i = state.currentIndex;
    if (i >= state.statuses.length) return;
    
    final list = List<StepStatus>.from(state.statuses);
    list[i] = StepStatus.completed;
    final next = (i + 1 < list.length) ? i + 1 : i;
    if (next != i) list[next] = StepStatus.current;
    state = state.copyWith(currentIndex: next, statuses: list);
  }

  void reset() {
    final list = List<StepStatus>.filled(state.statuses.length, StepStatus.upcoming)..[0] = StepStatus.current;
    state = StepState(currentIndex: 0, statuses: list);
  }

  // Helper method to handle step progression based on scan state
  void handleScanStateChange(String scanState, int totalSteps) {
    switch (scanState) {
      case 'success':
        // First scan completed, move to step 2 (confirm details)
        if (state.currentIndex == 0) {
          completeAndNext();
        }
        break;
      case 'confirmDetail':
        // Details confirmed, move to step 3 (scan level QR)
        if (state.currentIndex == 1) {
          completeAndNext();
        }
        break;
      case 'scanNextQR':
        // Level QR scanned, complete the process
        if (state.currentIndex == 2) {
          completeAndNext();
        }
        break;
    }
  }

  // Method to handle initial scan success (when user first scans a QR)
  void handleInitialScanSuccess() {
    if (state.currentIndex == 0) {
      // First scan (Tray QR) completed
      completeAndNext();
    }
  }

  // Method to handle second scan success (when user scans Level QR)
  void handleSecondScanSuccess() {
    if (state.currentIndex == 2) {
      // Second scan (Level QR) completed
      completeAndNext();
    }
  }
}

// Provider factory that creates a step controller with the correct length
final stepControllerProvider = StateNotifierProvider.family<StepController, StepState, int>((ref, length) {
  return StepController(length: length);
});

final progressProvider = Provider.family<double, int>((ref, length) {
  final s = ref.watch(stepControllerProvider(length));
  final done = s.statuses.where((e) => e == StepStatus.completed).length;
  return done / s.statuses.length;
});
