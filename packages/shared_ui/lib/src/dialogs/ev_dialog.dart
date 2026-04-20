import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import '../buttons/ev_button.dart';

class EvDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final bool isDestructive;

  const EvDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmLabel = 'Confirm',
    this.cancelLabel  = 'Cancel',
    required this.onConfirm,
    this.onCancel,
    this.isDestructive = false,
  });

  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String message,
    String confirmLabel = 'Confirm',
    String cancelLabel  = 'Cancel',
    bool isDestructive  = false,
  }) =>
      showDialog<bool>(
        context: context,
        builder: (_) => EvDialog(
          title: title,
          message: message,
          confirmLabel: confirmLabel,
          cancelLabel: cancelLabel,
          onConfirm: () => Navigator.pop(context, true),
          onCancel:  () => Navigator.pop(context, false),
          isDestructive: isDestructive,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: AppRadius.dialogRadius),
      backgroundColor: context.colors.surface,
      child: Padding(
        padding: AppSpacing.cardInsets,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTypography.h3.copyWith(color: context.colors.textPrimary)),
            const SizedBox(height: AppSpacing.sm),
            Text(message, style: AppTypography.bodyMedium.copyWith(color: context.colors.textSecondary)),
            const SizedBox(height: AppSpacing.xxl),
            Row(children: [
              Expanded(child: EvButton.outlined(label: cancelLabel, onPressed: onCancel ?? () => Navigator.pop(context), size: EvButtonSize.medium)),
              const SizedBox(width: AppSpacing.sm),
              Expanded(child: EvButton(label: confirmLabel, onPressed: onConfirm, size: EvButtonSize.medium)),
            ]),
          ],
        ),
      ),
    );
  }
}
