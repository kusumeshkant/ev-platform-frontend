import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:design_system/design_system.dart';

class EvTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final String? errorText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLines;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool enabled;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;

  const EvTextField({
    super.key,
    required this.label,
    this.hint,
    this.errorText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLines = 1,
    this.maxLength,
    this.onChanged,
    this.onTap,
    this.enabled = true,
    this.readOnly = false,
    this.inputFormatters,
    this.validator,
    this.textInputAction,
    this.focusNode,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: AppTypography.labelLarge.copyWith(color: context.colors.textSecondary),
        ),
        const SizedBox(height: AppSpacing.xs),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          maxLines: maxLines,
          maxLength: maxLength,
          onChanged: onChanged,
          onTap: onTap,
          enabled: enabled,
          readOnly: readOnly,
          inputFormatters: inputFormatters,
          validator: validator,
          textInputAction: textInputAction,
          focusNode: focusNode,
          onFieldSubmitted: onFieldSubmitted,
          style: AppTypography.bodyLarge.copyWith(color: context.colors.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTypography.bodyLarge.copyWith(color: context.colors.textHint),
            errorText: errorText,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            counterText: '',
            filled: true,
            fillColor: enabled ? context.colors.surfaceVariant : context.colors.border.withOpacity(0.3),
            contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
            border: OutlineInputBorder(borderRadius: AppRadius.textFieldRadius, borderSide: BorderSide(color: context.colors.border)),
            enabledBorder: OutlineInputBorder(borderRadius: AppRadius.textFieldRadius, borderSide: BorderSide(color: context.colors.border)),
            focusedBorder: OutlineInputBorder(borderRadius: AppRadius.textFieldRadius, borderSide: BorderSide(color: context.colors.primary, width: 2)),
            errorBorder: OutlineInputBorder(borderRadius: AppRadius.textFieldRadius, borderSide: BorderSide(color: context.colors.error)),
            focusedErrorBorder: OutlineInputBorder(borderRadius: AppRadius.textFieldRadius, borderSide: BorderSide(color: context.colors.error, width: 2)),
            disabledBorder: OutlineInputBorder(borderRadius: AppRadius.textFieldRadius, borderSide: BorderSide(color: context.colors.border.withOpacity(0.5))),
          ),
        ),
      ],
    );
  }
}
