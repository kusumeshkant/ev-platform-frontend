import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:shared_ui/shared_ui.dart';
import 'package:brand_config/brand_config.dart';

class HubDashboardScreen extends StatelessWidget {
  const HubDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: EvAppBar(title: '${BrandConfig.current.appName} Hub', showBack: false),
      body: SingleChildScrollView(
        padding: AppSpacing.screenPadding,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Overview', style: AppTypography.h3.copyWith(color: context.colors.textPrimary)),
          const SizedBox(height: AppSpacing.lg),
          _StatsGrid(),
          const SizedBox(height: AppSpacing.xxl),
          Text('Recent Activity', style: AppTypography.h4.copyWith(color: context.colors.textPrimary)),
          const SizedBox(height: AppSpacing.lg),
          ...List.generate(5, (i) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: _ActivityTile(index: i),
          )),
        ]),
      ),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  final _stats = const [
    ('Total Vehicles', '24', Icons.electric_scooter_rounded),
    ('Available',      '18', Icons.check_circle_outline_rounded),
    ('In Ride',        '4',  Icons.directions_run_rounded),
    ('Charging',       '2',  Icons.battery_charging_full_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: context.isWide ? 4 : 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: AppSpacing.sm,
      mainAxisSpacing: AppSpacing.sm,
      childAspectRatio: 1.5,
      children: _stats.map((s) => EvCard(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(s.$3, color: context.colors.primary, size: 28),
          const SizedBox(height: AppSpacing.xs),
          Text(s.$2, style: AppTypography.h2.copyWith(color: context.colors.textPrimary)),
          Text(s.$1, style: AppTypography.caption.copyWith(color: context.colors.textSecondary), textAlign: TextAlign.center),
        ]),
      )).toList(),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final int index;
  const _ActivityTile({required this.index});

  @override
  Widget build(BuildContext context) {
    return EvCard(
      child: Row(children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(color: context.colors.successSurface, shape: BoxShape.circle),
          child: Icon(Icons.electric_scooter_rounded, color: context.colors.success, size: 20),
        ),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Scooter EV-${1000 + index} unlocked', style: AppTypography.labelLarge.copyWith(color: context.colors.textPrimary)),
            Text('2 min ago', style: AppTypography.bodySmall.copyWith(color: context.colors.textSecondary)),
          ]),
        ),
      ]),
    );
  }
}
