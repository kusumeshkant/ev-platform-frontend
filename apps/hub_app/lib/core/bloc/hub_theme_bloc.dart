import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:design_system/design_system.dart';
import 'package:brand_config/brand_config.dart';

class HubThemeState {
  final ThemeData lightTheme;
  final ThemeData darkTheme;
  final ThemeMode mode;
  const HubThemeState({required this.lightTheme, required this.darkTheme, required this.mode});
}

class HubThemeBloc extends Cubit<HubThemeState> {
  HubThemeBloc(BrandData brand) : super(HubThemeState(
    lightTheme: BrandThemeBuilder.buildLight(_cfg(brand)),
    darkTheme:  BrandThemeBuilder.buildDark(_cfg(brand)),
    mode:       ThemeMode.system,
  ));
  static BrandThemeConfig _cfg(BrandData b) => BrandThemeConfig(
    primaryColor: b.primaryColor, primaryDarkColor: b.primaryDarkColor,
    primaryLightColor: b.primaryLightColor, secondaryColor: b.secondaryColor,
    secondaryDarkColor: b.secondaryDarkColor, secondaryLightColor: b.secondaryLightColor,
    fontFamily: b.fontFamily,
  );
}
