import 'package:flutter/material.dart';

abstract final class AppRadius {
  static const double xs   = 4;
  static const double sm   = 8;
  static const double md   = 12;
  static const double lg   = 16;
  static const double xl   = 20;
  static const double xxl  = 24;
  static const double full = 999;

  // Semantic aliases
  static const double button      = lg;
  static const double card        = xl;
  static const double bottomSheet = xxl;
  static const double textField   = md;
  static const double chip        = full;
  static const double dialog      = xl;

  // BorderRadius shortcuts
  static final buttonRadius      = BorderRadius.circular(button);
  static final cardRadius        = BorderRadius.circular(card);
  static final bottomSheetRadius = BorderRadius.vertical(top: Radius.circular(bottomSheet));
  static final textFieldRadius   = BorderRadius.circular(textField);
  static final chipRadius        = BorderRadius.circular(chip);
  static final dialogRadius      = BorderRadius.circular(dialog);
}
