import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:design_system/design_system.dart';
import 'package:shared_ui/shared_ui.dart';
import 'package:localization/localization.dart';

import '../../../../../core/router/route_names.dart';

class RideCompleteScreen extends StatelessWidget {
  final String rideId;
  const RideCompleteScreen({super.key, required this.rideId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.screenPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Icon(Icons.check_circle_rounded, size: 96, color: context.colors.success),
              const SizedBox(height: AppSpacing.xxl),
              Text('Ride Complete!', style: AppTypography.h1.copyWith(color: context.colors.textPrimary), textAlign: TextAlign.center),
              const SizedBox(height: AppSpacing.sm),
              Text('Thanks for riding with us.', style: AppTypography.bodyLarge.copyWith(color: context.colors.textSecondary), textAlign: TextAlign.center),
              const SizedBox(height: AppSpacing.x4l),
              EvCard(
                child: Column(children: [
                  _Row(label: 'Ride ID', value: rideId.substring(0, 8).toUpperCase()),
                  Divider(color: context.colors.divider, height: AppSpacing.xxl),
                  _Row(label: 'Duration', value: '12 min 34 sec'),
                  Divider(color: context.colors.divider, height: AppSpacing.xxl),
                  _Row(label: 'Distance', value: '2.4 km'),
                  Divider(color: context.colors.divider, height: AppSpacing.xxl),
                  _Row(label: 'Total Fare', value: '₹25.08', bold: true),
                ]),
              ),
              const Spacer(),
              EvButton(label: 'Back to Home', onPressed: () => context.go(RouteNames.home)),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String label, value;
  final bool bold;
  const _Row({required this.label, required this.value, this.bold = false});

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: AppTypography.bodyMedium.copyWith(color: context.colors.textSecondary)),
      Text(value,  style: (bold ? AppTypography.h4 : AppTypography.bodyMedium).copyWith(color: context.colors.textPrimary)),
    ],
  );
}
