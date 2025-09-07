// seed_lot_model.dart
class SeedLotModel {
  final String id;
  final String brandId;
  final String name;
  final String scientificName;

  SeedLotModel({
    required this.id,
    required this.brandId,
    required this.name,
    required this.scientificName,
  });

  factory SeedLotModel.fromJson(Map<String, dynamic> json) {
    return SeedLotModel(
      id: json['id'],
      brandId: json['brandId'],
      name: json['name'],
      scientificName: json['scientificName'],
    );
  }
}

class SeedLot {
  final String id;
  final String seedId;
  final String lotCode;
  final String receivedDate;
  final SeedLotModel seed;

  SeedLot({
    required this.id,
    required this.seedId,
    required this.lotCode,
    required this.receivedDate,
    required this.seed,
  });

  factory SeedLot.fromJson(Map<String, dynamic> json) {
    return SeedLot(
      id: json['id'],
      seedId: json['seedId'],
      lotCode: json['lotCode'],
      receivedDate: json['receivedDate'],
      seed: SeedLotModel.fromJson(json['seed']),
    );
  }
}
