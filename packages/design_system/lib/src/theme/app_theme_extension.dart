import 'package:flutter/material.dart';
import '../colors/semantic_colors.dart';
import '../spacing/app_spacing.dart';
import '../radius/app_radius.dart';

@immutable
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  final SemanticColors colors;

  const AppThemeExtension({required this.colors});

  @override
  AppThemeExtension copyWith({SemanticColors? colors}) =>
      AppThemeExtension(colors: colors ?? this.colors);

  @override
  AppThemeExtension lerp(AppThemeExtension? other, double t) => this;
}

extension ThemeX on BuildContext {
  AppThemeExtension get _ext => Theme.of(this).extension<AppThemeExtension>()!;
  SemanticColors get colors  => _ext.colors;
  TextTheme get text         => Theme.of(this).textTheme;
  bool get isDark            => Theme.of(this).brightness == Brightness.dark;

  double get screenWidth  => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;
  EdgeInsets get safeArea => MediaQuery.paddingOf(this);
}
