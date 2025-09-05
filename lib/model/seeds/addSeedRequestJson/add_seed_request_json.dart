class AddSeedRequestJson {
  final List<String> seedLots;
  final int seedGramsPerTray;
  final int coirGramsPerTray;
  final int numFullTrays;
  final int numHalfTrays;

  AddSeedRequestJson({
    required this.seedLots,
    required this.seedGramsPerTray,
    required this.coirGramsPerTray,
    required this.numFullTrays,
    required this.numHalfTrays,
  });

  /// Factory constructor to create object from JSON
  factory AddSeedRequestJson.fromJson(Map<String, dynamic> json) {
    return AddSeedRequestJson(
      seedLots: List<String>.from(json['seedLots']),
      seedGramsPerTray: json['seedGramsPerTray'],
      coirGramsPerTray: json['coirGramsPerTray'],
      numFullTrays: json['numFullTrays'],
      numHalfTrays: json['numHalfTrays'],
    );
  }

  /// Convert object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'seedLots': seedLots,
      'seedGramsPerTray': seedGramsPerTray,
      'coirGramsPerTray': coirGramsPerTray,
      'numFullTrays': numFullTrays,
      'numHalfTrays': numHalfTrays,
    };
  }
}
