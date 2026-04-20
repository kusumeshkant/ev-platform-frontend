import 'package:flutter/material.dart';
import 'font_weights.dart';

abstract final class AppTypography {
  static const String _font = 'Poppins';

  // Display
  static const display1 = TextStyle(fontFamily: _font, fontSize: 48, fontWeight: AppFontWeights.bold,     height: 1.1,  letterSpacing: -1.0);
  static const display2 = TextStyle(fontFamily: _font, fontSize: 36, fontWeight: AppFontWeights.bold,     height: 1.15, letterSpacing: -0.5);

  // Headings
  static const h1 = TextStyle(fontFamily: _font, fontSize: 28, fontWeight: AppFontWeights.bold,     height: 1.25, letterSpacing: -0.3);
  static const h2 = TextStyle(fontFamily: _font, fontSize: 24, fontWeight: AppFontWeights.semiBold, height: 1.3);
  static const h3 = TextStyle(fontFamily: _font, fontSize: 20, fontWeight: AppFontWeights.semiBold, height: 1.35);
  static const h4 = TextStyle(fontFamily: _font, fontSize: 17, fontWeight: AppFontWeights.semiBold, height: 1.4);

  // Body
  static const bodyLarge  = TextStyle(fontFamily: _font, fontSize: 16, fontWeight: AppFontWeights.regular, height: 1.6);
  static const bodyMedium = TextStyle(fontFamily: _font, fontSize: 14, fontWeight: AppFontWeights.regular, height: 1.6);
  static const bodySmall  = TextStyle(fontFamily: _font, fontSize: 12, fontWeight: AppFontWeights.regular, height: 1.5);

  // Labels
  static const labelLarge  = TextStyle(fontFamily: _font, fontSize: 14, fontWeight: AppFontWeights.medium, height: 1.4, letterSpacing: 0.1);
  static const labelMedium = TextStyle(fontFamily: _font, fontSize: 12, fontWeight: AppFontWeights.medium, height: 1.4, letterSpacing: 0.2);
  static const labelSmall  = TextStyle(fontFamily: _font, fontSize: 11, fontWeight: AppFontWeights.medium, height: 1.4, letterSpacing: 0.5);

  // Misc
  static const caption  = TextStyle(fontFamily: _font, fontSize: 11, fontWeight: AppFontWeights.regular, height: 1.4, letterSpacing: 0.3);
  static const overline = TextStyle(fontFamily: _font, fontSize: 10, fontWeight: AppFontWeights.semiBold, height: 1.4, letterSpacing: 1.2);

  // Buttons
  static const buttonLarge  = TextStyle(fontFamily: _font, fontSize: 16, fontWeight: AppFontWeights.semiBold, height: 1.0, letterSpacing: 0.3);
  static const buttonMedium = TextStyle(fontFamily: _font, fontSize: 14, fontWeight: AppFontWeights.semiBold, height: 1.0, letterSpacing: 0.2);

  // Numeric displays
  static const fareDisplay = TextStyle(fontFamily: _font, fontSize: 32, fontWeight: AppFontWeights.bold, height: 1.0, letterSpacing: -0.5);
  static const timerDisplay = TextStyle(
    fontFamily: _font, fontSize: 48, fontWeight: AppFontWeights.bold, height: 1.0, letterSpacing: 2.0,
    fontFeatures: [FontFeature.tabularFigures()],
  );
}
