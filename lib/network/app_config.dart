enum Flavor { development, uat, production }

class AppConfig {
  final Flavor flavor;
  final String baseUrl;
  final String truDriveBaseUrl;
  final String subDomain;
  final String privacyUrl;
  final String termsUrl;
  final String legalDisclaimerUrl;

  static late AppConfig _instance;

  factory AppConfig({required Flavor flavor}) {
    _instance = AppConfig._internal(
      flavor,
      _getBaseUrl(flavor),
      _getTruDriveBaseUrl(flavor),
      _getSubdomain(flavor),
      _getPrivacyUrl(flavor),
      _getTermsUrl(flavor),
      _getLegalDisclaimerUrl(flavor),
    );
    return _instance;
  }

  AppConfig._internal(
    this.flavor,
    this.baseUrl,
    this.truDriveBaseUrl,
    this.subDomain,
    this.privacyUrl,
    this.termsUrl,
    this.legalDisclaimerUrl,
  );

  static AppConfig get instance => _instance;

  static String _getBaseUrl(Flavor flavor) {
    switch (flavor) {
      case Flavor.development:
        return "https://farmeasy-m6p9.onrender.com";
      case Flavor.uat:
        return "https://farmeasy-m6p9.onrender.com";
      case Flavor.production:
        return "https://farmeasy-m6p9.onrender.com";
    }
  }

  static String _getTruDriveBaseUrl(Flavor flavor) {
    switch (flavor) {
      case Flavor.development:
        return "https://tlf-trudriveapi-dev.azurewebsites.net";
      case Flavor.uat:
        return "https://tlf-trudriveapi-uat.azurewebsites.net";
      case Flavor.production:
        return "https://tflapi.azurewebsites.net";
    }
  }

  static String _getSubdomain(Flavor flavor) {
    switch (flavor) {
      case Flavor.development:
        return "tlfadminportal-dev";
      case Flavor.uat:
        return "tlfadminportal-uat";
      case Flavor.production:
        return "tlfportal";
    }
  }

  static String _getPrivacyUrl(Flavor flavor) {
    switch (flavor) {
      case Flavor.development:
        return "https://tlfadminportal-dev.azurewebsites.net/privacy-policy";
      case Flavor.uat:
        return "https://tlfadminportal-uat.azurewebsites.net/privacy-policy";
      case Flavor.production:
        return "https://tflapi.azurewebsites.net/privacy-policy";
    }
  }

  static String _getTermsUrl(Flavor flavor) {
    switch (flavor) {
      case Flavor.development:
        return "https://tlfadminportal-dev.azurewebsites.net/terms-of-use";
      case Flavor.uat:
        return "https://tlfadminportal-uat.azurewebsites.net/terms-of-use";
      case Flavor.production:
        return "https://tflapi.azurewebsites.net/terms-of-use";
    }
  }

  static String _getLegalDisclaimerUrl(Flavor flavor) {
    switch (flavor) {
      case Flavor.development:
        return "https://tlfadminportal-dev.azurewebsites.net/legal-disclaimers";
      case Flavor.uat:
        return "https://tlfadminportal-uat.azurewebsites.net/legal-disclaimers";
      case Flavor.production:
        return "https://tflapi.azurewebsites.net/legal-disclaimers";
    }
  }
}
