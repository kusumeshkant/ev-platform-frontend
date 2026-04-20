import 'package:flutter/material.dart';

abstract final class AppColors {
  // Neutrals
  static const white   = Color(0xFFFFFFFF);
  static const black   = Color(0xFF000000);
  static const gray50  = Color(0xFFF9FAFB);
  static const gray100 = Color(0xFFF3F4F6);
  static const gray200 = Color(0xFFE5E7EB);
  static const gray300 = Color(0xFFD1D5DB);
  static const gray400 = Color(0xFF9CA3AF);
  static const gray500 = Color(0xFF6B7280);
  static const gray600 = Color(0xFF4B5563);
  static const gray700 = Color(0xFF374151);
  static const gray800 = Color(0xFF1F2937);
  static const gray900 = Color(0xFF111827);

  // Green — success / battery high
  static const green400 = Color(0xFF4ADE80);
  static const green500 = Color(0xFF22C55E);
  static const green600 = Color(0xFF16A34A);

  // Yellow — warning / battery mid
  static const yellow400 = Color(0xFFFACC15);
  static const yellow500 = Color(0xFFEAB308);

  // Red — error / battery low
  static const red400 = Color(0xFFF87171);
  static const red500 = Color(0xFFEF4444);
  static const red600 = Color(0xFFDC2626);

  // Blue — info
  static const blue400 = Color(0xFF60A5FA);
  static const blue500 = Color(0xFF3B82F6);

  // Orange — battery critical
  static const orange400 = Color(0xFFFB923C);
  static const orange500 = Color(0xFFF97316);
}
