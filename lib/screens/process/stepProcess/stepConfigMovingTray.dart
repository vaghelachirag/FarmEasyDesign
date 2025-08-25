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
    final list = List<StepStatus>.from(state.statuses);
    for (int i = 0; i < list.length; i++) {
      if (i < index && list[i] != StepStatus.completed) list[i] = StepStatus.completed;
      if (i == index) list[i] = StepStatus.current;
      if (i > index && list[i] != StepStatus.upcoming) list[i] = StepStatus.upcoming;
    }
    state = state.copyWith(currentIndex: index, statuses: list);
  }

  void setStatus(int index, StepStatus status) {
    final list = List<StepStatus>.from(state.statuses)..[index] = status;
    state = state.copyWith(statuses: list);
  }

  void completeAndNext() {
    final i = state.currentIndex;
    final list = List<StepStatus>.from(state.statuses);
    list[i] = StepStatus.completed;
    final next = (i + 1 < list.length) ? i + 1 : i;
    if (next != i) list[next] = StepStatus.current;
    state = StepState(currentIndex: next, statuses: list);
  }
}

final stepControllerProvider =
StateNotifierProvider<StepController, StepState>((ref) {
  return StepController(length: 3);
});

final progressProvider = Provider<double>((ref) {
  final s = ref.watch(stepControllerProvider);
  final done = s.statuses.where((e) => e == StepStatus.completed).length;
  return done / s.statuses.length;
});
