class AppStrings {
  ///Theme
  static const theme = "Theme";
  static const darkTheme = "Dark";
  static const lightTheme = "Light";
  static const systemTheme = "System";

  static String androidDocumentDownloadPath = "/storage/emulated/0/Download";

  //App Regex
  static final RegExp email = RegExp(
    r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$',
  );
  static final RegExp ukPhoneNoRegex = RegExp(
    r"^(\+44\s?7\d{3}|\(?07\d{3}\)?)\s?\d{3}\s?\d{3}$",
  );
  static final RegExp hasUpperCase = RegExp(r'[A-Z]');
  static final RegExp hasLowerCase = RegExp(r'[a-z]');
  static final RegExp hasDigit = RegExp(r'[0-9]');
  static final RegExp hasSpecialChar = RegExp(
    r'[!@#\$&*~^%()_+\-=\[\]{};:"\\|,.<>\/?]+',
  );
  static final RegExp phoneNoWithCountryCode = RegExp(r'^\+\d{10,15}$');
}
