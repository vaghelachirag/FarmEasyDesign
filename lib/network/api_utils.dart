class ApiPath {
  static const String startPoint = '/auth';


  static const String loginUrl = '$startPoint/login';
  static const String createCycleUrl = '/cycles';
  static const String getCycleUrl = '/cycles';

  // Seeds
  static const String getSeedsUrl = '/seed';
  static const String getSeedsBrandUrl = '/seed/brands';
  static const String addSeedLotUrl = '/seed/lots';
  static const String getSeedLotUrl = '/seed/lots';

  // Cycles
  static const String getCycle = '/cycles';

}

abstract interface class ApiUtils {
  static const String applicationJson = "application/json";
  static const String multipartFormData = "multipart/form-data";
  static const String bearer = "Bearer ";
  static const String textPlain = "text/plain";
}

abstract interface class ApiKeys {
  static const String accept = "accept";
  static const String contentType = "Content-Type";
  static const String authorization = "Authorization";
  static const String appVersion = "App-Version";
  static const String os = "OS";
  static const String lang = "lang";
  static const String page = "Page";
  static const String pageSize = "PageSize";
  static const String uploadedDocuments = "UploadedDocuments";
  static const String filters = 'Filters';
  static const String entityType = 'entitytype';
  static const String files = 'Files';
  static const String sortOrder = 'SortOrder';
  static const String sortColumn = 'SortColumn';
  static const String searchText = "SearchText";
  static const String folderSId = "folder_sid";

  //Signup
  static const String phoneNumber = "phone_number";
  static const String customerSId = "customer_sid";
  static const String otp = "otp";
  static const String firstName = "first_name";
  static const String lastName = "last_name";
  static const String email = "email";
  static const String password = "password";
  static const String message = "message";
  static const String confirmPassword = "confirm_password";

  static const String countryCode = "countryCode";

  //change password
  static const String currentPass = "current_password";
  static const String newPass = "new_password";
  static const String confirmPass = "confirm_new_password";
}
