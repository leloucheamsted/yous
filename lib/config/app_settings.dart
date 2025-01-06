class AppSettings {
  AppSettings({
    required this.appName,
    required this.apiStreamingURL,
    required this.appBrand,
    required this.appleAuthEndpoint,
    required this.applicationId,
    required this.inAppPurchaseDefaultPrice,
    required this.canalPlusAuthUrl,
    required this.garSSOAuthUrl,
    required this.canalPlusYsRedirectUrl,
    required this.daysLeftBeforeBookExpiry,
    required this.mainYSAPIUrl,
    required this.mobileAPIUrl,
    required this.privacyPolicyUrl,
    required this.secretKey,
    required this.supportEmail,
    required this.termsOfServiceUrl,
    required this.userAgent,
    required this.ysAuthHeaderKey,
    required this.editorialBaseImageUrl,
    required this.logoutGarUrl,
    required this.telemetryKey,
    required this.personnalDataCharterGarUrl,
    required this.legalNoticesGarUrl,
    this.inAppPurchaseSubscriptionId = '',
    this.pdfLicenseKey = '',
    this.faqUrl = '',
    this.logIntervalInMiliSeconds = 259200000, //3 Days before rotating logs
  });

  String appName = '';
  String inAppPurchaseSubscriptionId = '';
  String inAppPurchaseDefaultPrice = '';
  String pdfLicenseKey = '';
  String mainYSAPIUrl = '';
  String mobileAPIUrl = '';
  String apiStreamingURL = '';
  String appleAuthEndpoint = '';
  String userAgent = '';
  String supportEmail = '';
  String termsOfServiceUrl = '';
  String privacyPolicyUrl = '';
  String ysAuthHeaderKey = '';
  String canalPlusAuthUrl = '';
  String garSSOAuthUrl = '';
  String logoutGarUrl = '';
  String canalPlusYsRedirectUrl = '';
  String editorialBaseImageUrl = '';
  String secretKey = '';
  String telemetryKey = '';
  String faqUrl = '';
  String personnalDataCharterGarUrl = '';
  String legalNoticesGarUrl = '';
  int applicationId = 0;
  int daysLeftBeforeBookExpiry = 0;
  num logIntervalInMiliSeconds = 0;
  AppBrand appBrand = AppBrand.youScribe;
}

enum AppBrand { youScribe, maktabati }
