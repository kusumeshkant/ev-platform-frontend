import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:design_system/design_system.dart';

class EvOtpField extends StatefulWidget {
  final int length;
  final ValueChanged<String> onCompleted;
  final ValueChanged<String>? onChanged;

  const EvOtpField({
    super.key,
    this.length = 6,
    required this.onCompleted,
    this.onChanged,
  });

  @override
  State<EvOtpField> createState() => _EvOtpFieldState();
}

class _EvOtpFieldState extends State<EvOtpField> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _nodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _nodes       = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in _controllers) c.dispose();
    for (final n in _nodes) n.dispose();
    super.dispose();
  }

  void _onChange(int index, String value) {
    if (value.length == 1 && index < widget.length - 1) {
      _nodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _nodes[index - 1].requestFocus();
    }
    final otp = _controllers.map((c) => c.text).join();
    widget.onChanged?.call(otp);
    if (otp.length == widget.length) widget.onCompleted(otp);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(widget.length, (i) {
        return SizedBox(
          width: 48,
          height: 56,
          child: TextField(
            controller: _controllers[i],
            focusNode: _nodes[i],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(1)],
            style: AppTypography.h3.copyWith(color: context.colors.textPrimary),
            decoration: InputDecoration(
              counterText: '',
              filled: true,
              fillColor: context.colors.surfaceVariant,
              border:        OutlineInputBorder(borderRadius: AppRadius.textFieldRadius, borderSide: BorderSide(color: context.colors.border)),
              enabledBorder: OutlineInputBorder(borderRadius: AppRadius.textFieldRadius, borderSide: BorderSide(color: context.colors.border)),
              focusedBorder: OutlineInputBorder(borderRadius: AppRadius.textFieldRadius, borderSide: BorderSide(color: context.colors.primary, width: 2)),
            ),
            onChanged: (v) => _onChange(i, v),
          ),
        );
      }),
    );
  }
}
