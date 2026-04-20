import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

enum EvButtonSize { small, medium, large }
enum EvButtonVariant { filled, outlined, text }

class EvButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isFullWidth;
  final EvButtonSize size;
  final EvButtonVariant variant;
  final Widget? leading;
  final Widget? trailing;

  const EvButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.isFullWidth = true,
    this.size = EvButtonSize.large,
    this.variant = EvButtonVariant.filled,
    this.leading,
    this.trailing,
  });

  const EvButton.outlined({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.isFullWidth = true,
    this.size = EvButtonSize.large,
    this.leading,
    this.trailing,
  }) : variant = EvButtonVariant.outlined;

  const EvButton.text({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.isFullWidth = false,
    this.size = EvButtonSize.medium,
    this.leading,
    this.trailing,
  }) : variant = EvButtonVariant.text;

  @override
  Widget build(BuildContext context) {
    final h = switch (size) {
      EvButtonSize.small  => 36.0,
      EvButtonSize.medium => 44.0,
      EvButtonSize.large  => 52.0,
    };
    final style = switch (size) {
      EvButtonSize.small  => AppTypography.buttonMedium,
      EvButtonSize.medium => AppTypography.buttonMedium,
      EvButtonSize.large  => AppTypography.buttonLarge,
    };

    final child = isLoading
        ? SizedBox(
            width: 20, height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: variant == EvButtonVariant.filled
                  ? context.colors.onPrimary
                  : context.colors.primary,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leading != null) ...[leading!, const SizedBox(width: AppSpacing.xs)],
              Text(label, style: style),
              if (trailing != null) ...[const SizedBox(width: AppSpacing.xs), trailing!],
            ],
          );

    final btn = switch (variant) {
      EvButtonVariant.filled => FilledButton(
        onPressed: isLoading ? null : onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: context.colors.primary,
          foregroundColor: context.colors.onPrimary,
          disabledBackgroundColor: context.colors.primary.withOpacity(0.5),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.buttonRadius),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.buttonPaddingH, vertical: AppSpacing.buttonPaddingV),
          minimumSize: Size(0, h),
        ),
        child: child,
      ),
      EvButtonVariant.outlined => OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: context.colors.primary,
          side: BorderSide(color: context.colors.primary, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.buttonRadius),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.buttonPaddingH, vertical: AppSpacing.buttonPaddingV),
          minimumSize: Size(0, h),
        ),
        child: child,
      ),
      EvButtonVariant.text => TextButton(
        onPressed: isLoading ? null : onPressed,
        style: TextButton.styleFrom(foregroundColor: context.colors.primary),
        child: child,
      ),
    };

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: variant == EvButtonVariant.text ? null : h,
      child: btn,
    );
  }
}
