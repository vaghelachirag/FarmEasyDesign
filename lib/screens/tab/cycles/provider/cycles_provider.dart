
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../model/model_cycle_info.dart';

final cycleInfoProvider = Provider<ModelCycleInfo>((ref) {
  return ModelCycleInfo(
    cycleName: 'Cycle 8',
    crop: 'Arugula',
    startDate: DateTime(2025, 5, 22),
    endDate: DateTime(2025, 5, 22),
    trays: 38,
    upcomingSeedingDays: 1,
  );
});