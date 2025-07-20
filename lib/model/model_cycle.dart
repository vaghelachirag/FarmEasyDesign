import '../screens/tab/cycles/provider/cycles_provider.dart';

class ModelCycle {
  final String cycleName;
  final String trayInfo;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final List<String> assignedUsers;
  final int arugulaCompleted;
  final int arugulaTotal;
  final int cabbageCompleted;
  final int cabbageTotal;
  final int upcomingSeedsDay;
  final int seedingStatus;
  final CycleStage currentStage;

  ModelCycle({
    required this.cycleName,
    required this.trayInfo,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.assignedUsers,
    required this.arugulaCompleted,
    required this.arugulaTotal,
    required this.cabbageCompleted,
    required this.cabbageTotal,
    required this.upcomingSeedsDay,
    required this.seedingStatus,
    required this.currentStage,
  });
}
