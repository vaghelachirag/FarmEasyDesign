import 'package:hooks_riverpod/hooks_riverpod.dart';

final cycleStatusProvider = Provider.family<String, String>((ref, cycleStatus) {
  return cycleStatus;
});