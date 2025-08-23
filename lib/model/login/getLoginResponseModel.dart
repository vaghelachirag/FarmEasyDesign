class GetLoginResponseModel {
  final int statusCode;
  final String message;
  final Data data;

  GetLoginResponseModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory GetLoginResponseModel.fromJson(Map<String, dynamic> json) {
    return GetLoginResponseModel(
      statusCode: json['statusCode'],
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class Data {
  final String accessToken;

  Data({required this.accessToken});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(accessToken: json['access_token']); // match API key name
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
    };
  }
}
