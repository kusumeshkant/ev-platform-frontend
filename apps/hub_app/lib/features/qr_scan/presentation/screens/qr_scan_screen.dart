import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:design_system/design_system.dart';
import 'package:shared_ui/shared_ui.dart';

class QrScanScreen extends StatefulWidget {
  const QrScanScreen({super.key});
  @override
  State<QrScanScreen> createState() => _QrScanScreenState();
}

class _QrScanScreenState extends State<QrScanScreen> {
  final _controller = MobileScannerController();
  bool _scanned = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_scanned) return;
    final code = capture.barcodes.firstOrNull?.rawValue;
    if (code == null) return;
    setState(() => _scanned = true);
    _controller.stop();
    _handleCode(code);
  }

  void _handleCode(String code) {
    showModalBottomSheet(
      context: context,
      backgroundColor: context.colors.surface,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.bottomSheetRadius),
      builder: (_) => _ActionSheet(vehicleCode: code, onDone: () {
        Navigator.pop(context);
        setState(() => _scanned = false);
        _controller.start();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: EvAppBar(title: 'Scan Vehicle QR', transparent: true),
      body: Stack(
        children: [
          MobileScanner(controller: _controller, onDetect: _onDetect),
          // Scan overlay
          Center(
            child: Container(
              width: 240, height: 240,
              decoration: BoxDecoration(
                border: Border.all(color: context.colors.primary, width: 3),
                borderRadius: AppRadius.cardRadius,
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            left: 0, right: 0,
            child: Center(
              child: Text(
                'Point camera at vehicle QR code',
                style: AppTypography.bodyMedium.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionSheet extends StatelessWidget {
  final String vehicleCode;
  final VoidCallback onDone;
  const _ActionSheet({required this.vehicleCode, required this.onDone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.screenPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.sm),
          Text('Vehicle Scanned', style: AppTypography.h3.copyWith(color: context.colors.textPrimary)),
          const SizedBox(height: AppSpacing.sm),
          Text('ID: $vehicleCode', style: AppTypography.bodyMedium.copyWith(color: context.colors.textSecondary)),
          const SizedBox(height: AppSpacing.xxl),
          Row(children: [
            Expanded(child: EvButton.outlined(label: 'Mark Offline', onPressed: onDone, size: EvButtonSize.medium)),
            const SizedBox(width: AppSpacing.sm),
            Expanded(child: EvButton(label: 'Mark Available', onPressed: onDone, size: EvButtonSize.medium)),
          ]),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}
