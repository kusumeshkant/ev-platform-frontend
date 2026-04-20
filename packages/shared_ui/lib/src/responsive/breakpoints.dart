import 'package:flutter/material.dart';

enum ScreenSize { phone, phoneL, tabletS, tabletL, desktop }

abstract final class Breakpoints {
  static const double phoneMax  = 479;
  static const double phoneLMax = 599;
  static const double tabletS   = 600;
  static const double tabletL   = 840;
  static const double desktop   = 1200;
}

abstract final class ScreenSizeHelper {
  static ScreenSize of(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    if (w < Breakpoints.phoneMax)  return ScreenSize.phone;
    if (w < Breakpoints.phoneLMax) return ScreenSize.phoneL;
    if (w < Breakpoints.tabletL)   return ScreenSize.tabletS;
    if (w < Breakpoints.desktop)   return ScreenSize.tabletL;
    return ScreenSize.desktop;
  }

  static bool isPhone(BuildContext ctx)   => of(ctx) == ScreenSize.phone || of(ctx) == ScreenSize.phoneL;
  static bool isTablet(BuildContext ctx)  => of(ctx) == ScreenSize.tabletS || of(ctx) == ScreenSize.tabletL;
  static bool isDesktop(BuildContext ctx) => of(ctx) == ScreenSize.desktop;
  static bool isWide(BuildContext ctx)    => !isPhone(ctx);
}

extension ResponsiveX on BuildContext {
  ScreenSize get screenSize => ScreenSizeHelper.of(this);
  bool get isPhone   => ScreenSizeHelper.isPhone(this);
  bool get isTablet  => ScreenSizeHelper.isTablet(this);
  bool get isDesktop => ScreenSizeHelper.isDesktop(this);
  bool get isWide    => ScreenSizeHelper.isWide(this);
}

T responsiveValue<T>(
  BuildContext context, {
  required T phone,
  T? tabletS,
  T? tabletL,
  T? desktop,
}) {
  final size = ScreenSizeHelper.of(context);
  return switch (size) {
    ScreenSize.phone || ScreenSize.phoneL => phone,
    ScreenSize.tabletS  => tabletS  ?? phone,
    ScreenSize.tabletL  => tabletL  ?? tabletS  ?? phone,
    ScreenSize.desktop  => desktop  ?? tabletL  ?? tabletS ?? phone,
  };
}
