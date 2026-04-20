import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import '../buttons/ev_button.dart';

class EvErrorState extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const EvErrorState({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacing.screenPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline_rounded, size: 64, color: context.colors.error),
            const SizedBox(height: AppSpacing.lg),
            Text('Something went wrong', style: AppTypography.h4.copyWith(color: context.colors.textPrimary)),
            const SizedBox(height: AppSpacing.sm),
            Text(message, style: AppTypography.bodySmall.copyWith(color: context.colors.textSecondary), textAlign: TextAlign.center),
            if (onRetry != null) ...[
              const SizedBox(height: AppSpacing.x3l),
              EvButton.outlined(label: 'Try Again', onPressed: onRetry, isFullWidth: false),
            ],
          ],
        ),
      ),
    );
  }
}
