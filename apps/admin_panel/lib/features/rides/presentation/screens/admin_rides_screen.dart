import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:shared_ui/shared_ui.dart';

class AdminRidesScreen extends StatelessWidget {
  const AdminRidesScreen({super.key});
  @override
  Widget build(BuildContext context) => Padding(
    padding: AppSpacing.screenPadding,
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: AppSpacing.lg),
      Text('Rides', style: AppTypography.h2.copyWith(color: context.colors.textPrimary)),
      const SizedBox(height: AppSpacing.x3l),
      const EvEmptyState(icon: Icons.route_rounded, title: 'Rides list', subtitle: 'Connect to API to load ride data'),
    ]),
  );
}
