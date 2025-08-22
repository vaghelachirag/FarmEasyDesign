class GetBrandsModel {
  int statusCode;
  String message;
  List<GetBrandsDataModel> data;

  GetBrandsModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

}

class GetBrandsDataModel {
  String id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  GetBrandsDataModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

}
