import 'package:flutter/material.dart';
import 'breakpoints.dart';

class AdaptiveLayout extends StatelessWidget {
  final Widget phone;
  final Widget? tabletS;
  final Widget? tabletL;
  final Widget? desktop;

  const AdaptiveLayout({
    super.key,
    required this.phone,
    this.tabletS,
    this.tabletL,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    final size = ScreenSizeHelper.of(context);
    return switch (size) {
      ScreenSize.phone || ScreenSize.phoneL => phone,
      ScreenSize.tabletS  => tabletS  ?? phone,
      ScreenSize.tabletL  => tabletL  ?? tabletS  ?? phone,
      ScreenSize.desktop  => desktop  ?? tabletL  ?? tabletS ?? phone,
    };
  }
}
