import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:design_system/design_system.dart';
import 'package:brand_config/brand_config.dart';

// Events
sealed class ThemeEvent {}
class ToggleTheme  extends ThemeEvent {}
class SetLightTheme extends ThemeEvent {}
class SetDarkTheme  extends ThemeEvent {}
class SetSystemTheme extends ThemeEvent {}

// State
class ThemeState {
  final ThemeData lightTheme;
  final ThemeData darkTheme;
  final ThemeMode mode;

  const ThemeState({
    required this.lightTheme,
    required this.darkTheme,
    required this.mode,
  });
}

// BLoC
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc(BrandData brand)
      : super(ThemeState(
          lightTheme: BrandThemeBuilder.buildLight(_config(brand)),
          darkTheme:  BrandThemeBuilder.buildDark(_config(brand)),
          mode:       ThemeMode.system,
        )) {
    on<ToggleTheme>((_, emit) => emit(ThemeState(
      lightTheme: state.lightTheme,
      darkTheme:  state.darkTheme,
      mode: state.mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
    )));
    on<SetLightTheme>((_, emit) => emit(ThemeState(lightTheme: state.lightTheme, darkTheme: state.darkTheme, mode: ThemeMode.light)));
    on<SetDarkTheme>((_, emit)  => emit(ThemeState(lightTheme: state.lightTheme, darkTheme: state.darkTheme, mode: ThemeMode.dark)));
    on<SetSystemTheme>((_, emit)=> emit(ThemeState(lightTheme: state.lightTheme, darkTheme: state.darkTheme, mode: ThemeMode.system)));
  }

  static BrandThemeConfig _config(BrandData b) => BrandThemeConfig(
    primaryColor:        b.primaryColor,
    primaryDarkColor:    b.primaryDarkColor,
    primaryLightColor:   b.primaryLightColor,
    secondaryColor:      b.secondaryColor,
    secondaryDarkColor:  b.secondaryDarkColor,
    secondaryLightColor: b.secondaryLightColor,
    fontFamily:          b.fontFamily,
  );
}
