class GetSeedLotInfoResponse {
  final String id;
  final String seedId;
  final String lotCode;
  final DateTime receivedDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final GetSeedLotSeed? seed;

  GetSeedLotInfoResponse({
    required this.id,
    required this.seedId,
    required this.lotCode,
    required this.receivedDate,
    required this.createdAt,
    required this.updatedAt,
    this.seed,
  });

  factory GetSeedLotInfoResponse.fromJson(Map<String, dynamic> json) {
    return GetSeedLotInfoResponse(
      id: json['id'] ?? '',
      seedId: json['seedId'] ?? '',
      lotCode: json['lotCode'] ?? '',
      receivedDate: DateTime.tryParse(json['receivedDate'] ?? '') ?? DateTime.now(),
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      seed: json['seed'] != null ? GetSeedLotSeed.fromJson(json['seed']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'seedId': seedId,
      'lotCode': lotCode,
      'receivedDate': receivedDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'seed': seed?.toJson(),
    };
  }
}

class GetSeedLotSeed {
  final String id;
  final String brandId;
  final String name;
  final String scientificName;
  final DateTime createdAt;
  final DateTime updatedAt;

  GetSeedLotSeed({
    required this.id,
    required this.brandId,
    required this.name,
    required this.scientificName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GetSeedLotSeed.fromJson(Map<String, dynamic> json) {
    return GetSeedLotSeed(
      id: json['id'] ?? '',
      brandId: json['brandId'] ?? '',
      name: json['name'] ?? '',
      scientificName: json['scientificName'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brandId': brandId,
      'name': name,
      'scientificName': scientificName,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
