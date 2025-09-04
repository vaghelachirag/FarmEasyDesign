// To parse this JSON data, do
//
//     final resGetCycle = resGetCycleFromJson(jsonString);

import 'dart:convert';

ResGetCycle resGetCycleFromJson(String str) => ResGetCycle.fromJson(json.decode(str));

String resGetCycleToJson(ResGetCycle data) => json.encode(data.toJson());

class ResGetCycle {
  final int? statusCode;
  final String? message;
  final List<CycleData>? data;

  ResGetCycle({
    this.statusCode,
    this.message,
    this.data,
  });

  factory ResGetCycle.fromJson(Map<String, dynamic> json) => ResGetCycle(
    statusCode: json["statusCode"],
    message: json["message"],
    data: json["data"] == null ? [] : List<CycleData>.from(json["data"]!.map((x) => CycleData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class CycleData {
  final String? id;
  final String? status;
  final String? name;
  final dynamic growthProfileId;
  final DateTime? startDate;
  final dynamic completedDate;
  final dynamic finalYieldGrams;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<SeedLotsResult>? seedLots;
  final List<CyclePhase>? cyclePhases;

  CycleData({
    this.id,
    this.status,
    this.name,
    this.growthProfileId,
    this.startDate,
    this.completedDate,
    this.finalYieldGrams,
    this.createdAt,
    this.updatedAt,
    this.seedLots,
    this.cyclePhases,
  });

  factory CycleData.fromJson(Map<String, dynamic> json) => CycleData(
    id: json["id"],
    status: json["status"],
    name: json["name"],
    growthProfileId: json["growthProfileId"],
    startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
    completedDate: json["completedDate"],
    finalYieldGrams: json["finalYieldGrams"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    seedLots: json["seedLots"] == null ? [] : List<SeedLotsResult>.from(json["seedLots"]!.map((x) => SeedLotsResult.fromJson(x))),
    cyclePhases: json["cyclePhases"] == null ? [] : List<CyclePhase>.from(json["cyclePhases"]!.map((x) => CyclePhase.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "name": name,
    "growthProfileId": growthProfileId,
    "startDate": startDate?.toIso8601String(),
    "completedDate": completedDate,
    "finalYieldGrams": finalYieldGrams,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "seedLots": seedLots == null ? [] : List<dynamic>.from(seedLots!.map((x) => x.toJson())),
    "cyclePhases": cyclePhases == null ? [] : List<dynamic>.from(cyclePhases!.map((x) => x.toJson())),
  };
}

class CyclePhase {
  final String? id;
  final String? cycleId;
  final String? phaseType;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final String? seedGramsPerTray;
  final String? coirGramsPerTray;
  final int? numFullTrays;
  final int? numHalfTrays;
  final dynamic totalGramsHarvested;
  final dynamic numBadTrays;
  final dynamic notes;
  final dynamic extraData;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Worker>? workers;

  CyclePhase({
    this.id,
    this.cycleId,
    this.phaseType,
    this.startedAt,
    this.completedAt,
    this.seedGramsPerTray,
    this.coirGramsPerTray,
    this.numFullTrays,
    this.numHalfTrays,
    this.totalGramsHarvested,
    this.numBadTrays,
    this.notes,
    this.extraData,
    this.createdAt,
    this.updatedAt,
    this.workers,
  });

  factory CyclePhase.fromJson(Map<String, dynamic> json) => CyclePhase(
    id: json["id"],
    cycleId: json["cycleId"],
    phaseType: json["phaseType"],
    startedAt: json["startedAt"] == null ? null : DateTime.parse(json["startedAt"]),
    completedAt: json["completedAt"] == null ? null : DateTime.parse(json["completedAt"]),
    seedGramsPerTray: json["seedGramsPerTray"],
    coirGramsPerTray: json["coirGramsPerTray"],
    numFullTrays: json["numFullTrays"],
    numHalfTrays: json["numHalfTrays"],
    totalGramsHarvested: json["totalGramsHarvested"],
    numBadTrays: json["numBadTrays"],
    notes: json["notes"],
    extraData: json["extraData"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    workers: json["workers"] == null ? [] : List<Worker>.from(json["workers"]!.map((x) => Worker.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cycleId": cycleId,
    "phaseType": phaseType,
    "startedAt": startedAt?.toIso8601String(),
    "completedAt": completedAt?.toIso8601String(),
    "seedGramsPerTray": seedGramsPerTray,
    "coirGramsPerTray": coirGramsPerTray,
    "numFullTrays": numFullTrays,
    "numHalfTrays": numHalfTrays,
    "totalGramsHarvested": totalGramsHarvested,
    "numBadTrays": numBadTrays,
    "notes": notes,
    "extraData": extraData,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "workers": workers == null ? [] : List<dynamic>.from(workers!.map((x) => x.toJson())),
  };
}

class Worker {
  final String? cyclePhaseId;
  final int? userId;
  final DateTime? joinedAt;
  final User? user;

  Worker({
    this.cyclePhaseId,
    this.userId,
    this.joinedAt,
    this.user,
  });

  factory Worker.fromJson(Map<String, dynamic> json) => Worker(
    cyclePhaseId: json["cyclePhaseId"],
    userId: json["userId"],
    joinedAt: json["joinedAt"] == null ? null : DateTime.parse(json["joinedAt"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "cyclePhaseId": cyclePhaseId,
    "userId": userId,
    "joinedAt": joinedAt?.toIso8601String(),
    "user": user?.toJson(),
  };
}

class User {
  final int? id;
  final String? email;
  final String? name;
  final String? passwordHash;
  final DateTime? createdAt;
  final String? role;

  User({
    this.id,
    this.email,
    this.name,
    this.passwordHash,
    this.createdAt,
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    email: json["email"],
    name: json["name"],
    passwordHash: json["password_hash"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "name": name,
    "password_hash": passwordHash,
    "created_at": createdAt?.toIso8601String(),
    "role": role,
  };
}

class SeedLotsResult {
  final String? cycleId;
  final String? seedLotId;
  final String? quantityKg;
  final DateTime? createdAt;
  final SeedLotDetails? seedLot;

  SeedLotsResult({
    this.cycleId,
    this.seedLotId,
    this.quantityKg,
    this.createdAt,
    this.seedLot,
  });

  factory SeedLotsResult.fromJson(Map<String, dynamic> json) => SeedLotsResult(
    cycleId: json["cycleId"],
    seedLotId: json["seedLotId"],
    quantityKg: json["quantityKg"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    seedLot: json["seedLot"] == null ? null : SeedLotDetails.fromJson(json["seedLot"]),
  );

  Map<String, dynamic> toJson() => {
    "cycleId": cycleId,
    "seedLotId": seedLotId,
    "quantityKg": quantityKg,
    "createdAt": createdAt?.toIso8601String(),
    "seedLot": seedLot?.toJson(),
  };
}

class SeedLotDetails {
  final String? id;
  final String? seedId;
  final String? lotCode;
  final DateTime? receivedDate;
  final String? initialQuantityKg;
  final String? currentQuantityKg;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final SeedData? seed;

  SeedLotDetails({
    this.id,
    this.seedId,
    this.lotCode,
    this.receivedDate,
    this.initialQuantityKg,
    this.currentQuantityKg,
    this.createdAt,
    this.updatedAt,
    this.seed,
  });

  factory SeedLotDetails.fromJson(Map<String, dynamic> json) => SeedLotDetails(
    id: json["id"],
    seedId: json["seedId"],
    lotCode: json["lotCode"],
    receivedDate: json["receivedDate"] == null ? null : DateTime.parse(json["receivedDate"]),
    initialQuantityKg: json["initialQuantityKg"],
    currentQuantityKg: json["currentQuantityKg"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    seed: json["seed"] == null ? null : SeedData.fromJson(json["seed"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "seedId": seedId,
    "lotCode": lotCode,
    "receivedDate": receivedDate?.toIso8601String(),
    "initialQuantityKg": initialQuantityKg,
    "currentQuantityKg": currentQuantityKg,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "seed": seed?.toJson(),
  };
}

class SeedData {
  final String? id;
  final String? brandId;
  final String? name;
  final String? scientificName;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SeedData({
    this.id,
    this.brandId,
    this.name,
    this.scientificName,
    this.createdAt,
    this.updatedAt,
  });

  factory SeedData.fromJson(Map<String, dynamic> json) => SeedData(
    id: json["id"],
    brandId: json["brandId"],
    name: json["name"],
    scientificName: json["scientificName"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "brandId": brandId,
    "name": name,
    "scientificName": scientificName,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
