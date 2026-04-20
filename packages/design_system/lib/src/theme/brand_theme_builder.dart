import 'package:flutter/material.dart';
import '../colors/app_colors.dart';
import '../colors/semantic_colors.dart';
import '../typography/app_typography.dart';
import '../typography/font_weights.dart';
import 'app_theme_extension.dart';

class BrandThemeConfig {
  final int primaryColor;
  final int primaryDarkColor;
  final int primaryLightColor;
  final int secondaryColor;
  final int secondaryDarkColor;
  final int secondaryLightColor;
  final String fontFamily;

  const BrandThemeConfig({
    required this.primaryColor,
    required this.primaryDarkColor,
    required this.primaryLightColor,
    required this.secondaryColor,
    required this.secondaryDarkColor,
    required this.secondaryLightColor,
    required this.fontFamily,
  });
}

abstract final class BrandThemeBuilder {
  static ThemeData buildLight(BrandThemeConfig brand) {
    final colors = _lightColors(brand);
    return _buildTheme(brand, colors, Brightness.light);
  }

  static ThemeData buildDark(BrandThemeConfig brand) {
    final colors = _darkColors(brand);
    return _buildTheme(brand, colors, Brightness.dark);
  }

  static SemanticColors _lightColors(BrandThemeConfig b) => SemanticColors(
    primary:          Color(b.primaryColor),
    primaryDark:      Color(b.primaryDarkColor),
    primaryLight:     Color(b.primaryLightColor),
    secondary:        Color(b.secondaryColor),
    secondaryDark:    Color(b.secondaryDarkColor),
    secondaryLight:   Color(b.secondaryLightColor),
    background:       AppColors.white,
    surface:          AppColors.gray50,
    surfaceVariant:   AppColors.gray100,
    onPrimary:        AppColors.white,
    onBackground:     AppColors.gray900,
    onSurface:        AppColors.gray900,
    textPrimary:      AppColors.gray900,
    textSecondary:    AppColors.gray500,
    textDisabled:     AppColors.gray300,
    textHint:         AppColors.gray400,
    border:           AppColors.gray200,
    divider:          AppColors.gray100,
    success:          AppColors.green500,
    successSurface:   const Color(0xFFDCFCE7),
    warning:          AppColors.yellow500,
    warningSurface:   const Color(0xFFFEF9C3),
    error:            AppColors.red500,
    errorSurface:     const Color(0xFFFEE2E2),
    info:             AppColors.blue500,
    infoSurface:      const Color(0xFFDBEAFE),
    batteryHigh:      AppColors.green500,
    batteryMid:       AppColors.yellow500,
    batteryLow:       AppColors.red500,
    scooterAvailable: AppColors.green500,
    scooterInRide:    AppColors.blue500,
    scooterOffline:   AppColors.gray400,
  );

  static SemanticColors _darkColors(BrandThemeConfig b) => SemanticColors(
    primary:          Color(b.primaryColor),
    primaryDark:      Color(b.primaryDarkColor),
    primaryLight:     Color(b.primaryLightColor),
    secondary:        Color(b.secondaryColor),
    secondaryDark:    Color(b.secondaryDarkColor),
    secondaryLight:   Color(b.secondaryLightColor),
    background:       AppColors.gray900,
    surface:          AppColors.gray800,
    surfaceVariant:   AppColors.gray700,
    onPrimary:        AppColors.white,
    onBackground:     AppColors.white,
    onSurface:        AppColors.white,
    textPrimary:      AppColors.white,
    textSecondary:    AppColors.gray400,
    textDisabled:     AppColors.gray600,
    textHint:         AppColors.gray500,
    border:           AppColors.gray700,
    divider:          AppColors.gray800,
    success:          AppColors.green400,
    successSurface:   const Color(0xFF14532D),
    warning:          AppColors.yellow400,
    warningSurface:   const Color(0xFF713F12),
    error:            AppColors.red400,
    errorSurface:     const Color(0xFF7F1D1D),
    info:             AppColors.blue400,
    infoSurface:      const Color(0xFF1E3A5F),
    batteryHigh:      AppColors.green400,
    batteryMid:       AppColors.yellow400,
    batteryLow:       AppColors.red400,
    scooterAvailable: AppColors.green400,
    scooterInRide:    AppColors.blue400,
    scooterOffline:   AppColors.gray500,
  );

  static ThemeData _buildTheme(
    BrandThemeConfig brand,
    SemanticColors colors,
    Brightness brightness,
  ) {
    final baseColor = brightness == Brightness.light ? AppColors.gray900 : AppColors.white;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: brand.fontFamily,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary:   colors.primary,
        onPrimary: colors.onPrimary,
        secondary: colors.secondary,
        onSecondary: AppColors.white,
        error:     colors.error,
        onError:   AppColors.white,
        surface:   colors.surface,
        onSurface: colors.onSurface,
      ),
      scaffoldBackgroundColor: colors.background,
      textTheme: TextTheme(
        displayLarge:  AppTypography.display1.copyWith(color: baseColor),
        displayMedium: AppTypography.display2.copyWith(color: baseColor),
        headlineLarge: AppTypography.h1.copyWith(color: baseColor),
        headlineMedium: AppTypography.h2.copyWith(color: baseColor),
        titleLarge:    AppTypography.h3.copyWith(color: baseColor),
        titleMedium:   AppTypography.h4.copyWith(color: baseColor),
        bodyLarge:     AppTypography.bodyLarge.copyWith(color: baseColor),
        bodyMedium:    AppTypography.bodyMedium.copyWith(color: baseColor),
        bodySmall:     AppTypography.bodySmall.copyWith(color: baseColor),
        labelLarge:    AppTypography.buttonLarge.copyWith(color: baseColor),
        labelMedium:   AppTypography.labelMedium.copyWith(color: baseColor),
        labelSmall:    AppTypography.labelSmall.copyWith(color: baseColor),
      ),
      extensions: [AppThemeExtension(colors: colors)],
    );
  }
}
