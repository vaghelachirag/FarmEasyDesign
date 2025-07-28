
import 'package:farmeasy/model/model_assign_user.dart';
import 'package:farmeasy/model/model_cycle_seeding.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../model/model_cycle.dart';


final selectedStepProvider = StateProvider<int>((ref) => 0);

final progressProvider = StateProvider<double>((ref) => 0.3);

final taskListProvider = StateProvider<List<ModelCycleSeeding>>((ref) => [
  ModelCycleSeeding(crop: 'Arugula', trays: '14F Trays', completed: 0, total: 14),
  ModelCycleSeeding(crop: 'Cabbage', trays: '18F 7H Trays', completed: 0, total: 25),
]);

enum CycleStage {
  seeding,
  germination,
  moveToFertigation,
  harvesting,
  fertigation,
}

final cyclesProvider = StateProvider<List<ModelCycle>>((ref) {
  return [
    ModelCycle(
      cycleName: "Cycle 9",
      trayInfo: "38 Arugula Trays",
      startDate: DateTime(2025, 5, 22),
      endDate: DateTime(2025, 5, 22),
      status: "Seeding",
      assignedUsers: ["A", "B", "C", "D", "E"],
      arugulaCompleted: 0,
      arugulaTotal: 14,
      cabbageCompleted: 0,
      cabbageTotal: 25,
      upcomingSeedsDay: 1,
      seedingStatus: 0, currentStage: CycleStage.seeding,
    ),
    ModelCycle(
        cycleName: "Cycle 8",
        trayInfo: "• 38 Arugula Trays",
        startDate: DateTime(2025, 5, 22),
        endDate: DateTime(2025, 5, 22),
        status: "Moving to germination",
        assignedUsers: ["A", "B", "C", "D", "E"],
        arugulaCompleted: 0,
        arugulaTotal: 14,
        cabbageCompleted: 0,
        cabbageTotal: 25,
        upcomingSeedsDay: 1,
        seedingStatus: 1, currentStage: CycleStage.germination
    ),
    ModelCycle(
        cycleName: "Cycle 8",
        trayInfo: "• 38 Arugula Trays",
        startDate: DateTime(2025, 5, 22),
        endDate: DateTime(2025, 5, 22),
        status: "Moving to Fertigation Room",
        assignedUsers: ["A", "B", "C", "D", "E"],
        arugulaCompleted: 0,
        arugulaTotal: 14,
        cabbageCompleted: 0,
        cabbageTotal: 25,
        upcomingSeedsDay: 1,
        seedingStatus: 2, currentStage: CycleStage.moveToFertigation
    ),
    ModelCycle(
        cycleName: "Cycle 8",
        trayInfo: "• 38 Arugula Trays",
        startDate: DateTime(2025, 5, 22),
        endDate: DateTime(2025, 5, 22),
        status: "Moving to Harvesting",
        assignedUsers: ["A", "B", "C", "D", "E"],
        arugulaCompleted: 0,
        arugulaTotal: 14,
        cabbageCompleted: 0,
        cabbageTotal: 25,
        upcomingSeedsDay: 1,
        seedingStatus: 3, currentStage: CycleStage.harvesting
    ),
    ModelCycle(
        cycleName: "Cycle 8",
        trayInfo: "• 38 Arugula Trays",
        startDate: DateTime(2025, 5, 22),
        endDate: DateTime(2025, 5, 22),
        status: "Fertigation",
        assignedUsers: ["A", "B", "C", "D", "E"],
        arugulaCompleted: 0,
        arugulaTotal: 14,
        cabbageCompleted: 0,
        cabbageTotal: 25,
        upcomingSeedsDay: 1,
        seedingStatus: 4, currentStage: CycleStage.fertigation
    ),
    // Add more cycles as needed
  ];
});



final assignedUsersProvider = StateProvider<List<ModelAssignUser>>((ref) {
  return [
    ModelAssignUser('assets/images/assign_person_1.png'),
    ModelAssignUser('assets/images/assign_person_2.png'),
    ModelAssignUser('assets/images/assign_person_3.png'),
    ModelAssignUser('assets/images/assign_person_1.png'),
    ModelAssignUser('assets/images/assign_person_1.png'),
    ModelAssignUser('assets/images/assign_person_1.png'),
    ModelAssignUser('assets/images/assign_person_1.png'),
  ];
});

final seedingStatusProvider = StateProvider<SeedingStatus>((ref) {
  return SeedingStatus.idle;
});

enum SeedingStatus { idle, started, issueMarked }

final selectedStageProvider = StateProvider<CycleStage>((ref) {
  return CycleStage.seeding;
});