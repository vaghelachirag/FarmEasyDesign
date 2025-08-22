class GetSeedsModel {
  int statusCode;
  String message;
  List<GetSeedsDataModel> data;

  GetSeedsModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

}

class GetSeedsDataModel {
  String id;
  String brandId;
  String name;
  String scientificName;
  DateTime createdAt;
  DateTime updatedAt;

  GetSeedsDataModel({
    required this.id,
    required this.brandId,
    required this.name,
    required this.scientificName,
    required this.createdAt,
    required this.updatedAt,
  });

}
