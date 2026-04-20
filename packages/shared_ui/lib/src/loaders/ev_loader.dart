import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

class EvLoader extends StatelessWidget {
  final String? message;
  const EvLoader({super.key, this.message});

  static Future<T> run<T>(BuildContext context, Future<T> future, {String? message}) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => EvLoader(message: message),
    );
    try {
      return await future;
    } finally {
      if (context.mounted) Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: context.colors.surface,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.cardRadius),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.x3l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: context.colors.primary),
            if (message != null) ...[
              const SizedBox(height: AppSpacing.lg),
              Text(message!, style: AppTypography.bodyMedium.copyWith(color: context.colors.textSecondary)),
            ],
          ],
        ),
      ),
    );
  }
}

class EvInlineLoader extends StatelessWidget {
  final double size;
  const EvInlineLoader({super.key, this.size = 24});

  @override
  Widget build(BuildContext context) =>
      Center(child: SizedBox(width: size, height: size, child: CircularProgressIndicator(color: context.colors.primary, strokeWidth: 2.5)));
}
