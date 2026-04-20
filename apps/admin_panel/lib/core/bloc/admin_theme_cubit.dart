import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:design_system/design_system.dart';
import 'package:brand_config/brand_config.dart';

class AdminThemeState {
  final ThemeData lightTheme;
  final ThemeData darkTheme;
  final ThemeMode mode;
  const AdminThemeState({required this.lightTheme, required this.darkTheme, required this.mode});
}

class AdminThemeCubit extends Cubit<AdminThemeState> {
  AdminThemeCubit(BrandData brand) : super(AdminThemeState(
    lightTheme: BrandThemeBuilder.buildLight(_cfg(brand)),
    darkTheme:  BrandThemeBuilder.buildDark(_cfg(brand)),
    mode:       ThemeMode.light,
  ));

  void toggle() => emit(AdminThemeState(
    lightTheme: state.lightTheme, darkTheme: state.darkTheme,
    mode: state.mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
  ));

  static BrandThemeConfig _cfg(BrandData b) => BrandThemeConfig(
    primaryColor: b.primaryColor, primaryDarkColor: b.primaryDarkColor,
    primaryLightColor: b.primaryLightColor, secondaryColor: b.secondaryColor,
    secondaryDarkColor: b.secondaryDarkColor, secondaryLightColor: b.secondaryLightColor,
    fontFamily: b.fontFamily,
  );
}
