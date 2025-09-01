class GetSeedLotResponse {
  final int statusCode;
  final String message;
  final List<GetSeedLotData> data;

  GetSeedLotResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory GetSeedLotResponse.fromJson(Map<String, dynamic> json) {
    return GetSeedLotResponse(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => GetSeedLotData.fromJson(item))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "statusCode": statusCode,
      "message": message,
      "data": data.map((e) => e.toJson()).toList(),
    };
  }
}

class GetSeedLotData {
  final String id;
  final String seedId;
  final String lotCode;
  final DateTime? receivedDate;
  final String initialQuantityKg;
  final String currentQuantityKg;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  GetSeedLotData({
    required this.id,
    required this.seedId,
    required this.lotCode,
    required this.receivedDate,
    required this.initialQuantityKg,
    required this.currentQuantityKg,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GetSeedLotData.fromJson(Map<String, dynamic> json) {
    return GetSeedLotData(
      id: json['id'] ?? '',
      seedId: json['seedId'] ?? '',
      lotCode: json['lotCode'] ?? '',
      receivedDate: json['receivedDate'] != null
          ? DateTime.tryParse(json['receivedDate'])
          : null,
      initialQuantityKg: json['initialQuantityKg'] ?? '0',
      currentQuantityKg: json['currentQuantityKg'] ?? '0',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "seedId": seedId,
      "lotCode": lotCode,
      "receivedDate": receivedDate?.toIso8601String(),
      "initialQuantityKg": initialQuantityKg,
      "currentQuantityKg": currentQuantityKg,
      "createdAt": createdAt?.toIso8601String(),
      "updatedAt": updatedAt?.toIso8601String(),
    };
  }
}
