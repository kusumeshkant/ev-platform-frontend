import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:shared_ui/shared_ui.dart';
import 'package:localization/localization.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppSpacing.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.lg),
          Text('Dashboard', style: AppTypography.h2.copyWith(color: context.colors.textPrimary)),
          Text('Live platform overview', style: AppTypography.bodyMedium.copyWith(color: context.colors.textSecondary)),
          const SizedBox(height: AppSpacing.x3l),

          // KPI grid
          _KpiGrid(),
          const SizedBox(height: AppSpacing.x3l),

          // Two-column row on wide screens
          if (context.isWide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: _RecentRidesTable()),
                const SizedBox(width: AppSpacing.lg),
                Expanded(flex: 2, child: _FleetStatusCard()),
              ],
            )
          else ...[
            _RecentRidesTable(),
            const SizedBox(height: AppSpacing.lg),
            _FleetStatusCard(),
          ],
        ],
      ),
    );
  }
}

class _KpiGrid extends StatelessWidget {
  static const _kpis = [
    _Kpi('Total Revenue',    '₹1,24,560', Icons.currency_rupee_rounded, true),
    _Kpi('Active Rides',     '42',        Icons.directions_run_rounded,  false),
    _Kpi('Total Users',      '8,234',     Icons.people_rounded,          false),
    _Kpi('Vehicles Online',  '187',       Icons.electric_scooter_rounded,false),
  ];

  @override
  Widget build(BuildContext context) {
    final cols = responsiveValue<int>(context, phone: 2, tabletS: 2, tabletL: 4, desktop: 4);
    return GridView.count(
      crossAxisCount: cols,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: AppSpacing.md,
      mainAxisSpacing: AppSpacing.md,
      childAspectRatio: context.isWide ? 1.6 : 1.4,
      children: _kpis.map((k) => _KpiCard(kpi: k)).toList(),
    );
  }
}

class _KpiCard extends StatelessWidget {
  final _Kpi kpi;
  const _KpiCard({required this.kpi});

  @override
  Widget build(BuildContext context) {
    return EvCard(
      shadow: AppShadows.md,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(kpi.label, style: AppTypography.labelMedium.copyWith(color: context.colors.textSecondary)),
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: kpi.isPrimary ? context.colors.primary.withOpacity(0.1) : context.colors.successSurface,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Icon(kpi.icon,
                size: 18,
                color: kpi.isPrimary ? context.colors.primary : context.colors.success,
              ),
            ),
          ]),
          Text(kpi.value, style: AppTypography.h2.copyWith(color: context.colors.textPrimary)),
        ],
      ),
    );
  }
}

class _RecentRidesTable extends StatelessWidget {
  static final _rides = List.generate(6, (i) => (
    id:       'RD-${10000 + i}',
    user:     'User ${1000 + i}',
    vehicle:  'EV-${200 + i}',
    duration: '${8 + i} min',
    fare:     '₹${(16 + i * 3).toString()}',
    status:   i == 0 ? 'Active' : 'Completed',
  ));

  @override
  Widget build(BuildContext context) {
    return EvCard(
      shadow: AppShadows.md,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recent Rides', style: AppTypography.h4.copyWith(color: context.colors.textPrimary)),
          const SizedBox(height: AppSpacing.lg),
          Table(
            columnWidths: const {0: FlexColumnWidth(2), 1: FlexColumnWidth(2), 2: FlexColumnWidth(1), 3: FlexColumnWidth(1), 4: FlexColumnWidth(1)},
            children: [
              TableRow(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: context.colors.divider))),
                children: ['Ride ID', 'User', 'Duration', 'Fare', 'Status']
                    .map((h) => Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                          child: Text(h, style: AppTypography.labelSmall.copyWith(color: context.colors.textSecondary)),
                        ))
                    .toList(),
              ),
              ..._rides.map((r) => TableRow(
                children: [
                  _Cell(r.id),
                  _Cell(r.user),
                  _Cell(r.duration),
                  _Cell(r.fare),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs, vertical: 2),
                      decoration: BoxDecoration(
                        color: r.status == 'Active' ? context.colors.infoSurface : context.colors.successSurface,
                        borderRadius: AppRadius.chipRadius,
                      ),
                      child: Text(r.status,
                        style: AppTypography.labelSmall.copyWith(
                          color: r.status == 'Active' ? context.colors.info : context.colors.success,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
            ],
          ),
        ],
      ),
    );
  }
}

class _Cell extends StatelessWidget {
  final String text;
  const _Cell(this.text);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
    child: Text(text, style: AppTypography.bodySmall.copyWith(color: context.colors.textPrimary)),
  );
}

class _FleetStatusCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EvCard(
      shadow: AppShadows.md,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Fleet Status', style: AppTypography.h4.copyWith(color: context.colors.textPrimary)),
          const SizedBox(height: AppSpacing.lg),
          _StatusRow('Available',   187, context.colors.scooterAvailable,  context),
          _StatusRow('In Ride',      42, context.colors.scooterInRide,     context),
          _StatusRow('Low Battery',  18, context.colors.batteryLow,        context),
          _StatusRow('Offline',      12, context.colors.scooterOffline,    context),
        ],
      ),
    );
  }

  Widget _StatusRow(String label, int count, Color color, BuildContext context) {
    const total = 259;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(label, style: AppTypography.bodySmall.copyWith(color: context.colors.textSecondary)),
            Text('$count', style: AppTypography.labelMedium.copyWith(color: context.colors.textPrimary)),
          ]),
          const SizedBox(height: AppSpacing.xs),
          ClipRRect(
            borderRadius: AppRadius.chipRadius,
            child: LinearProgressIndicator(
              value: count / total,
              backgroundColor: context.colors.surfaceVariant,
              valueColor: AlwaysStoppedAnimation(color),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}

class _Kpi {
  final String label, value;
  final IconData icon;
  final bool isPrimary;
  const _Kpi(this.label, this.value, this.icon, this.isPrimary);
}
