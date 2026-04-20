import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

enum EvSnackBarType { success, error, warning, info }

abstract final class EvSnackBar {
  static void show(
    BuildContext context,
    String message, {
    EvSnackBarType type = EvSnackBarType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    final colors = context.colors;
    final (bg, icon) = switch (type) {
      EvSnackBarType.success => (colors.success, Icons.check_circle_rounded),
      EvSnackBarType.error   => (colors.error,   Icons.error_rounded),
      EvSnackBarType.warning => (colors.warning, Icons.warning_rounded),
      EvSnackBarType.info    => (colors.info,    Icons.info_rounded),
    };

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        duration: duration,
        backgroundColor: bg,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.sm)),
        content: Row(children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: AppSpacing.sm),
          Expanded(child: Text(message, style: AppTypography.bodyMedium.copyWith(color: Colors.white))),
        ]),
      ));
  }
}
