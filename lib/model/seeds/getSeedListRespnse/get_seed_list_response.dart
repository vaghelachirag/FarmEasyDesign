class GetSeedListResponse {
  final String id;
  final String brandId;
  final String name;
  final String scientificName;
  final String createdAt;
  final String updatedAt;

  GetSeedListResponse({
    required this.id,
    required this.brandId,
    required this.name,
    required this.scientificName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GetSeedListResponse.fromJson(Map<String, dynamic> json) {
    return GetSeedListResponse(
      id: json['id'],
      brandId: json['brandId'],
      name: json['name'],
      scientificName: json['scientificName'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
