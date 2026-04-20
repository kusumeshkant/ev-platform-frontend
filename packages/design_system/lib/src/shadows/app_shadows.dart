import 'package:flutter/material.dart';

abstract final class AppShadows {
  static const none = <BoxShadow>[];

  static const sm = [
    BoxShadow(color: Color(0x0A000000), blurRadius: 4, offset: Offset(0, 1)),
  ];

  static const md = [
    BoxShadow(color: Color(0x0F000000), blurRadius: 8,  offset: Offset(0, 2)),
    BoxShadow(color: Color(0x06000000), blurRadius: 4,  offset: Offset(0, 1)),
  ];

  static const lg = [
    BoxShadow(color: Color(0x14000000), blurRadius: 24, offset: Offset(0, 8)),
    BoxShadow(color: Color(0x0A000000), blurRadius: 8,  offset: Offset(0, 2)),
  ];

  static const floating = [
    BoxShadow(color: Color(0x1A000000), blurRadius: 32, offset: Offset(0, 12)),
  ];

  static List<BoxShadow> primaryGlow(Color primary) => [
    BoxShadow(color: primary.withOpacity(0.25), blurRadius: 16, offset: const Offset(0, 4)),
  ];
}
