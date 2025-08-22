class ApiPath {
  static const String startPoint = '/auth';


  static const String sendOtpUrl = '$startPoint/auth/otp';
  static const String verifyOtpUrl = '$startPoint/auth/verifyotp';
  static const String signupUrl = '$startPoint/auth/signup';
  static const String forgotPwdSendOtpUrl =
      '$startPoint/auth/forgotpassword/otp';
  static const String forgotPwdVerifyOtpUrl =
      '$startPoint/auth/forgotpassword/verifyotp';
  static const String forgotPwdUrl = '$startPoint/auth/forgotpassword';
  static const String loginUrl = '$startPoint/login';
  static const String logoutUrl = '$startPoint/logout';
  static const String feedUrl = '$startPoint/feed';
  static const String feedPostViewsUrl = '$startPoint/feed/feedpostviews';
  static const String getEnquiryTypesUrl = '$startPoint/dropdowns/enquirytypes';
  static String getEnquiryPurposeUrl(String sId) =>
      '$startPoint/dropdowns/enquirytypes/$sId/enquirypurposemasters';
  static String getEnquiryChannelsUrl(String sId) =>
      '$startPoint/dropdowns/enquirytypes/$sId/enquirypreferredchannels';
  static const String enquiriesUrl = '$startPoint/enquiries';
  static String enquiryDetailUrl(String sId) => '$startPoint/enquiries/$sId';
  static String attachmentsUrl(String? sId) =>
      '$startPoint/entity/$sId/attachments';
  static String notesUrl(String? sId) => '$startPoint/entity/$sId/notes';
  static String editNotesUrl(String? sId, String? noteSId) =>
      '$startPoint/entity/$sId/notes/$noteSId';
  static String getClaimReasons = '$startPoint/dropdowns/claimreasons';
  static String getClaimBusinessTypes = '$startPoint/dropdowns/businesstypes';
  static String claimsUrl = '$startPoint/claims';
  static String claimDetailUrl(String? sId) =>
      '$startPoint/claims/$sId/details';
  static String editClaimUrl(String? sId) => '$startPoint/claims/$sId';
  static String getClaimHistoryUrl(String? sId) =>
      '$startPoint/claims/$sId/history';
  static String truCastUrl = '$startPoint/trucast';
  static String truDriveUrl = '$startPoint/TruDrive';
  static String addFolderUrl = '$startPoint/TruDrive/EmptyFolder';
  static String uploadTruDriveFileUrl =
      '$startPoint/TruDrive/UploadDriveDocument';
  static String deleteFileFolderUrl = '$startPoint/TruDrive/DeleteDocuments';
  static String renameFileFolderUrl(String docSId) =>
      '$startPoint/TruDrive/Rename/$docSId';
  static String downloadDriveFolderUrl(String sId) =>
      '$startPoint/TruDrive/$sId/Download';
  static String getSupportTicketCategory =
      '$startPoint/dropdowns/SupportTicketCategory';
  static String addFeedbackUrl = '$startPoint/supporttickets';
  static String notificationUrl = '$startPoint/notifications';
  static String changePasswordUrl = '$startPoint/auth/changepassword';
  static String getProfileUrl = '$startPoint/auth/profile';
  static String sendUpdateProfileOtp = '$startPoint/auth/profile/otp';
  static String updateProfileUrl = '$startPoint/auth/profile';
  static String updateProfileImageUrl = '$startPoint/auth/profileimage';
  static String deleteAccountUrl = '$startPoint/auth/deleteaccount';
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
