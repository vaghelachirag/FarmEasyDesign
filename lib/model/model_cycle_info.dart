class ModelCycleInfo {
  final String cycleName;
  final String crop;
  final DateTime startDate;
  final DateTime endDate;
  final int trays;
  final int upcomingSeedingDays;

  ModelCycleInfo({
    required this.cycleName,
    required this.crop,
    required this.startDate,
    required this.endDate,
    required this.trays,
    required this.upcomingSeedingDays,
  });
}
