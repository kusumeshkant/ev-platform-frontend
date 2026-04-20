import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:lottie/lottie.dart';
import '../buttons/ev_button.dart';

class EvEmptyState extends StatelessWidget {
  final String? animationAsset;
  final IconData? icon;
  final String title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;

  const EvEmptyState({
    super.key,
    this.animationAsset,
    this.icon,
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacing.screenPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (animationAsset != null)
              Lottie.asset(animationAsset!, width: 180, repeat: false)
            else if (icon != null)
              Icon(icon, size: 72, color: context.colors.textDisabled),
            const SizedBox(height: AppSpacing.xxl),
            Text(title, style: AppTypography.h3.copyWith(color: context.colors.textPrimary), textAlign: TextAlign.center),
            if (subtitle != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(subtitle!, style: AppTypography.bodyMedium.copyWith(color: context.colors.textSecondary), textAlign: TextAlign.center),
            ],
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: AppSpacing.x3l),
              EvButton(label: actionLabel!, onPressed: onAction, isFullWidth: false),
            ],
          ],
        ),
      ),
    );
  }
}
