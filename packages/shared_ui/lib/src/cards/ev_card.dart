import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

class EvCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final List<BoxShadow>? shadow;
  final Color? color;
  final BorderRadius? borderRadius;

  const EvCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.shadow,
    this.color,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? AppRadius.cardRadius;
    return Material(
      color: color ?? context.colors.surface,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Ink(
          decoration: BoxDecoration(
            color: color ?? context.colors.surface,
            borderRadius: radius,
            boxShadow: shadow ?? AppShadows.sm,
          ),
          padding: padding ?? AppSpacing.cardInsets,
          child: child,
        ),
      ),
    );
  }
}
