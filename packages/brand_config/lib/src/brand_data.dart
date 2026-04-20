class BrandFeatureFlags {
  final bool enableStripe;
  final bool enableRazorpay;
  final bool enableWallet;
  final bool enableSubscriptions;
  final bool enableSOS;
  final bool enableHubApp;
  final bool enableAdminPanel;
  final bool enableReferrals;
  final bool enableDynamicPricing;

  const BrandFeatureFlags({
    this.enableStripe = false,
    this.enableRazorpay = true,
    this.enableWallet = true,
    this.enableSubscriptions = false,
    this.enableSOS = true,
    this.enableHubApp = true,
    this.enableAdminPanel = true,
    this.enableReferrals = false,
    this.enableDynamicPricing = false,
  });

  factory BrandFeatureFlags.fromJson(Map<String, dynamic> json) =>
      BrandFeatureFlags(
        enableStripe:         json['enableStripe']         as bool? ?? false,
        enableRazorpay:       json['enableRazorpay']       as bool? ?? true,
        enableWallet:         json['enableWallet']         as bool? ?? true,
        enableSubscriptions:  json['enableSubscriptions']  as bool? ?? false,
        enableSOS:            json['enableSOS']            as bool? ?? true,
        enableHubApp:         json['enableHubApp']         as bool? ?? true,
        enableAdminPanel:     json['enableAdminPanel']     as bool? ?? true,
        enableReferrals:      json['enableReferrals']      as bool? ?? false,
        enableDynamicPricing: json['enableDynamicPricing'] as bool? ?? false,
      );
}

class BrandData {
  final String brandId;
  final String appName;
  final String tagline;
  final int primaryColor;
  final int primaryDarkColor;
  final int primaryLightColor;
  final int secondaryColor;
  final int secondaryDarkColor;
  final int secondaryLightColor;
  final String fontFamily;
  final String logoFile;
  final String logoDarkFile;
  final String logoLightFile;
  final String splashFile;
  final String supportEmail;
  final String supportPhone;
  final String currency;
  final String currencySymbol;
  final String countryCode;
  final String defaultLocale;
  final BrandFeatureFlags features;

  const BrandData({
    required this.brandId,
    required this.appName,
    required this.tagline,
    required this.primaryColor,
    required this.primaryDarkColor,
    required this.primaryLightColor,
    required this.secondaryColor,
    required this.secondaryDarkColor,
    required this.secondaryLightColor,
    required this.fontFamily,
    required this.logoFile,
    required this.logoDarkFile,
    required this.logoLightFile,
    required this.splashFile,
    required this.supportEmail,
    required this.supportPhone,
    required this.currency,
    required this.currencySymbol,
    required this.countryCode,
    required this.defaultLocale,
    required this.features,
  });

  factory BrandData.fromJson(Map<String, dynamic> json) => BrandData(
    brandId:            json['brandId']            as String,
    appName:            json['appName']            as String,
    tagline:            json['tagline']            as String,
    primaryColor:       int.parse(json['primaryColor']      as String),
    primaryDarkColor:   int.parse(json['primaryDarkColor']  as String),
    primaryLightColor:  int.parse(json['primaryLightColor'] as String),
    secondaryColor:     int.parse(json['secondaryColor']     as String),
    secondaryDarkColor: int.parse(json['secondaryDarkColor'] as String),
    secondaryLightColor:int.parse(json['secondaryLightColor'] as String),
    fontFamily:         json['fontFamily']         as String,
    logoFile:           json['logoFile']           as String,
    logoDarkFile:       json['logoDarkFile']        as String,
    logoLightFile:      json['logoLightFile']       as String,
    splashFile:         json['splashFile']          as String,
    supportEmail:       json['supportEmail']        as String,
    supportPhone:       json['supportPhone']        as String,
    currency:           json['currency']            as String,
    currencySymbol:     json['currencySymbol']      as String,
    countryCode:        json['countryCode']         as String,
    defaultLocale:      json['defaultLocale']       as String,
    features: BrandFeatureFlags.fromJson(
      json['features'] as Map<String, dynamic>,
    ),
  );
}
