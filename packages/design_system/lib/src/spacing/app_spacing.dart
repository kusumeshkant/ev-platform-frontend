import 'package:flutter/material.dart';

abstract final class AppSpacing {
  // Base scale (4pt grid)
  static const double xs  = 4;
  static const double sm  = 8;
  static const double md  = 12;
  static const double lg  = 16;
  static const double xl  = 20;
  static const double xxl = 24;
  static const double x3l = 32;
  static const double x4l = 40;
  static const double x5l = 48;
  static const double x6l = 64;

  // Semantic aliases
  static const double screenPaddingH = lg;
  static const double screenPaddingV = xl;
  static const double cardPadding    = lg;
  static const double sectionGap     = xxl;
  static const double listItemGap    = sm;
  static const double iconTextGap    = xs;
  static const double buttonPaddingH = xxl;
  static const double buttonPaddingV = md;
  static const double bottomNavHeight = 64.0;
  static const double appBarHeight    = 56.0;

  // Convenience EdgeInsets
  static const screenPadding = EdgeInsets.symmetric(
    horizontal: screenPaddingH,
    vertical: screenPaddingV,
  );
  static const cardInsets  = EdgeInsets.all(cardPadding);
  static const zeroPadding = EdgeInsets.zero;
}
