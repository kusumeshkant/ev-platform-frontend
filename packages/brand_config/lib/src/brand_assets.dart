import 'package:flutter/material.dart';
import 'brand_loader.dart';

abstract final class BrandAssets {
  static String get logo    => 'assets/brand/${BrandConfig.current.logoFile}';
  static String get splash  => 'assets/brand/${BrandConfig.current.splashFile}';

  static String logoForTheme(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final brand  = BrandConfig.current;
    return 'assets/brand/${isDark ? brand.logoDarkFile : brand.logoLightFile}';
  }
}
