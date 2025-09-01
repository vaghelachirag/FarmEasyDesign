import 'dart:convert';

class AddSeedRequest {
  final List<AddSeedLotRequestData> seedLots;
  final int seedGramsPerTray;
  final int coirGramsPerTray;
  final int numFullTrays;
  final int numHalfTrays;

  AddSeedRequest({
    required this.seedLots,
    required this.seedGramsPerTray,
    required this.coirGramsPerTray,
    required this.numFullTrays,
    required this.numHalfTrays,
  });

  factory AddSeedRequest.fromJson(Map<String, dynamic> json) {
    return AddSeedRequest(
      seedLots: (json['seedLots'] as List)
          .map((e) => AddSeedLotRequestData.fromJson(e))
          .toList(),
      seedGramsPerTray: json['seedGramsPerTray'],
      coirGramsPerTray: json['coirGramsPerTray'],
      numFullTrays: json['numFullTrays'],
      numHalfTrays: json['numHalfTrays'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'seedLots': seedLots.map((e) => e.toJson()).toList(),
      'seedGramsPerTray': seedGramsPerTray,
      'coirGramsPerTray': coirGramsPerTray,
      'numFullTrays': numFullTrays,
      'numHalfTrays': numHalfTrays,
    };
  }

  static AddSeedLotRequestData fromRawJson(String str) =>
      AddSeedLotRequestData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}

class AddSeedLotRequestData {
  final String seedLotId;
  final int quantityKg;

  AddSeedLotRequestData({
    required this.seedLotId,
    required this.quantityKg,
  });

  factory AddSeedLotRequestData.fromJson(Map<String, dynamic> json) {
    return AddSeedLotRequestData(
      seedLotId: json['seedLotId'],
      quantityKg: json['quantityKg'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'seedLotId': seedLotId,
      'quantityKg': quantityKg,
    };
  }
}
