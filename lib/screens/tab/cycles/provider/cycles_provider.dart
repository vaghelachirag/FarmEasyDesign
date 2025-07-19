
import 'package:farmeasy/model/model_assign_user.dart';
import 'package:farmeasy/model/model_cycle_seeding.dart';
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


final selectedStepProvider = StateProvider<int>((ref) => 0);

final progressProvider = StateProvider<double>((ref) => 0.3);

final taskListProvider = StateProvider<List<ModelCycleSeeding>>((ref) => [
  ModelCycleSeeding(crop: 'Arugula', trays: '14F Trays', completed: 0, total: 14),
  ModelCycleSeeding(crop: 'Cabbage', trays: '18F 7H Trays', completed: 0, total: 25),
]);


final assignedUsersProvider = StateProvider<List<ModelAssignUser>>((ref) {
  return [
    ModelAssignUser('assets/user1.jpg'),
    ModelAssignUser('assets/user2.jpg'),
    ModelAssignUser('assets/user3.jpg'),
    ModelAssignUser('assets/user4.jpg'),
    ModelAssignUser('assets/user5.jpg'),
    ModelAssignUser('assets/user6.jpg'),
    ModelAssignUser('assets/user7.jpg'),
  ];
});