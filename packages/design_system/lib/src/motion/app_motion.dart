import 'package:flutter/material.dart';

abstract final class AppMotion {
  static const Duration instant       = Duration(milliseconds: 100);
  static const Duration fast          = Duration(milliseconds: 150);
  static const Duration normal        = Duration(milliseconds: 250);
  static const Duration slow          = Duration(milliseconds: 350);
  static const Duration xSlow        = Duration(milliseconds: 500);
  static const Duration pageTransition = Duration(milliseconds: 300);

  static const Curve standard   = Curves.easeInOut;
  static const Curve enter      = Curves.easeOut;
  static const Curve exit       = Curves.easeIn;
  static const Curve spring     = Curves.elasticOut;
  static const Curve emphasize  = Curves.fastOutSlowIn;
  static const Curve decelerate = Curves.decelerate;
}
